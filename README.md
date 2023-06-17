# OneLuaPro
**OneLuaPro** is ...

- a portable, monolithic distribution of the [Lua](http://www.lua.org/) programming language for the Windows operation system (should run from Windows 7 on upwards),
- natively build with MSVC compilers, without the unnecessary overhead of a complete MS Visual Studio installation,
- provided as `Win32` and `x64` binaries,
- targeted for corporate application scenarios on computers without permanent Internet access.

**OneLuaPro** is not ...

- made for compatibility with Lua package managers like `luarocks` .

**OneLuaPro** does not ...

- provide a complete Integrated Development Environment (IDE). Instead, it is designed to have a small installation footprint.

**OneLuaPro** can ...

- be build and installed with minimum effort and toolchain-footprint as all its components are prepared for the [CMake](https://cmake.org/) build infrastructure.
- be installed entirely without administrative privileges using the released zip-archives.

## Contents of the OneLuaPro Distribution

**OneLuaPro** comprises not only the Lua programming language binaries, but also a number of mature and widely-used extensions in their respective most recent version, all of which tailored to **OneLuaPro**'s requirements:

| Module                                                       | Purpose                                                      | Version                               | License                                                      |
| ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------- | ------------------------------------------------------------ |
| [Lua](https://github.com/KritzelKratzel/lua)                 | The Lua Programming Language                                 | 5.4.6                                 | [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT) |
| [LuaSocket](https://github.com/KritzelKratzel/luasocket)     | Network support for the Lua language                         | 3.1.0 with commits until Oct 8, 2022  | [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT) |
| [librs232](https://github.com/KritzelKratzel/librs232)       | Multi-platform library for serial communications over RS-232 (serial port) | 1.0.3 with commits until Jan 15, 2021 | [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT) |
| [LuaFileSystem](https://github.com/KritzelKratzel/luafilesystem) | Complements the set of functions related to file systems offered by the standard Lua distribution | 1.8.0 with commits until Jul 26, 2022 | [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT) |
| [argparse](https://github.com/KritzelKratzel/argparse)       | Feature-rich command line parser for Lua inspired by argparse for Python | 0.7.1                                 | [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT) |
| [Luacheck](https://github.com/KritzelKratzel/luacheck)       | Static analyzer and a linter for Lua. It detects various issues such as usage of undefined global variables, unused variables and values, accessing uninitialized variables, unreachable code and more. | 1.1.1                                 | [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT) |
| [lsleep](https://github.com/KritzelKratzel/lsleep)           | Adds the missing `sleep()` and `usleep()` functions to Lua.  | 1.05                                  | [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT) |
| [libffi](https://github.com/KritzelKratzel/libffi)           | A Portable Foreign Function Interface Library.               | 3.4.4                                 | [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT) |
| [libusb](https://github.com/KritzelKratzel/libusb)           | A library for USB device access.                             | 1.0.26                                | [![License: LGPL v3](https://img.shields.io/badge/License-LGPL_v3-blue.svg)](https://www.gnu.org/licenses/lgpl-3.0) |
| [MoonUSB](https://github.com/KritzelKratzel/moonusb)         | Lua binding library for libusb, allowing applications to access and use USB devices. | 0.1                                   | [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT) |

More will follow soon.

## Installation of released OneLuaPro Binaries

Download released zip-archive and unpack in a directory of your choice. The maintainer of this distribution suggest to install OneLuaPro into `c:\Apps`. Manually extend `PATH` -variable to the `bin` directory of your installation, e.g. `C:\Apps\OneLuaPro-Win32\bin`. Documentation and code examples (if available) are located in `<OneLuaPro_Install_Path>\share\doc`.

## Building and Installing OneLuaPro from Source Code

A complete Microsoft Visual Studio Installation is optional but not strictly necessary. Simply install **Buildtools for Visual Studio 2022, Version 17.5.5** from https://visualstudio.microsoft.com/de/downloads/#build-tools-for-visual-studio-2022 and select  the following suggested components for download and installation:

- MSVC v143 - VS 2022 C++-x64/x86-Buildtools
- C++-CMake-Tools for Windows (Version 3.25.1-msvc1)
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
mkdir build
cd build
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

Almost all components of **OneLuaPro** are licensed under the MIT License. `libusb` is licensed under the GNU Lesser General Public License v2.1 (see https://github.com/libusb/libusb/blob/master/COPYING for details).

```MIT License
MIT License
-----------------------------------------------------------------------------
Lua           - Copyright (c) 1994–2023 Lua.org, PUC-Rio
luasocket     - Copyright (c) 2004-2022 Diego Nehab
librs232      - Copyright (c) 2011 Petr Stetiar <ynezz@true.cz>, Gaben Ltd.
luafilesystem - Copyright (c) 2003-2010 Kepler Project
                Copyright (c) 2010-2022 The LuaFileSystem authors
argparse      - Copyright (c) 2013-2018 Peter Melnichenko
                              2019 Paul Ouellette
luacheck      - Copyright (c) 2013-2018 Peter Melnichenko
                              2018-2023 The luacheck authors
lsleep        - Copyright (c) 2013 Andrew Starks
libffi        - Copyright (c) 1996-2022 Anthony Green, Red Hat, Inc and others.
                              See source files for details.
MoonUSB       - Copyright (c) 2021 Stefano Trettel
OneLuaPro     - Copyright (c) 2023 Kritzel Kratzel

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

GNU Lesser General Public License v2.1
-----------------------------------------------------------------------------
libusb - See https://github.com/libusb/libusb/blob/master/COPYING
```

