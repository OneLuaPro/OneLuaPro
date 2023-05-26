# OneLuaPro
**OneLuaPro** is ...

- a portable, monolithic distribution of the [Lua](http://www.lua.org/) programming language for the Windows operation system,
- natively build with MSVC compilers, but without the unnecessary overhead of a complete MS Visual Studio installation,
- targeted for corporate application scenarios on computers without permanent Internet access.

**OneLuaPro** is not ...

- dependent on package managers like `luarocks` ,
- able to be extended on the fly by missing features or modules.

**OneLuaPro** can ...

- be build and installed with minimum effort and toolchain-footprint as all its components are prepared for the [CMake](https://cmake.org/) build infrastructure.
- be installed entirely without administrative privileges.

**OneLuaPro** comprises not only the Lua programming language binaries, but also a number of mature and widely-used extensions in their respective most recent version, all of which tailored to **OneLuaPro**'s requirements:

| Module                                                       | Purpose                                                      | Version                               | License                                                      |
| ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------- | ------------------------------------------------------------ |
| [Lua](https://github.com/KritzelKratzel/lua)                 | The Lua Programming Language                                 | 5.4.6                                 | [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT) |
| [LuaSocket](https://github.com/KritzelKratzel/luasocket)     | Network support for the Lua language                         | 3.1.0 with commits until Oct 8, 2022  | [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT) |
| [librs232](https://github.com/KritzelKratzel/librs232)       | Multiplatform library for serial communications over RS-232 (serial port) | 1.0.3 with commits until Jan 15, 2021 | [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT) |
| [LuaFileSystem](https://github.com/KritzelKratzel/luafilesystem) | Complements the set of functions related to file systems offered by the standard Lua distribution | 1.8.0 with commits until Jul 26, 2022 | [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT) |
| [argparse](https://github.com/KritzelKratzel/argparse)       | Feature-rich command line parser for Lua inspired by argparse for Python | 0.7.1                                 | [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT) |
| [Luacheck](https://github.com/KritzelKratzel/luacheck)       | Static analyzer and a linter for Lua. It detects various issues such as usage of undefined global variables, unused variables and values, accessing uninitialized variables, unreachable code and more. | 1.1.0 with commits until May 4, 2023  | [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT) |

More will follow soon.

## Building and Installing OneLuaPro

A complete Microsoft Visual Studio Installation is optional but not strictly necessary. Simply install **Buildtools for Visual Studio 2022** from https://visualstudio.microsoft.com/de/downloads/#build-tools-for-visual-studio-2022 and select  the following suggested components for download and installation:

- MSVC v143 - VS 2022 C++-x64/x86-Buildtools
- C++-CMake-Tools for Windows
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
cmake .. -G "Visual Studio 17 2022" -A Win32
cmake --build . --config Release
```

Available architectures with selected `Visual Studio 17 2022` generator are `Win32`, `x64`, `ARM` and `ARM64`. Default installation directory is `C:/Apps/OneLuaPro`, where a directory structure according to [GNU Coding Standards](https://www.gnu.org/prep/standards/html_node/Directory-Variables.html) is created. 

Currently, the `PATH` environment variable has to be extended by the user in order to make `lua` callable from any Windows command prompt. For the current Windows user and without administrative privileges permanently extend the <u>user-specific</u> part of the `PATH` variable by executing the following [two commands](https://stackoverflow.com/questions/19287379/) in the given order:

```cmd
for /f "usebackq tokens=2,*" %A in (`reg query HKCU\Environment /v PATH`) do set my_user_path=%B

setx PATH "%my_user_path%;c:\Apps\OneLuaPro\bin"
```

Open a new Windows command prompt and verify if Lua is available:

```cmd
C:\Users\John Doe>lua -v
Lua 5.4.6  Copyright (C) 1994-2023 Lua.org, PUC-Rio

C:\Users\John Doe>
```

## License

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT) OneLuaPro is licensed entirely under the MIT License. 

```MIT License
MIT License

Portions Copyright (c) 1994–2023 Lua.org, PUC-Rio
Portions Copyright (c) 2004-2022 Diego Nehab
Portions Copyright (c) 2011 Petr Stetiar <ynezz@true.cz>, Gaben Ltd.
Portions Copyright (c) 2003-2010 Kepler Project
Portions Copyright (c) 2010-2022 The LuaFileSystem authors
Portions Copyright (c) 2013-2018 Peter Melnichenko
                       2019 Paul Ouellette
Portions Copyright (c) 2023 Kritzel Kratzel

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
```

