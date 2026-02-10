##############################################################################
## Homebrew SDL2 + Readline on Apple Silicon (arm64) macOS
##
## Overrides the default framework-based SDL2 paths for Homebrew's
## pkg-config-style install under /opt/homebrew.
##############################################################################

ARCH        = -arch arm64

SDL2_CFLAGS = -DUSE_SDL2 -I/opt/homebrew/include
SDL2_LFLAGS = -L/opt/homebrew/lib -lSDL2 \
              -framework CoreGraphics -framework AppKit \
              -framework Foundation -lobjc

RL_CFLAGS   = -DUSE_GNU_READLINE -I/opt/homebrew/opt/readline/include
RL_LFLAGS   = /opt/homebrew/opt/readline/lib/libreadline.a -ltermcap

LTO         =
