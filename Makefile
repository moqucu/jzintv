# Default to osx_sdl2 - override with: make PLATFORM=linux_sdl2
PLATFORM ?= osx_sdl2

.PHONY: all build clean

all build:
	$(MAKE) -C src -f Makefile.$(PLATFORM) $@

clean:
	$(MAKE) -C src -f Makefile.$(PLATFORM) clean
