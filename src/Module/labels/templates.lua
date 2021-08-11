local export = {}

--[=[
	Modules used:
	[[Module:labels]]
	[[Module:parameters]]
	[[Module:utilities]]
	[[Module:languages]]
	[[Module:template_link]]
]=]

function export.show(frame)
	local parent_args = frame:getParent().args
	local compat = (frame.args["compat"] or "") ~= "" and parent_args["lang"]
	local term_mode = (frame.args["term"] or "") ~= ""
	
	local params = {
		[1] = {required = true},
		[2] = {list = true},
		["nocat"] = {type = "boolean"},
		["script"] = {},
		["script2"] = {},
		["sort"] = {},
		["sort2"] = {},
	}
	
	if compat then
		params[1] = params[2]
		params[2] = nil
		params["lang"] = {required = true}
	end
	
	local args = require("Module:parameters").process(parent_args, params)
	
	-- Gather parameters
	local lang = args[compat and "lang" or 1]
	local labels = args[compat and 1 or 2]
	local nocat = args["nocat"]
	local script = args["script"]
	local script2 = args["script2"]
	local sort_key = args["sort"]
	local sort_key2 = args["sort2"]

	if not lang then
		if mw.title.getCurrentTitle().nsText == "Template" then
			lang = "und"
		else
			error("Language code has not been specified. Please provide it to the template using the first parameter.")
		end
	end
	
	lang = require("Module:languages").getByCode(lang) or require("Module:languages").err(lang, compat and "lang" or 1)
	
	return require("Module:labels").show_labels(labels, lang, script, script2, sort_key, sort_key2, nocat, term_mode)
end

--[[	temporary. intentionally undocumented.
		this function is only to be used in
		{{alternative spelling of}},
		{{eye dialect of}}
		and similar templates					]]
function export.show_from(frame)
	local m_labeldata = require("Module:labels/data")
	
	local froms = {}
	local categories = {}

	local iparams = {
		["lang"] = {},
		["limit"] = {type = "number"},
		["default"] = {},
	}
	
	local iargs = require("Module:parameters").process(frame.args, iparams)
	local parent_args = frame:getParent().args
	local compat = iargs["lang"] or parent_args["lang"]

	local params = {
		[compat and "lang" or 1] = {required = not iargs["lang"]},
		["from"] = {list = true},
		["nocat"] = {type = "boolean"},
	}

	-- This is called by various form-of templates. They accept several params,
	-- and some templates accept additional params. To avoid having to list all
	-- of them, we just ignore unrecognized params. The main processing for the
	-- form-of template will catch true unrecognized params.
	local args = require("Module:parameters").process(parent_args, params, "allow unrecognized params")
	local lang = args[compat and "lang" or 1] or iargs["lang"] or "und"
	local nocat = args["nocat"]
	local limit = iargs.limit or 99999
	
	local m_languages = require("Module:languages")
	lang = m_languages.getByCode(lang) or m_languages.err(lang, "lang")

	local already_seen = {}

	for i, k in ipairs(args["from"]) do
		if i > limit then
			break	
		end
		local ret = require("Module:labels").get_label_info(k, lang, already_seen)
		if ret.label ~= "" then
			table.insert(froms, ret.label)
		end
		if ret.categories ~= "" then
			table.insert(categories, ret.categories)
		end
	end
	
	if #froms == 0 then
		return iargs.default
	end

	return require("Module:table").serialCommaJoin(froms) .. table.concat(categories)
end

return export