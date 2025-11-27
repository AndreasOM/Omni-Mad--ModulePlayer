# Omni-Mad ModulePlayer

**Note: This project was an abandoned experiment from 2012 and is preserved here for historic reference only.**

This was an early work-in-progress Haxe-based .MOD (Protracker module) player targeting Flash/SWF. The goal was to parse classic Amiga .MOD files and play them back in the browser using Flash's audio capabilities.

## Status

This project is **not maintained** and **should not be used** in production. Known issues include:
- Pitch/frequency handling is broken
- Only basic sample playback works (no pattern playback)
- Effect commands are not implemented
- Targets Flash Player 10.1, which is now deprecated

## Building (for reference)

```bash
make         # Build library and test
make test    # Build test application
```

Requires: Haxe compiler and swfmill

Open `test.html` in a Flash-enabled environment to run the test application.

