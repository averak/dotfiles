require "fileutils"
require "minitest/autorun"
require "open3"
require "tmpdir"

class SymlinkTest < Minitest::Test
  def setup
    @test_dir = Dir.mktmpdir("dotfiles-symlink-")
    @source = File.join(@test_dir, "source with spaces", "long-running-task")
    @backup = File.join(@test_dir, "backups")
    @helper = File.expand_path("_symlink.sh", __dir__)
    FileUtils.mkdir_p(@source)
    File.write(File.join(@source, "SKILL.md"), "shared skill\n")
  end

  def teardown
    FileUtils.remove_entry_secure(@test_dir)
  end

  def link(target, source: @source)
    script = <<~'BASH'
      source "$1"
      _BACKUP_DIR=$2
      _log_info() { :; }
      _log_error() { printf '%s\n' "$*" >&2; }
      _symlink "$3" "$4"
    BASH
    Open3.capture3("bash", "-c", script, "symlink-test", @helper, @backup, source, target)
  end

  def target_for(tool)
    File.join(@test_dir, tool, "skills", "long-running-task")
  end

  def backup_for(target)
    File.join(@backup, target.sub(%r{\A/}, ""))
  end

  def assert_linked(target)
    assert File.symlink?(target)
    assert_equal @source, File.readlink(target)
    assert_equal "shared skill\n", File.read(File.join(target, "SKILL.md"))
  end

  def test_creates_individual_links_without_replacing_skill_directories
    %w[claude codex].each do |tool|
      target = target_for(tool)
      sibling = File.join(File.dirname(target), "another-skill")
      FileUtils.mkdir_p(sibling)
      File.write(File.join(sibling, "SKILL.md"), "unrelated\n")

      _, error, status = link(target)

      assert status.success?, error
      assert_linked(target)
      assert_equal "unrelated\n", File.read(File.join(sibling, "SKILL.md"))
    end
  end

  def test_repeated_installation_keeps_the_existing_link
    target = target_for("claude")
    2.times do
      _, error, status = link(target)
      assert status.success?, error
    end

    assert_linked(target)
    refute File.exist?(@backup)
    refute File.exist?(File.join(@source, "long-running-task"))
  end

  def test_backs_up_same_named_directories_separately
    %w[claude codex].each do |tool|
      target = target_for(tool)
      FileUtils.mkdir_p(target)
      File.write(File.join(target, "SKILL.md"), "original #{tool}\n")

      _, error, status = link(target)

      assert status.success?, error
      assert_linked(target)
      assert_equal "original #{tool}\n", File.read(File.join(backup_for(target), "SKILL.md"))
    end
  end

  def test_preserves_an_existing_regular_file
    target = File.join(@test_dir, "existing-file")
    File.write(target, "original\n")

    _, error, status = link(target)

    assert status.success?, error
    assert_linked(target)
    assert_equal "original\n", File.read(backup_for(target))
  end

  def test_backs_up_a_dangling_link
    target = File.join(@test_dir, "dangling-link")
    missing_source = File.join(@test_dir, "missing")
    File.symlink(missing_source, target)

    _, error, status = link(target)

    assert status.success?, error
    assert_linked(target)
    assert_equal missing_source, File.readlink(backup_for(target))
  end

  def test_replaces_a_directory_link_without_modifying_its_destination
    target = File.join(@test_dir, "directory-link")
    original_source = File.join(@test_dir, "original-source")
    FileUtils.mkdir_p(original_source)
    File.write(File.join(original_source, "SKILL.md"), "original\n")
    File.symlink(original_source, target)

    _, error, status = link(target)

    assert status.success?, error
    assert_linked(target)
    assert_equal original_source, File.readlink(backup_for(target))
    assert_equal ["SKILL.md"], Dir.children(original_source)
    assert_equal "original\n", File.read(File.join(original_source, "SKILL.md"))
  end

  def test_does_not_overwrite_an_existing_backup
    target = File.join(@test_dir, "existing-file")
    File.write(target, "current\n")
    FileUtils.mkdir_p(File.dirname(backup_for(target)))
    File.write(backup_for(target), "previous\n")

    _, _, status = link(target)

    refute status.success?
    assert_equal "current\n", File.read(target)
    assert_equal "previous\n", File.read(backup_for(target))
  end

  def test_missing_source_leaves_the_target_untouched
    target = File.join(@test_dir, "existing-file")
    File.write(target, "current\n")

    _, _, status = link(target, source: File.join(@test_dir, "missing"))

    refute status.success?
    assert_equal "current\n", File.read(target)
    refute File.exist?(@backup)
  end
end
