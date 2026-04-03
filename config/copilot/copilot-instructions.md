## Git Worktree Workflow

Before starting implementation, check `git status`. If the current working tree has uncommitted changes, suggest using a worktree. Also follow this workflow when the user explicitly requests worktree-based work.

### Setup

```shell
git fetch origin
git worktree add -b <branch_name> ~/workspace/worktree/<repo>@<topic> origin/<base_branch>
cd ~/workspace/worktree/<repo>@<topic>
```

- **Worktree path**: `~/workspace/worktree/<repo>@<topic>`
- **Base branch**: Ask the user which branch to base from.
- **Branch naming**: `feature/<topic>` recommended. Use the user's specified name if provided.

### Pre-checks

1. Run `git status` to confirm uncommitted changes exist.
2. If the worktree path already exists, ask the user before proceeding.
