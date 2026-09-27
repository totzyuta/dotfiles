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

表示内容（[Catppuccin Frappé](https://github.com/catppuccin/catppuccin) 配色）:

- 1行目: モデル名(effort) │ worktree名/ディレクトリ名 │ gitブランチ + 変更状況 │ PR番号 + PR全体のdiff │ コンテキスト使用率バー
- 2行目: input/outputトークン数 │ セッションコスト │ 経過時間 │ キャッシュヒット率 │ 5時間枠使用率バー │ 週次枠使用率バー

`tput cols` でターミナル幅を検出し、両方が収まる広さがあれば1行、収まらない狭いターミナル（iTerm半分割など）では自動的に2行へ折り返す。session/weekはcontextと同じブロックバー表現（幅5、%はバーと同色）。

- PR番号・diffは `gh pr diff` で取得（30秒キャッシュ、`gh` 未認証/未インストール時は非表示）
- アイコン・絵文字は使わず、縦棒区切りのみでレイアウト崩れを防止
- 候補の比較検討は dotfiles PR #12 のセッションログ参照（[Nord](https://www.nordtheme.com/) / [Gruvbox](https://github.com/morhetz/gruvbox) / [statuslin.es](https://statuslin.es/) の複数案を実機比較した上でCatppuccin Frappéベースのカスタム版に決定）

## TODO: chezmoi 移行

現状の `ln -sf` 方式はシンプルだが、`settings.json` のような「一部だけ同期したい・
マシンごとに差分がある」設定と相性が悪い。将来的には chezmoi へ移行し、

- `settings.json` を丸ごとテンプレート化して同期
- 秘密情報混入を chezmoi の暗号化機能で防ぐ
- `skills/` `agents/` `commands/` も同期対象に含める

方向で拡張する。
