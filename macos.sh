#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────────────────────
#  macos.sh — sensible macOS defaults for a developer machine.
#  Ported from the 2019 dotfiles, with dead keys removed and a few additions.
#  Run once:  ./macos.sh   (re-runnable; some keys need sudo)
# ─────────────────────────────────────────────────────────────────────────────
set -euo pipefail

# Ask for sudo upfront and keep it alive for the duration.
sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

echo "Configuring macOS defaults…"

# ── Keyboard ─────────────────────────────────────────────────────────────────
# Full keyboard access for all controls (Tab in dialogs).
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3
# Disable press-and-hold accent menu (enables key repeat in editors).
defaults write -g ApplePressAndHoldEnabled -bool false
# Blazing key repeat.
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 25

# ── Text (turn off "helpful" substitutions that fight code) ──────────────────
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# ── Finder ───────────────────────────────────────────────────────────────────
defaults write com.apple.finder QuitMenuItem -bool true
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder _FXSortFoldersFirst -bool true
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"      # search current folder
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"      # list view
defaults write com.apple.finder NewWindowTarget -string "PfLo"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/Downloads/"
defaults write com.apple.finder WarnOnEmptyTrash -bool false
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true
chflags nohidden "$HOME/Library" 2>/dev/null || true

# ── Dock ─────────────────────────────────────────────────────────────────────
defaults write com.apple.dock tilesize -int 40
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-time-modifier -float 0.3
defaults write com.apple.dock no-bouncing -bool true
defaults write com.apple.dock showhidden -bool true             # dim hidden apps
defaults write com.apple.dock minimize-to-application -bool true
defaults write com.apple.dock mineffect -string "scale"
defaults write com.apple.dock show-process-indicators -bool true
defaults write com.apple.dock mru-spaces -bool false            # don't reorder Spaces
defaults write com.apple.dock show-recents -bool false
defaults write com.apple.dock expose-animation-duration -float 0.15

# ── Security ─────────────────────────────────────────────────────────────────
# Require password immediately after sleep / screen saver starts.
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# ── Trackpad (no-op if you use a mouse) ──────────────────────────────────────
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# ── Screenshots ──────────────────────────────────────────────────────────────
mkdir -p "${HOME}/Screenshots"
defaults write com.apple.screencapture location -string "${HOME}/Screenshots"
defaults write com.apple.screencapture type -string "png"
defaults write com.apple.screencapture disable-shadow -bool true

# ── General UI ───────────────────────────────────────────────────────────────
defaults write NSGlobalDomain AppleShowScrollBars -string "WhenScrolling"
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001
defaults write NSGlobalDomain NSUseAnimatedFocusRing -bool false   # no focus-ring animation
# macOS Tahoe (26) "Liquid Glass": uncomment to reduce the transparency effect.
# defaults write com.apple.universalaccess reduceTransparency -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false  # save to disk, not iCloud
defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 2              # medium sidebar icons
defaults write NSGlobalDomain com.apple.springing.enabled -bool true
defaults write NSGlobalDomain com.apple.springing.delay -float 0

# ── Locale (Spain / multilingual; matches your setup) ────────────────────────
defaults write NSGlobalDomain AppleLanguages -array "en" "fr" "es"
defaults write NSGlobalDomain AppleLocale -string "en_ES@currency=EUR"
defaults write NSGlobalDomain AppleMeasurementUnits -string "Centimeters"
defaults write NSGlobalDomain AppleMetricUnits -bool true

# ── Login window safety note ─────────────────────────────────────────────────
sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName
sudo defaults write /Library/Preferences/com.apple.loginwindow LoginwindowText \
  "Found this Mac? Please contact me at: me@macx.im"

# ── Power (sudo) ─────────────────────────────────────────────────────────────
sudo systemsetup -setrestartfreeze on >/dev/null 2>&1 || true
sudo pmset -a displaysleep 10 >/dev/null 2>&1 || true
sudo pmset -a autorestart 1   >/dev/null 2>&1 || true

# ─────────────────────────────────────────────────────────────────────────────
#  REMOVED from the old file (intentionally):
#   • spctl --master-disable  → disables Gatekeeper, a real security risk. Skip.
#   • Dashboard keys          → Dashboard removed from macOS years ago.
#   • ftp.plist load          → built-in FTP server removed.
#   • Notification Center / Siri launchctl unloads → no longer work / unwise.
#   • EmptyTrashSecurely      → removed from modern macOS.
#   • "Automatically Add to iTunes" → iTunes is gone (now Music).
# ─────────────────────────────────────────────────────────────────────────────

# Apply changes by restarting affected apps.
for app in Finder Dock SystemUIServer; do killall "$app" >/dev/null 2>&1 || true; done

echo "✓ macOS defaults applied. A logout/restart makes everything stick."
