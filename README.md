# jzIntv — Joe Zbiciak's Intellivision Emulator

jzIntv is an Intellivision emulator and development kit for Linux, macOS, and Windows.

- **Homepage:** http://spatula-city.org/~im14u2c/intv
- **Author:** Joe Zbiciak (intvnut AT gmail.com)
- **License:** [GNU General Public License v2](LICENSE)

## Quick Start

Run `jzintv --help` for usage information. You'll need an EXEC image, a GROM image, and a game ROM to run. These can be found on the *Intellivision Lives!* or *Intellivision Rocks!* CDs from http://www.intellivisionlives.com/.

### Key Bindings (Default)

| Key | Action |
| :--- | :--- |
| **F1** | Quit |
| **F4** | Break into Debugger |
| **F5** | Switch to Keymap 0 (Default) |
| **F6** | Switch to Keymap 1 (1-Player) |
| **F7** | Switch to Keymap 2 (ECS Keyboard) |
| **F8** | Shift to Keymap 3 (Command Keys) |
| **F9** | Toggle Fullscreen/Windowed |
| **F10** | Toggle Movie Recording |
| **F11** | Take Screenshot |
| **F12** | Reset Emulator |
| **Pause** | Pause Emulator |
| **PgUp/PgDn**| Volume Up/Down |

## Building

```sh
make                  # defaults to macOS SDL2 on macOS
make -C src -f Makefile.linux_sdl2   # Linux
```

Build outputs go to `bin/`, `lib/`, and `rom/`. Create these directories before the first build if they don't exist.

Build configuration overrides can be placed in `src/buildcfg/*.mak`.

## Project Structure

- `src/`: Core emulator and tool source code.
    - `cp1600/`: CP-1600 CPU simulation.
    - `stic/`: STIC graphics chip simulation.
    - `ay8910/`: PSG sound chip simulation.
    - `debug/`: Integrated debugger.
    - `asm/`, `dasm/`: Assembler (`as1600`) and Disassembler (`dasm1600`).
- `docs/`: Technical documentation and historical references.
- `examples/`: Programming examples and library functions.
- `bin/`: Compiled executables.
- `rom/`: Place for system ROMs (`exec.bin`, `grom.bin`).

For a deep dive into the source code, see the **[Source Code Reference](https://github.com/jzintv/jzintv/wiki/Source-Code-Structure)** on the Wiki.

## Documentation

See the [`docs/`](docs/) directory, which includes:

- **`docs/jzintv/`** — Emulator usage, debugger, joystick config, keyboard hack files
- **`docs/utilities/`** — AS1600 assembler, disassembler, and other SDK tools
- **`docs/programming/`** — CP-1600 assembly language tutorial and Intellivision hardware references
- **`docs/De_Re_Intellivision/`** — Comprehensive Intellivision reference by William M. Moeller
- **`docs/tech/`** — Hardware schematics and SP0256 voice chip documentation

## Platform Notes

### macOS

- Builds are 64-bit only and use SDL2.
- `Cmd-F` toggles fullscreen/windowed mode. `Cmd-W` closes the program (SDL2).
- Homebrew SDL2 and Readline paths are configured via `src/buildcfg/20-homebrew-sdl2.mak`.

### Windows

- See the **[Windows Setup Guide](https://github.com/jzintv/jzintv/wiki/Windows-Setup)** on the Wiki for detailed installation and environment variable instructions.
- Console output is available; set `SDL_STDIO_REDIRECT=0` to send stdout/stderr to files instead.
- Use `Makefile.w32_sdl1` or `Makefile.w32_sdl2` to build.

## Release Notes

### 2020-07-12 (SVN r2110)

#### New Features

- **GNU Readline support** in the debugger (Windows, Linux, Mac). Readline-enabled builds pump the event loop in the background, improving window behavior.
- New debugger commands: `rs` (reset), `va` (toggle AVI), `vm` (toggle MVI), `vs` (screenshot).
- `Ctrl-C` at the debugger console halts the game and drops to the debugger instead of killing jzIntv.
- Documented the Cheat facility — up to 8 cheats (`CHEAT0`–`CHEAT7`). See `docs/jzintv/cheat.txt`.

#### Changes

- Batch mode defaults to rate-control off; AVI recording defaults to 1x time scale.
- `--rand-mem` now randomizes CPU registers at reset.
- CPU registers and flags no longer reset when resetting mid-game.

#### Bug Fixes

- Intellivoice min tick too high; deadlocked with small audio buffers.
- `PREVMAP` accidentally did `NEXTMAP`.
- Crash when using `--rand-mem` with `.ROM` files.
- Looping noise in SDL2 builds when stopped at a breakpoint — now explicitly mutes audio.
- Correctly managed sRGB colorspace on Mac with SDL2 for multi-monitor systems.
- Restored console output and window decorations on Windows.
- New `buildcfg/` directory for cleaner Makefile configuration with sane out-of-the-box defaults.

### 2020-06-07 (SVN r1996)

#### New Features

- **SDL2 support.** Thanks to Daniele Moglia.
- **Cheat support** (thanks to Patrick Nadeau) — bind keys to poke values in memory for adding lives, invincibility, etc.
- New kbdhackfile actions: `PAUSE_ON`, `PAUSE_OFF`, `PAUSE_HOLD`, `WINDOW`, `FULLSC`, `SETMAPx`, `NEXTMAP`, `PREVMAP`.
- UTF-8 support in game metadata.
- `P` macro in `.CFG` files can now poke paged ROM.
- Added CP-1600X macro support and examples.

#### Changes

- AS1600: no longer sign-extends characters >= 0x80 in `STRING`/`DECLE` declarations; macro expansion limits raised 10x.
- macOS builds are now 64-bit. `Cmd-F` toggles fullscreen, `Cmd-W` closes the program on SDL2.

#### Bug Fixes

- Better `.ROM` format detection with metadata tags.
- You can power jzIntv off like an Intellivision II again.
- Fix INTRQ regression (assert failure).
- Debugger pokes to paged ROMs now work correctly.
- Fix cycle skid on reaching a `HLT` instruction.
- Intellicart bankswitch and paged-ROM instruction cache invalidation fixes.
- Begin cleaning up global variables and narrowing module interfaces.
- Many type, const, and restrict cleanups; more MSVC compatibility fixes.

### 2018-12-25

#### New Features

- Added Carl Mueller's IDIV, JDIV, ISQRT to the library.
- Raw-bits mode for controller adaptors (e.g. Retronic) that provide raw input bits from native controllers.
- Debugger: `b?`, `t?`, `w?`, `@?`, `??` commands for listing breakpoints, tracepoints, watches, and status.
- "Button" mode for analog joysticks with analog buttons reporting as axes.
- Support for saving/loading ECS cassettes and printing to the ECS printer.

#### Changes

- Updated NTSC and PAL palettes based on TV capture experiments. NTSC and PAL now have different palettes.
- macOS builds are 64-bit only.
- Raw semicolons in kbdhackfiles now introduce comments; use `SEMICOLON` to bind the key.

#### Bug Fixes

- Fix `voice_compat` in internal ROM database accidentally requesting ECS instead of Intellivoice.
- Fix `JSx_BTN_28` (broken for ~20 years).
- Fix ECS `ecs_compat` / version / publisher metadata spelling.
- Fix HH:MM parsing for UTC offsets in metadata.
- Remove C++14-isms; restrict to C++11 baseline.
- Many sanitizer-directed fixes and minor memory leak cleanups.

### 1.0

First jzIntv release with a proper version number. See the documentation for details.

## Copyright

Copyright (c) 1998-2020, Joseph Zbiciak

This program is free software; you can redistribute it and/or modify it under the terms of the [GNU General Public License v2](LICENSE) as published by the Free Software Foundation.

Intellivision is a trademark of Intellivision Productions. Joe Zbiciak and jzIntv are not affiliated with Intellivision Productions.
