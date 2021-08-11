local export = {}

function export.exists(frame)
	local args = frame.args
	local lang = args[1] or error("Language code has not been specified. Please pass parameter 1 to the module invocation.")
	
	lang = require("Module:languages").getByCode(lang)
	
	if lang then
		return "1"
	else
		return ""
	end
end

-- Used by the following JS:
-- * [[WT:ACCEL]]
-- * [[WT:EDIT]]
-- * [[WT:NEC]]
function export.getByCode(frame)
	local iparams = {
		[1] = {required = true},
		[2] = {required = true},
		[3] = {},
		[4] = {},
		[5] = {},
	}
	
	local iargs = require("Module:parameters").process(frame.args, iparams)
	local langcode = iargs[1]
	
	local lang = require("Module:languages").getByCode(langcode, true)
	
	return require("Module:language-like").templateGetByCode(lang, iargs,
		function(itemname)
			local list
			if itemname == "getWikimediaLanguages" then
				list = lang:getWikimediaLanguages()
			elseif itemname == "getScripts" then
				list = lang:getScriptCodes()
			elseif itemname == "getAncestors" then
				list = lang:getAncestors()
			end
			if list then
				local index = iargs[3]
				index = tonumber(index) or error("Please specify the numeric index of the desired item.")
				local retval = list[index]
				if retval then
					if type(retval) == "string" then
						return retval
					else
						return retval:getCode()
					end
				else
					return ""
				end
			end
			if itemname == "transliterate" then
				local text = iargs[3]
				local sc = iargs[4]
				local module_override = iargs[5]
				sc = require("Module:scripts").getByCode(sc, 4)
				return lang:transliterate(text, sc, module_override) or ""
			elseif itemname == "makeEntryName" then
				local text = iargs[3]
				return lang:makeEntryName(text) or ""
			elseif itemname == "makeSortKey" then
				local text = iargs[3]
				return lang:makeSortKey(text) or ""
			elseif itemname == "countCharacters" then
				local text = args[3] or ""
				local sc = require("Module:scripts").getByCode(iargs[4], 4, "disallow nil")
				return sc:countCharacters(text)
			end
		end
	)
end

function export.getByCanonicalName(frame)
	local args = frame.args
	local langname = args[1] or error("Language name has not been specified. Please pass parameter 1 to the module invocation.")
	
	local lang = require("Module:languages").getByCanonicalName(langname)
	
	if lang then
		return lang:getCode()
	else
		return ""
	end
end

function export.getByName(frame)
	local args = frame.args
	local langname = args[1] or error("Language name has not been specified. Please pass parameter 1 to the module invocation.")
	
	local lang = require("Module:languages").getByName(langname)
	
	if lang then
		return lang:getCode()
	else
		return ""
	end
end

function export.makeEntryName(frame)
	local args = frame.args
	local langname = args[1] or error("Language name has not been specified. Please pass parameter 1 to the module invocation.")
	
	local lang = require("Module:languages").getByCode(langname)
	
	if lang then
		return lang:makeEntryName(args[2])
	else
		return ""
	end
end

function export.getCanonicalName(frame)
	local langCode, args
	if require("Module:yesno")(frame.args.parent) then
		args = frame:getParent().args
	else
		args = frame.args
	end
	langCode = args[1]
	
	if not langCode or langCode == "" then
		error("Supply a language code in parameter 1.")
	end
	
	return mw.loadData("Module:languages/code to canonical name")[langCode]
		or not args.return_if_invalid and "" or langCode
end

return export