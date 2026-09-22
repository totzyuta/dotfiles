# Claude Code

`~/.claude/` 配下のうち、マシン間で使い回したいものだけをここに置く。
`settings.json` 全体は machine-local な hooks/permissions/plugins が混ざっているため、
今のところ同期対象に含めていない（後述の TODO 参照）。

## statusline.sh

Claude Code のステータスラインスクリプト。`bootstrap.sh` を実行すると
`~/.claude/statusline.sh` にシンボリックリンクされる。

有効化するには `~/.claude/settings.json` に以下を追記する（このリポでは管理していないので手動でマージする）:

```json
{
  "statusLine": {
    "type": "command",
    "command": "~/.claude/statusline.sh"
  }
}
```

表示内容:
- 1行目: モデル名 | worktree名 or ディレクトリ名 | gitブランチ + 変更状況
- 2行目: コンテキスト使用率バー | セッションコスト | 経過時間 | 5時間枠使用率 | 週次枠使用率

## TODO: chezmoi 移行

現状の `ln -sf` 方式はシンプルだが、`settings.json` のような「一部だけ同期したい・
マシンごとに差分がある」設定と相性が悪い。将来的には chezmoi へ移行し、

- `settings.json` を丸ごとテンプレート化して同期
- 秘密情報混入を chezmoi の暗号化機能で防ぐ
- `skills/` `agents/` `commands/` も同期対象に含める

方向で拡張する。
