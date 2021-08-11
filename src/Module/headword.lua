local export = {}

local m_data = mw.loadData("Module:headword/data")

local title = mw.title.getCurrentTitle()

local isLemma = m_data.lemmas
local isNonLemma = m_data.nonlemmas
local notranslit = m_data.notranslit
local toBeTagged = m_data.toBeTagged

-- If set to true, categories always appear, even in non-mainspace pages
local test_force_categories = false

local function test_script(text, script_code)
	if type(text) == "string" and type(script_code) == "string" then
		local sc = require("Module:scripts").getByCode(script_code)
		local characters
		if sc then
			characters = sc:getCharacters()
		end
		
		local out
		if characters then
			text = mw.ustring.gsub(text, "%W", "")
			out = mw.ustring.find(text, "[" .. characters .. "]")
		end
		
		if out then
			return true
		else
			return false
		end
	else
		mw.log("Parameters to test_script were incorrect.")
		return nil
	end
end


local spacingPunctuation = "[%s%p]+"
--[[ List of punctuation or spacing characters that are found inside of words.
	 Used to exclude characters from the regex above. ]]
local wordPunc = "-־׳״'.·*’་•"
local notWordPunc = "[^" .. wordPunc .. "]+"


-- Return true if the given head is multiword according to the algorithm used
-- in full_headword().
function export.head_is_multiword(head)
	for possibleWordBreak in mw.ustring.gmatch(head, spacingPunctuation) do
		if mw.ustring.find(possibleWordBreak, notWordPunc) then
			return true
		end
	end

	return false
end


-- Add links to a multiword head.
function export.add_multiword_links(head)
	local function workaround_to_exclude_chars(s)
		return mw.ustring.gsub(s, notWordPunc, "]]%1[[")
	end
	
	head = "[["
		.. mw.ustring.gsub(
			head,
			spacingPunctuation,
			workaround_to_exclude_chars
			)
		.. "]]"
	--[=[
	use this when workaround is no longer needed:
	head = "[["
		.. mw.ustring.gsub(head, WORDBREAKCHARS, "]]%1[[")
		.. "]]"
	
	Remove any empty links, which could have been created above
	at the beginning or end of the string.
	]=]
	head = mw.ustring.gsub(head, "%[%[%]%]", "")
	return head
end


local function non_categorizable()
	return (title:inNamespace("") and title.text:find("^Unsupported titles/"))
		or (title:inNamespace("Appendix") and title.text:find("^Gestures/"))
end


local function preprocess(data, postype)
	--[=[
	[[Special:WhatLinksHere/Template:tracking/headword/heads-not-table]]
	[[Special:WhatLinksHere/Template:tracking/headword/translits-not-table]]
	]=]
	if type(data.heads) ~= "table" then
		if data.heads then
			require("Module:debug").track("headword/heads-not-table")
		end
		
		data.heads = { data.heads }
	end
	
	if type(data.translits) ~= "table" then
		if data.translits then
			require("Module:debug").track("headword/translits-not-table")
		end
		
		data.translits = { data.translits }
	end
	
	if type(data.transcriptions) ~= "table" then
		if data.transcriptions then
			require("Module:debug").track("headword/transcriptions-not-table")
		end
		
		data.transcriptions = { data.transcriptions }
	end
	
	if not data.heads or #data.heads == 0 then
		data.heads = {""}
	end
	
	-- Determine if term is reconstructed
	local is_reconstructed = data.lang:getType() == "reconstructed"
		or title.nsText == "Reconstruction"
	
	-- Create a default headword.
	local subpagename = title.subpageText
	local pagename = title.text
	local default_head
	if is_reconstructed then
		default_head = require("Module:utilities").plain_gsub(pagename, data.lang:getCanonicalName() .. "/", "")
	else
		default_head = subpagename
	end

	local unmodified_default_head = default_head

	-- Add links to multi-word page names when appropriate
	if data.lang:getCode() ~= "zh" and (not is_reconstructed) and
			export.head_is_multiword(default_head) then
		default_head = export.add_multiword_links(default_head)
	end
	
	if is_reconstructed then
		default_head = "*" .. default_head
	end
	
	-- If a head is the empty string "", then replace it with the default
	for i, head in ipairs(data.heads) do
		if head == "" then
			head = default_head
		else
			if head == default_head and data.lang:getCanonicalName() == "English" then
				table.insert(data.categories, data.lang:getCanonicalName() .. " terms with redundant head parameter")
			end			
		end
		data.heads[i] = head
	end

	-- If the first head is multiword (after removing links), maybe insert into "LANG multiword terms"
	if not data.nomultiwordcat and postype == "lemma" and not m_data.no_multiword_cat[data.lang:getCode()] then
		-- Check for spaces or hyphens, but exclude prefixes and suffixes.
		-- Use the pagename, not the head= value, because the latter may have extra
		-- junk in it, e.g. superscripted text that throws off the algorithm.
		local checkpattern = ".[%s%-]."
		if m_data.hyphen_not_multiword_sep[data.lang:getCode()] then
			-- Exclude hyphens if the data module states that they should for this language
			checkpattern = ".[%s]."
		end
		if mw.ustring.find(unmodified_default_head, checkpattern) and not non_categorizable() then
			table.insert(data.categories, data.lang:getCanonicalName() .. " multiword terms")
		end
	end

	--[[	Try to detect the script if it was not provided
			We use the first headword for this, and assume
			that all of them have the same script
			This *should* always be true, right?		]]
	if not data.sc then
		data.sc = require("Module:scripts").findBestScript(data.heads[1], data.lang)
	end
	
	for i, val in pairs(data.translits) do
		data.translits[i] = {display = val, is_manual = true}
	end
	
	-- Make transliterations
	for i, head in ipairs(data.heads) do
		local translit = data.translits[i]
		
		-- Try to generate a transliteration if necessary
		-- Generate it if the script is not Latn or similar, and if no transliteration was provided
		if translit and translit.display == "-" then
			translit = nil
		elseif not translit and not (data.sc:getCode():find("Latn", nil, true) or data.sc:getCode() == "Latinx" or data.sc:getCode() == "None") and (not data.sc or data.sc:getCode() ~= "Imag") then
			translit = data.lang:transliterate(require("Module:links").remove_links(head), data.sc)
			
			-- There is still no transliteration?
			-- Add the entry to a cleanup category.
			if not translit and not notranslit[data.lang:getCode()] then
				translit = "<small>transliteration needed</small>"
				table.insert(data.categories, "Requests for transliteration of " .. data.lang:getCanonicalName() .. " terms")
			end
			
			if translit then
				translit = {display = translit, is_manual = false}
			end
		end
		
		-- Link to the transliteration entry for languages that require this
		if translit and data.lang:link_tr() then
			translit.display = require("Module:links").full_link{
				term = translit.display,
				lang = data.lang,
				sc = require("Module:scripts").getByCode("Latn"),
				tr = "-"
				}
		end
		
		data.translits[i] = translit
	end
	
	if data.id and type(data.id) ~= "string" then
		error("The id in the data table should be a string.")
	end
end


-- Format a headword with transliterations
local function format_headword(data)
	local m_links = require("Module:links")
	local m_scriptutils = require("Module:script utilities")
	
	-- Are there non-empty transliterations?
	-- Need to do it this way because translit[1] might be nil while translit[2] is not
	local has_translits = false
	local has_manual_translits = false
	
	-- Format the headwords
	for i, head in ipairs(data.heads) do
		if data.translits[i] or data.transcriptions[i] then
			has_translits = true
		end
		if data.translits[i] and data.translits[i].is_manual or data.transcriptions[i] then
			has_manual_translits = true
		end
		
		-- Apply processing to the headword, for formatting links and such
		if head:find("[[", nil, true) and (not data.sc or data.sc:getCode() ~= "Imag") then
			head = m_links.language_link({term = head, lang = data.lang}, false)
		end
		
		-- Add language and script wrapper
		if i == 1 then
			head = m_scriptutils.tag_text(head, data.lang, data.sc, "head", nil, data.id)
		else
			head = m_scriptutils.tag_text(head, data.lang, data.sc, "head", nil)
		end
		
		data.heads[i] = head
	end
	
	local translits_formatted = ""

	if has_manual_translits then
		-- [[Special:WhatLinksHere/Template:tracking/headword/has-manual-translit/LANG]]
		require("Module:debug").track("headword/has-manual-translit/" .. data.lang:getCode())
	end
		
	if has_translits then

		-- Format the transliterations
		local translits = data.translits
		local transcriptions = data.transcriptions
		
		if translits then
			-- using pairs() instead of ipairs() in case there is a gap
			for i, _ in pairs(translits) do
				if type(i) == "number" then
					translits[i] = m_scriptutils.tag_translit(translits[i].display, data.lang:getCode(), "head", nil, translits[i].is_manual)
				end
			end
		end

		if transcriptions then
			for i, _ in pairs(transcriptions) do
				if type(i) == "number" then
					transcriptions[i] = m_scriptutils.tag_transcription(transcriptions[i], data.lang:getCode(), "head")
				end
			end
		end

		for i = 1, math.max(#translits, #transcriptions) do
			local translits_formatted = {}
			table.insert(translits_formatted, translits[i] and translits[i] or "")
			table.insert(translits_formatted, (translits[i] and transcriptions[i]) and " " or "")
			table.insert(translits_formatted, transcriptions[i] and "/" .. transcriptions[i] .. "/" or "")
			data.translits[i] = table.concat(translits_formatted)
		end
		
		translits_formatted = " (" .. table.concat(data.translits, " <i>or</i> ") .. ")"
		
		local transliteration_page = mw.title.new(data.lang:getCanonicalName() .. " transliteration", "Wiktionary")
		
		if transliteration_page then
			local success, exists = pcall(function () return transliteration_page.exists end)
			if success and exists then
				translits_formatted = " [[Wiktionary:" .. data.lang:getCanonicalName() .. " transliteration|•]]" .. translits_formatted
			end
		end
	end
	
	return table.concat(data.heads, " <i>or</i> ") .. translits_formatted
end


local function format_genders(data)
	if data.genders and #data.genders > 0 then
		local pos_for_cat
		if not data.nogendercat and not m_data.no_gender_cat[data.lang:getCode()] then
			local pos_category = data.pos_category:gsub("^reconstructed ", "")
			pos_for_cat = m_data.pos_for_gender_number_cat[pos_category]
		end
		local gen = require("Module:gender and number")
		local text, cats = gen.format_genders(data.genders, data.lang, pos_for_cat)
		for _, cat in ipairs(cats) do
			table.insert(data.categories, cat)
		end
		return "&nbsp;" .. text
	else
		return ""
	end
end


local function format_inflection_parts(data, parts)
	local m_links = require("Module:links")
	
	for key, part in ipairs(parts) do
		if type(part) ~= "table" then
			part = {term = part}
		end
		
		local qualifiers
		local reftext
		
		if part.qualifiers and #part.qualifiers > 0 then
			qualifiers = require("Module:qualifier").format_qualifier(part.qualifiers) .. " "
			
			-- [[Special:WhatLinksHere/Template:tracking/headword/qualifier]]
			require("Module:debug").track("headword/qualifier")
		end
		if part.refs and #part.refs > 0 then
			local refs = {}
			for _, ref in ipairs(part.refs) do
				if type(ref) ~= "table" then
					ref = {text = ref}
				end
				local refargs
				if ref.name or ref.group then
					refargs = {name = ref.name, group = ref.group}
				end
				table.insert(refs, mw.getCurrentFrame():extensionTag("ref", ref.text, refargs))
			end
			reftext = table.concat(refs)
		end
		
		local partaccel = part.accel
		local face = part.hypothetical and "hypothetical" or "bold"
		local nolink = part.hypothetical or part.nolink
		
		-- Convert the term into a full link
		-- Don't show a transliteration here, the consensus seems to be not to
		-- show them in headword lines to avoid clutter.
		part = m_links.full_link(
			{
				term = not nolink and part.term or nil,
				alt = part.alt or (nolink and part.term or nil),
				lang = part.lang or data.lang,
				sc = part.sc or parts.sc or (not part.lang and data.sc),
				id = part.id,
				genders = part.genders,
				tr = part.translit or (not (parts.enable_auto_translit or data.inflections.enable_auto_translit) and "-" or nil),
				ts = part.transcription,
				accel = parts.accel or partaccel,
			},
			face,
			false
			)
		
		if qualifiers then
			part = qualifiers .. part
		end
		if reftext then
			part = part .. reftext
		end
		
		parts[key] = part
	end
	
	local parts_output = ""
	
	if #parts > 0 then
		parts_output = " " .. table.concat(parts, " <i>or</i> ")
	elseif parts.request then
		parts_output = " <small>[please provide]</small>"
			.. require("Module:utilities").format_categories(
				{"Requests for inflections in " .. data.lang:getCanonicalName() .. " entries"},
				lang,
				nil,
				nil,
				data.force_cat_output or test_force_categories,
				data.sc
				)
	end
	
	return "<i>" .. parts.label .. "</i>" .. parts_output
end

-- Format the inflections following the headword
local function format_inflections(data)
	if data.inflections and #data.inflections > 0 then
		-- Format each inflection individually
		for key, infl in ipairs(data.inflections) do
			data.inflections[key] = format_inflection_parts(data, infl)
		end
		
		return " (" .. table.concat(data.inflections, ", ") .. ")"
	else
		return ""
	end
end


-- Return "lemma" if the given POS is a lemma, "non-lemma form" if a non-lemma form, or nil
-- if unknown. The POS passed in must be in its plural form ("nouns", "prefixes", etc.).
-- If you have a POS in its singular form, call pluralize() in [[Module:string utilities]] to
-- pluralize it in a smart fashion that knows when to add '-s' and when to add '-es'.
--
-- If `best_guess` is given and the POS is in neither the lemma nor non-lemma list, guess
-- based on whether it ends in " forms"; otherwise, return nil.
function export.pos_lemma_or_nonlemma(plpos, best_guess)
	-- Is it a lemma category?
	if isLemma[plpos] or isLemma[plpos:gsub("^reconstructed ", "")] then
		return "lemma"
	-- Is it a nonlemma category?
	elseif isNonLemma[plpos]
		or isNonLemma[plpos:gsub("^reconstructed ", "")]
		or isLemma[plpos:gsub("^mutated ", "")]
		or isNonLemma[plpos:gsub("^mutated ", "")] then
		return "non-lemma form"
	elseif best_guess then
		return plpos:find(" forms$") and "non-lemma form" or "lemma"
	else
		return nil
	end
end


local function show_headword_line(data)
	local namespace = title.nsText

	-- Check the namespace against the language type
	if namespace == "" then
		if data.lang:getType() == "reconstructed" then
			error("Entries for this language must be placed in the Reconstruction: namespace.")
		elseif data.lang:getType() == "appendix-constructed" then
			error("Entries for this language must be placed in the Appendix: namespace.")
		end
	end
	
	local tracking_categories = {}

	if not data.noposcat then	
		local pos_category = data.lang:getCanonicalName() .. " " .. data.pos_category
		if pos_category ~= "Translingual Han characters" then
			table.insert(data.categories, 1, pos_category)
		end
	end

	if data.sccat and data.sc then
		table.insert(data.categories, data.lang:getCanonicalName() .. " " .. data.pos_category
			.. " in " .. data.sc:getDisplayForm())
	end
	
	-- Is it a lemma category?
	local postype = export.pos_lemma_or_nonlemma(data.pos_category)
	if not postype then
		-- We don't know what this category is, so tag it with a tracking category.
		--[=[
		[[Special:WhatLinksHere/Template:tracking/headword/unrecognized pos]]
		]=]
		table.insert(tracking_categories, "head tracking/unrecognized pos")
		require("Module:debug").track{
			"headword/unrecognized pos",
			"headword/unrecognized pos/lang/" .. data.lang:getCode(),
			"headword/unrecognized pos/pos/" .. data.pos_category
		}
	elseif not data.noposcat then
		table.insert(data.categories, 1, data.lang:getCanonicalName() .. " " .. postype .. "s")
	end

	-- Preprocess
	preprocess(data, postype)
	
	local m_links = require("Module:links")
	
	if namespace == "" and data.lang:getType() ~= "reconstructed" then
		for _, head in ipairs(data.heads) do
			if title.prefixedText ~= m_links.getLinkPage(m_links.remove_links(head), data.lang) then
				--[=[
				[[Special:WhatLinksHere/Template:tracking/headword/pagename spelling mismatch]]
				]=]
				require("Module:debug").track{
					"headword/pagename spelling mismatch",
					"headword/pagename spelling mismatch/" .. data.lang:getCode()
				}
				break
			end
		end
	end
	
	-- Format and return all the gathered information
	return
		format_headword(data) ..
		format_genders(data) ..
		format_inflections(data) ..
		require("Module:utilities").format_categories(
			tracking_categories, data.lang, data.sort_key, nil,
			data.force_cat_output or test_force_categories, data.sc
			)
end

function export.full_headword(data)
	local tracking_categories = {}
	
	-- Script-tags the topmost header.
	local pagename = title.text
	local fullPagename = title.fullText
	local namespace = title.nsText
	
	if not data.lang or type(data.lang) ~= "table" or not data.lang.getCode then
		error("In data, the first argument to full_headword, data.lang should be a language object.")
	end
	
	if not data.sc then
		data.sc = require("Module:scripts").findBestScript(data.heads and data.heads[1] ~= "" and data.heads[1] or pagename, data.lang)
	else
		-- Track uses of sc parameter
		local best = require("Module:scripts").findBestScript(pagename, data.lang)
		require("Module:debug").track("headword/sc")
		
		if data.sc:getCode() == best:getCode() then
			require("Module:debug").track("headword/sc/redundant")
			require("Module:debug").track("headword/sc/redundant/" .. data.sc:getCode())
		else
			require("Module:debug").track("headword/sc/needed")
			require("Module:debug").track("headword/sc/needed/" .. data.sc:getCode())
		end
	end
	
	local displayTitle
	-- Assumes that the scripts in "toBeTagged" will never occur in the Reconstruction namespace.
	-- Avoid tagging ASCII as Hani even when it is tagged as Hani in the
	-- headword, as in [[check]]. The check for ASCII might need to be expanded
	-- to a check for any Latin characters and whitespace or punctuation.
	if (namespace == "" and data.sc and toBeTagged[data.sc:getCode()]
			and not pagename:find "^[%z\1-\127]+$")
			or (data.sc:getCode() == "Jpan" and (test_script(pagename, "Hira") or test_script(pagename, "Kana"))) then
		displayTitle = '<span class="' .. data.sc:getCode() .. '">' .. pagename .. '</span>'
	elseif namespace == "Reconstruction" then
		displayTitle, matched = mw.ustring.gsub(
			fullPagename,
			"^(Reconstruction:[^/]+/)(.+)$",
			function(before, term)
				return before ..
					require("Module:script utilities").tag_text(
						term,
						data.lang,
						data.sc
					)
			end
		)
		
		if matched == 0 then
			displayTitle = nil
		end
	end
	
	if displayTitle then
		local frame = mw.getCurrentFrame()
		frame:callParserFunction(
			"DISPLAYTITLE",
			displayTitle
		)
	end
	
	if data.force_cat_output then
		--[=[
		[[Special:WhatLinksHere/Template:tracking/headword/force cat output]]
		]=]
		require("Module:debug").track("headword/force cat output")
	end
	
	if data.getCanonicalName then
		error('The "data" variable supplied to "full_headword" should not be a language object.')
	end
		
	-- Were any categories specified?
	if data.categories and #data.categories > 0 then
		local lang_name = require("Module:string").pattern_escape(data.lang:getCanonicalName())
		for _, cat in ipairs(data.categories) do
			-- Does the category begin with the language name? If not, tag it with a tracking category.
			if not mw.ustring.find(cat, "^" .. lang_name) then
				mw.log(cat, data.lang:getCanonicalName())
				table.insert(tracking_categories, "head tracking/no lang category")
				
				--[=[
				[[Special:WhatLinksHere/Template:tracking/head tracking/no lang category]]
				]=]
				require("Module:debug").track{
					"headword/no lang category",
					"headword/no lang category/lang/" .. data.lang:getCode()
				}
			end
		end
		
		if not data.pos_category
			and mw.ustring.find(data.categories[1], "^" .. data.lang:getCanonicalName())
				then
			data.pos_category = mw.ustring.gsub(data.categories[1], "^" .. data.lang:getCanonicalName() .. " ", "")
			table.remove(data.categories, 1)
		end
	end
	
	if not data.pos_category then
		error(
			'No valid part-of-speech categories were found in the list '
			.. 'of categories passed to the function "full_headword". '
			.. 'The part-of-speech category should consist of a language\'s '
			.. 'canonical name plus a part of speech.'
			)
	end
	
	-- Categorise for unusual characters
	local standard = data.lang:getStandardCharacters()
	
	if standard then
		if mw.ustring.len(title.subpageText) ~= 1 and not non_categorizable() then
			for character in mw.ustring.gmatch(title.subpageText, "([^" .. standard .. "])") do
				local upper = mw.ustring.upper(character)
				if not mw.ustring.find(upper, "[" .. standard .. "]") then
					character = upper
				end
				table.insert(
					data.categories,
					data.lang:getCanonicalName() .. " terms spelled with " .. character
				)
			end
		end
	end
	
	-- Categorise for palindromes
	if title.nsText ~= "Reconstruction" and mw.ustring.len(title.subpageText)>2
		and require('Module:palindromes').is_palindrome(
			title.subpageText, data.lang, data.sc
			) then
		table.insert(data.categories, data.lang:getCanonicalName() .. " palindromes")
	end

	-- This may add more categories (e.g. gender categories), so make sure it gets
	-- evaluated first.
	local text = show_headword_line(data)
	return
		text ..
		require("Module:utilities").format_categories(
			data.categories, data.lang, data.sort_key, nil,
			data.force_cat_output or test_force_categories, data.sc
			) ..
		require("Module:utilities").format_categories(
			tracking_categories, data.lang, data.sort_key, nil,
			data.force_cat_output or test_force_categories, data.sc
			)
end

return export