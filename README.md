# OneLuaPro

Brief summary on how to compile OneLuaPro, currently only for the Windows operating system.

## Building and Installing OneLuaPro from Source Code

A complete Microsoft Visual Studio Installation is optional but not strictly necessary. Simply install **Buildtools for Visual Studio 2022, Version 17.9.6** from https://visualstudio.microsoft.com/de/downloads/#build-tools-for-visual-studio-2022 and select  the following suggested components for download and installation:

- MSVC v143 - VS 2022 C++-x64/x86-Buildtools
- C++-CMake-Tools for Windows (Version 3.28.0-msvc1)
- Windows 11-SDK (10.0.22621.0) 

Open `Developer Command Prompt for VS 2022` and change drive and directory. Download and unpack sources or simply clone this repository:

```cmd
c:
cd c:\Temp
git clone https://github.com/OneLuaPro/OneLuaPro.git
cd OneLuaPro
```

CMake strongly encourages out-of-source builds. **OneLuaPro** is an CMake Multiple External Projects build for automatic download, update/patch, configure, build and install.

```cmd
mkdir build && cd build
cmake .. -G "Visual Studio 17 2022" -A <arch>
cmake --build . --config Release
```

Available architectures `<arch>` with selected `Visual Studio 17 2022` generator are `Win32`, `x64`, `ARM` and `ARM64`. Default installation directory is `C:\Apps\OneLuaPro-<arch>`, where a directory structure according to [GNU Coding Standards](https://www.gnu.org/prep/standards/html_node/Directory-Variables.html) is created. 

Currently, the `PATH` environment variable has to be extended by the user in order to make `lua` callable from any Windows command prompt. For the current Windows user and without administrative privileges permanently extend the <u>user-specific</u> part of the `PATH` variable by executing the following [two commands](https://stackoverflow.com/questions/19287379/) in the given order:

```cmd
for /f "usebackq tokens=2,*" %A in (`reg query HKCU\Environment /v PATH`) do set my_user_path=%B

setx PATH "%my_user_path%;c:\Apps\OneLuaPro-<arch>\bin"
```

Open a new Windows command prompt and verify if Lua is available:

```cmd
C:\Users\John Doe>lua -v
Lua 5.4.6  Copyright (C) 1994-2023 Lua.org, PUC-Rio

C:\Users\John Doe>
```

## License

See `https://github.com/OneLuaPro/OneLuaPro/blob/main/LICENSE`.
