#!/bin/zsh
# Mac side: squeeze the TING -> Wispr Flow push-to-talk.
set -e
cd "$(dirname "$0")"
command -v brew >/dev/null || { echo "Needs Homebrew: https://brew.sh"; exit 1; }
[ -d /Applications/tingle.app ] || brew install --cask tutorintelligence/tap/tingle

mkdir -p ~/.local/bin "$HOME/Library/Application Support/tingle"
if command -v swiftc >/dev/null; then
  swiftc -O tinghold.swift -o ~/.local/bin/tinghold
else
  cp tinghold ~/.local/bin/tinghold
fi
chmod +x ~/.local/bin/tinghold
cp config.toml "$HOME/Library/Application Support/tingle/config.toml"
open -a tingle

cat <<'MSG'
Done. Now:
 1. Allow tingle Microphone + Accessibility when asked.
 2. tingle menu > Input device > your adapter's Line IN.
 3. Wispr > Settings > Shortcuts > Push to talk > + , then squeeze the TING.
MSG
