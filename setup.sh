#!/bin/zsh
# Mac side: squeeze the TING -> Wispr Flow push-to-talk.
set -e
cd "$(dirname "$0")"
command -v brew >/dev/null || { echo "Needs Homebrew: https://brew.sh"; exit 1; }
# No admin rights needed: fall back to ~/Applications if /Applications is not writable.
if [ ! -d /Applications/tingle.app ] && [ ! -d ~/Applications/tingle.app ]; then
  if [ -w /Applications ]; then
    brew install --cask tutorintelligence/tap/tingle
  else
    mkdir -p ~/Applications
    brew install --cask --appdir="$HOME/Applications" tutorintelligence/tap/tingle
  fi
fi

mkdir -p ~/.local/bin "$HOME/Library/Application Support/tingle"
if command -v swiftc >/dev/null; then
  swiftc -O tinghold.swift -o ~/.local/bin/tinghold
else
  cp tinghold ~/.local/bin/tinghold
fi
chmod +x ~/.local/bin/tinghold
cp ting ~/.local/bin/ting && chmod +x ~/.local/bin/ting
grep -q '.local/bin' ~/.zshrc 2>/dev/null || echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc
cp config.toml "$HOME/Library/Application Support/tingle/config.toml"
open -a tingle

cat <<'MSG'
Done. Allow tingle Microphone + Accessibility, then:
 - First time with this TING? Plug it in over USB-C and run ./install-ting.sh
 - tingle menu > Input device > your adapter's Line IN
 - Wispr > Settings > microphone > the same Line IN
 - Wispr > Shortcuts > Push to talk > + , then squeeze the TING
MSG
