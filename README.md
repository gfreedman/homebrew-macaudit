# homebrew-macaudit

Homebrew tap for [Mac Audit](https://github.com/gfreedman/mac_audit) — Mac System Health Inspector & Auditor.

## Install

```bash
brew install gfreedman/macaudit/macaudit
```

## Upgrade

```bash
brew upgrade macaudit
```

## Uninstall

```bash
brew uninstall macaudit
brew untap gfreedman/macaudit   # optional — removes the tap entirely
```

## Shell completion

**zsh** — add to `~/.zshrc`:

```bash
eval "$(_MACAUDIT_COMPLETE=zsh_source macaudit)"
```

**bash** — add to `~/.bash_profile`:

```bash
eval "$(_MACAUDIT_COMPLETE=bash_source macaudit)"
```

Then restart your terminal, or run `source ~/.zshrc` (zsh) / `source ~/.bash_profile` (bash).

Or run `macaudit --show-completion` to see the instructions again at any time.

---

[Full documentation → gfreedman.github.io/mac_audit](https://gfreedman.github.io/mac_audit/)
