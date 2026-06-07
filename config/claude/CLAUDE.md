# Global Conventions

## コード

- 既存コードの命名・構造・イディオムに合わせる。
  周辺と読み比べて違和感のない記述にし、独自スタイルを持ち込まない。

## 自然言語

対象 = { code comment, docstring / doc comment, docs files, PR description }。
コード以外のすべての自然言語に適用する。

### 改行

- 1文の途中で改行しない。
- 1文1行に分けるのは、複数文があり、かつそれで読みやすくなる場合に限る。

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

## Sandbox

* ユーザからの指示を完遂するのに sandbox 無効化が必要な場合は、そのツール実行時のみ sandbox を無効化すること。
