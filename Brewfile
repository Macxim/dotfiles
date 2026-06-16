# ─────────────────────────────────────────────────────────────────────────────
#  Brewfile — single source of truth for everything installable.
#  Run:  brew bundle --file=./Brewfile
#  Dump: brew bundle dump --force   (regenerate from current machine)
# ─────────────────────────────────────────────────────────────────────────────

# Taps

# ── Core CLI ────────────────────────────────────────────────────────────────
brew "git"
brew "gh"                 # GitHub CLI — auth + SAML SSO flow (YouAble org)
brew "git-lfs"
brew "chezmoi"            # dotfiles manager
brew "mas"                # Mac App Store CLI
brew "gnupg"

# ── Shell experience ────────────────────────────────────────────────────────
brew "starship"          # prompt
brew "zsh-autosuggestions"
brew "zsh-syntax-highlighting"
brew "zoxide"            # smarter cd (z)
brew "fzf"               # fuzzy finder

# ── Modern CLI replacements ─────────────────────────────────────────────────
brew "eza"               # ls
brew "bat"               # cat
brew "ripgrep"           # grep
brew "fd"                # find
brew "jq"                # JSON
brew "wget"
brew "yt-dlp"            # successor to youtube-dl

# ── Node / web toolchain ────────────────────────────────────────────────────
brew "fnm"               # fast Node version manager (reads .node-version)
brew "pnpm"
# brew "bun"             # uncomment if you want bun for scripts/speed

# ── GUI apps (casks) ────────────────────────────────────────────────────────
# Terminal & editors
cask "ghostty"
cask "visual-studio-code"
cask "cursor"

# Design / work
cask "figma"
cask "slack"
cask "appcleaner"
cask "imageoptim"
cask "obsidian"          # replaces nvALT

# Productivity / window management
cask "raycast"           # launcher + window mgmt (replaces Spectacle + Spotlight)
cask "rectangle"         # simple window snapping (or try aerospace for tiling)

# Dev infra
cask "orbstack"          # fast, light Docker/Linux VMs

# Browsers
cask "google-chrome"
cask "firefox"
# cask "brave-browser"   # uncomment if you want it for crypto/DeFi

# Media
cask "spotify"
cask "iina"              # video player

# Fonts (needed for starship/terminal glyphs)
cask "font-jetbrains-mono-nerd-font"   # terminal glyphs (starship icons)
cask "font-geist-mono"                  # clean editor font (Vercel)

# ── Optional: password manager ──────────────────────────────────────────────
# You currently lean on the macOS keychain. If you want a dedicated manager
# (useful for crypto seed-adjacent secrets), uncomment:
# cask "1password"
# cask "1password-cli"

# ── Mac App Store (requires being signed in to the App Store first) ──────────
# Find IDs with:  mas search "App Name"
# mas "Things 3", id: 904280696
# mas "Amphetamine", id: 937984704
