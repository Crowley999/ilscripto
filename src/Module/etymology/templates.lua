local export = {}

local m_languages = require("Module:languages")
local m_etymology = require("Module:etymology")

local rsplit = mw.text.split
local rsubn = mw.ustring.gsub

-- version of rsubn() that discards all but the first return value
local function rsub(term, foo, bar)
	local retval = rsubn(term, foo, bar)
	return retval
end

local function fetch_lang(lang, parameter)
	return m_languages.getByCode(lang) or m_languages.err(lang, parameter)
end


local function fetch_source(code, disallow_family)
	local source =
		m_languages.getByCode(code)
		or require("Module:etymology languages").getByCode(code)
		or not disallow_family and require("Module:families").getByCode(code)
	
	if source then
		return source
	else
		error("The language" .. (not disallow_family and ", family" or "") .. " or etymology language code \"" .. code .. "\" is not valid.")
	end
end


local function fetch_script(sc)
	if sc then
		return require("Module:scripts").getByCode(sc) or error("The script code \"" .. sc .. "\" is not valid.")
	else
		return nil
	end
end


function export.etyl(frame)
	local params = {
		[1] = {required = true, default = "und"},
		[2] = {},
		["sort"] = {},
	}
	
	local args = require("Module:parameters").process(frame:getParent().args, params)
	
	local source = fetch_source(args[1])
	local lang = args[2]
	local sort_key = args["sort"]
	
	-- Empty language means English, but "-" means no language. Yes, confusing...
	if not lang then
		lang = "en"
	elseif lang == "-" then
		lang = nil
	end
	if lang then
		lang = fetch_lang(lang, 2)
	end
	if lang and (lang:getCode() == "la" or lang:getCode() == "nl") then
		require("Module:debug").track("etyl/" .. lang:getCode())
		require("Module:debug").track("etyl/" .. lang:getCode() .. "/" .. source:getCode())
	end
	
	return m_etymology.format_etyl(lang, source, sort_key)
end


function export.cognate(frame)
	local args = frame:getParent().args
	
	if args.gloss then
		require("Module:debug").track("cognate/gloss param")
	end
	
	local params = {
		[1] = {required = true, default = "und"},
		[2] = {},
		[3] = {alias_of = "alt"},
		[4] = {alias_of = "t"},
		
		["alt"] = {},
		["g"] = {list = true},
		["id"] = {},
		["lit"] = {},
		["pos"] = {},
		["t"] = {},
		["gloss"] = {alias_of = "t"},
		["tr"] = {},
		["ts"] = {},
		["sc"] = {},
		
		["sort"] = {},
	}
	
	args = require("Module:parameters").process(args, params)
	
	local source = fetch_source(args[1])
	local sc = fetch_script(args["sc"])

	return m_etymology.format_cognate(
		{
			lang = source,
			sc = sc,
			term = args[2],
			alt = args["alt"],
			id = args["id"],
			genders = args["g"],
			tr = args["tr"],
			ts = args["ts"],
			gloss = args["t"],
			pos = args["pos"],
			lit = args["lit"]
		},
		args["sort"])
end


function export.noncognate(frame)
	return export.cognate(frame)
end

local function parse_2_lang_args(frame, has_text, no_family)
	local params = {
		[1] = {required = true, default = "und"},
		[2] = {required = true, default = "und"},
		[3] = {},
		[4] = {alias_of = "alt"},
		[5] = {alias_of = "t"},
		
		["alt"] = {},
		["g"] = {list = true},
		["gloss"] = {alias_of = "t"},
		["id"] = {},
		["lit"] = {},
		["pos"] = {},
		["t"] = {},
		["tr"] = {},
		["ts"] = {},
		["sc"] = {},

		["nocat"] = {type = "boolean"},
		["sort"] = {},
	}

	if has_text then
		params["notext"] = {type = "boolean"}
		params["nocap"] = {type = "boolean"}
	end

	local args = require("Module:parameters").process(frame:getParent().args, params)
	
	local lang = fetch_lang(args[1], 1)
	local source = fetch_source(args[2], no_family)
	local sc = fetch_script(args["sc"])

	return args, lang, {
		lang = source,
		sc = sc,
		term = args[3],
		alt = args["alt"],
		id = args["id"],
		genders = args["g"],
		tr = args["tr"],
		ts = args["ts"],
		gloss = args["t"],
		pos = args["pos"],
		lit = args["lit"]
	}
end
	

function export.derived(frame)
	local args, lang, term = parse_2_lang_args(frame)
	return m_etymology.format_derived(lang, term, args["sort"], args["nocat"], "derived")
end

function export.inherited(frame)
	local args, lang, term = parse_2_lang_args(frame, nil, "no family")
	return m_etymology.format_inherited(lang, term, args["sort"], args["nocat"])
end

function export.borrowed(frame)
	local args, lang, term = parse_2_lang_args(frame)
	return m_etymology.format_borrowed(lang, term, args["sort"],
		false, true, args["nocat"], "plain")
end

function export.learned_borrowing(frame)
	if frame:getParent().args.gloss then
		require("Module:debug").track("learned_borrowing/gloss param")
	end

	local args, lang, term = parse_2_lang_args(frame, "has text")
	return m_etymology.format_borrowed(lang, term, args["sort"],
		args["nocap"], args["notext"], args["nocat"], "learned")
end

function export.semi_learned_borrowing(frame)
	if frame:getParent().args.gloss then
		require("Module:debug").track("semi_learned_borrowing/gloss param")
	end

	local args, lang, term = parse_2_lang_args(frame, "has text")
	return m_etymology.format_borrowed(lang, term, args["sort"],
		args["nocap"], args["notext"], args["nocat"], "semi-learned")
end

function export.orthographic_borrowing(frame)
	if frame:getParent().args.gloss then
		require("Module:debug").track("orthographic_borrowing/gloss param")
	end

	local args, lang, term = parse_2_lang_args(frame, "has text")
	return m_etymology.format_borrowed(lang, term, args["sort"],
		args["nocap"], args["notext"], args["nocat"], "orthographic")
end

function export.unadapted_borrowing(frame)
	if frame:getParent().args.gloss then
		require("Module:debug").track("unadapted_borrowing/gloss param")
	end

	local args, lang, term = parse_2_lang_args(frame, "has text")
	return m_etymology.format_borrowed(lang, term, args["sort"],
		args["nocap"], args["notext"], args["nocat"], "unadapted")
end

function export.calque(frame)
	local args = frame:getParent().args
	
	-- More informative error message.
	if args["etyl lang"] or args["etyl term"] or args["etyl t"] or args["etyl tr"] then
		error("{{[[Template:calque|calque]]}} no longer supports parameters beginning with etyl. " ..
			"The parameters supported are similar to those used by " ..
			"{{[[Template:der|der]]}}, {{[[Template:inh|inh]]}}, " ..
			"{{[[Template:bor|bor]]}}. See [[Template:calque/documentation]] for more.")
	end
	
	local args, lang, term = parse_2_lang_args(frame, "has text")
	return m_etymology.calque(lang, term, args["sort"],
		args["nocap"], args["notext"], args["nocat"])
end

function export.partial_calque(frame)
	if frame:getParent().args.gloss then
		require("Module:debug").track("partial_calque/gloss param")
	end

	local args, lang, term = parse_2_lang_args(frame, "has text")
	return m_etymology.partial_calque(lang, term, args["sort"],
		args["nocap"], args["notext"], args["nocat"])
end

function export.semantic_loan(frame)
	local args, lang, term = parse_2_lang_args(frame, "has text")
	return m_etymology.semantic_loan(lang, term, args["sort"],
		args["nocap"], args["notext"], args["nocat"])
end

function export.psm(frame)
	local args, lang, term = parse_2_lang_args(frame, "has text")
	return m_etymology.phono_semantic_matching(lang, term, args["sort"],
		args["nocap"], args["notext"], args["nocat"])
end

local function qualifier(content)
	if content then
		return table.concat{
			'<span class="ib-brac qualifier-brac">(</span>',
			'<span class="ib-content qualifier-content">',
			content,
			'</span>',
			'<span class="ib-brac qualifier-brac">)</span>'
		}
	end
end

local function desc_or_desc_tree(frame, desc_tree)
	local params
	if desc_tree then
		params = {
			[1] = {required = true, default = "gem-pro"},
			[2] = {required = true, default = "*fuhsaz"},
			["notext"] = { type = "boolean" },
			["noalts"] = { type = "boolean" },
			["noparent"] = { type = "boolean" },
		}
	else
		params = {
			[1] = { required = true },
			[2] = {},
			["alts"] = { type = "boolean" }
		}
	end

	for k, v in pairs({
		[3] = {},
		[4] = { alias_of = "gloss" },
		["g"] = {list = true},
		["gloss"] = {},
		["id"] = {},
		["lit"] = {},
		["pos"] = {},
		["t"] = { alias_of = "gloss" },
		["tr"] = {},
		["ts"] = {},
		["sc"] = {},
		["bor"] = { type = "boolean" },
		["lbor"] = { type = "boolean" },
		["slb"] = { type = "boolean" },
		["der"] = { type = "boolean" },
		["clq"] = { type = "boolean" },
		["cal"] = { alias_of = "clq" },
		["calq"] = { alias_of = "clq" },
		["calque"] = { alias_of = "clq" },
		["pclq"] = { type = "boolean" },
		["sml"] = { type = "boolean" },
		["unc"] = { type = "boolean" },
		["sclb"] = { type = "boolean" },
		["nolb"] = { type = "boolean" },
		["q"] = {},
		["sandbox"] = { type = "boolean" },
	}) do
		params[k] = v
	end

	local namespace = mw.title.getCurrentTitle().nsText

	local args
	if frame.args[1] then
		args = require("Module:parameters").process(frame.args, params)
	else
		args = require("Module:parameters").process(frame:getParent().args, params)
	end

	if args.sandbox then
		if namespace == "" or namespace == "Reconstruction" then
			error('The sandbox module, Module:descendants tree/sandbox, should not be used in entries.')
		end
	end
	
	local lang = args[1]
	local term = args[2]
	local alt = args[3]
	local gloss = args["gloss"]
	local tr = args["tr"]
	local ts = args["ts"]
	local sc = args["sc"]
	local id = args["id"]
	
	if namespace == "Template" then
		if not ( sc or lang ) then
			sc = "Latn"
		end
		if not lang then
			lang = "en"
		end
		if not term then
			term = "word"
		end
	end
	
	lang = m_languages.getByCode(lang)
		or require("Module:etymology languages").getByCode(lang)
		or m_languages.err(lang, 1)
		
	local entryLang = m_etymology.getNonEtymological(lang)
	
	if not desc_tree and entryLang:getType() == "family" then
		error("Cannot use language family code in [[Template:desc]].")
	end
	
	if lang:getCode() ~= entryLang:getCode() then
		-- [[Special:WhatLinksHere/Template:tracking/descendant/etymological]]
		require("Module:debug").track("descendant/etymological")
		require("Module:debug").track("descendant/etymological/" .. lang:getCode())
	end
	
	if sc then
		sc = require("Module:scripts").getByCode(sc) or error("The script code \"" .. sc .. "\" is not valid.")
	end
	
	local languageName = lang:getCanonicalName()
	local link = ""
	
	if term ~= "-" then
		link = require("Module:links").full_link(
			{
				lang = entryLang,
				sc = sc,
				term = term,
				alt = alt,
				id = id,
				tr = tr,
				ts = ts,
				genders = args["g"],
				gloss = gloss,
				pos = args["pos"],
				lit = args["lit"],
			},
			nil,
			true)
	elseif ts or gloss or #args["g"] > 0 then
		-- [[Special:WhatLinksHere/Template:tracking/descendant/no term]]
		require "Module:debug".track("descendant/no term")
		link = require("Module:links").full_link(
			{
				lang = entryLang,
				sc = sc,
				ts = ts,
				gloss = gloss,
				genders = args["g"],
			},
			nil,
			true)
		link = link
			:gsub("<small>%[Term%?%]</small> ", "")
			:gsub("<small>%[Term%?%]</small>&nbsp;", "")
			:gsub("%[%[Category:[^%[%]]+ term requests%]%]", "")
	else -- display no link at all
		-- [[Special:WhatLinksHere/Template:tracking/descendant/no term or annotations]]
		require "Module:debug".track("descendant/no term or annotations")
	end
	
	local function add_tooltip(text, tooltip)
		return '<span class="desc-arr" title="' .. tooltip .. '">' .. text .. '</span>'
	end
	
	local label, arrow, descendants, alts, semi_learned, calque, partial_calque, semantic_loan, qual
	
	if args["sclb"] then
		if sc then
			label = sc:getCanonicalName()
		else
			label = require("Module:scripts").findBestScript(term, lang):getCanonicalName()
		end
	else
		label = languageName
	end
	
	if args["bor"] then
		arrow = add_tooltip("→", "borrowed")
	elseif args["lbor"] then
		arrow = add_tooltip("→", "learned borrowing")
	elseif args["slb"] then
		arrow = add_tooltip("→", "semi-learned borrowing")
	elseif args["clq"] then
		arrow = add_tooltip("→", "calque")
	elseif args["pclq"] then
		arrow = add_tooltip("→", "partial calque")
	elseif args["sml"] then
		arrow = add_tooltip("→", "semantic loan")
	elseif args["unc"] and not args["der"] then
		arrow = add_tooltip(">", "inherited")
	else
		arrow = ""
	end
	-- allow der=1 in conjunction with bor=1 to indicate e.g. English "pars recta"
	-- derived and borrowed from Latin "pars".
	if args["der"] then
		arrow = arrow .. add_tooltip("⇒", "reshaped by analogy or addition of morphemes")
	end
	
	if args["unc"]then
		arrow = arrow .. add_tooltip("?", "uncertain")
	end

	local m_desctree
	if desc_tree or args["alts"] then
		if args.sandbox or require("Module:yesno")(frame.args.sandbox, false) then
			m_desctree = require("Module:descendants tree/sandbox")
		else
			m_desctree = require("Module:descendants tree")
		end
	end

	if desc_tree then
		descendants = m_desctree.getDescendants(entryLang, term, id)
	end
	
	if desc_tree and not args["noalts"] or not desc_tree and args["alts"] then
		-- [[Special:WhatLinksHere/Template:tracking/desc/alts]]
		require("Module:debug").track("desc/alts")
		alts = m_desctree.getAlternativeForms(entryLang, term, id)
	end
	
	if args["lbor"] then
		learned = " " .. qualifier("learned")
	else
		learned = ""
	end
	
	if args["slb"] then
		semi_learned = " " .. qualifier("semi-learned")
	else
		semi_learned = ""
	end
	
	if args["clq"] then
		calque = " " .. qualifier("calque")
	else
		calque = ""
	end
	
	if args["pclq"] then
		partial_calque = " " .. qualifier("partial calque")
	else
		partial_calque = ""
	end

	if args["sml"] then
		semantic_loan = " " .. qualifier("semantic loan")
	else
		semantic_loan = ""
	end
	
	if args["q"] then
		qual = " " .. require("Module:qualifier").format_qualifier(args["q"])
	else
		qual = ""
	end

	if args["noparent"] then
		return descendants
	end
	
	if arrow and arrow ~= "" then
		arrow = arrow .. " "
	end
	
	local linktext = table.concat{link, alts or "", learned, semi_learned, calque,
		partial_calque, semantic_loan, qual, descendants or ""}
	if args["notext"] then
		return linktext
	elseif args["nolb"] then
		return arrow .. linktext
	else
		return table.concat{arrow, label, ":", linktext ~= "" and " " or "", linktext}
	end
end
	
function export.descendant(frame)
	return desc_or_desc_tree(frame, false) .. require("Module:TemplateStyles")("Module:etymology/style.css")
end

function export.descendants_tree(frame)
	return desc_or_desc_tree(frame, true)
end

-- Implementation of miscellaneous templates such as {{back-formation}}, {{clipping}},
-- {{ellipsis}}, {{rebracketing}}, and {{reduplication}} that have a single
-- associated term.
function export.misc_variant(frame)
	local params = {
		[1] = {required = true, default = "und"},
		[2] = {},
		[3] = {alias_of = "alt"},
		[4] = {alias_of = "t"},
		
		["alt"] = {},
		["gloss"] = {alias_of = "t"},
		["g"] = {list = true},
		["id"] = {},
		["lit"] = {},
		["pos"] = {},
		["t"] = {},
		["tr"] = {},
		["ts"] = {},
		["sc"] = {},
		
		["nocap"] = {type = "boolean"}, -- should be processed in the template itself
		["notext"] = {type = "boolean"},
		["nocat"] = {type = "boolean"},
		["sort"] = {},
	}
	
	-- |ignore-params= parameter to module invocation specifies
	-- additional parameter names to allow  in template invocation, separated by
	-- commas. They must consist of ASCII letters or numbers or hyphens.
	local ignore_params = frame.args["ignore-params"]
	if ignore_params then
		ignore_params = mw.text.trim(ignore_params)
		if not ignore_params:match "^[%w%-,]+$" then
			error("Invalid characters in |ignore-params=: " .. ignore_params:gsub("[%w%-,]+", ""))
		end
		for param in ignore_params:gmatch "[%w%-]+" do
			if params[param] then
				error("Duplicate param |" .. param
					.. " in |ignore-params=: already specified in params")
			end
			params[param] = {}
		end
	end
	
	local args = require("Module:parameters").process(frame:getParent().args, params)
	
	local lang = fetch_lang(args[1], 1)
	local sc = fetch_script(args["sc"])

	local parts = {}
	if not args["notext"] then
		table.insert(parts, frame.args["text"])
	end
	if args[2] or args["alt"] then
		if not args["notext"] then
			table.insert(parts, " ")
			table.insert(parts, frame.args["oftext"] or "of")
			table.insert(parts, " ")
		end
		table.insert(parts, require("Module:links").full_link(
			{
				lang = lang,
				sc = sc,
				term = args[2],
				alt = args["alt"],
				id = args["id"],
				tr = args["tr"],
				ts = args["ts"],
				genders = args["g"],
				gloss = args["t"],
				pos = args["pos"],
				lit = args["lit"],
			},
			"term",
			true))
	end
	-- Allow |cat=, |cat2=, |cat3=, etc. They must be sequential. If |cat=
	-- is not defined, |cat2= will not be checked. Empty categories are ignored.
	local categories = {}
	if not args["nocat"] and frame.args["cat"] then
		local cat_number
		while true do
			local cat = frame.args["cat" .. (cat_number or "")]
			if not cat then break end
			cat = mw.text.trim(cat)
			if cat ~= "" then
				table.insert(categories, lang:getCanonicalName() .. " " .. cat)
			end
			cat_number = (cat_number or 1) + 1
		end
	end
	if #categories > 0 then
		table.insert(
			parts,
			require("Module:utilities").format_categories(categories, lang, args["sort"]))
	end

	return table.concat(parts)
end


local function get_parsed_part(template, lang, args, terms, i)
	local term = terms[i]
	local alt = args["alt"][i]
	local id = args["id"][i]
	local sc = fetch_script(args["sc"][i])

	local tr = args["tr"][i]
	local ts = args["ts"][i]
	local gloss = args["t"][i]
	local pos = args["pos"][i]
	local lit = args["lit"][i]
	local g = args["g"][i]

	if not (term or alt or tr or ts) then
		require("Module:debug").track(template .. "/no term or alt or tr")
		return nil
	else
		return require("Module:links").full_link(
			{ term = term, alt = alt, id = id, lang = lang, sc = sc, tr = tr,
			ts = ts, gloss = gloss, pos = pos, lit = lit,
			genders = g and rsplit(g, ",") or {}
		}, "term", true)
	end
end


local function get_parsed_parts(template, lang, args, terms)
	local parts = {}

	-- Find the maximum index among any of the list parameters.
	local maxmaxindex = 0
	for k, v in pairs(args) do
		if type(v) == "table" and v.maxindex and v.maxindex > maxmaxindex then
			maxmaxindex = v.maxindex
		end
	end

	for index = 1, maxmaxindex do
		table.insert(parts, get_parsed_part(template, lang, args, terms, index))
	end
	
	return parts
end


-- Implementation of miscellaneous templates such as {{doublet}} that can take
-- multiple terms. Doesn't handle {{blend}} or {{univerbation}}, which display
-- + signs between elements and use compound_like in [[Module:compound/templates]].
function export.misc_variant_multiple_terms(frame)
	local params = {
		[1] = {required = true, default = "und"},
		[2] = {list = true, allow_holes = true},

		["t"] = {list = true, allow_holes = true, require_index = true},
		["gloss"] = {list = true, allow_holes = true, require_index = true, alias_of = "t"},
		["tr"] = {list = true, allow_holes = true, require_index = true},
		["ts"] = {list = true, allow_holes = true, require_index = true},
		["g"] = {list = true, allow_holes = true, require_index = true},
		["id"] = {list = true, allow_holes = true, require_index = true},
		["alt"] = {list = true, allow_holes = true, require_index = true},
		["lit"] = {list = true, allow_holes = true, require_index = true},
		["pos"] = {list = true, allow_holes = true, require_index = true},
		["sc"] = {list = true, allow_holes = true, require_index = true},

		["nocap"] = {type = "boolean"}, -- should be processed in the template itself
		["notext"] = {type = "boolean"},
		["nocat"] = {type = "boolean"},
		["sort"] = {},
	}

	local args = require("Module:parameters").process(frame:getParent().args, params)
	
	local lang = fetch_lang(args[1], 1)

	local parts = {}
	if not args["notext"] then
		table.insert(parts, frame.args["text"])
	end
	if #args[2] > 0 or #args["alt"] > 0 then
		if not args["notext"] then
			table.insert(parts, " ")
			table.insert(parts, frame.args["oftext"] or "of")
			table.insert(parts, " ")
		end
		local formatted_terms = get_parsed_parts(mw.ustring.lower(
			-- Remove link and convert uppercase to lowercase to get an
			-- approximation of the original template name.
			rsub(rsub(frame.args["text"], "^%[%[.*|", ""), "%]%]$", "")),
			lang, args, args[2])
		table.insert(parts, require("Module:table").serialCommaJoin(formatted_terms))
	end
	if not args["nocat"] and frame.args["cat"] then
		local categories = {}
		table.insert(categories, lang:getCanonicalName() .. " " .. frame.args["cat"])
		table.insert(parts, require("Module:utilities").format_categories(categories, lang, args["sort"]))
	end

	return table.concat(parts)
end


-- Implementation of miscellaneous templates such as {{unknown}} that have no
-- associated terms.
function export.misc_variant_no_term(frame)
	local params = {
		[1] = {required = true, default = "und"},

		["title"] = {},
		["nocap"] = {type = "boolean"}, -- should be processed in the template itself
		["notext"] = {type = "boolean"},
		["nocat"] = {type = "boolean"},
		["sort"] = {},
	}

	if frame.args["title2_alias"] then
		params[2] = {alias_of = "title"}
	end
	
	local args = require("Module:parameters").process(frame:getParent().args, params)
	
	local lang = fetch_lang(args[1], 1)

	local parts = {}
	if not args["notext"] then
		table.insert(parts, args["title"] or frame.args["text"])
	end
	if not args["nocat"] and frame.args["cat"] then
		local categories = {}
		table.insert(categories, lang:getCanonicalName() .. " " .. frame.args["cat"])
		table.insert(parts, require("Module:utilities").format_categories(categories, lang, args["sort"]))
	end

	return table.concat(parts)
end

return export