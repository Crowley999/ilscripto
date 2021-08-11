local export = {}

-- Part of speech types that should not be pluralized.
local invariable = mw.loadData("Module:headword/data").invariable

function export.head_t(frame)
	local plain_param = {}
	local list_with_holes = {list = true, allow_holes = true}
	local boolean_list_with_holes = {list = true, allow_holes = true, type = "boolean"}
	local params = {
		[1] = {required = true, default = "und"},
		["sc"] = plain_param,
		["sort"] = plain_param,
		
		[2] = {required = true, default = "nouns"},
		["sccat"] = {type = "boolean"},
		["noposcat"] = {type = "boolean"},
		["nomultiwordcat"] = {type = "boolean"},
		["nogendercat"] = {type = "boolean"},
		["autotrinfl"] = {type = "boolean"},
		["cat2"] = plain_param,
		["cat3"] = plain_param,
		["cat4"] = plain_param,
		
		["head"] = {list = true, allow_holes = true, default = ""},
		["id"] = plain_param,
		["tr"] = list_with_holes,
		["ts"] = list_with_holes,
		["g"] = {list = true},
		
		[3] = list_with_holes,
		
		["f=accel-form"]     = list_with_holes,
		["f=accel-translit"] = list_with_holes,
		["f=accel-lemma"]    = list_with_holes,
		["f=accel-lemma-translit"] = list_with_holes,
		["f=accel-gender"]   = list_with_holes,
		["f=accel-nostore"]  = boolean_list_with_holes,
		["f=request"]        = list_with_holes,
		["f=alt"]            = list_with_holes,
		["f=sc"]             = list_with_holes,
		["f=id"]             = list_with_holes,
		["f=tr"]             = list_with_holes,
		["f=g"]              = list_with_holes,
		["f=qual"]           = list_with_holes,
		["f=autotr"]         = boolean_list_with_holes,
		["f=nolink"]         = boolean_list_with_holes,
		["f=lang"]           = list_with_holes,
	}
	
	local args = require("Module:parameters").process(frame:getParent().args, params)
	
	-- Get language and script information
	local data = {}
	data.lang = require("Module:languages").getByCode(args[1]) or require("Module:languages").err(args[1], 1)
	data.sort_key = args["sort"]
	data.heads = args["head"]
	data.id = args["id"]
	data.translits = args["tr"]
	data.transcriptions = args["ts"]
	data.genders = args["g"]
	
	-- Script
	data.sc = args["sc"] and require("Module:scripts").getByCode(args["sc"], "sc") or nil
	data.sccat = args["sccat"]

	-- Part-of-speech category
	data.pos_category = args[2]
	data.noposcat = args["noposcat"]
	
	if not data.pos_category:find("s$") and not invariable[data.pos_category] then
		-- Make the plural form of the part of speech
		if data.pos_category:find("x$") then -- prefix, suffix, confix, infix, circumfix, affix, interfix, transfix
			data.pos_category = data.pos_category .. "es"
		else
			data.pos_category = data.pos_category .. "s"
		end
	end
	
	if cat_sc then
		data.pos_category = data.pos_category .. " in " .. cat_sc:getCategoryName()
	end
	
	-- Additional categories
	data.categories = {}
	data.nomultiwordcat = args["nomultiwordcat"]
	data.nogendercat = args["nogendercat"]
	
	if args["cat2"] then
		table.insert(data.categories, data.lang:getCanonicalName() .. " " .. args["cat2"])
	end
	
	if args["cat3"] then
		table.insert(data.categories, data.lang:getCanonicalName() .. " " .. args["cat3"])
	end
	
	if args["cat4"] then
		table.insert(data.categories, data.lang:getCanonicalName() .. " " .. args["cat4"])
	end
	
	-- Inflected forms
	data.inflections = {enable_auto_translit = args["autotrinfl"]}
	
	for i = 1, math.ceil(args[3].maxindex / 2) do
		local infl_part = {
			label    = args[3][i * 2 - 1],
			accel    = args["faccel-form"][i] and {
				form      = args["faccel-form"][i],
				translit  = args["faccel-translit"][i],
				lemma     = args["faccel-lemma"][i],
				lemma_translit = args["faccel-lemma-translit"][i],
				gender    = args["faccel-gender"][i],
				nostore   = args["faccel-nostore"][i],
			} or nil,
			request  = args["frequest"][i],
			enable_auto_translit = args["fautotr"][i],
		}
		
		local form = {
			term       =  args[3][i * 2],
			alt        =  args["falt"][i],
			genders    =  args["fg"][i] and mw.text.split(args["fg"][i], ",") or {},
			id         =  args["fid"][i],
			lang       =  args["flang"][i],
			nolink     =  args["fnolink"][i],
			qualifiers = {args["fqual"][i]},
			sc         =  args["fsc"][i],
			translit   =  args["ftr"][i],
		}
		
		if form.lang then
			form.lang = require("Module:languages").getByCode(form.lang) or require("Module:languages").err(form.lang, "f" .. i .. "lang")
		end
		
		if form.sc then
			form.sc = require("Module:scripts").getByCode(form.sc) or error("The script code \"" .. form.sc .. "\" is not valid.")
		end
		
		-- If no term or alt is given, then the label is shown alone.
		if form.term or form.alt then
			table.insert(infl_part, form)
		end
		
		if infl_part.label == "or" then
			-- Append to the previous inflection part, if one exists
			if #infl_part > 0 and data.inflections[1] then
				table.insert(data.inflections[#data.inflections], form)
			end
		elseif infl_part.label then
			-- Add a new inflection part
			table.insert(data.inflections, infl_part)
		end
	end
	
	return require("Module:headword").full_headword(data)
end

return export