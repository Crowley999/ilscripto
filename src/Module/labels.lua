local m_labeldata = mw.loadData("Module:labels/data")
local m_utilities = require("Module:utilities")
local m_links = require("Module:links")

local export = {}

-- for testing
local force_cat = false

local function show_categories(data, lang, script, sort_key, script2, sort_key2, term_mode)
	local categories = {}
	local categories2 = {}
	
	local lang_code = lang:getCode()
	local canonical_name = lang:getCanonicalName()
	
	local topical_categories = data.topical_categories or {}
	local sense_categories = data.sense_categories or {}
	local pos_categories = data.pos_categories or {}
	local regional_categories = data.regional_categories or {}
	local plain_categories = data.plain_categories or {}

	local function insert_cat(cat)
		table.insert(categories, cat)
		
		if script then
			table.insert(categories, cat .. " in " .. script .. " script")
		end
		
		if script2 then
			table.insert(categories2, cat .. " in " .. script2 .. " script")
		end
	end

	for i, cat in ipairs(topical_categories) do
		insert_cat(lang_code .. ":" .. cat)
	end
	
	for i, cat in ipairs(sense_categories) do
		cat = (term_mode and cat .. " terms" ) or "terms with " .. cat .. " senses"
		insert_cat(canonical_name .. " " .. cat)
	end

	for i, cat in ipairs(pos_categories) do
		insert_cat(canonical_name .. " " .. cat)
	end
	
	for i, cat in ipairs(regional_categories) do
		insert_cat(cat .. " " .. canonical_name)
	end
	
	for i, cat in ipairs(plain_categories) do
		insert_cat(cat)
	end
	
	return	m_utilities.format_categories(categories, lang, sort_key, nil, force_cat) ..
			m_utilities.format_categories(categories2, lang, sort_key2, nil, force_cat)
end

function export.get_label_info(label, lang, already_seen, script, script2, sort_key, sort_key2, nocat, term_mode)
	local ret = {}
	local deprecated = false
	local categories = ""
	local alias
	if m_labeldata.deprecated[label] then
		deprecated = true
	end
	if m_labeldata.aliases[label] then
		alias = label
		label = m_labeldata.aliases[label]
	end
	if m_labeldata.deprecated[label] then
		deprecated = true
	end
	
	local data = m_labeldata.labels[label] or {}
	
	if data.track then
		require("Module:debug").track("labels/label/" .. label)
	end
	
	--[=[
		Do not use the data in the table if the current language
		is not in the "languages" list.
		
		If the original label was an alias, and was redirected to a label
		with a data file, go back to the original label.
		
		For example, suppose the label "Rome" is used with the language code "en" (English).
		"Rome" redirects to "Romanesco" in [[Module:labels/data/regional]].
		The only language in the "languages" list is "it" (Italian).
		Because the language code provided to the template was not "it",
		the label's data file will not be used,
		and the label will display as "Rome".
		
		tracking:	[[Special:WhatLinksHere/Template:tracking/labels/incorrect-language]]
					[[Special:WhatLinksHere/Template:tracking/labels/redirect-undone]]
	]=]
	if data.languages then
		local lang_code = lang:getCode()
		if not data.languages[lang_code] then
			require("Module:debug").track("labels/incorrect-language")
			mw.log("incorrect language in label template " .. lang_code .. ":" .. label)
			
			if alias and label ~= alias then
				require("Module:debug").track("labels/redirect-undone")
				mw.log("redirect undone in label template " .. lang_code .. ":" .. label .. " > " .. alias)
				label = alias
			end
			
			data = {}
		end
	end
	
	if data.special_display then
		local function add_language_name(str)
			if str == "canonical_name" then
				return lang:getCanonicalName()
			else
				return ""
			end
		end
		
		label = mw.ustring.gsub(data.special_display, "<([^>]+)>", add_language_name)
	else
		--[[
			If data.glossary or data.Wikipedia are set to true, there is a glossary definition
			with an anchor identical to the label, or a Wikipedia article with a title
			identical to the label.
				For example, the code
					labels["formal"] = {
						glossary = true,
					}
				indicates that there is a glossary entry for "formal".
				
			
			Otherwise, data.glossary and data.Wikipedia specify the title or the anchor.
		]]
		if data.glossary then
			local glossary_entry = type(data.glossary) == "string" and data.glossary or label
			label = "[[Appendix:Glossary#" .. glossary_entry .. "|" .. ( data.display or label ) .. "]]"
		elseif data.Wikipedia then
			Wikipedia_entry = type(data.Wikipedia) == "string" and data.Wikipedia or label
			label = "[[w:" .. Wikipedia_entry .. "|" .. ( data.display or label ) .. "]]"
		else
			label = data.display or label
		end
	end
	
	if deprecated then
		label = '<span class="deprecated-label">' .. label .. '</span>'
		if not nocat then
			categories = categories .. m_utilities.format_categories({ "Entries with deprecated labels" }, lang, sort_key, nil, force_cat)
		end
	end
	
	local label_for_already_seen =
		(data.topical_categories or data.regional_categories
		or data.plain_categories or data.pos_categories
		or data.sense_categories) and label
		or nil
	
	-- Track label text. If label text was previously used, don't show it,
	-- but include the categories.
	-- For an example, see [[hypocretin]].
	if already_seen[label_for_already_seen] then
		ret.label = ""
	else
		ret.label = label
	end
	
	if nocat then
		ret.categories = ""
	else
		ret.categories = categories .. show_categories(data, lang, script, sort_key, script2, sort_key2, term_mode)
	end

	ret.data = data

	if label_for_already_seen then
		already_seen[label_for_already_seen] = true
	end

	return ret
end
	

function export.show_labels(labels, lang, script, script2, sort_key, sort_key2, nocat, term_mode)
	if not labels[1] then
		if mw.title.getCurrentTitle().nsText == "Template" then
			labels = {"example"}
		else
			error("You must specify at least one label.")
		end
	end
	
	-- Show the labels
	local omit_preComma = false
	local omit_postComma = true
	local omit_preSpace = false
	local omit_postSpace = true
	
	local already_seen = {}
	
	for i, label in ipairs(labels) do
		omit_preComma = omit_postComma
		omit_postComma = false
		omit_preSpace = omit_postSpace
		omit_postSpace = false

		local ret = export.get_label_info(label, lang, already_seen, script, script2, sort_key, sort_key2, nocat, term_mode)
		
		local omit_comma = omit_preComma or ret.data.omit_preComma
		omit_postComma = ret.data.omit_postComma
		local omit_space = omit_preSpace or ret.data.omit_preSpace
		omit_postSpace = ret.data.omit_postSpace
		
		if ret.label == "" then
			label = ""
		else
			label = (omit_comma and "" or '<span class="ib-comma">,</span>') ..
					(omit_space and "" or "&#32;") ..
					ret.label
		end
		labels[i] = label .. ret.categories
	end
	
	return
		"<span class=\"ib-brac\">(</span><span class=\"ib-content\">" ..
		table.concat(labels, "") ..
		"</span><span class=\"ib-brac\">)</span>"
end

return export