local export = {}

-- For testing
local force_cat = false

--[[	If language is an etymology language, iterates through parent languages
		until it finds a non-etymology language. ]]
function export.getNonEtymological(lang)
	while lang:getType() == "etymology language" do
		local parentCode = lang:getParentCode()
		local parent = require("Module:languages").getByCode(parentCode)
			or require("Module:etymology languages").getByCode(parentCode)
			or require("Module:families").getByCode(parentCode)
		
		lang = parent
--		mw.log(terminfo.lang:getCode() .. " " .. terminfo.lang:getType())
	end
	
	return lang
end


local function termError(terminfo)
	if terminfo.lang:getType() == "family" then
		if terminfo.term and terminfo.term ~= "-" then
			require("Module:debug").track("etymology/family/has-term")
		end
		
		terminfo.term = "-"
	end
	return terminfo
end


local function createLink(terminfo, templateName)
	local link = ""
	
	if terminfo.term == "-" then
		--[=[
		[[Special:WhatLinksHere/Template:tracking/cognate/no-term]]
		[[Special:WhatLinksHere/Template:tracking/derived/no-term]]
		[[Special:WhatLinksHere/Template:tracking/borrowed/no-term]]
		[[Special:WhatLinksHere/Template:tracking/calque/no-term]]
		]=]
		require("Module:debug").track(templateName .. "/no-term")
	else
--		mw.log(terminfo.term)
		link = " " .. require("Module:links").full_link(terminfo, "term", true)
	end
	
	return link
end


function export.format_etyl(lang, source, sort_key, categories, nocat)
	local info = {}
	
	
	-- [[Special:WhatLinksHere/Template:tracking/etymology/sortkey]]
	if sort_key then
		require("Module:debug").track("etymology/sortkey")
	end
	
	if not categories then
		categories = {}
	end
	
	if source:getCode() == "und" then
		info = {
			display = "undetermined",
			cat_name = "other languages",
		}
	elseif source:getCode() == "mul" then
		info = {
			display = "[[w:Translingualism|translingual]]",
			cat_name = "Translingual",
		}
	elseif source:getCode() == "mul-tax" then
		info = {
			display = "[[w:taxonomic name|taxonomic name]]",
			cat_name = "taxonomic names",
		}
	else
		info.display = source:makeWikipediaLink()
		info.cat_name = source:getDisplayForm()
	end
	
	-- Add the categories, but only if there is a current language
	
	if lang and not nocat then
		local m_utilities = require("Module:utilities")
		
		if lang:getCode() == source:getCode() then
			table.insert(categories, lang:getCanonicalName() .. " twice-borrowed terms")
		else
			table.insert(categories, lang:getCanonicalName() .. " terms derived from " .. info.cat_name)
		end
		
		categories = m_utilities.format_categories(categories, lang, sort_key, nil, force_cat)
	else
		categories = ""
	end
	
	return "<span class=\"etyl\">" .. info.display .. categories .. "</span>"
end


-- Internal implementation of {{cognate|...}} template
function export.format_cognate(terminfo, sort_key)
	return export.format_derived(nil, terminfo, sort_key, nil, "cognate")
end


-- Internal implementation of {{derived|...}} template
function export.format_derived(lang, terminfo, sort_key, nocat, templateName)
	local source = terminfo.lang
	
	terminfo.lang = export.getNonEtymological(terminfo.lang)

	terminfo = termError(terminfo)
	
	local link = createLink(terminfo, templateName or "derived")
	
	return export.format_etyl(lang, source, sort_key, nil, nocat) .. link
end


-- Internal implementation of {{inherited|...}} template
function export.format_inherited(lang, terminfo, sort_key, nocat)
	local source = terminfo.lang

	terminfo = termError(terminfo)
	
	terminfo.lang = export.getNonEtymological(terminfo.lang)

	if not lang:hasAncestor(terminfo.lang) and mw.title.getCurrentTitle().nsText ~= "Template" then
		local function showLanguage(lang)
			return ("[[:Category:%s|%s]] (%s)")
				:format(lang:getCategoryName(), lang:getCanonicalName(), lang:getCode())
		end
		local postscript
		local ancestors = lang:getAncestors()
		local moduleLink = "[[Module:"
			.. require("Module:languages").getDataModuleName(lang:getCode())
			.. "]]"
		if not ancestors[1] then
			postscript = showLanguage(lang) .. " has no ancestors."
		else
			local ancestorList = table.concat(
				require("Module:fun").map(
					showLanguage,
					ancestors),
				" and ")
			postscript = ("The ancestor%s of %s %s %s."):format(
				ancestors[2] and "s" or "", lang:getCanonicalName(),
				ancestors[2] and "are" or "is", ancestorList)
		end
		error(("%s is not set as an ancestor of %s in %s. %s")
			:format(showLanguage(terminfo.lang), showLanguage(lang), moduleLink, postscript))
	end
	
	local categories = {}
	
	local link = createLink(terminfo, "inherited")
	
	table.insert(categories, lang:getCanonicalName() .. " terms inherited from " .. source:getCanonicalName())
	
	return export.format_etyl(lang, source, sort_key, categories, nocat) .. link
end


-- Internal implementation of {{borrowed|...}} template
function export.format_borrowed(lang, terminfo, sort_key, nocap, notext, nocat, borrowing_type)
	local source = terminfo.lang
	
	terminfo.lang = export.getNonEtymological(terminfo.lang)
	
	terminfo = termError(terminfo)
	
	local text = ""
	local categories = {}

	if lang:getCode() == source:getCode() then
		table.insert(categories, lang:getCanonicalName() .. " twice-borrowed terms")
	else
		table.insert(categories, lang:getCanonicalName() .. " terms borrowed from " .. source:getDisplayForm())
	end

	if not notext then
		if borrowing_type == "learned" then
			text = "[[learned borrowing|" .. (nocap and "l" or "L") .. "earned borrowing]] from "
		elseif borrowing_type == "semi-learned" then
			text = "[[semi-learned borrowing|" .. (nocap and "s" or "S") .. "emi-learned borrowing]] from "
		elseif borrowing_type == "orthographic" then
			text = "[[orthographic|" .. (nocap and "o" or "O") .. "rthographic]] [[Appendix:Glossary#borrowing|borrowing]] from "
		elseif borrowing_type == "unadapted" then
			text = "[[Appendix:Glossary#unadapted borrowing|" .. (nocap and "u" or "U") .. "nadapted borrowing]] from "
		else
			text = "[[Appendix:Glossary#loanword|Borrowing]] from "
		end
	end

	if borrowing_type ~= "plain" and lang:getCode() ~= source:getCode() then
		-- For non-plain borrowings, insert extra category, unless lang and source
		-- are the same (a twice-borrowed term).
		table.insert(categories, lang:getCanonicalName() .. " " .. borrowing_type .. " borrowings from " ..
			source:getDisplayForm())
	end
	
	local link = createLink(terminfo, "borrowed")
	
	return text .. export.format_etyl(lang, source, sort_key, categories, nocat) .. link
end


local function specialized_borrowing(lang, terminfo, sort_key, nocat, pre_text, template_name, category)
	local result = pre_text
	
	local source = terminfo.lang
	
	terminfo.lang = export.getNonEtymological(terminfo.lang)

	terminfo = termError(terminfo)

	local categories = {}

	category = category:gsub("SOURCE", source:getDisplayForm())
	table.insert(categories, lang:getCanonicalName() .. " " .. category)
	
	local link = createLink(terminfo, template_name)
	
	result = result .. " " ..  export.format_etyl(lang, source, sort_key, categories, nocat) .. link
	
	return result
end


-- Internal implementation of {{calque|...}} template
function export.calque(lang, terminfo, sort_key, nocap, notext, nocat)
	local pre_text = ""
	
	if not notext then
		pre_text = pre_text .. "[[Appendix:Glossary#calque|" .. (nocap and "c" or "C") .. "alque]] of "
	end

	return specialized_borrowing(lang, terminfo, sort_key, nocat, pre_text, "calque", "terms calqued from SOURCE")
end


-- Internal implementation of {{partial calque|...}} template
function export.partial_calque(lang, terminfo, sort_key, nocap, notext, nocat)
	local pre_text = ""
	
	if not notext then
		pre_text = pre_text .. "[[Appendix:Glossary#partial calque|" .. (nocap and "p" or "P") .. "artial calque]] of "
	end

	return specialized_borrowing(lang, terminfo, sort_key, nocat, pre_text, "partial_calque", "terms partially calqued from SOURCE")
end


-- Internal implementation of {{semantic loan|...}} template
function export.semantic_loan(lang, terminfo, sort_key, nocap, notext, nocat)
	if nocap then
		require("Module:debug").track("semantic_loan/nocap")
	end

	local pre_text = ""
	
	if not notext then
		pre_text = pre_text .. "[[Appendix:Glossary#semantic loan|" .. (nocap and "s" or "S") .. "emantic loan]] from "
	end

	return specialized_borrowing(lang, terminfo, sort_key, nocat, pre_text, "semantic_loan", "semantic loans from SOURCE")
end

-- Internal implementation of {{phono-semantic matching|...}} template
function export.phono_semantic_matching(lang, terminfo, sort_key, nocap, notext, nocat)
	if nocap then
		require("Module:debug").track("phono_semantic_matching/nocap")
	end

	local pre_text = ""
	
	if not notext then
		-- FIXME, create entry in [[Appendix:Glossary]]
		pre_text = pre_text .. "[[w:Phono-semantic matching|" .. (nocap and "p" or "P") .. "hono-semantic matching]] of "
	end

	return specialized_borrowing(lang, terminfo, sort_key, nocat, pre_text, "phono_semantic_matching", "phono-semantic matchings from SOURCE")
end

return export