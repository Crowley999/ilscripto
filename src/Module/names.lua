local m_languages = require("Module:languages")
local m_links = require("Module:links")
local m_utilities = require("Module:utilities")
local m_table = require("Module:table")

local export = {}

local enlang = m_languages.getByCode("en")

local rfind = mw.ustring.find
local rmatch = mw.ustring.match
local rsubn = mw.ustring.gsub
local rsplit = mw.text.split

local force_cat = false -- for testing

--[=[

FIXME:

1. from=the Bible (DONE)
2. origin=18th century [DONE]
3. popular= (DONE)
4. varoftype= (DONE)
5. eqtype= [DONE]
6. dimoftype= [DONE]
7. from=de:Elisabeth (same language) (DONE)
8. blendof=, blendof2= [DONE]
9. varform, dimform [DONE]
10. from=English < Latin [DONE]
11. usage=rare -> categorize as rare?
12. dimeq= (also vareq=?) [DONE]
13. fromtype= [DONE]
14. <tr:...> and similar params [DONE]
]=]

-- version of rsubn() that discards all but the first return value
local function rsub(term, foo, bar)
	local retval = rsubn(term, foo, bar)
	return retval
end

-- Used in category code
export.personal_name_types = {
	"surnames", "patronymics", "given names",
	"male given names", "female given names", "unisex given names",
	"diminutives of male given names", "diminutives of female given names",
	"diminutives of unisex given names",
	"augmentatives of male given names", "augmentatives of female given names",
	"augmentatives of unisex given names"
}


local translit_name_type_list = {
	"surname", "male given name", "female given name", "unisex given name",
	"patronymic"
}
local translit_name_types = m_table.listToSet(translit_name_type_list)

local param_mods = {"t", "alt", "tr", "ts", "pos", "lit", "id", "sc", "g", "q", "eq"}
local param_mod_set = m_table.listToSet(param_mods)


local function track(page)
	require("Module:debug").track("names/" .. page)
end



--[=[
Parse a term and associated properties. This works with parameters of the form 'Karlheinz' or
'Kunigunde<q:medieval, now rare>' or 'non:Óláfr' or 'ru:Фру́нзе<tr:Frúnzɛ><q:rare>' where the modifying properties
are contained in <...> specifications after the term. `term` is the full parameter value including any angle brackets
and colons; `pname` is the name of the parameter that this value comes from, for error purposes; `deflang` is a
language object used in the return value when the language isn't specified (e.g. in the examples 'Karlheinz' and
'Kunigunde<q:medieval, now rare>' above); `allow_explicit_lang` indicates whether the language can be explicitly given
(e.g. in the examples 'non:Óláfr' or 'ru:Фру́нзе<tr:Frúnzɛ><q:rare>' above).

Normally the return value is an object with properties '.term' (a terminfo object that can be passed to full_link() in
[[Module:links]]) and '.q' (a qualifier). However, if `allow_multiple_terms` is given, multiple comma-separated names
can be given in `term`, and the return value is a list of objects of the form described just above.
]=]
local function parse_term_with_annotations(term, pname, deflang, allow_explicit_lang, allow_multiple_terms)
	local function parse_single_run_with_annotations(run)
		local function parse_err(msg)
			error(msg .. ": " .. pname .. "= " .. table.concat(run))
		end
		if #run == 1 and run[1] == "" then
			error("Blank form for param '" .. pname .. "' not allowed")
		end
		local termobj = {term = {}}
		local lang, form = run[1]:match("^(.-):(.*)$")
		if lang then
			if not allow_explicit_lang then
				parse_err("Explicit language '" .. lang .. "' not allowed for this parameter")
			end
			termobj.term.lang = m_languages.getByCode(lang, pname, "allow etym lang")
			termobj.term.term = form
		else
			termobj.term.lang = deflang
			termobj.term.term = run[1]
		end

		for i = 2, #run - 1, 2 do
			if run[i + 1] ~= "" then
				parse_err("Extraneous text '" .. run[i + 1] .. "' after modifier")
			end
			local modtext = run[i]:match("^<(.*)>$")
			if not modtext then
				parse_err("Internal error: Modifier '" .. modtext .. "' isn't surrounded by angle brackets")
			end
			local prefix, arg = modtext:match("^([a-z]+):(.*)$")
			if not prefix then
				parse_err("Modifier " .. run[i] .. " lacks a prefix, should begin with one of '" ..
					table.concat(param_mods, ":', '") .. ":'")
			end
			if param_mod_set[prefix] then
				local obj_to_set
				if prefix == "q" or prefix == "eq" then
					obj_to_set = termobj
				else
					obj_to_set = termobj.term
				end
				if obj_to_set[prefix] then
					parse_err("Modifier '" .. prefix .. "' occurs twice, second occurrence " .. run[i])
				end
				if prefix == "t" then
					termobj.term.gloss = arg
				elseif prefix == "g" then
					termobj.term.genders = rsplit(arg, ",")
				elseif prefix == "sc" then
					termobj.term.sc = require("Module:scripts").getByCode(arg, pname)
				elseif prefix == "eq" then
					termobj.eq = parse_term_with_annotations(arg, pname .. ".eq", enlang, false, "allow multiple terms")
				else
					obj_to_set[prefix] = arg
				end
			else
				parse_err("Unrecognized prefix '" .. prefix .. "' in modifier " .. run[i])
			end
		end
		return termobj
	end

	local iut = require("Module:inflection utilities")
	local run = iut.parse_balanced_segment_run(term, "<", ">")
	if allow_multiple_terms then
		local comma_separated_runs = iut.split_alternating_runs(run, "%s*,%s*")
		local termobjs = {}
		for _, comma_separated_run in ipairs(comma_separated_runs) do
			table.insert(termobjs, parse_single_run_with_annotations(comma_separated_run))
		end
		return termobjs
	else
		return parse_single_run_with_annotations(run)
	end
end


--[=[
Link a single term. If `do_language_link` is given and a given term's language is English, the link will be constructed
using language_link() in [[Module:links]]; otherwise, with full_link(). Each term in `terms` is an object as returned
by parse_term_with_annotations(), i.e. it contains fields '.term' (a terminfo structure suitable for passing to
full_link() or language_link()), optional '.q' (a qualifier) and optional '.eq' (a list of objects of the same form as
`termobj`).
]=]
local function link_one_term(termobj, do_language_link)
	termobj.term.lang = m_languages.getNonEtymological(termobj.term.lang)
	local link
	if do_language_link and termobj.term.lang:getCode() == "en" then
		link = m_links.language_link(termobj.term, nil, true)
	else
		link = m_links.full_link(termobj.term, nil, true)
	end
	if termobj.q then
		link = require("Module:qualifier").format_qualifier(termobj.q) .. " " .. link
	end
	if termobj.eq then
		local eqtext = {}
		for _, eqobj in ipairs(termobj.eq) do
			table.insert(eqtext, link_one_term(eqobj, true))
		end
		link = link .. " [=" .. m_table.serialCommaJoin(eqtext, {conj = "or"}) .. "]"
	end
	return link
end


--[=[
Link the terms in `terms`, and join them using the conjunction in `conj` (defaulting to "or"). Joining is done using
serialCommaJoin() in [[Module:table]], so that e.g. two terms are joined as "TERM or TERM" while three terms are joined
as "TERM, TERM or TERM" with special CSS spans before the final "or" to allow an "Oxford comma" to appear if configured
appropriately. (However, if `conj` is the special value ", ", joining is done directly using that value.)
If `include_langname` is given, the language of the first term will be prepended to the joined terms. If
`do_language_link` is given and a given term's language is English, the link will be constructed using language_link()
in [[Module:links]]; otherwise, with full_link(). Each term in `terms` is an object as returned by
parse_term_with_annotations(), i.e. it contains fields '.term' (a terminfo structure suitable for passing to full_link()
or language_link()), optional '.q' (a qualifier) and optional '.eq' (a list of objects of the same form as in `terms`).
]=]
local function join_terms(terms, include_langname, do_language_link, conj)
	local links = {}
	local langnametext
	for _, termobj in ipairs(terms) do
		if include_langname and not langnametext then
			langnametext = termobj.term.lang:getCanonicalName() .. " "
		end
		table.insert(links, link_one_term(termobj, do_language_link))
	end
	local joined_terms
	if conj == ", " then
		joined_terms = table.concat(links, conj)
	else
		joined_terms = m_table.serialCommaJoin(links, {conj = conj or "or"})
	end
	return (langnametext or "") .. joined_terms
end


--[=[
Gather the parameters for multiple names and link each name using full_link() (for foreign names) or language_link()
(for English names), joining the names using serialCommaJoin() in [[Module:table]] with the conjunction `conj`
(defaulting to "or"). (However, if `conj` is the special value ", ", joining is done directly using that value.)
This can be used, for example, to fetch and join all the masculine equivalent names for a feminine given name. Each
name is specified using parameters beginning with `pname` in `args`, e.g. "m", "m2", "m3", etc. `lang` is a language
object specifying the language of the names (defaulting to English), for use in linking them. If `allow_explicit_lang`
is given, the language of the terms can be specified explicitly by prefixing a term with a language code, e.g.
'sv:Björn' or 'la:[[Nicolaus|Nīcolāī]]'. This function assumes that the parameters have already been parsed by
[[Module:parameters]] and gathered into lists, so that e.g. all "mN" parameters are in a list in args["m"].
]=]
local function join_names(lang, args, pname, conj, allow_explicit_lang)
	local termobjs = {}
	local do_language_link = false
	if not lang then
		lang = enlang
		do_language_link = true
	end

	for i, term in ipairs(args[pname]) do
		table.insert(termobjs, parse_term_with_annotations(term, pname .. (i == 1 and "" or i), lang, allow_explicit_lang))
	end
	return join_terms(termobjs, nil, do_language_link, conj), #termobjs
end


local function get_eqtext(args)
	local eqsegs = {}
	local lastlang = nil
	local last_eqseg = {}
	for i, term in ipairs(args.eq) do
		local termobj = parse_term_with_annotations(term, "eq" .. (i == 1 and "" or i), enlang, "allow explicit lang")
		local termlang = termobj.term.lang:getCode()
		if lastlang and lastlang ~= termlang then
			if #last_eqseg > 0 then
				table.insert(eqsegs, last_eqseg)
			end
			last_eqseg = {}
		end
		lastlang = termlang
		table.insert(last_eqseg, termobj)
	end
	if #last_eqseg > 0 then
		table.insert(eqsegs, last_eqseg)
	end
	local eqtextsegs = {}
	for _, eqseg in ipairs(eqsegs) do
		table.insert(eqtextsegs, join_terms(eqseg, "include langname"))
	end
	return m_table.serialCommaJoin(eqtextsegs, {conj = "or"})
end


local function get_fromtext(lang, args)
	local catparts = {}
	local fromsegs = {}
	local i = 1

	local function parse_from(from)
		local unrecognized = false
		local prefix, suffix
		if from == "surnames" then
			prefix = "transferred from the "
			suffix = "surname"
			table.insert(catparts, from)
		elseif from == "place names" then
			prefix = "transferred from the "
			suffix = "place name"
			table.insert(catparts, from)
		elseif from == "coinages" then
			prefix = "originating "
			suffix = "as a coinage"
			table.insert(catparts, from)
		elseif from == "the Bible" then
			prefix = "originating "
			suffix = "from the Bible"
			table.insert(catparts, from)
		else
			prefix = "from "
			if from:find(":") then
				local termobj = parse_term_with_annotations(from, "from" .. (i == 1 and "" or i), lang, "allow explicit lang")
				local fromlangname = ""
				if termobj.term.lang:getCode() ~= lang:getCode() then
					-- If name is derived from another name in the same language, don't include lang name after text "from "
					-- or create a category like "German male given names derived from German".
					local canonical_name = termobj.term.lang:getCanonicalName()
					fromlangname = canonical_name .. " "
					table.insert(catparts, canonical_name)
				end
				termobj.term.lang = m_languages.getNonEtymological(termobj.term.lang)
				suffix = fromlangname .. link_one_term(termobj)
			elseif from:find(" languages$") then
				local family = from:match("^(.*) languages$")
				if require("Module:families").getByCanonicalName(family) then
					table.insert(catparts, from)
				else
					unrecognized = true
				end
				suffix = "the " .. from
			else
				if m_languages.getByCanonicalName(from, nil, "allow etym") then
					table.insert(catparts, from)
				else
					unrecognized = true
				end
				suffix = from
			end
		end
		if unrecognized then
			track("unrecognized from")
			track("unrecognized from/" .. from)
		end
		return prefix, suffix
	end

	local last_fromseg = nil
	while args.from[i] do
		local rawfrom = args.from[i]
		local froms = rsplit(rawfrom, "%s+<%s+")
		if #froms == 1 then
			local prefix, suffix = parse_from(froms[1])
			if last_fromseg and (last_fromseg.has_multiple_froms or last_fromseg.prefix ~= prefix) then
				table.insert(fromsegs, last_fromseg)
				last_fromseg = nil
			end
			if not last_fromseg then
				last_fromseg = {prefix = prefix, suffixes = {}}
			end
			table.insert(last_fromseg.suffixes, suffix)
		else
			if last_fromseg then
				table.insert(fromsegs, last_fromseg)
				last_fromseg = nil
			end
			local first_suffixpart = ""
			local rest_suffixparts = {}
			for j, from in ipairs(froms) do
				local prefix, suffix = parse_from(from)
				if j == 1 then
					first_suffixpart = prefix .. suffix
				else
					table.insert(rest_suffixparts, prefix .. suffix)
				end
			end
			local full_suffix = first_suffixpart .. " [in turn " .. table.concat(rest_suffixparts, ", in turn ") .. "]"
			last_fromseg = {prefix = "", has_multiple_froms = true, suffixes = {full_suffix}}
		end
		i = i + 1
	end
	table.insert(fromsegs, last_fromseg)
	local fromtextsegs = {}
	for _, fromseg in ipairs(fromsegs) do
		table.insert(fromtextsegs, fromseg.prefix ..  m_table.serialCommaJoin(fromseg.suffixes, {conj = "or"}))
	end
	return m_table.serialCommaJoin(fromtextsegs, {conj = "or"}), catparts
end


-- The entry point for {{given name}}.
function export.given_name(frame)
	local parent_args = frame:getParent().args
	local compat = parent_args.lang
	local offset = compat and 0 or 1

	local params = {
		[compat and "lang" or 1] = { required = true, default = "und" },
		["gender"] = { default = "unknown-gender" },
		[1 + offset] = { alias_of = "gender", default = "unknown-gender" },
		-- second gender
		["or"] = {},
		["usage"] = {},
		["origin"] = {},
		["popular"] = {},
		["populartype"] = {},
		["meaning"] = { list = true },
		["meaningtype"] = {},
		["q"] = {},
		-- initial article: A or An
		["A"] = {},
		["sort"] = {},
		["from"] = { list = true },
		[2 + offset] = { alias_of = "from", list = true },
		["fromtype"] = {},
		["xlit"] = { list = true },
		["eq"] = { list = true },
		["eqtype"] = {},
		["varof"] = { list = true },
		["varoftype"] = {},
		["var"] = { alias_of = "varof", list = true },
		["vartype"] = { alias_of = "varoftype" },
		["varform"] = { list = true },
		["dimof"] = { list = true },
		["dimoftype"] = {},
		["dim"] = { alias_of = "dimof", list = true },
		["dimtype"] = { alias_of = "dimoftype" },
		["diminutive"] = { alias_of = "dimof", list = true },
		["diminutivetype"] = { alias_of = "dimoftype" },
		["dimform"] = { list = true },
		["blend"] = { list = true },
		["blendtype"] = {},
		["m"] = { list = true },
		["mtype"] = {},
		["f"] = { list = true },
		["ftype"] = {},
	}

	local args = require("Module:parameters").process(parent_args, params)
	
	local textsegs = {}
	local lang = m_languages.getByCode(args[compat and "lang" or 1], compat and "lang" or 1)

	local function fetch_typetext(param)
		return args[param] and args[param] .. " " or ""
	end

	local dimoftext, numdims = join_names(lang, args, "dimof")
	local xlittext = join_names(nil, args, "xlit")
	local blendtext = join_names(lang, args, "blend", "and")
	local varoftext = join_names(lang, args, "varof")
	local mtext = join_names(lang, args, "m")
	local ftext = join_names(lang, args, "f")
	local varformtext, numvarforms = join_names(lang, args, "varform", ", ")
	local dimformtext, numdimforms = join_names(lang, args, "dimform", ", ")
	local meaningsegs = {}
	for _, meaning in ipairs(args.meaning) do
		table.insert(meaningsegs, '"' .. meaning .. '"')
	end
	local meaningtext = m_table.serialCommaJoin(meaningsegs, {conj = "or"})
	local eqtext = get_eqtext(args)

	table.insert(textsegs, "<span class='use-with-mention'>")
	local dimtype = args.dimtype
	local article = args.A or
		dimtype and rfind(dimtype, "^[aeiouAEIOU]") and "An" or
		args.gender == "unknown-gender" and "An" or
		"A"

	table.insert(textsegs, article .. " ")
	if numdims > 0 then
		table.insert(textsegs,
			(dimtype and dimtype .. " " or "") ..
			"[[diminutive]]" ..
			(xlittext ~= "" and ", " .. xlittext .. "," or "") ..
			" of the ")
	end
	local genders = {}
	table.insert(genders, args.gender)
	table.insert(genders, args["or"])
	table.insert(textsegs, table.concat(genders, " or ") .. " ")
	table.insert(textsegs, numdims > 1 and "[[given name|given names]]" or
		"[[given name]]")
	local need_comma = false
	if numdims > 0 then
		table.insert(textsegs, " " .. dimoftext)
		need_comma = true
	elseif xlittext ~= "" then
		table.insert(textsegs, ", " .. xlittext)
		need_comma = true
	end
	local from_catparts = {}
	if #args.from > 0 then
		if need_comma then
			table.insert(textsegs, ",")
		end
		need_comma = true
		table.insert(textsegs, " " .. fetch_typetext("fromtype"))
		local textseg, this_catparts = get_fromtext(lang, args)
		for _, catpart in ipairs(this_catparts) do
			m_table.insertIfNot(from_catparts, catpart)
		end
		table.insert(textsegs, textseg)
	end
	
	if meaningtext ~= "" then
		if need_comma then
			table.insert(textsegs, ",")
		end
		need_comma = true
		table.insert(textsegs, " " .. fetch_typetext("meaningtype") .. "meaning " .. meaningtext)
	end
	if args.origin then
		if need_comma then
			table.insert(textsegs, ",")
		end
		need_comma = true
		table.insert(textsegs, " of " .. args.origin .. " origin")
	end
	if args.usage then
		if need_comma then
			table.insert(textsegs, ",")
		end
		need_comma = true
		table.insert(textsegs, " of " .. args.usage .. " usage")
	end
	if varoftext ~= "" then
		table.insert(textsegs, ", " ..fetch_typetext("varoftype") .. "variant of " .. varoftext)
	end
	if blendtext ~= "" then
		table.insert(textsegs, ", " .. fetch_typetext("blendtype") .. "blend of " .. blendtext)
	end
	if args.popular then
		table.insert(textsegs, ", " .. fetch_typetext("populartype") .. "popular " .. args.popular)
	end
	if mtext ~= "" then
		table.insert(textsegs, ", " .. fetch_typetext("mtype") .. "masculine equivalent " .. mtext)
	end
	if ftext ~= "" then
		table.insert(textsegs, ", " .. fetch_typetext("ftype") .. "feminine equivalent " .. ftext)
	end
	if eqtext ~= "" then
		table.insert(textsegs, ", " .. fetch_typetext("eqtype") .. "equivalent to " .. eqtext)
	end
	if args.q then
		table.insert(textsegs, ", " .. args.q)
	end
	if varformtext ~= "" then
		table.insert(textsegs, "; variant form" .. (numvarforms > 1 and "s" or "") .. " " .. varformtext)
	end
	if dimformtext ~= "" then
		table.insert(textsegs, "; diminutive form" .. (numdimforms > 1 and "s" or "") .. " " .. dimformtext)
	end
	table.insert(textsegs, "</span>")

	local categories = {}
	local langname = lang:getCanonicalName() .. " "
	local function insert_cats(isdim)
		if isdim == "" then
			-- No category such as "English diminutives of given names"
			table.insert(categories, langname .. isdim .. "given names")
		end
		local function insert_cats_gender(g)
			if g == "unknown-gender" then
				track("unknown gender")
				return
			end
			if g ~= "male" and g ~= "female" and g ~= "unisex" then
				error("Unrecognized gender: " .. g)
			end
			if g == "unisex" then
				insert_cats_gender("male")
				insert_cats_gender("female")
			end
			table.insert(categories, langname .. isdim .. g .. " given names")
			for _, catpart in ipairs(from_catparts) do
				table.insert(categories, langname .. isdim .. g .. " given names from " .. catpart)
			end
		end
		insert_cats_gender(args.gender)
		if args["or"] then
			insert_cats_gender(args["or"])
		end
	end
	insert_cats("")
	if numdims > 0 then
		insert_cats("diminutives of ")
	end

	return table.concat(textsegs, "") ..
		m_utilities.format_categories(categories, lang, args.sort, nil, force_cat)
end

-- The entry point for {{name translit}}, {{name respelling}}, {{name obor}} and {{foreign name}}.
function export.name_translit(frame)
    local iparams = {
        ["desctext"] = {required = true},
        ["obor"] = {type = "boolean"},
        ["foreign_name"] = {type = "boolean"},
    }
    local iargs = require("Module:parameters").process(frame.args, iparams)

	local parent_args = frame:getParent().args

	local params = {
		[1] = { required = true, default = "en" },
		[2] = { required = true, default = "ru" },
		[3] = { list = true },
		["type"] = { required = true, list = true, default = "patronymic" },
		["alt"] = { list = true, allow_holes = true },
		["t"] = { list = true, allow_holes = true },
		["gloss"] = { list = true, alias_of = "t", allow_holes = true },
		["tr"] = { list = true, allow_holes = true },
		["ts"] = { list = true, allow_holes = true },
		["id"] = { list = true, allow_holes = true },
		["sc"] = { list = true, allow_holes = true },
		["g"] = { list = true, allow_holes = true },
		["q"] = { list = true, allow_holes = true },
		["xlit"] = { list = true, allow_holes = true },
		["eq"] = { list = true, allow_holes = true },
		["dim"] = { type = "boolean" },
		["aug"] = { type = "boolean" },
		["nocap"] = { type = "boolean" },
		["sort"] = {},
		["pagename"] = {},
	}
	
	local args = require("Module:parameters").process(parent_args, params)
	local lang = m_languages.getByCode(args[1], 1)
	local sources = {}
	local source_non_etym_langs = {}
	for _, source in ipairs(rsplit(args[2], "%s*,%s*")) do
		local sourcelang = m_languages.getByCode(source, 2, "allow etym")
		table.insert(sources, sourcelang)
		table.insert(source_non_etym_langs, m_languages.getNonEtymological(sourcelang))
	end

	local nametypes = {}
	for _, typearg in ipairs(args["type"]) do
		for _, ty in ipairs(rsplit(typearg, "%s*,%s*")) do
			if not translit_name_types[ty] then
				local quoted_types = {}
				for _, nametype in ipairs(translit_name_type_list) do
					table.insert(quoted_types, "'" .. nametype .. "'")
				end
				error("Unrecognized type '" .. ty .. "': It should be one of " ..
					m_table.serialCommaJoin(quoted_types, {conj = "or"}))
			end
			table.insert(nametypes, ty)
		end
	end

	-- Find the maximum index among any of the list parameters, to determine how many names are given.
	local maxmaxindex = #args[3]
	for k, v in pairs(args) do
		if type(v) == "table" and v.maxindex and v.maxindex > maxmaxindex then
			maxmaxindex = v.maxindex
		end
	end

	local SUBPAGENAME = args.pagename or mw.title.getCurrentTitle().subpageText
	
	local textsegs = {}
	table.insert(textsegs, "<span class='use-with-mention'>")
	local desctext = iargs.desctext
	if not args.nocap then
		desctext = mw.getContentLanguage():ucfirst(desctext)
	end
	table.insert(textsegs, desctext .. " ")
	if not iargs.foreign_name then
		table.insert(textsegs, "of ")
	end
	local langsegs = {}
	for i, source in ipairs(sources) do
		local sourcename = source:getCanonicalName()
		local function get_source_link()
			local term_to_link = args[3][1] or SUBPAGENAME
			-- We link the language name to either the first specified name or the pagename, in the following circumstances:
			-- (1) More than one language was given along with at least one name; or
			-- (2) We're handling {{foreign name}} or {{name obor}}, and no name was given.
			-- The reason for (1) is that if more than one language was given, we want a link to the name
			-- in each language, as the name that's displayed is linked only to the first specified language.
			-- However, if only one language was given, linking the language to the name is redundant.
			-- The reason for (2) is that {{foreign name}} is often used when the name in the destination language
			-- is spelled the same as the name in the source language (e.g. [[Clinton]] or [[Obama]] in Italian),
			-- and in that case no name will be explicitly specified but we still want a link to the name in the
			-- source language. The reason we restrict this to {{foreign name}} or {{name obor}}, not to {{name translit}}
			-- or {{name respelling}}, is that {{name translit}} and {{name respelling}} ought to be used for names
			-- spelled differently in the destination language (either transliterated or respelled), so assuming the
			-- pagename is the name in the source language is wrong.
			if args[3][1] and #sources > 1 or (iargs.foreign_name or iargs.obor) and not args[3][1] then
				return m_links.language_link({
					lang = source_non_etym_langs[i], term = term_to_link, alt = sourcename, tr = "-"
				}, "allow self link")
			else
				return sourcename
			end
		end
		
		if i == 1 and not iargs.foreign_name then
			-- If at least one name is given, we say "A transliteration of the LANG surname FOO", linking LANG to FOO.
			-- Otherwise we say "A transliteration of a LANG surname".
			if maxmaxindex > 0 then
				table.insert(langsegs, "the " .. get_source_link())
			else
				table.insert(langsegs, require("Module:string utilities").add_indefinite_article(sourcename))
			end
		else
			table.insert(langsegs, get_source_link())
		end
	end
	local langseg_text = m_table.serialCommaJoin(langsegs, {conj = "or"})
	local augdim_text
	if args.dim then
		augdim_text = " [[diminutive]]"
	elseif args.aug then
		augdim_text = " [[augmentative]]"
	else
		augdim_text = ""
	end
	local nametype_text = m_table.serialCommaJoin(nametypes) .. augdim_text

	if not iargs.foreign_name then
		table.insert(textsegs, langseg_text .. " ")
		table.insert(textsegs, nametype_text)
		if maxmaxindex > 0 then
			table.insert(textsegs, " ")
		end
	else
		table.insert(textsegs, nametype_text)
		table.insert(textsegs, " in " .. langseg_text)
		if maxmaxindex > 0 then
			table.insert(textsegs, ", ")
		end
	end

	local names = {}
	local embedded_comma = false

	for i = 1, maxmaxindex do
		local sc = require("Module:scripts").getByCode(args["sc"][i], true)
		
		local terminfo = {
			lang = source_non_etym_langs[1], term = args[3][i], alt = args["alt"][i], id = args["id"][i], sc = sc,
			tr = args["tr"][i], ts = args["ts"][i], gloss = args["t"][i],
			genders = args["g"][i] and rsplit(args["g"][i], ",") or {}
		}
		local linked_term = m_links.full_link(terminfo, "term", "allow self link")
		if  args["q"][i] then
			linked_term = require("Module:qualifier").format_qualifier(args["q"][i]) .. " " .. linked_term
		end
		if args["xlit"][i] then
			embedded_comma = true
			linked_term = linked_term .. ", " .. m_links.language_link({ lang = m_languages.getByCode("en"), term = args["xlit"][i] })
		end
		if args["eq"][i] then
			embedded_comma = true
			linked_term = linked_term .. ", equivalent to " .. m_links.language_link({ lang = m_languages.getByCode("en"), term = args["eq"][i] })
		end
		table.insert(names, linked_term)
	end

	if embedded_comma then
		table.insert(textsegs, table.concat(names, "; or of "))
	else
		table.insert(textsegs, m_table.serialCommaJoin(names, {conj = "or"}))
	end
	table.insert(textsegs, "</span>")

	local categories = {}
	for _, nametype in ipairs(nametypes) do
		local function insert_cats(isdim)
			local function insert_cats_type(ty)
				if ty == "unisex given name" then
					insert_cats_type("male given name")
					insert_cats_type("female given name")
				end
				for i, source in ipairs(sources) do
					table.insert(categories, lang:getCode() .. ":" .. source:getCanonicalName() .. " " .. isdim .. ty .. "s")
					local sourcelang = source_non_etym_langs[i]
					if source:getCode() ~= sourcelang:getCode() then
						-- etymology language
						table.insert(categories, lang:getCode() .. ":" .. sourcelang:getCanonicalName() .. " " .. isdim .. ty .. "s")
					end
				end
			end
			insert_cats_type(nametype)
		end
		insert_cats("")
		if args.dim then
			insert_cats("diminutives of ")
		end
		if args.aug then
			insert_cats("augmentatives of ")
		end
	end

	return table.concat(textsegs, "") ..
		m_utilities.format_categories(categories, lang, args.sort, nil, force_cat)
end

return export