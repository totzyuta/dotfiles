# My ~/.*

## What's in here

- zsh — aliases, exports, a few autoload functions, `bd`/`fzf`/`zoxide` integration. Only *extras* are sourced from this repo; `~/.zshrc` itself stays owned by [oh-my-zsh](https://ohmyz.sh/).
- vim — plugins via [vim-plug](https://github.com/junegunn/vim-plug) (auto-installs itself on first launch)
- tmux — modernized (no more `reattach-to-user-namespace`, true color passthrough for vim/statusline)
- git — global aliases (`git_globalconfig`)
- [claude code](claude/README.md) — statusline

Ruby (rbenv/pry/rubocop) config was removed — not in use anymore. See git history if you ever need it back.

## Using it

```
$ git clone https://github.com/totzyuta/dotfiles.git
$ cd dotfiles
$ sh bootstrap.sh
```

Safe to re-run. `bootstraps/link.sh` backs up anything it would overwrite under `~/.dotfiles-backups/<timestamp>/` first.

## Layout

- `bootstrap.sh` — runs the three scripts below, in order
- `bootstraps/brew.sh` — installs Homebrew + `vim`/`tmux`/`fzf`/`zoxide`
- `bootstraps/fetch.sh` — installs oh-my-zsh + its `zsh-autosuggestions`/`zsh-syntax-highlighting` plugins
- `bootstraps/link.sh` — symlinks `vimrc` → `~/.vimrc`, `tmux.conf` → `~/.tmux.conf`, `zsh/zshrc` → `~/.zshrc.local` (sourced from the end of `~/.zshrc`), and `claude/statusline.sh` → `~/.claude/statusline.sh`; also runs `git_globalconfig`
