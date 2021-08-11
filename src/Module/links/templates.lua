local export = {}

--[=[
	Modules used:
	[[Module:links]]
	[[Module:languages]]
	[[Module:scripts]]
	[[Module:parameters]]
	[[Module:debug]]
]=]

-- Used in [[Template:l]] and [[Template:m]].
function export.l_term_t(frame)
	local face = frame.args["face"]
	local allowSelfLink = frame.args["notself"]; allowSelfLink = not allowSelfLink or allowSelfLink == ""
	
	local params = {
		[1] = {required = true},
		[2] = {},
		[3] = {},
		[4] = {alias_of = "gloss"},
		["accel-form"] = {},
		["accel-translit"] = {},
		["accel-lemma"] = {},
		["accel-lemma-translit"] = {},
		["accel-gender"] = {},
		["accel-nostore"] = {type = "boolean"},
		["g"] = {list = true},
		["gloss"] = {},
		["id"] = {},
		["lit"] = {},
		["pos"] = {},
		["t"] = {alias_of = "gloss"},
		["tr"] = {},
		["ts"] = {},
		["sc"] = {},
	}
	
	-- Compatibility mode for {{term}}.
	-- If given a nonempty value, the function uses lang= to specify the
	-- language, and all the positional parameters shift one number lower.
	local compat = (frame.args["compat"] or "") ~= ""
	
	if compat then
		params["lang"] = {},
		table.remove(params, 1)
	end
	
	local args = require("Module:parameters").process(frame:getParent().args, params)
	
	local lang = args[compat and "lang" or 1]
	
	-- Tracking for missing language or und
	if not lang then
		require("Module:debug").track("link/no lang")
	elseif lang == "und" then
		require("Module:debug").track("link/und")
	end
	
	lang = lang or "und"
	local sc = args["sc"]
	
	local term = args[(compat and 1 or 2)]
	local alt = args[(compat and 2 or 3)]
	
	-- Check parameters
	lang = require("Module:languages").getByCode(lang, 1, "allow etym")
	lang = require("Module:languages").getNonEtymological(lang)
	
	if sc then
		sc = require("Module:scripts").getByCode(sc, "sc")
	end
	
	if not term and not alt and frame.args["demo"] then
		term = frame.args["demo"]
	end
	
	-- Forward the information to full_link
	return require("Module:links").full_link( 
		{
			lang = lang, 
			sc = sc, 
			term = term,
			alt = alt, 
			id = args["id"], 
			tr = args["tr"],
			ts = args["ts"],
			genders = args["g"], 
			gloss = args["gloss"], 
			pos = args["pos"], 
			lit = args["lit"],
			accel = args["accel-form"] and {
				form = args["accel-form"],
				translit = args["accel-translit"],
				lemma = args["accel-lemma"],
				lemma_translit = args["accel-lemma-translit"],
				gender = args["accel-gender"],
				nostore = args["accel-nostore"],
			} or nil,
		},
		face,
		allowSelfLink
	)
end

-- Used in [[Template:ll]].
function export.ll(frame)
	local params = {
		[1] = { required = true },
		[2] = { allow_empty = true },
		[3] = {},
		["notself"] = { type = "boolean", default = false },
		["id"] = {},
	}
	local args = require("Module:parameters").process(frame:getParent().args, params)
	local allowSelfLink = not args["notself"]
	
	local lang = args[1]
	lang = require("Module:languages").getByCode(lang, 1, "allow etym")
	lang = require("Module:languages").getNonEtymological(lang)

	local text = args[2]
	local alt = args[3]
	if text == "" then
		return alt or ""
	end
	
	local id = args["id"]
	
	return require("Module:links").language_link(
		{
			term = text,
			alt = alt,
			lang = lang,
			id = id
		},
		allowSelfLink
	)
end

function export.def_t(frame)
	local params = {
		[1] = {required = true, default = ""},
	}
	
	local args = require("Module:parameters").process(frame:getParent().args, params)
	
	return require("Module:links").english_links(args[1])
end


function export.linkify_t(frame)
	local params = {
		[1] = {required = true, default = ""},
	}
	
	local args = require("Module:parameters").process(frame:getParent().args, params)
	
	args[1] = mw.text.trim(args[1])
	
	if args[1] == "" or args[1]:find("[[", nil, true) then
		return args[1]
	else
		return "[[" .. args[1] .. "]]"
	end
end

function export.section_link_t(frame)
	local params = {
		[1] = {},
	}
	
	local args = require("Module:parameters").process(frame:getParent().args, params)
	
	return require("Module:links").section_link(args[1])
end

function export.language_name_link_t(frame)
	local face = frame.args["face"]
	local allowSelfLink = frame.args["notself"]; allowSelfLink = not allowSelfLink or allowSelfLink == ""
	
	local params = {
		[1] = {required = true},
		[2] = {},
		[3] = {},
		[4] = {alias_of = "gloss"},
		["g"] = {list = true},
		["gloss"] = {},
		["id"] = {},
		["lit"] = {},
		["pos"] = {},
		["t"] = {alias_of = "gloss"},
		["tr"] = {},
		["ts"] = {},
		["sc"] = {},
		["w"] = { type = "boolean", default = false },
	}
	
	-- Compatibility mode for {{term}}.
	-- If given a nonempty value, the function uses lang= to specify the
	-- language, and all the positional parameters shift one number lower.
	local compat = (frame.args["compat"] or "") ~= ""
	
	if compat then
		params["lang"] = {},
		table.remove(params, 1)
	end
	
	local args = require("Module:parameters").process(frame:getParent().args, params)
	
	local lang = args[compat and "lang" or 1]
	
	-- Tracking for missing language or und
	if not lang then
		require("Module:debug").track("link/no lang")
	elseif lang == "und" then
		require("Module:debug").track("link/und")
	end
	
	lang = lang or "und"
	local sc = args["sc"]
	
	local term = args[(compat and 1 or 2)]
	local alt = args[(compat and 2 or 3)]
	
	-- Check parameters
	lang = require("Module:languages").getByCode(lang, 1, "allow etym")
	local non_etym_lang = require("Module:languages").getNonEtymological(lang)
	
	if sc then
		sc = require("Module:scripts").getByCode(sc, "sc")
	end

	if not term and not alt and frame.args["demo"] then
		term = frame.args["demo"]
	end
	
	--[[
		Add a language name, linked to Wikipedia if the Wikipedia parameter is set to true.
		Forward the information to full_link.
	]]
	local language_name = args.w and lang:makeWikipediaLink() or lang:getCanonicalName()
	
	if term == "-" then
		return language_name
	else
		return language_name .. " " ..
			require("Module:links").full_link( 
				{
					lang = non_etym_lang, 
					sc = sc, 
					term = term, 
					alt = alt, 
					id = args["id"], 
					tr = args["tr"], 
					ts = args["ts"], 
					genders = args["g"], 
					gloss = args["gloss"], 
					pos = args["pos"], 
					lit = args["lit"]
				},
				face,
				allowSelfLink
			)
	end
end

return export