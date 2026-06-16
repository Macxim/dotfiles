# dotfiles

Reproducible setup for a fresh Mac (Apple Silicon). One repo, one script.

**Stack:** Homebrew + Brewfile · chezmoi (config + templating) · fnm + pnpm · zsh + starship · Ghostty.

## Fresh machine — quick start

```bash
# 1. Clone (Homebrew can be already installed or not)
git clone https://github.com/Macxim/dotfiles.git ~/.dotfiles
cd ~/.dotfiles

# 2. Run everything
./install.sh

# 3. Authenticate GitHub (SAML SSO via browser for the YouAble org)
gh auth login && gh auth setup-git

# 4. Install a Node version
fnm install --lts
```

Open a new terminal tab afterwards so the shell config loads.

## What it does

| Step | Tool | Result |
|------|------|--------|
| Packages | `Brewfile` | CLIs, GUI apps, fonts — edit then `brew bundle` |
| Config | `chezmoi` | `.zshrc`, `.gitconfig`, starship, etc. into `$HOME` |
| System | `macos.sh` | Finder/Dock/keyboard/screenshot defaults |

## Layout

```
.
├── Brewfile            # everything installable
├── install.sh          # one-shot bootstrap (idempotent)
├── macos.sh            # macOS defaults
├── .chezmoiroot        # points chezmoi at home/
└── home/               # chezmoi source (dot_* → ~/.*)
    ├── .chezmoi.toml.tmpl   # prompts: name, personal + work email
    ├── dot_zprofile
    ├── dot_zshrc
    ├── dot_gitconfig.tmpl
    ├── dot_gitconfig-work.tmpl
    ├── dot_gitconfig_aliases
    ├── dot_gitignore_global
    └── dot_config/starship.toml
```

## Work vs personal git identity

`chezmoi init` asks for a personal and a work email. Repos under your work
directory (default `~/Work`) automatically use the work email via an
`includeIf` rule — everything else uses personal. No manual switching.

## Daily use

```bash
chezmoi edit --apply ~/.zshrc   # edit a tracked file and apply (alias: df.)
chezmoi cd                      # jump into the source repo (alias: dfcd)
chezmoi update                  # pull + apply latest from GitHub
brew bundle dump --force        # snapshot currently-installed packages
```

## Local, uncommitted overrides

Drop machine-specific bits in `~/.zshrc.local` — it's sourced last and never
tracked.
