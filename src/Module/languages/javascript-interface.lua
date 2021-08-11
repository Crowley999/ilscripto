local export = {}

function string.starts(String,Start)
   return string.sub(String,1,string.len(Start))==Start
end

--used by translation adder for language autocompletion
function export.GetSingleLanguageByLanguagePrefix(prefix)
	local byName = require("Module:languages/by name")
	local found_code = nil
	local found_name = nil
	for name, code in pairs(byName) do
		if (string.starts(name, prefix.args[1])) then 
			if found_code == nil or found_code == code then
				found_code = code
				found_name = name
			else
				return ""
			end
		end
	end
	if found_code ~= nil then
		return found_code..":"..found_name
	else 
		return "" end
end


--translation adder may prefetch all data and do processing on client side
function export.GetAllData()
	local byName = require("Module:languages/by name")
	return require("Module:JSON").toJSON(byName)
end

function export.AllCanonicalToCode()
	local byCanonicalName = require("Module:languages/canonical names")
	return require("Module:JSON").toJSON(byCanonicalName)
end

function export.AllCodeToCanonical()
	local codeToName = require("Module:languages/code to canonical name")
	return require("Module:JSON").toJSON(codeToName)
end

function export.AllLangcodeToScripts()
	local resultData = {}

	for code, data in pairs(require("Module:languages/alldata")) do
		resultData[code] = data.scripts
	end

	return require("Module:JSON").toJSON(resultData)
end



function export.GetLanguagesWithAutomaticTransliteration()
	local resultData = {}

	for code, data in pairs(require("Module:languages/alldata")) do
		if data.override_translit == true then
			resultData[code] = true
		end
	end

	return require("Module:JSON").toJSON(resultData)
end

function export.AllWiktionaryCodeToWikimediaCode()
	local resultData = {}

	for code, data in pairs(require("Module:languages/alldata")) do
		if data.wikimedia_codes ~= nil then
			resultData[code] = data.wikimedia_codes
		end
	end

	return require("Module:JSON").toJSON(resultData)
end


return export