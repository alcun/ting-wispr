# ting-wispr

Squeeze a Teenage Engineering EP-2350 (TING / FX MIC) to talk to
[Wispr Flow](https://wisprflow.ai). Release to stop. No USB cable while you use it:
the mic runs on batteries and its signals ride the 3.5mm audio cable.

Built on [tingle](https://github.com/tutorintelligence/tingle), which hears the TING's
signals. This repo adds:

- **tinghold**: holds ctrl+opt+F12 while you squeeze, as real key presses, so Wispr
  takes it as its push-to-talk key.
- **A quieter TING script**: tingle's script with no chirps while idle or on button
  presses, and chirps at about 1/6 volume. Chirps only play on squeeze, on release,
  and every 2s while held.
- **Effect presets with chirps kept clean**: echo, spring, pixie, robot. The sample
  slot is last in each chain, so the chirps skip the effects. Shake adds reverb.
- **An installer that works on firmware 1.0.9**, where the disk is called FX MIC DISK.
  tingle's Flash EP only looks for TINGDISK.

## You need

- A TING, and a USB line-in adapter (tested with a Cubilux HLMS-C4, **Line IN** socket).
- macOS 13+, Homebrew, Wispr Flow.

## Install

```sh
git clone https://github.com/alcun/ting-wispr.git ~/ting-wispr
~/ting-wispr/setup.sh          # every Mac
~/ting-wispr/install-ting.sh   # once per TING, plugged in over USB-C
```

Then:

1. Allow tingle Microphone and Accessibility.
2. tingle menu > Input device > your adapter's Line IN.
3. Unplug the TING, press the button above its USB port, squeeze to start.
   Hold one squeeze for about 6s so tingle learns the chirp level.
4. Wispr > Settings > Shortcuts > Push to talk > **+**, then squeeze the TING.
   It should record ctrl+opt+F12.
5. Set Wispr's microphone to the adapter's Line IN.

## Trade-offs

- tingle's chirps fill the TING's four sample slots, so the horn/claps/bell samples
  and the white button do nothing.
- The chirps are 16.5-19.5 kHz. They are quiet, but you may still hear them.
- Buttons do nothing on the Mac. The orange button still changes effects on the TING.

## Undo

- TING: delete `main.py`, `config.json` and `1.wav` to `4.wav` from its disk.
  `install-ting.sh` backs the disk up to `~/Documents/` first.
- Mac: delete `~/Library/Application Support/tingle/config.toml` and
  `~/.local/bin/tinghold`, remove the shortcut in Wispr.

## License

MIT. `ting-disk/main.py` and the chirp WAVs come from tingle,
Copyright (c) 2026 Tutor Intelligence, Inc., MIT licensed.
