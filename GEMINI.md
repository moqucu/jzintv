# jzIntv — Project Context

## Overview
`jzintv` is a comprehensive Intellivision emulator and software development kit (SDK) authored by Joe Zbiciak. It is designed for high portability and accuracy, supporting a wide range of platforms (Linux, macOS, Windows, Wii, Emscripten). The project includes the emulator itself (`jzintv`), an assembler (`as1600`), a disassembler (`dasm1600`), and various utility tools.

## Core Technologies
- **Languages:** Primarily **C** (C99), with some **C++** (C++11/C++14) and **Objective-C** (for macOS/SDL2 integration).
- **Libraries:** **SDL2** (primary for graphics/sound/input), **SDL1** (legacy/alternative), and **GNU Readline** (for the debugger).
- **Build System:** Custom **Makefile**-based system with modular `subMakefile` includes.

## Architecture
The codebase is highly modular, with each major component of the Intellivision system residing in its own directory within `src/`:
- `cp1600/`: CP-1600 CPU simulator (includes opcode decoding tables in `.tbl` files).
- `stic/`: Standard Television Interface Circuit (graphics).
- `snd/`, `ay8910/`: Sound subsystems.
- `mem/`: Memory management (RAM/ROM).
- `periph/`: Peripheral bus emulation.
- `ivoice/`, `ecs/`, `icart/`: Specialized peripheral support (Intellivoice, ECS, Intellicart).
- `debug/`: Integrated debugger with Readline support.

## Building and Running

### Prerequisites
- Build outputs go to `bin/`, `lib/`, and `rom/`. Ensure these exist before building.
- SDL2 development libraries.

### Key Commands
- **Build (Root):** `make` (Detects platform, defaults to macOS SDL2 on Darwin).
- **Build (Linux SDL2):** `make -C src -f Makefile.linux_sdl2`
- **Build (Windows):** `make -C src -f Makefile.w32_sdl2`
- **Clean:** `make clean`
- **Run Emulator:** `./bin/jzintv <game_rom>` (Requires `exec.bin` and `grom.bin` in the search path).
- **Help:** `./bin/jzintv --help`

### Build Configuration
Overrides for the build process (compiler flags, library paths) should be placed in `src/buildcfg/*.mak`. These files are included by the main Makefile and allow for local environment customization without modifying tracked files.

## Development Conventions
- **Modularity:** When adding features or fixing bugs, identify the relevant module directory. Each module usually contains a `subMakefile` that lists its objects.
- **Portability:** Use macros from `src/config.h` for endianness-safe code (`HOST_TO_LE_16`, etc.) and platform-specific logic.
- **Instruction Decoding:** Many CPU/Grom instructions are decoded via `.tbl` files in their respective module directories.
- **Header Files:** Always include `config.h` as the first local header to ensure proper platform defines.
- **Coding Style:** Follow the existing indentation (typically spaces) and naming conventions (snake_case for functions/variables).

## Documentation
- `docs/jzintv/`: General emulator usage and configuration.
- `docs/programming/`: Intellivision hardware and assembly programming references.
- `docs/utilities/`: Documentation for `as1600` and `dasm1600`.
- `README.md`: Quick start and build instructions.
