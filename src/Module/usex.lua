local export = {}

local translit_data = mw.loadData("Module:transliteration/data")
local needs_translit = translit_data[1]

-- microformat2 classes, see https://phabricator.wikimedia.org/T138709
local class = {
	container_ux = 'h-usage-example',
	container_quotation = 'h-quotation',
	example = 'e-example',
	quotation = 'e-quotation',
	quotation_with_citation = 'e-quotation cited-passage',
	translation = 'e-translation',
	-- The following are added by [[Module:script utilities]], using [[Module:script utilities/data]]
--	transliteration = 'e-transliteration',	
--	transcription = 'e-transcription',
	literally = 'e-literally',
	source = 'e-source',
	footer = 'e-footer'
}

-- helper functions

local function wrap(tag, class, text, lang)
	if lang then
		lang = ' lang="' .. lang .. '"'
	else
		lang = ""
	end
	
	if text and class then
		return table.concat{'<', tag, ' class="', class, '"', lang, '>', text, '</', tag, '>'}
	else
		return nil
	end
end

local function span(class, text) return wrap('span', class, text) end
local function div(class, text) return wrap('div', class, text) end

function export.format_usex(data)
	local namespace = mw.title.getCurrentTitle().nsText

	local lang, sc, usex, translation, transliteration, transcription, noenum,
		inline, ref, quote, lit, substs, qualifiers, source, nocat, brackets, footer,
		sortkey =
			data.lang, data.sc, data.usex, data.translation, data.transliteration,
			data.transcription, data.noenum, data.inline, data.ref, data.quote,
			data.lit, data.substs, data.qualifiers, data.source, data.nocat,
			data.brackets, data.footer, data.sortkey

	--[[
	if lang:getType() == "reconstructed" or namespace == "Reconstruction" then
		error("Reconstructed languages and reconstructed terms cannot have usage examples, as we have no record of their use.")
	end
	]]
	
	if lit then
		lit = "(literally, “" .. span(class.literally, lit) .. "”)"
	end

	if source then
		source = "(" .. span(class.source, source) .. ")"
	end

	if footer then
		footer = span(class.footer, footer)
	end
	
	local example_type = quote and "quote" or "usage example" -- used in error messages
	local categories = {}

	if not sc then
		sc = require("Module:scripts").findBestScript(usex, lang)
	end

	-- tr=- means omit transliteration altogether
	if transliteration == "-" then
		transliteration = nil
	else
		-- Try to auto-transliterate
		if not transliteration and usex then
			local subbed_usex = require("Module:links").remove_links(usex)

			if substs then
				--[=[
				[[Special:WhatLinksHere/Template:tracking/quote/substs]]
				[[Special:WhatLinksHere/Template:tracking/usex/substs]]
				]=]
				
				if quote then
					require("Module:debug").track("quote/substs")
				else
					require("Module:debug").track("usex/substs")
				end
				
				local substs = mw.text.split(substs, ",")
				for _, subpair in ipairs(substs) do
					local subsplit = mw.text.split(subpair, mw.ustring.find(subpair, "//") and "//" or "/")
					subbed_usex = mw.ustring.gsub(subbed_usex, subsplit[1], subsplit[2])
				end
			end

			transliteration = lang:transliterate(subbed_usex, sc)
		end

		-- If there is still no transliteration, then add a cleanup category
		if not transliteration and needs_translit[lang] then
			table.insert(categories, "Requests for transliteration of " .. lang:getCanonicalName() .. " terms")
		end
	end
	if transliteration then
		transliteration = require("Module:script utilities").tag_translit(transliteration, lang:getCode(), "usex")
	end
	if transcription then
		transcription = require("Module:script utilities").tag_transcription(transcription, lang:getCode(), "usex")
	end

	if translation == "-" then
		translation = nil
		table.insert(categories, "Omitted translation in the main namespace")
	elseif translation then
		translation = span(class.translation, translation)
	elseif lang:getCode() ~= "en" and lang:getCode() ~= "und" then
		-- add trreq category if translation is unspecified and language is not english or undetermined
		table.insert(categories, "Requests for translations of " .. lang:getCanonicalName() .. " usage examples")
		translation = "<small>(please add an English translation of this " .. example_type .. ")</small>"
	end

	if usex then
		if usex:find("[[", 1, true) then
			usex = require("Module:links").language_link({term = usex, lang = lang}, false)
		end
		
		local face
		if quote then
			face = nil
		else
			face = "term"
		end
		
		if not nocat and namespace == "" or namespace == "Reconstruction" then
			if quote then
				table.insert(categories, lang:getCanonicalName() .. " terms with quotations")
			else
				table.insert(categories, lang:getCanonicalName() .. " terms with usage examples")
			end
		end
		
		usex = require("Module:script utilities").tag_text(usex, lang, sc, face,
			quote == "quote-meta" and class.quotation_with_citation or
			quote and class.quotation or class.example)
	else
		if transliteration then
			table.insert(categories, "Requests for native script in " .. lang:getCanonicalName() .. " usage examples")
		end
		
		-- TODO: Trigger some kind of error here
		usex = "<small>(please add the primary text of this " .. example_type .. ")</small>"
	end

	local result = {}
	
	if sc:getDirection() == "rtl" then
		usex = "&rlm;" .. usex .. "&lrm;"
	end
	
	table.insert(result, usex)
	
	if #qualifiers > 0 then
		table.insert(result, " " .. require("Module:qualifier").format_qualifier(qualifiers))
	end
	
	table.insert(result, ref)
	
	if inline then
		if transliteration then
			table.insert(result, " ― " .. transliteration)
			if transcription then
				table.insert(result, " /" .. transcription .. "/")
			end
		elseif transcription then
			table.insert(result, " ― /" .. transcription .. "/")
		end

		if translation then
			table.insert(result, " ― " .. translation)
		end

		if lit then
			table.insert(result, " " .. lit)
		end
		
		if source then
			table.insert(result, " " .. source)
		end

		if footer then
			table.insert(result, " " .. footer)
		end

		if brackets then
			table.insert(result, "]")
		end
	elseif transliteration or translation or transcription or lit or source or footer then
		table.insert(result, "<dl>")
		local closing_tag = ""

		if transliteration then
			table.insert(result, closing_tag)
			table.insert(result, "<dd>" .. transliteration)
			closing_tag = "</dd>"
		end
		
		if transcription then
			table.insert(result, closing_tag)
			table.insert(result, "<dd>/" .. transcription .. "/")
			closing_tag = "</dd>"
		end
		
		if translation then
			table.insert(result, closing_tag)
			table.insert(result, "<dd>" .. translation)
			closing_tag = "</dd>"
		end

		if lit then
			table.insert(result, closing_tag)
			table.insert(result, "<dd>" .. lit)
			closing_tag = "</dd>"
		end

		local extra_indent, closing_extra_indent
		if transliteration or transcription or translation or lit then
			extra_indent = "<dd><dl><dd>"
			closing_extra_indent = "</dd></dl></dd>"
		else
			extra_indent = "<dd>"
			closing_extra_indent = "</dd>"
		end
		if source then
			table.insert(result, closing_tag)
			table.insert(result, extra_indent .. source)
			closing_tag = closing_extra_indent
		end

		if footer then
			table.insert(result, closing_tag)
			table.insert(result, extra_indent .. footer)
			closing_tag = closing_extra_indent
		end

		if brackets then
			table.insert(result, "]")
		end
		
		table.insert(result, closing_tag)

		table.insert(result, "</dl>")
	else
		if brackets then
			table.insert(result, "]")
		end
	end
	
	result = table.concat(result)
	result = div(quote and class.container_quotation or class.container_ux, result)
	result = result .. require("Module:utilities").format_categories(categories, lang, sortkey)
	if noenum then
		result = "\n: " .. result
	end
	return result
end

return export