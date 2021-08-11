local export = {}
local m_templateparser = require("Module:templateparser")

local function track(page)
	--[[Special:WhatLinksHere/Template:tracking/descendants tree/PAGE]]
	return require("Module:debug").track("descendants tree/" .. page)
end


local function language_header_error(entry_name, language_name)
	mw.log("No header for " .. language_name .. " was found in the entry [["
			.. entry_name .. "]].")
	track("language header not found")
end

local function get_content_after_senseid(content, entry_name, lang, id)
	local code = lang:getCode()
	local t_start = nil
	local t_end = nil
	for name, args, _, index in m_templateparser.findTemplates(content) do
		if name == "senseid" and args[1] == code and args[2] == id then
			t_start = index
		elseif name == "etymid" then
			if args[1] == code and args[2] == id then
				t_start = index
			elseif t_start ~= nil and t_end == nil then
				t_end = index
			end
		elseif name == "head" and args[1] == code then
			if args["id"] == id then
				t_start = index
			elseif args["id"] ~= nil and t_start ~= nil and t_end == nil then
				t_end = index
			end
		end
	end
	
	if t_start == nil then
		error("Could not find the correct senseid template in the entry [["
		.. entry_name .. "]] (with language " .. code .. " and id '" .. id .. "')")
	end
	
	if t_end == nil then
		-- terminate on L2 or another "Etymology ..." header
		-- match L2 and remove it and everything after it
		content = string.gsub(content:sub(t_start), "\n==[^=].+$", "")
		-- match Etymology header and remove it and everything after it
		content = string.gsub(content, "\n===+%s*Etymology.+$", "")
		return content
	end
	
	return content:sub(t_start, t_end)
end

function export.getAlternativeForms(lang, term, id)
	local entry_name = require("Module:links").getLinkPage(term, lang)
	local page = mw.title.new(entry_name)
	local content = page:getContent()
	
	if not content then
		-- FIXME, should be an error
		track("alts-nonexistent-page")
		return ""
	end
	
	local _, index = string.find(content,
		"==[ \t]*" .. require("Module:string").pattern_escape(lang:getCanonicalName()) .. "[ \t]*==")
	
	if not index then
		language_header_error(entry_name, lang:getCanonicalName())
		-- FIXME, should be an error
		track("alts-lang-not-found")
		return ""
	end

	if id then
		content = get_content_after_senseid(content, entry_name, lang, id)
		index = 0
	end
	
	local _, next_lang = string.find(content, "\n==[^=\n]+==", index, false)
	local _, index = string.find(content, "\n(====?=?)[ \t]*Alternative forms[ \t]*%1", index, false)
	
	local langCodeRegex = require("Module:string").pattern_escape(lang:getCode())
	index = string.find(content, "{{alte?r?|" .. langCodeRegex .. "|[^|}]+", index)
	if (not index) or (next_lang and next_lang < index) then
		-- FIXME, should be an error
		track("alts-alter-not-found")
		return ""
	end
	
	local next_section = string.find(content, "\n(=+)[^=]+%1", index)
	
	local alternative_forms_section = string.sub(content, index, next_section)
	
	local parameters_list
	
	-- This assumes that there are no nested templates in {{alter}}.
	for alternative_form_template_parameters in string.gmatch(alternative_forms_section,
		"{{alte?r?|" .. langCodeRegex .. "|(.-)}}") do
		local double_pipe_pos = string.find(alternative_form_template_parameters, "||", 1, true)
		local term_parameters = string.sub(alternative_form_template_parameters, 1,
			double_pipe_pos and double_pipe_pos - 1)
		
		if term_parameters then
			parameters_list = mw.text.split(term_parameters, "|")
			break
		end
	end
	
	if not parameters_list or #parameters_list == 0 then
		-- FIXME, should be an error
		track("alts-alter-no-params")
		return ""
	end
	
	local terms_list = {}
	
	local items = {
		t = {},
		id = {},
		alt = {},
		tr = {},
		ts = {},
		g = {}
	}
	
	for _, parameter in ipairs(parameters_list) do
		local parameterName, value = string.match(parameter, "^([^=]+)=(.+)$")
		if parameterName and value then
			local item_type, index = string.match(parameterName, "(%D+)(%d)")
			if item_type and index and items[item_type] then
				items[item_type][tonumber(index)] = value
			elseif parameterName == "sc" then
				items.sc = value
			elseif items[parameterName] then
				items[parameterName][1] = value
			end
		else
			table.insert(terms_list, parameter)
		end
	end
	
	local i = 1
	while true do
		local term = terms_list[i]
		local alt, tr, ts, g, t = items.alt[i], items.tr[i], items.ts[i], items.g[i], items.t[i]
		if not (term or alt or tr or ts or g or t) then
			break
		end
		local sc
		if items.sc then
			sc = require "Module:scripts".getByCode(items.sc)
		end
		terms_list[i] = require("Module:links").full_link({
			term = term,
			lang = lang,
			sc = sc,
			alt = alt,
			tr = tr,
			ts = ts,
			genders = g,
			gloss = t
		}, nil, true)
		i = i + 1
	end
	
	return ", " .. table.concat(terms_list, ", ")
end

function export.getDescendants(lang, term, id, noerror)
	local entry_name = require("Module:links").getLinkPage(term, lang)
	local page = mw.title.new(entry_name)
	local content = page:getContent()
	
	if not content then
		-- FIXME, should be an error
		track("desctree-nonexistent-page")
		return ""
	end
	
	-- Ignore columns and blank lines
	content = string.gsub(content, "{{top%d}}%s", "")
	content = string.gsub(content, "{{mid%d}}%s", "")
	content = string.gsub(content, "{{bottom}}%s", "")
	content = string.gsub(content, "\n?{{(desc?%-%l+)|?[^}]*}}",
		function (template_name)
			if template_name == "desc-top" or template_name == "desc-bottom" or template_name == "des-top" or template_name == "des-mid" or template_name == "des-bottom" then
				return ""
			end
		end)
	content = string.gsub(content, "\n%s*\n", "\n")
	
	local _, index = string.find(content,
		"%f[^\n%z]==[ \t]*" .. lang:getCanonicalName() .. "[ \t]*==", nil, true)
	if not index then
		_, index = string.find(content, "%f[^\n%z]==[ \t]*"
				.. require("Module:utilities").pattern_escape(lang:getCanonicalName())
				.. "[ \t]*==", nil, false)
	end
	if not index then
		language_header_error(entry_name, lang:getCanonicalName())
		-- FIXME, should be an error
		track("desctree-lang-not-found")
		return ""
	end

	if id then
		content = get_content_after_senseid(content, entry_name, lang, id)
		index = 0
	end

	local _, next_lang = string.find(content, "\n==[^=\n]+==", index, false)
	local _, index = string.find(content, "\n(====*)[ \t]*Descendants[ \t]*%1", index, false)
	if not index then
		if noerror then
			track("desctree-no-descendants")
			return nil
		else
			error("No Descendants section was found in the entry [[" .. entry_name .. "]].")
		end
	elseif next_lang and next_lang < index then
		if noerror then
			track("desctree-no-descendants-in-lang-section")
			return nil
		else
			error("No Descendants section was found in the entry [[" .. entry_name
					.. "]] under the header for " .. lang:getCanonicalName() .. ".")
		end
	end
	
	-- Skip past final equals sign.
	index = index + 1
	
	-- Skip past spaces or tabs or HTML comments.
	while true do
		local new_index = string.match(content, "^[ \t]+()", index)
			or string.match(content, "^<!%-%-.-%-%->()", index)
		if not new_index then
			break
		end
		index = new_index
	end
	
	local items = require("Module:array")()
	local frame = mw.getCurrentFrame()
	local previous_list_markers = ""
	
	-- Skip paragraphs at beginning of Descendants section.
	while true do
		local new_index = content:match("^\n[^%*:=][^\n]*()", index)
		if not new_index then
			break
		else
			index = new_index
		end
	end
	
	previous_index = 1
	
	-- Find a consecutive series of list items that begins directly after the
	-- Descendants header.
	-- start_index and previous_index are used to check that list items are
	-- consecutive.
	for start_index, list_markers, item, index in string.gmatch(content:sub(index), "()\n([%*:]+) *([^\n]+)()") do
		if start_index ~= previous_index then
			break
		end
		
		-- Preprocess, but replace recursive calls to avoid template loop errors
		item = string.gsub(item, "{{desctree|", "{{#invoke:etymology/templates|descendants_tree|")
		item = frame:preprocess(item)
		
		local difference = #list_markers - #previous_list_markers
		
		if difference > 0 then
			for i = #previous_list_markers + 1, #list_markers  do
				items:insert(list_markers:sub(i, i) == "*" and "<ul>" or "<dl>")
			end
		else
			if difference < 0 then
				for i = #previous_list_markers, #list_markers + 1, -1 do
					items:insert(previous_list_markers:sub(i, i) == "*" and "</li></ul>" or "</dd></dl>")
				end
			else
				items:insert(previous_list_markers:sub(-1, -1) == "*" and "</li>" or "</dd>")
			end
			
			if previous_list_markers:sub(#list_markers, #list_markers) ~= list_markers:sub(-1, -1) then
				items:insert(list_markers:sub(-1, -1) == "*" and "</dl><ul>" or "</ul><dl>")
			end
		end
		
		items:insert(list_markers:sub(-1, -1) == "*" and "<li>" or "<dd>")
		
		items:insert(item)
		
		previous_list_markers = list_markers
		previous_index = index
	end
	
	for i = #previous_list_markers, 1, -1 do
		items:insert(previous_list_markers:sub(i, i) == "*" and "</li></ul>" or "</dd></dl>")
	end
	
	return items:concat()
end

return export