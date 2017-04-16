#!/bin/zsh

alias dockutil="$DOTFILES/submodules/dockutil/scripts/dockutil"

alias seeosxmenuextras="open $OSX_MENU_EXTRAS"

##
# macOS aliases
##
alias flushdns="dscacheutil -flushcache"
alias changedns="sudo networksetup -setdnsservers \"$(networksetup -listnetworkserviceorder | awk -F'\\) ' '/\(1\)/ {print $2}')\" $@"

alias killa="killall '${app}' > /dev/null 2>&1"

alias killosxprefs="killall -u $USER cfprefsd && sleep 1" # wait for restart
alias killosxfinder="killa Finder"
alias killosxdock="killa Dock"
alias killosx="killosxprefs && killa Dock Finder SystemUIServer NotificationCenter"

# Show/hide hidden files in Finder
alias show="defaults write com.apple.finder AppleShowAllFiles -bool true && killosxfinder"
alias hide="defaults write com.apple.finder AppleShowAllFiles -bool false && killosxfinder"

# Hide/show all desktop icons (useful when presenting)
alias desktop="defaults write com.apple.finder CreateDesktop -bool"
alias hidedesktop="desktop false && killosxfinder"
alias showdesktop="desktop true && killosxfinder"

# Recursively delete `.DS_Store` files
alias cleanup="find . -type f -name '*.DS_Store' -ls -delete"

# Empty the Trash on all mounted volumes and the main HDD
# Also, clear Apple’s System Logs to improve shell startup speed
alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl"
