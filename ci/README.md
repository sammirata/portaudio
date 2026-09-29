# ci/ - SipRadius controlled PortAudio builds

This branch (`sipradius`) is the upstream `v19.7.0` tag plus ONLY this
directory and `.github/workflows/build.yml`. No PortAudio source file is
modified, so the delta against upstream is auditable in one `git diff
v19.7.0..sipradius -- . ':!ci' ':!.github'` (empty).

The workflow builds the three binaries naudiodon2 links and ships:

| artifact              | runner        | recipe                                                        |
| --------------------- | ------------- | ------------------------------------------------------------- |
| `portaudio_x64.dll`   | windows-2022  | the vcxproj/def recipe in `ci/msvc/`, retargeted to v143      |
| `portaudio_x64.lib`   | windows-2022  | (import library from the same build)                          |
| `libportaudio.dylib`  | macos-14      | `./configure --disable-mac-universal` once per arch (x86_64 min 10.13, arm64 min 11.0), `-Werror` dropped from the generated Makefile, merged with `lipo`, install id fixed to `@rpath/libportaudio.dylib` |
| `libportaudio.so.2`   | ubuntu-latest | `./configure --without-jack` against ALSA, soname `libportaudio.so.2` |

The recipes reproduce the ones upstream naudiodon2 documented for its
vendored prebuilts (`portaudio/mac-build.txt`, `portaudio/msvc/readme.txt`)
so the ABI the binding was built against does not change.

`ci/msvc/portaudio.vcxproj` and `portaudio.def` come from the naudiodon2
repo (`portaudio/msvc/`), which carried them next to the vendored
binaries. The vcxproj targets VS2015 (v140); the workflow retargets it to
v143 on the command line rather than editing the file.

Tag `pa-v*` to cut a release with the four binaries attached.
