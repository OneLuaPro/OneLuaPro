# OneLuaPro
## Building and Installing OneLuaPro from Source Code

A complete Microsoft Visual Studio Installation is optional but not strictly necessary. Simply install **Buildtools for Visual Studio 2022, Version 17.9.6** from https://visualstudio.microsoft.com/de/downloads/#build-tools-for-visual-studio-2022 and select  the following suggested components for download and installation:

- MSVC v143 - VS 2022 C++-x64/x86-Buildtools
- C++-CMake-Tools for Windows (Version 3.28.0-msvc1)
- Windows 11-SDK (10.0.22621.0) 

Open `Developer Command Prompt for VS 2022` and change drive and directory. Download and unpack sources or simply clone this repository:

```cmd
c:
cd c:\Temp
git clone git@github.com:KritzelKratzel/OneLuaPro.git
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

Almost all components of **OneLuaPro** are licensed under the MIT License. The following components are licensed in a different way:

- `libusb` is licensed under the GNU Lesser General Public License v2.1 (see https://github.com/libusb/libusb/blob/master/COPYING for details).
- `luv` is licensed under the Apache License 2.0 (see https://github.com/luvit/luv/blob/master/LICENSE.txt for details).

```MIT License
MIT License
-----------------------------------------------------------------------------
Lua           - Copyright (c) 1994–2024 Lua.org, PUC-Rio
luasocket     - Copyright (c) 2004-2022 Diego Nehab
librs232      - Copyright (c) 2011 Petr Stetiar <ynezz@true.cz>, Gaben Ltd.
luafilesystem - Copyright (c) 2003-2010 Kepler Project
                Copyright (c) 2010-2024 The LuaFileSystem authors
argparse      - Copyright (c) 2013-2018 Peter Melnichenko
                              2019 Paul Ouellette
luacheck      - Copyright (c) 2013-2018 Peter Melnichenko
                              2018-2024 The luacheck authors
lsleep        - Copyright (c) 2013 Andrew Starks
libffi        - Copyright (c) 1996-2022 Anthony Green, Red Hat, Inc and others.
                              See source files for details.
MoonUSB       - Copyright (c) 2021 Stefano Trettel
libuv         - Copyright (c) 2015-present libuv project contributors.
lanes         - Copyright (c) 2007-2011 Asko Kauppi, <akauppi@gmail.com>
                Copyright (c) 2010-2024 Benoit Germain, <bnt.germain@gmail.com>
OneLuaPro     - Copyright (c) 2023-present Kritzel Kratzel

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

Apache License Version 2.0
-----------------------------------------------------------------------------
luv - See https://github.com/luvit/luv/blob/master/LICENSE.txt

GNU Lesser General Public License v2.1
-----------------------------------------------------------------------------
libusb - See https://github.com/libusb/libusb/blob/master/COPYING
```

