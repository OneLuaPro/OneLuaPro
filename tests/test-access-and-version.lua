--------------------------------------------------------------------------------
-- MIT License
--
-- Copyright (c) 2023-2025 Kritzel Kratzel.
--
-- Permission is hereby granted, free of charge, to any person obtaining a copy of
-- this software and associated documentation files (the "Software"), to deal in 
-- the Software without restriction, including without limitation the rights to 
-- use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
-- the Software, and to permit persons to whom the Software is furnished to do so,
-- subject to the following conditions:
--
-- The above copyright notice and this permission notice shall be included in all 
-- copies or substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
-- SOFTWARE.
--------------------------------------------------------------------------------

-- This script tests OneLuPro's modules for availability and queries version
-- information.

--------------------------------------------------------------------------------
-- local functions
local function printf(s,...)
   -- write to stdout and flush output buffer
   return io.stdout:write(s:format(...)):flush()
end

local modules = {
   "socket",
   "rs232",
   "lfs",
   "argparse",
   "lsleep",
   "ffi",
   "moonusb",
   "luv",
   "lanes",
   "luaping",
   "luadaqmx",
   "lua4882",
   "lpeg",
   "wx",
   "pl.utils",
   "distro"
}

printf("Testing modules ...\n")
for i=1, #modules do
   local m = require(modules[i])
   if modules[i] == "rs232" then
      printf("   %s %s\n",m._NAME,m._VERSION)
   elseif modules[i] == "argparse" then
      printf("   argparse %s\n",m.version)
   elseif modules[i] == "ffi" then
      printf("   lua-ffi %s\n",m._VERSION)
   elseif modules[i] == "pl.utils" then
      printf("   Penlight %s\n",m._VERSION)
   elseif modules[i] == "luv" then
      printf("   luv %s\n",m.version_string())
   elseif modules[i] == "lanes" then
      printf("   lanes %s\n",m.ABOUT.version)
   elseif modules[i] == "lpeg" then
      printf("   %s\n",m.version)
   elseif modules[i] == "wx" then
      printf("   %s\n",wx.wxVERSION_STRING)
      printf("   %s\n",wxlua.wxLUA_VERSION_STRING)
   else
      printf("   %s\n",m._VERSION)
   end
end
printf("Done.\n\n")

-- Luacheck
printf("Testing luacheck ...\n")
os.execute("luacheck -v")
printf("Done.\n\n")

-- Result
print("If there are no Lua errors, then this test is PASSED.")
--------------------------------------------------------------------------------
