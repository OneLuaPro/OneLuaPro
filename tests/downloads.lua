-- ============================================================================
-- downloads.lua
--
-- Fetches and displays the download statistics for a specific OneLuaPro
-- release from GitHub. Requires a version number (min. 5.4.0.0) as argument.
--
-- Usage: lua downloads.lua <version>
-- Dependencies: luasocket, luasec, lua-cjson, argparse
-- ============================================================================
local http = require("socket.http")
local https = require("ssl.https")
local cjson = require("cjson")
local ltn12 = require("ltn12")
local argparse = require("argparse")

local parser = argparse()
   :name("downloads.lua")
   :description("Fetch OneLuaPro Github download count.")
   :epilog("https://github.com/OneLuaPro")
parser:argument("version")
   :args(1)
   :description("OneLuaPro Version 5.x.y.z")
   :convert(function(content)
	 local major,minor,patch,release = content:match("^(%d+)%.(%d+)%.(%d+)%.(%d+)$")
	 if major == nil then
	    -- no match at all
	    return nil, "Not a valid OneLuaPro version number"
	 elseif tonumber(major) < 5 or tonumber(minor) < 4 or
	    tonumber(patch) < 0 or tonumber(release) < 0 then
	    return nil, "OneLuaPro version number must be at least 5.4.0.0"
	 else
	    -- OK
	    return content	-- as string
	 end
	   end)
local args = parser:parse()

-- Compose Release URL
local url = "https://api.github.com/repos/OneLuaPro/OneLuaPro/releases/tags/v"..args.version

-- GitHub requires User-Agent Header
local response_body = {}
local res, code, headers, status = https.request{
   url = url,
   method = "GET",
   headers = {
      ["User-Agent"] = "Lua-Script", -- any name
      ["Accept"] = "application/vnd.github+json"
   },
   sink = ltn12.sink.table(response_body)
}

if code == 200 then
   -- Concat JSON string and decode
   local json_text = table.concat(response_body)
   local data = cjson.decode(json_text)
   
   print("Release: " .. data.name)
   print("----------------------------------")
   -- Run through assets and return download count
   for _, asset in ipairs(data.assets) do
      print("Datei: " .. asset.name)
      print("Downloads: " .. asset.download_count)
      print("----------------------------------")
   end
else
   print("Unknown version number "..args.version)
end
