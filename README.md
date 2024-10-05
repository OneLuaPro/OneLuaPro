# OneLuaPro

This is the head repository of [OneLuaPro](https://github.com/OneLuaPro). For more information on the **OneLuaPro** distribution visit https://github.com/OneLuaPro.

## Change Log

```txt
OneLuaPro Release 5.4.7.2  (Oct 5, 2024)
----------------------------------------
- New unified install media for Windows-x64 7 to 11 (signed installer
  and ZIP-archive)
- Luacheck           Updated to v1.2.0 with commits until Aug 29, 2024
- libffi             Updated to v3.4.6 with commits until Jun 28, 2024
- lua-ffi            Added with v1.0.0 with commits until Aug 18, 2024
- libuv              Updated to v1.49.0
- lanes              Updated to v4.0.0 with commits until Oct 1, 2024
- wxWidgets          Added with v3.2.6
- wxLua              Added with v3.2.0.2 with commits until Sep 4, 2023
- ZeroBraneStudio    Added with v2.01 with commits until May 20, 2024

OneLuaPro Release 5.4.7.1  (Aug 29, 2024)
-----------------------------------------
- LPeg               Added with 1.1.0
- Windows 10 binaries built with Visual Studio Build Tools 2022 17.11.2
- Windows 7 binaries built with Visual Studio Build Tools 2022 17.5.5

OneLuaPro Release 5.4.7.0  (Aug 25, 2024)
-----------------------------------------
- Windows 10 binaries built with Visual Studio Build Tools 2022 17.11.0
- Windows 7 binaries built with Visual Studio Build Tools 2022 17.5.5
- lua                Updated to 5.4.7
- luadaqmx           Added with 0.1
- lua4882            Added with 1.0
- Windows 10 binaries use NI-488.2 2024 Q3 and NI-DAQmx 2024 Q3
- Windows 7 binaries use NI-488.2 19.0 and NI-DAQmx 19.0
- OneLuaPro Win32 binaries are no longer provided.

OneLuaPro Release 5.4.6.6  (Jun 8, 2024)
----------------------------------------
- luaping            Added with 1.0

OneLuaPro Release 5.4.6.5  (May 12, 2024)
-----------------------------------------
- Binaries built with Visual Studio Build Tools 2022 17.9.6
- LuaSocket          Updated to 3.1.0 with commits until Oct 27, 2023
- librs232           Updated to 1.0.3 with commits until Oct 12, 2023
- LuaFileSystem      Updated to 1.8.0 with commits until Dec 13, 2023
- Luacheck           Updated to 1.1.2
- libffi             Updated to 3.4.6 with commits until Mar 19, 2024
- libusb             Updated to 1.0.27
- MoonUSB            Updated to 0.1 with commits until Jul 25, 2023
- libuv              Updated to 1.48.0
- luv                Updated to 1.48.0-2 with commits until Mar 2, 2024
- lanes              Added with 3.17.0 with commits until May 7, 2024

OneLuaPro Release 5.4.6.4 (Jul 8, 2023)
---------------------------------------
- moonusb            Fixed remote repository issue
- luv                Updated to 1.46.0
- libusb             Updated to 1.0.26 with commits until Jul 7, 2023

OneLuaPro Release 5.4.6.3 (Jul 2, 2023)
---------------------------------------
- libuv              Added
- luv                Added

OneLuaPro Release 5.4.6.2 (Jul 1, 2023)
---------------------------------------
- libffi, lubusb     Small fixes by merging remote-tracking branches

OneLuaPro Release 5.4.6.1 (Jun 17, 2023)
----------------------------------------
- luacheck           Updated to v1.1.1
- libffi             Added
- libusb             Added
- moonusb            Added

OneLuaPro Release 5.4.6.0 (May 27, 2023)
----------------------------------------
- Initial release
```

## Building and Installing OneLuaPro from Source Code

A complete Microsoft Visual Studio Installation is optional but not strictly necessary. Simply install **Buildtools for Visual Studio 2022, Version 17.11.4** from https://visualstudio.microsoft.com/de/downloads/#build-tools-for-visual-studio-2022 and select  the following suggested components for download and installation:

- MSVC v143 - VS 2022 C++-x64/x86-Buildtools
- C++-CMake-Tools for Windows (Version 3.28.0-msvc1)
- Windows 11-SDK (10.0.22621.0) 

In addition install the following prerequisites:

- pandoc (https://github.com/jgm/pandoc/releases)
- doxygen (https://www.doxygen.nl/download.html)
- National Instruments [NI-488.2](https://www.ni.com/en/support/downloads/drivers/download.ni-488-2.html) 2024 Q3 (Support for C/C++, with all dependencies)
- National Instruments [NI-DAQmx](https://www.ni.com/en/support/downloads/drivers/download.ni-daq-mx.html) 2024 Q3 (Support for C/C++, with all dependencies)

Open `Developer Command Prompt for VS 2022` and change drive and directory. Download and unpack sources or simply clone this repository:

```cmd
c:
cd c:\Temp
git clone https://github.com/OneLuaPro/OneLuaPro.git
cd OneLuaPro
```

CMake strongly encourages out-of-source builds. **OneLuaPro** is an CMake Multiple External Projects build for automatic download, update/patch, configure, build and install.

```cmd
mkdir build64 && cd build64
cmake .. -G "Visual Studio 17 2022" -A x64
cmake --build . --config Release > 00_log.txt
```

Building takes some time, all terminal output is redirected into file `00_log.txt` for later inspection. A successful build is indicated by an `errorlevel` return value of `0` of the last `cmake` command.

```cmd
[C:\...\John Doe]> echo %errorlevel%
0
```

The (unsigned) installer and the zip-archive are created with the following commands. Results are placed into the current build directory.

```cmd
cpack -G NSIS64
cpack -G ZIP
```

The installer offers the choice to update the `PATH`-variable according to the chosen installation directory. For a manual installation using the ZIP-archive the `PATH` environment variable has to be extended by the user in order to make `lua` callable from any Windows command prompt. For the current Windows user and without administrative privileges permanently extend the <u>user-specific</u> part of the `PATH` variable by executing the following [two commands](https://stackoverflow.com/questions/19287379/) in the given order:

```cmd
for /f "usebackq tokens=2,*" %A in (`reg query HKCU\Environment /v PATH`) do set my_user_path=%B

setx PATH "%my_user_path%;c:\Apps\OneLuaPro-<VERSION>-Win-x64\bin"
```

Open a new Windows command prompt and verify if Lua is available:

```cmd
C:\Users\John Doe>lua -v
Lua 5.4.7  Copyright (C) 1994-2024 Lua.org, PUC-Rio

C:\Users\John Doe>
```

## License

See `https://github.com/OneLuaPro/OneLuaPro/blob/main/LICENSE`.
