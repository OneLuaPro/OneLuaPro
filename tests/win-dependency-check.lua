local lfs = require("lfs")
local argparse = require("argparse")

-- Setup argparse: accept exactly one directory as an argument
local parser = argparse("dependency_scanner", "Scans files for external DLL dependencies.")
parser:argument("dir", "Starting directory to scan."):args(1)

local args = parser:parse()

-- Whitelist: These DLLs are part of the Windows OS and are expected to be present.
local system_whitelist = {
   -- Lua libs
   ["lua.dll"] = true,
   -- Windows libs
   ["kernel32.dll"] = true, ["user32.dll"] = true,   ["gdi32.dll"] = true,
   ["shell32.dll"] = true,  ["advapi32.dll"] = true, ["ole32.dll"] = true,
   ["oleaut32.dll"] = true, ["comdlg32.dll"] = true, ["ws2_32.dll"] = true,
   ["winspool.drv"] = true, ["comctl32.dll"] = true, ["shlwapi.dll"] = true,
   ["netapi32.dll"] = true, ["version.dll"] = true,  ["dnsapi.dll"] = true,
   ["iphlpapi.dll"] = true, ["crypt32.dll"] = true,  ["winmm.dll"] = true,
   ["winhttp.dll"] = true,  ["wininet.dll"] = true,  ["setupapi.dll"] = true,
   ["mpr.dll"] = true,      ["rpcrt4.dll"] = true,   ["imm32.dll"] = true,
   ["msimg32.dll"] = true,  ["uxtheme.dll"] = true,  ["dwmapi.dll"] = true,
   ["bcrypt.dll"] = true,   ["wintrust.dll"] = true, ["ntdll.dll"] = true,
   ["dbghelp.dll"] = true,  ["userenv.dll"] = true,  ["opengl32.dll"] = true,
   ["oleacc.dll"] = true,   ["wsock32.dll"] = true,  ["wldap32.dll"] = true,
   ["normaliz.dll"] = true, ["secur32.dll"] = true,  ["msvbvm60.dll"] = true,
   --3rd party libs
   ["nicaiu.dll"] = true,
}

function get_all_dependencies(file)
   -- Extract only the filename from the path (e.g., "chksum.dll") to avoid self-reference
   local filename_only = file:match("([^/\\]+)$"):lower()
    
   local cmd = 'dumpbin.exe /dependents "' .. file .. '" 2>nul'
   local handle = io.popen(cmd)
   local output = handle:read("*a")
   handle:close()

   local external_deps = {}
   -- Search for all .dll entries in the dumpbin output
   for dll in output:gmatch("[%w%-_%.]+%.[Dd][Ll][Ll]") do
      local lower_dll = dll:lower()
        
      -- Logic: 
      -- 1. Not in the system whitelist?
      -- 2. AND not identical to the file itself?
      if not system_whitelist[lower_dll] and lower_dll ~= filename_only then
	 table.insert(external_deps, dll)
      end
   end
   return external_deps
end

function scan_directory(path)
   -- Verify path existence and directory mode
   local attr = lfs.attributes(path)
   if not attr or attr.mode ~= "directory" then
      print("Error: '" .. path .. "' is not a valid directory.")
      os.exit(1)
   end

   for file in lfs.dir(path) do
      if file ~= "." and file ~= ".." then
	 local full_path = path .. "/" .. file
	 local f_attr = lfs.attributes(full_path)

	 if f_attr and f_attr.mode == "directory" then
	    scan_directory(full_path)
	 elseif file:match("%.exe$") or file:match("%.dll$") then
	    local deps = get_all_dependencies(full_path)
	    if #deps > 0 then
	       print("\n[DEPENDENCY ALERT] " .. full_path)
	       for _, d in ipairs(deps) do print("   -> " .. d) end
	       print()
	    else
	       print("[OK - SYSTEM ONLY] " .. full_path)
	    end
	 end
      end
   end
end

-- Start scanning
print("Scanning for non-system dependencies in: " .. args.dir)
scan_directory(args.dir)
print("\nScan complete.")
