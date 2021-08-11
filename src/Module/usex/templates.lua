local export = {}

local m_languages = require("Module:languages")
local rsplit = mw.text.split
local rfind = mw.ustring.find

function export.usex_t(frame)
	local params = {
		[1] = {required = true},
		[2] = {},
		[3] = {},
		
		["inline"] = {type = "boolean"},
		["noenum"] = {type = "boolean"},
		["ref"] = {},
		["lit"] = {},
		["q"] = {list = true},
		["sc"] = {},
		["source"] = {},
		["footer"] = {},
		["subst"] = {},
		["t"] = {alias_of = 3},
		["translation"] = {alias_of = 3},
		["tr"] = {},
		["transliteration"] = {alias_of = "tr"},
		["ts"] = {},
		["transcription"] = {alias_of = "ts"},
		["nocat"] = {type = "boolean"},
		["brackets"] = {type = "boolean"},
		["sort"] = {},
	}
	
	local quote = (frame.args["quote"] or "") ~= ""
	local compat = (frame.args["compat"] or "") ~= ""
	local template_inline = (frame.args["inline"] or "") ~= ""
	
	if compat then
		params["lang"] = {required = true}
		params["t"].alias_of = 2
		params["translation"].alias_of = 2
		table.remove(params, 1)
	end
	
	local args = require("Module:parameters").process(frame:getParent().args, params)
	
	local lang = args[compat and "lang" or 1] or "und"
	local sc = args["sc"]
	
	local data = {
		lang = m_languages.getByCode(lang, compat and "lang" or 1),
		sc = (sc and require("Module:scripts").getByCode(sc, true) or nil),
		usex = args[compat and 1 or 2],
		translation = args[compat and 2 or 3],
		transliteration = args["tr"],
		transcription = args["ts"],
		noenum = args["noenum"],
		inline = args["inline"] or template_inline,
		ref = args["ref"],
		quote = quote,
		lit = args["lit"],
		substs = args["subst"],
		qualifiers = args["q"],
		source = args["source"],
		footer = args["footer"],
		nocat = args["nocat"],
		brackets = args["brackets"],
		sortkey = args["sort"],
	}
	
	return require("Module:usex").format_usex(data)
end

-- Given a comma-separated list of language codes, return the English equivalent.
function export.format_langs(frame)
	local langcodes = rsplit(frame.args[1], ",")
	local langnames = {}
	for _, langcode in ipairs(langcodes) do
		local lang = m_languages.getByCode(langcode) or m_languages.err(langcode, 1)
		table.insert(langnames, lang:getCanonicalName())
	end
	if #langnames == 1 then
		return langnames[1]
	elseif #langnames == 2 then
		return langnames[1] .. " and " .. langnames[2]
	else
		local retval = {}
		for i, langname in ipairs(langnames) do
			table.insert(retval, langname)
			if i <= #langnames - 2 then
				table.insert(retval, ", ")
			elseif i == #langnames - 1 then
				table.insert(retval, "<span class=\"serial-comma\">,</span><span class=\"serial-and\"> and</span> ")
			end
		end
		return table.concat(retval, "")
	end
end

-- Given a comma-separated list of language codes, return the first one.
function export.first_lang(frame)
	local langcodes = rsplit(frame.args[1], ",")
	return langcodes[1]
end

local ignore_prefixes = {"User:", "Talk:",
	"Wiktionary:Beer parlour", "Wiktionary:Translation requests",
	"Wiktionary:Grease pit", "Wiktionary:Etymology scriptorium",
	"Wiktionary:Information desk", "Wiktionary:Tea room",
	"Wiktionary:Requests for", "Wiktionary:Votes"
}

function export.page_should_be_ignored(page)
	-- Ignore user pages, talk pages and certain Wiktionary pages
	for _, ip in ipairs(ignore_prefixes) do
		if rfind(page, "^" .. ip) then
			return true
		end
	end
	if rfind(page, " talk:") then
		return true
	end
	return false
end

function export.page_should_be_ignored_t(frame)
	return export.page_should_be_ignored(frame.args[1]) and "true" or ""
end

return export