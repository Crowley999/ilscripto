local export = {}

local m_pron = require("Module:gem-pronunc")
local m_links = require("Module:links")
local m_utils = require("Module:utilities")

local lang = require("Module:languages").getByCode("gem-pro")

local i_muts = m_pron.i_mutations

local decl_data = require("Module:gem-decl-noun/data")
local decl_data_irreg = require("Module:gem-decl-noun/data/irreg")

local endings = {
	["az"] = "a-m", ["ą"] = "a-n", ["iz"] = "i-mf", ["i"] = "i-n", ["ī"] = "ijo-f", ["į̄"] = "in-f",
	["ǭ"] = "n-f", ["ō"] = "o-f", ["ēr"] = "r-mf", ["uz"] = "u-mf", ["u"] = "u-n"
}

local endings_reverse = {
	["a-m"] = "az", ["a-n"] = "ą", ["cons-n"] = "", ["i-mf"] = "iz", ["i-m"] = "iz", ["i-f"] = "iz", ["i-n"] = "i", 
	["ijo-f"] = "ī", ["in-f"] = "į̄", ["n-m"] = "ô", ["n-n"] = "ô", ["n-f"] = "ǭ", ["o-f"] = "ō", ["r-mf"] = "ēr", ["r-m"] = "ēr", 
	["r-f"] = "ēr", ["u-mf"] = "uz", ["u-m"] = "uz", ["u-f"] = "uz", ["u-n"] = "u", ["z-n"] = "az",
}

local function detect_decl(word, stem, gender)
	if stem and gender then
		local decl = stem .. "-" .. gender
		return decl, {mw.ustring.sub(word, 1, -(mw.ustring.len(endings_reverse[decl]) + 1))}
	elseif stem == "z" and mw.ustring.sub(word, -2) == "az" then -- z-stem
		return "z-n", {mw.ustring.sub(word, 1, -3)}
	elseif mw.ustring.find(word, "ô$") then -- an-stem
		if gender then
			return "n-" .. gender, {mw.ustring.sub(word, 1, -2)}
		else
			error("Gender must be specified for an-stems.")
		end
	else
		for ending, decl in pairs(endings) do
			if mw.ustring.find(word, ending .. "$") then
				return decl, {mw.ustring.sub(word, 1, -(mw.ustring.len(ending) + 1))}
			end
		end
		-- No matches, assume consonant stem. Now check for s-stems
		local stem = ""
		if mw.ustring.sub(word, -1, -1) == "s" and not mw.ustring.find(mw.ustring.sub(word, -2, -2), "[fhkptþ]") then
			stem = word
		else
			stem = mw.ustring.sub(word, 1, -2)
		end
		return (gender and "cons-" .. gender or "cons-mf"), {stem}
	end
end
		
	
local function add_asterisks(forms, data)
	for _, form in ipairs(forms) do
		for i, subform in ipairs(data.forms[form]) do
			data.forms[form][i] = "*" .. subform
		end
	end
end

-- The main entry point.
-- This is the only function that can be invoked from a template.
function export.show(frame)
	local parent_args = frame:getParent().args
	if mw.title.getCurrentTitle().nsText ~= "Reconstruction" then return end
	
	local stems = nil
	local decl_type = {}
	local word = mw.title.getCurrentTitle().subpageText
	local args = {}

	if not decl_data_irreg[word] then
		if frame.args.decl then
			decl_type = frame.args.decl
		else
			if parent_args.stem and parent_args.g and parent_args[1] then
				decl_type = parent_args.stem .. "-" .. parent_args.g
				stems = {parent_args[1]}
			else
				decl_type, stems = detect_decl(word, parent_args.stem, parent_args.g)
			end
		end
		
		if not decl_type then
			error("Unknown declension '" .. decl_type .. "'")
		end
		
		args = require("Module:parameters").process(parent_args, decl_data[decl_type].params, true)
	
		if stems then
			for i, stem in ipairs(stems) do
				args[i] = stem
			end
		end
	end

	local data = {forms = {}, categories = {}}
	
	data.head = parent_args["head"] or nil
	
	-- Generate the forms
	if decl_data_irreg[word] then
		table.insert(data.categories, "Proto-Germanic irregular nouns")
		decl_data_irreg[word](parent_args, data)
	else
		decl_data[decl_type](args, data)
	end

	-- Make the table
	return make_table(data)
end

function make_table(data)

	local function show_form(form)
		if not form then
			return "—"
		end
		
		local ret = {}
		
		for key, subform in ipairs(form) do
			if mw.ustring.find(subform, "[iīįǐj]") or mw.ustring.find(subform, "e[mn]") then
				subform = i_muts(subform)
			end
			if subform ~= "—" then
				subform = "*" .. subform
			end
			table.insert(ret, subform)
		end
			
		return table.concat(ret, ", ")
	end
	
	local function repl(param)
		if param == "decl_type" then
			return data.decl_type
		elseif param == "title" then
			return "*" .. data.forms.nom_sg[1]
		else
			return show_form(data.forms[param])
		end
	end

	local function make_cases(data)
		local cases = {"nominative", "vocative", "accusative", "genitive", "dative", "instrumental"}
		local ret = {}
		
		for _, case in ipairs(cases) do
			local case_short = mw.ustring.sub(case, 1, 3)
		--	assert(false, case_short)
			table.insert(ret, "|- " .. ((case_short == "nom" or case_short == "gen") and "" or "class=\"vsHide\"") .. " \n! style=\"background: #FFF0DC\" | " .. case .. "\n")
			table.insert(ret, "| style=\"background: #FFF8ED\" | " .. show_form(data.forms[case_short .. "_sg"]) .. "\n")
			if data.forms[case_short .. "_pl"] then
				table.insert(ret, "| class=\"vsHide\" style=\"background: #FFF8ED\" | " .. show_form(data.forms[case_short .. "_pl"]) .. "\n")
			end
		end
		return table.concat(ret)
	end

	local no_plural = data.forms.nom_pl == nil

	local wikicode = [=[
	
{| class="inflection-table vsSwitcher" data-toggle-category="inflection" style="background: #FFFDFB; border: 1px solid #d0d0d0; text-align: left;" cellspacing="1" cellpadding="2"
|-
! style="background-image: -webkit-gradient(linear,left top,left bottom,from(#EFEFEF),to(#DFDFDF),color-stop(0.6,#E3E3E3)); background-image: -moz-linear-gradient(top,#EFEFEF,#E3E3E3 60%,#DFDFDF); background-image: -o-linear-gradient(top,#EFEFEF,#E3E3E3 60%,#DFDFDF);" class="vsToggleElement" colspan="]=] .. (no_plural and "3" or "4") .. [=[" | <span class="vsShow">{{{decl_type}}}</span><span class="vsHide">Declension of <span lang="gem-pro">{{{title}}} ({{{decl_type}}})</span></span>
|-
| style="min-width: 8em; background-color:#F4E6AC" |
! style="min-width: 11em; background-color:#F4E6AC" | singular]=] .. (no_plural and "\n" or [=[

! class="vsHide" style="min-width: 11em; background-color:#F4E6AC" | plural
]=]) .. make_cases(data) .. [=[
|}]=]

	return (mw.ustring.gsub(wikicode, "{{{([a-z0-9_]+)}}}", repl)) .. m_utils.format_categories(data.categories, lang)
end

return export