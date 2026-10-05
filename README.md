# ting-wispr

Squeeze a Teenage Engineering TING (EP-2350 FX MIC) to talk to
[Wispr Flow](https://wisprflow.ai). Let go to stop. No USB cable needed while you use it.

## Quick start

You need a TING, a USB line-in adapter (e.g. Cubilux HLMS-C4), Homebrew and Wispr Flow.

**1. Install on the Mac**

```sh
git clone https://github.com/alcun/ting-wispr.git ~/ting-wispr
~/ting-wispr/setup.sh
```

Allow tingle **Microphone** and **Accessibility** when asked.

**2. Set up the TING (once per TING)**

Plug the TING in over USB-C, then:

```sh
~/ting-wispr/install-ting.sh
```

Unplug it, press the small button above its USB port, then squeeze to turn it on.

**3. Connect**

- TING cable → adapter **Line IN** → Mac.
- tingle menu → **Input device** → the adapter's Line IN.
- Wispr → Settings → microphone → the adapter's Line IN.
- Wispr → Settings → Shortcuts → Push to talk → **+**, then squeeze the TING.
  It records ctrl+opt+F12.

**4. Go**

Hold the first squeeze after turning the TING on for about 7 seconds. Then squeeze and talk.

## Controls

| Control | Does |
|---|---|
| Squeeze | Talk to Wispr |
| Bottom button | Enter |
| Middle button | Undo (cmd+Z) |
| Top button | Effects: clean, echo, spring, pixie, robot |
| Shake while talking | Adds reverb |

Use clean for dictation. Wispr types the echo repeats too.

## Good to know

- You'll hear quiet chirps when you squeeze, let go and press a button. That's how the
  TING talks to the Mac.
- The built-in samples (horn, claps, bell) are gone. The chirps use their slots.
- Firmware is not touched. `install-ting.sh` backs up the TING's disk to `~/Documents/`.

## Undo

- TING: delete `main.py`, `config.json` and `1.wav` to `4.wav` from its disk.
- Mac: delete `~/Library/Application Support/tingle/config.toml` and
  `~/.local/bin/tinghold`, and remove the shortcut in Wispr.

## How it works

[tingle](https://github.com/tutorintelligence/tingle) puts a script on the TING that
plays inaudible chirps down the audio cable, and a Mac app that hears them. This repo:

- `tinghold` holds real ctrl+opt+F12 keys while you squeeze, so Wispr sees push-to-talk.
- `ting-disk/main.py` is tingle's script, made quieter: no chirps when idle, one every
  10s while held, chirps at 1/6 volume.
- `ting-disk/config.json` has effect presets with the sample slot last, so chirps skip
  the effects.
- `install-ting.sh` works on firmware 1.0.9, where the disk is called FX MIC DISK.

## License

MIT. `ting-disk/main.py` and the chirp WAVs come from tingle, Copyright (c) 2026
Tutor Intelligence, Inc., MIT licensed (see `LICENSE.tingle`).
