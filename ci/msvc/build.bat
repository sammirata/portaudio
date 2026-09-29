@echo Building portaudio_x64 for naudiodon2
copy ci\msvc\portaudio.vcxproj build\msvc\
copy ci\msvc\portaudio.def build\msvc\
cd build\msvc
msbuild /nologo /p:Configuration=Release /p:Platform=x64 /p:PlatformToolset=v143 /p:WindowsTargetPlatformVersion=10.0 portaudio.vcxproj
