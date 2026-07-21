# Global Conventions

## コード

- 既存コードの命名・構造・イディオムに合わせる。
  周辺と読み比べて違和感のない記述にし、独自スタイルを持ち込まない。

## 自然言語

対象 = { code comment, docstring / doc comment, docs files, PR description }。
コード以外のすべての自然言語に適用する。

### 改行

- 1文の途中で改行しない。
    - コードコメントも例外ではない。
- 1文1行に分けるのは、複数文があり、かつそれで読みやすくなる場合に限る。
- 改行したくなるほど長い文は、構造化や ASCII 図、表、箇条書きなど human-readable な表現に置き換える。

### 内容 — why だけを書く

- 書く (why): 非自明な契約 (どんな入力でエラーか、空値を渡すと何が起きるか)、採用しなかった代替案、不変条件・順序・並行性・落とし穴、「なぜこう書くのか」の意図。
- 書かない (describe-only): 識別子・シグネチャ・実装をなぞる説明、コード変更で腐るリスト (subcommand 一覧、フィールド名一覧など)。

### 配置 — 優先順位: 型 ≻ code comment ≻ doc comment

- 型で表現できるもの (型・単位・制約) は型で表現する。コメントは腐るが型は腐らない。
- 手続き的な why は doc comment ではなく実装箇所の code comment に書く。
- doc comment / docstring は sparse に保ち、本当に有益なものだけ残す。

## PR

- 作業 branch には勝手に push してよい。
- `gh pr create --assignee @me` で自分を assignee にする。
- description はレビュアー目線で読みやすく書く。plain text の段落を延々並べない。
    - 冒頭に TL;DR (何を・どれだけ・互換性への影響) を置き、忙しいレビュアーが数行で掴めるようにする。
    - 構造 (before/after の図・表・箇条書き) で伝える。ASCII 図は code fence に入れる (GitHub でも monospace で崩れない)。
    - 数値やベンチ結果を貼るときは「その数値が何を示すか」を必ず併記する。裸の数値だけ置かない。
    - レビュアーが最も気にする点 (互換性・破壊的変更の有無) を目立つ位置に明示する。

## Sandbox

- ユーザからの指示を完遂するのに sandbox 無効化が必要な場合は、そのツール実行時のみ sandbox を無効化すること。

## 調査・提案資料

ユーザからのテキストではなく HTML 形式での説明を求められた場合、下記要点に従って作成せよ。

- **自己完結 HTML で書く**。図はインライン SVG、スタイルはインライン CSS で、外部 CDN (mermaid 等) に依存しない。sandbox / offline でもブラウザで開けるようにするため。
- **human-readable な図・表で伝える**。複雑な機序は文章の羅列ではなく、読み手が直観的に掴める図・表に落とす (記法の予備知識を要する表現は避ける)。
- **コード参照は permanent link で張る**。branch 名や `HEAD` のような流動的なポインタは避け、URL単体で常に同じコード・行範囲を参照できる不変の識別子（commit hash や tag 等）を埋めること。
    - **URL形式:** `https://<github-domain>/<org>/<repo>/blob/<immutable-ref>/<path>#L<start>-L<end>`
    - リンク範囲は示したい箇所に合わせる。関数全体でも、関数内の一部の行範囲 (`#L<start>-L<end>`) でもよい。
    - 識別子 (関数名・テーブル名) そのものをリンクテキストにするとフレンドリー。
- **A4 印刷に対応させる** (`@page` / `print-color-adjust: exact`)。
- **出力先:** `~/tmp/docs/<repo-name>/<YYYYMMDD>_<topic>.html`

※ `<github-domain>`, `<org>`, `<repo>`, `<project-root>` は、現在作業中のプロジェクト環境に合わせて適宜置き換えること。
