local export = {}

local force_cat = false -- for testing

local m_form_of = require("Module:form of")
local m_form_of_pos = require("Module:form of/pos")
local rfind = mw.ustring.find
local rmatch = mw.ustring.match
local rgsplit = mw.text.gsplit

-- Add tracking category for PAGE when called from TEMPLATE. The tracking
-- category linked to is [[Template:tracking/form-of/TEMPLATE/PAGE]].
local function track(template, page)
	require("Module:debug").track("form-of/" .. template .. "/" .. page)
end


--[=[
Process parent arguments. This is similar to the following:
	require("Module:parameters").process(parent_args, params)
but in addition it does the following:
(1) Supplies default values for unspecified parent arguments as specified in
	DEFAULTS, which consist of specs of the form "ARG=VALUE". These are
	added to the parent arguments prior to processing, so boolean and number
	parameters will process the value appropriately.
(2) Removes parent arguments specified in IGNORESPECS, which consist either
	of bare argument names to remove, or list-argument names to remove of the
	form "ARG:list".
(3) Tracks the use of any parent arguments specified in TRACKED_PARAMS, which
	is a set-type table where the keys are arguments as they exist after
	processing (hence numeric arguments should be numbers, not strings)
	and the values should be boolean true.
]=]--
local function process_parent_args(template, parent_args, params, defaults, ignorespecs, tracked_params)
	if #defaults > 0 or #ignorespecs > 0 then
		local new_parent_args = {}
		for _, default in ipairs(defaults) do
			local defparam, defval = rmatch(default, "^(.-)=(.*)$")
			if not defparam then
				error("Bad default spec " .. default)
			end
			new_parent_args[defparam] = defval
		end
	
		local params_to_ignore = {}
		local numbered_list_params_to_ignore = {}
		local named_list_params_to_ignore = {}

		for _, ignorespec in ipairs(ignorespecs) do
			for ignore in rgsplit(ignorespec, ",") do
				local param = rmatch(ignore, "^(.*):list$")
				if param then
					if rfind(param, "^[0-9]+$") then
						table.insert(numbered_list_params_to_ignore, tonumber(param))
					else
						table.insert(named_list_params_to_ignore,
							"^" .. require("Module:utilities").pattern_escape(param) .. "[0-9]*$")
					end
				else
					if rfind(ignore, "^[0-9]+$") then
						ignore = tonumber(ignore)
					end
					params_to_ignore[ignore] = true
				end
			end
		end

		for k, v in pairs(parent_args) do
			if not params_to_ignore[k] then
				local ignore_me = false
				if type(k) == "number" then
					for _, lparam in ipairs(numbered_list_params_to_ignore) do
						if k >= lparam then
							ignore_me = true
							break
						end
					end
				else
					for _, lparam in ipairs(named_list_params_to_ignore) do
						if rfind(k, lparam) then
							ignore_me = true
							break
						end
					end
				end
				if not ignore_me then
					new_parent_args[k] = v
				end
			end
		end
		parent_args = new_parent_args
	end

	local args = require("Module:parameters").process(parent_args, params)

	-- Tracking for certain user-specified params. This is generally used for
	-- parameters that we accept but ignore, so that we can eventually remove
	-- all uses of these params and stop accepting them.
	if tracked_params then
		for tracked_param, _ in pairs(tracked_params) do
			if parent_args[tracked_param] then
				track(template, "arg/" .. tracked_param)
			end
		end
	end

	return args
end


-- Split TAGSPECS (inflection tag specifications) on SPLIT_REGEX, which
-- may be nil for no splitting.
local function split_inflection_tags(tagspecs, split_regex)
	if not split_regex then
		return tagspecs
	end
	local inflection_tags = {}
	for _, tagspec in ipairs(tagspecs) do
		for tag in rgsplit(tagspec, split_regex) do
			table.insert(inflection_tags, tag)
		end
	end
	return inflection_tags
end


-- Modify PARAMS in-place by adding parameters that control the link to the
-- main entry. TERM_PARAM is the number of the param specifying the main
-- entry itself; TERM_PARAM + 1 will be the display text, and TERM_PARAM + 2
-- will be the gloss, unless NO_NUMBERED_GLOSS is given.
local function add_link_params(params, term_param, no_numbered_gloss)
	-- Numbered params controlling link display
	params[term_param] = {}
	params[term_param + 1] = {alias_of = "alt"}
	if not no_numbered_gloss then
		params[term_param + 2] = {alias_of = "t"}
	end
	
	-- Named params controlling link display
	params["alt"] = {}
	params["t"] = {}
	params["gloss"] = {alias_of = "t"}
	params["sc"] = {}
	params["tr"] = {}
	params["ts"] = {}
	params["pos"] = {}
	params["g"] = {list = true}
	params["id"] = {}
	params["lit"] = {}
end


-- Given processed invocation arguments IARGS and processed parent arguments
-- ARGS, as well as TERM_PARAM (the parent argument specifying the main
-- entry) and COMPAT (true if the language code is found in args["lang"]
-- instead of args[1]), return LANG, TERMINFO, CATEGORIES, where
-- * LANG is the language code;
-- * TERMINFO is the terminfo structure specifying the main entry, as
--   passed to full_link in Module:links;
-- * CATEGORIES is the categories to add the page to (consisting of any
--   categories specified in the invocation or parent args and any tracking
--   categories, but not any additional lang-specific categories that may be
--   added by {{inflection of}} or similar templates).
--
-- This is a subfunction of construct_form_of_text().
local function get_terminfo_and_categories(iargs, args, term_param, compat)
	local lang = args[compat and "lang" or 1] or iargs["lang"] or "und"
	lang = require("Module:languages").getByCode(lang) or
		require("Module:languages").err(lang, compat and "lang" or 1)

	-- Determine categories for the page, including tracking categories

	local categories = {}

	if not args["nocat"] then
		for _, cat in ipairs(iargs["cat"]) do
			table.insert(categories, lang:getCanonicalName() .. " " .. cat)
		end
	end
	for _, cat in ipairs(args["cat"]) do
		table.insert(categories, lang:getCanonicalName() .. " " .. cat)
	end
		
	-- Format the link, preceding text and categories

	local terminfo

	if iargs["nolink"] then
		terminfo = nil
	elseif iargs["linktext"] then
		terminfo = iargs["linktext"]
	else
		local term = args[term_param]

		if not term and not args["alt"] and not args["tr"] and not args["ts"] then
			if mw.title.getCurrentTitle().nsText == "Template" then
				term = "term"
			else
				error("No linked-to term specified; either specify term, alt, translit or transcription")
			end
		end
		
		-- add tracking category if term is same as page title
		if term and mw.title.getCurrentTitle().text == lang:makeEntryName(term) then
			table.insert(categories, "Forms linking to themselves")
		end
		-- maybe add tracking category if primary entry doesn't exist (this is an
		-- expensive call so we don't do it by default)
		if iargs["noprimaryentrycat"] and term and mw.title.getCurrentTitle().nsText == ""
			and not mw.title.new(term).exists then
			table.insert(categories, lang:getCanonicalName() .. " " .. iargs["noprimaryentrycat"])
		end

		local sc = args["sc"] or iargs["sc"]
		
		sc = (sc and (require("Module:scripts").getByCode(sc) or
			error("The script code \"" .. sc .. "\" is not valid.")) or nil)

		terminfo = {
			lang = lang,
			sc = sc,
			term = term,
			alt = args["alt"],
			id = args["id"],
			gloss = args["t"],
			tr = args["tr"],
			ts = args["ts"],
			pos = args["pos"],
			genders = args["g"],
			lit = args["lit"],
		}
	end
	
	return lang, terminfo, categories
end


-- Construct and return the full definition line for a form-of-type template
-- invocation, given processed invocation arguments IARGS, processed parent
-- arguments ARGS, TERM_PARAM (the parent argument specifying the main entry),
-- COMPAT (true if the language code is found in args["lang"] instead of
-- args[1]), and DO_FORM_OF, which is a function that returns the actual
-- definition-line text and any language-specific categories. The terminating
-- period/dot will be added as appropriate, the language-specific categories
-- will be added to any categories requested by the invocation or parent args,
-- and then whole thing will be appropriately formatted.
--
-- DO_FORM_OF takes two arguments:
--
-- (1) The object describing the language;
-- (2) the terminfo object. Normally, this is a table of the form ultimately
--     passed to full_link in [[Module:links]] (which, among other things, also
--     includes the language object inside of it), but if the invocation argument
--     linktext= is given, it will be a string consisting of that text, and if
--     the invocation argument nolink= is given, it will be nil.
--
-- DO_FORM_OF should return two arguments:
--
-- (1) The actual definition-line text, marked up appropriately with
--     <span>...</span> but without any terminating period/dot.
-- (2) Any extra categories to add the page to (other than those that can be
--     derived from parameters specified to the invocation or parent arguments,
--     which will automatically be added to the page).
local function construct_form_of_text(iargs, args, term_param, compat, do_form_of)
	local lang, terminfo, categories = get_terminfo_and_categories(iargs, args, term_param, compat)

	local form_of_text, lang_cats = do_form_of(lang, terminfo)
	for _, cat in ipairs(lang_cats) do
		table.insert(categories, cat)
	end
	local text = form_of_text .. (
		args["nodot"] and "" or args["dot"] or iargs["withdot"] and "." or ""
	)
	if #categories == 0 then
		return text
	end
	return text .. require("Module:utilities").format_categories(categories, lang, args["sort"], nil, force_cat)
end


--[=[
Function that implements {{form of}} and the various more specific form-of
templates (but not {{inflection of}} or templates that take tagged inflection
parameters).

Invocation params:

1= (required):
	Text to display before the link.
term_param=:
	Numbered param holding the term linked to. Other numbered params come after.
	Defaults to 1 if invocation or template param lang= is present, otherwise 2.
lang=:
	Default language code for language-specific templates. If specified, no
	language code needs to be specified, and if specified it needs to be set
	using lang=, not 1=.
sc=:
	Default script code for language-specific templates. The script code can
	still be overridden using template param sc=.
cat=, cat2=, ...:
	Categories to place the page into. The language name will automatically be
	prepended. Note that there is also a template param cat= to specify
	categories at the template level. Use of nocat= disables categorization of
	categories specified using invocation param cat=, but not using template
	param cat=.
ignore=, ignore2=, ...:
	One or more template params to silently accept and ignore. Useful e.g. when
	the template takes additional parameters such as from= or POS=. Each value
	is a comma-separated list of either bare parameter names or specifications
	of the form "PARAM:list" to specify that the parameter is a list parameter.
def=, def2=, ...:
	One or more default values to supply for template args. For example,
	specifying '|def=tr=-' causes the default for template param '|tr=' to be
	'-'. Actual template params override these defaults.
withcap=:
	Capitalize the first character of the text preceding the link, unless
	template param nocap= is given.
withdot=:
	Add a final period after the link, unless template param nodot= is given
	to suppress the period, or dot= is given to specify an alternative
	punctuation character.
nolink=:
	Suppress the display of the link. If specified, none of the template
	params that control the link (TERM_PARAM, TERM_PARAM + 1, TERM_PARAM + 2,
	t=, gloss=, sc=, tr=, ts=, pos=, g=, id=, lit=) will be available.
	If the calling template uses any of these parameters, they must be
	ignored using ignore=.
linktext=:
	Override the display of the link with the specified text. This is useful
	if a custom template is available to format the link (e.g. in Hebrew,
	Chinese and Japanese). If specified, none of the template params that
	control the link (TERM_PARAM, TERM_PARAM + 1, TERM_PARAM + 2, t=, gloss=,
	sc=, tr=, ts=, pos=, g=, id=, lit=) will be available. If the calling
	template uses any of these parameters, they must be ignored using ignore=.
posttext=:
	Additional text to display directly after the formatted link, before any
	terminating period/dot and inside of "<span class='use-with-mention'>".
noprimaryentrycat=:
	Category to add the page to if the primary entry linked to doesn't exist.
	The language name will automatically be prepended.
]=]--
function export.form_of_t(frame)
	local iparams = {
		[1] = {required = true},
		["term_param"] = {type = "number"},
		["lang"] = {},
		["sc"] = {},
		["cat"] = {list = true},
		["ignore"] = {list = true},
		["def"] = {list = true},
		["withcap"] = {type = "boolean"},
		["withdot"] = {type = "boolean"},
		["nolink"] = {type = "boolean"},
		["linktext"] = {},
		["posttext"] = {},
		["noprimaryentrycat"] = {},
	}
	
	local iargs = require("Module:parameters").process(frame.args, iparams)
	local parent_args = frame:getParent().args

	local term_param = iargs["term_param"]
	
	local compat = iargs["lang"] or parent_args["lang"]
	term_param = term_param or compat and 1 or 2

	local params = {
		-- Numbered params
		[compat and "lang" or 1] = {required = not iargs["lang"]},
		
		-- Named params not controlling link display		
		["cat"] = {list = true},
		["notext"] = {type = "boolean"},
		["sort"] = {},
		-- FIXME! The following should only be available when withcap=1 in
		-- invocation args. Before doing that, need to remove all uses of
		-- nocap= in other circumstances.
		["nocap"] = {type = "boolean"},
		-- FIXME! The following should only be available when withdot=1 in
		-- invocation args. Before doing that, need to remove all uses of
		-- nodot= in other circumstances.
		["nodot"] = {type = "boolean"},
	}

	if not iargs["nolink"] and not iargs["linktext"] then
		add_link_params(params, term_param)
	end

	if next(iargs["cat"]) then
		params["nocat"] = {type = "boolean"}
	end

	local ignored_params = {}

	if iargs["withdot"] then
		params["dot"] = {}
	else
		ignored_params["nodot"] = true
	end

	if not iargs["withcap"] then
		params["cap"] = {type = "boolean"}
		ignored_params["nocap"] = true
	end

	local args = process_parent_args("form-of-t", parent_args, params, iargs["def"],
		iargs["ignore"], ignored_params)
	
	local text = args["notext"] and "" or iargs[1]
	if args["cap"] or iargs["withcap"] and not args["nocap"] then
		text = require("Module:string utilities").ucfirst(text)
	end

	return construct_form_of_text(iargs, args, term_param, compat,
		function(lang, terminfo)
			return m_form_of.format_form_of {text = text, terminfo = terminfo,
				terminfo_face = "term", posttext = iargs["posttext"]}, {}
		end
	)
end


-- Construct and return the full definition line for a form-of-type template
-- invocation that is based on inflection tags. This is a wrapper around
-- construct_form_of_text() and takes the following arguments:, processed
-- invocation arguments IARGS, processed parent arguments ARGS, TERM_PARAM
-- (the parent argument specifying the main entry), COMPAT (true if the language
-- code is found in args["lang"] instead of args[1]), and TAGS, the list of
-- (non-canonicalized) inflection tags. It returns that actual definition-line
-- text including terminating period/full-stop, formatted categories, etc. and
-- should be directly returned as the template function's return value.
-- JOINER is the strategy to join multipart tags for display; currently accepted
-- values are "and", "slash", "en-dash".
local function construct_tagged_form_of_text(iargs, args, term_param, compat, tags, joiner)
	return construct_form_of_text(iargs, args, term_param, compat,
		function(lang, terminfo)
			local lang_cats =
				args["nocat"] and {} or m_form_of.fetch_lang_categories(lang, tags, terminfo, args["p"])
			return m_form_of.tagged_inflections {
				tags = tags,
				terminfo = terminfo,
				terminfo_face = "term",
				notext = args["notext"],
				capfirst = args["cap"] or iargs["withcap"] and not args["nocap"],
				posttext = iargs["posttext"],
				joiner = joiner
			}, lang_cats
		end
	)
end


--[=[
Function that implements form-of templates that are defined by specific tagged
inflections (typically a template referring to a non-lemma inflection,
such as {{genitive plural of}}). This works exactly like form_of_t() except
that the "form of" text displayed before the link is based off of a
pre-specified set of inflection tags (which will be appropriately linked to
the glossary) instead of arbitrary text. From the user's perspective, there
is no difference between templates implemented using form_of_t() and
tagged_form_of_t(); they accept exactly the same parameters and work the same.
See also inflection_of_t() below, which is intended for templates with
user-specified inflection tags.

Invocation params:

1=, 2=, ... (required):
	One or more inflection tags describing the inflection in question.
split_tags=:
	If specified, character to split specified inflection tags on. This allows
	multiple tags to be included in a single argument, simplifying template
	code.
term_param=:
lang=:
sc=:
cat=, cat2=, ...:
ignore=, ignore2=, ...:
def=, def2=, ...:
withcap=:
withdot=:
nolink=:
linktext=:
posttext=:
noprimaryentrycat=:
	All of these are the same as in form_of_t().
]=]--
function export.tagged_form_of_t(frame)
	local iparams = {
		[1] = {list = true, required = true},
		["split_tags"] = {},
		["term_param"] = {type = "number"},
		["lang"] = {},
		["sc"] = {},
		["cat"] = {list = true},
		["ignore"] = {list = true},
		["def"] = {list = true},
		["withcap"] = {type = "boolean"},
		["withdot"] = {type = "boolean"},
		["nolink"] = {type = "boolean"},
		["linktext"] = {},
		["posttext"] = {},
		["noprimaryentrycat"] = {},
	}
	
	local iargs = require("Module:parameters").process(frame.args, iparams)
	local parent_args = frame:getParent().args

	local term_param = iargs["term_param"]

	local compat = iargs["lang"] or parent_args["lang"]
	term_param = term_param or compat and 1 or 2

	local params = {
		-- Numbered params
		[compat and "lang" or 1] = {required = not iargs["lang"]},

		-- Named params not controlling link display		
		["cat"] = {list = true},
		-- Always included because lang-specific categories may be added
		["nocat"] = {type = "boolean"},
		["p"] = {},
		["POS"] = {alias_of = "p"},
		["notext"] = {type = "boolean"},
		["sort"] = {},
		-- FIXME! The following should only be available when withcap=1 in
		-- invocation args. Before doing that, need to remove all uses of
		-- nocap= in other circumstances.
		["nocap"] = {type = "boolean"},
		-- FIXME! The following should only be available when withdot=1 in
		-- invocation args. Before doing that, need to remove all uses of
		-- nodot= in other circumstances.
		["nodot"] = {type = "boolean"},
	}
	
	if not iargs["nolink"] and not iargs["linktext"] then
		add_link_params(params, term_param)
	end

	local ignored_params = {}

	if iargs["withdot"] then
		params["dot"] = {}
	else
		ignored_params["nodot"] = true
	end

	if not iargs["withcap"] then
		params["cap"] = {type = "boolean"}
		ignored_params["nocap"] = true
	end

	local args = process_parent_args("tagged-form-of-t", parent_args,
		params, iargs["def"], iargs["ignore"], ignored_params)
	
	return construct_tagged_form_of_text(iargs, args, term_param, compat,
		split_inflection_tags(iargs[1], iargs["split_tags"]), "and")
end

--[=[
Function that implements {{inflection of}} and certain semi-specific variants,
such as {{participle of}} and {{past participle form of}}. This function is
intended for templates that allow the user to specify a set of inflection tags.
It works similarly to form_of_t() and tagged_form_of_t() except that the
calling convention for the calling template is
	{{TEMPLATE|LANG|MAIN_ENTRY_LINK|MAIN_ENTRY_DISPLAY_TEXT|TAG|TAG|...}}
instead of 
	{{TEMPLATE|LANG|MAIN_ENTRY_LINK|MAIN_ENTRY_DISPLAY_TEXT|GLOSS}}
Note that there isn't a numbered parameter for the gloss, but it can still
be specified using t= or gloss=.

Invocation params:

preinfl=, preinfl2=, ...:
	Extra inflection tags to automatically prepend to the tags specified by
	the template.
postinfl=, postinfl2=, ...:
	Extra inflection tags to automatically append to the tags specified by the
	template. Used for example by {{past participle form of}} to add the tags
	'of the|past|p' onto the user-specified tags, which indicate which past
	participle form the page refers to.
split_tags=:
	If specified, character to split specified inflection tags on. This allows
	multiple tags to be included in a single argument, simplifying template
	code. Note that this applies *ONLY* to inflection tags specified in the
	invocation arguments using preinfl= or postinfl=, not to user-specified
	inflection tags.
term_param=:
lang=:
sc=:
cat=, cat2=, ...:
ignore=, ignore2=, ...:
def=, def2=, ...:
withcap=:
withdot=:
nolink=:
linktext=:
posttext=:
noprimaryentrycat=:
	All of these are the same as in form_of_t().
]=]--
function export.inflection_of_t(frame)
	local iparams = {
		["preinfl"] = {list = true},
		["postinfl"] = {list = true},
		["split_tags"] = {},
		["term_param"] = {type = "number"},
		["lang"] = {},
		["sc"] = {},
		["cat"] = {list = true},
		["ignore"] = {list = true},
		["def"] = {list = true},
		["withcap"] = {type = "boolean"},
		["withdot"] = {type = "boolean"},
		["nolink"] = {type = "boolean"},
		["linktext"] = {},
		["posttext"] = {},
		["noprimaryentrycat"] = {},
	}

	local iargs = require("Module:parameters").process(frame.args, iparams)
	local parent_args = frame:getParent().args

	local term_param = iargs["term_param"]
	
	local compat = iargs["lang"] or parent_args["lang"]
	term_param = term_param or compat and 1 or 2

	local params = {
		-- Numbered params
		[compat and "lang" or 1] = {required = not iargs["lang"]},
		[term_param + 2] = {list = true,
			-- at least one inflection tag is required unless preinfl or
			-- postinfl tags are given
			required = #iargs["preinfl"] == 0 and #iargs["postinfl"] == 0},
		
		-- Named params not controlling link display		
		["cat"] = {list = true},
		-- Always included because lang-specific categories may be added
		["nocat"] = {type = "boolean"},
		["p"] = {},
		["POS"] = {alias_of = "p"},
		["notext"] = {type = "boolean"},
		["sort"] = {},
		-- FIXME! The following should only be available when withcap=1 in
		-- invocation args. Before doing that, need to remove all uses of
		-- nocap= in other circumstances.
		["nocap"] = {type = "boolean"},
		-- FIXME! The following should only be available when withdot=1 in
		-- invocation args. Before doing that, need to remove all uses of
		-- nodot= in other circumstances.
		["nodot"] = {type = "boolean"},
		-- Temporary, allows multipart joiner to be controlled on a template-by-template
		-- basis
		["joiner"] = {},
	}
	
	if not iargs["nolink"] and not iargs["linktext"] then
		add_link_params(params, term_param, "no-numbered-gloss")
	end

	local ignored_params = {}

	if iargs["withdot"] then
		params["dot"] = {}
	else
		ignored_params["nodot"] = true
	end

	if not iargs["withcap"] then
		params["cap"] = {type = "boolean"}
		ignored_params["nocap"] = true
	end

	local args = process_parent_args("inflection-of-t", parent_args,
		params, iargs["def"], iargs["ignore"], ignored_params)
	
	local infls
	if not next(iargs["preinfl"]) and not next(iargs["postinfl"]) then
		infls = args[term_param + 2]
	else
		infls = {}
		for _, infl in ipairs(split_inflection_tags(iargs["preinfl"], iargs["split_tags"])) do
			table.insert(infls, infl)
		end
		for _, infl in ipairs(args[term_param + 2]) do
			table.insert(infls, infl)
		end
		for _, infl in ipairs(split_inflection_tags(iargs["postinfl"], iargs["split_tags"])) do
			table.insert(infls, infl)
		end
	end

	return construct_tagged_form_of_text(iargs, args, term_param, compat, infls,
		parent_args["joiner"])
end

--[=[
Normalize a part-of-speech tag given a possible abbreviation
(passed in as 1= of the invocation args). If the abbreviation
isn't recognized, the original POS tag is returned. If no POS
tag is passed in, return the value of invocation arg default=.
]=]--
function export.normalize_pos(frame)
	local iparams = {
		[1] = {},
		["default"] = {},
	}
	local iargs = require("Module:parameters").process(frame.args, iparams)
	if not iargs[1] and not iargs["default"] then
		error("Either 1= or default= must be given in the invocation args")
	end
	return m_form_of_pos[iargs[1]] or iargs[1] or iargs["default"]
end

return export