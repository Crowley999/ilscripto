--[[--------------------------< F O R W A R D   D E C L A R A T I O N S >--------------------------------------
]]
local dates, year_date_check	-- functions in Module:Citation/CS1/Date_validation
local z, is_set, first_set, is_url, split_url, add_maint_cat, add_prop_cat, error_comment, in_array, substitute, set_error                 -- functions in Module:Citation/CS1/Utilities
local extract_ids, build_id_list, is_embargoed, extract_id_access_levels  -- functions in Module:Citation/CS1/Identifiers
local cfg = {};					-- table of configuration tables that are defined in Module:Citation/CS1/Configuration
local whitelist = {};			-- table of tables listing valid template parameter names; defined in Module:Citation/CS1/Whitelist

--[[--------------------------< A D D _ V A N C _ E R R O R >----------------------------------------------------

Adds a single Vancouver system error message to the template's output regardless of how many error actually exist.
To prevent duplication, added_vanc_errs is nil until an error message is emitted.

]]

local added_vanc_errs;															-- flag so we only emit one Vancouver error / category
local function add_vanc_error ()
	if not added_vanc_errs then
		added_vanc_errs = true;													-- note that we've added this category
		table.insert( z.message_tail, { set_error( 'vancouver', {}, true ) } );
	end
end



--[[--------------------------< L I N K _ P A R A M _ O K >---------------------------------------------------

checks the content of |title-link=, |series-link=, |author-link= etc for properly formatted content: no wikilinks, no urls

Link parameters are to hold the title of a wikipedia article so none of the WP:TITLESPECIALCHARACTERS are allowed:
	# < > [ ] | { } _
except the underscore which is used as a space in wiki urls and # which is used for section links

returns false when the value contains any of these characters.

When there are no illegal characters, this function returns TRUE if value DOES NOT appear to be a valid url (the
|<param>-link= parameter is ok); else false when value appears to be a valid url (the |<param>-link= parameter is NOT ok).

]]

local function link_param_ok (value)
	local scheme, domain;
	if value:find ('[<>%[%]|{}]') then											-- if any prohibited characters
		return false;
	end

	scheme, domain = split_url (value);											-- get scheme or nil and domain or nil from url; 
	return not is_url (scheme, domain);											-- return true if value DOES NOT appear to be a valid url
end


--[[--------------------------< C H E C K _ U R L >------------------------------------------------------------

Determines whether a URL string appears to be valid.

First we test for space characters.  If any are found, return false.  Then split the url into scheme and domain
portions, or for protocol relative (//example.com) urls, just the domain.  Use is_url() to validate the two
portions of the url.  If both are valid, or for protocol relative if domain is valid, return true, else false.

]]

local function check_url( url_str )
	if nil == url_str:match ("^%S+$") then										-- if there are any spaces in |url=value it can't be a proper url
		return false;
	end
	local scheme, domain;

	scheme, domain = split_url (url_str);										-- get scheme or nil and domain or nil from url; 
	return is_url (scheme, domain);												-- return true if value appears to be a valid url
end


--[=[-------------------------< I S _ P A R A M E T E R _ E X T _ W I K I L I N K >----------------------------

Return true if a parameter value has a string that begins and ends with square brackets [ and ] and the first
non-space characters following the opening bracket appear to be a url.  The test will also find external wikilinks
that use protocol relative urls. Also finds bare urls.

The frontier pattern prevents a match on interwiki links which are similar to scheme:path urls.  The tests that
find bracketed urls are required because the parameters that call this test (currently |title=, |chapter=, |work=,
and |publisher=) may have wikilinks and there are articles or redirects like '//Hus' so, while uncommon, |title=[[//Hus]]
is possible as might be [[en://Hus]].

]=]

local function is_parameter_ext_wikilink (value)
local scheme, domain;

	value = value:gsub ('([^%s/])/[%a%d].*', '%1');								-- strip path information (the capture prevents false replacement of '//')

	if value:match ('%f[%[]%[%a%S*:%S+.*%]') then								-- if ext wikilink with scheme and domain: [xxxx://yyyyy.zzz]
		scheme, domain = value:match ('%f[%[]%[(%a%S*:)(%S+).*%]')
	elseif value:match ('%f[%[]%[//%S*%.%S+.*%]') then							-- if protocol relative ext wikilink: [//yyyyy.zzz]
		domain = value:match ('%f[%[]%[//(%S*%.%S+).*%]');
	elseif value:match ('%a%S*:%S+') then										-- if bare url with scheme; may have leading or trailing plain text
		scheme, domain = value:match ('(%a%S*:)(%S+)');
	elseif value:match ('//%S*%.%S+') then										-- if protocol relative bare url: //yyyyy.zzz; may have leading or trailing plain text
		domain = value:match ('//(%S*%.%S+)');									-- what is left should be the domain
	else
		return false;															-- didn't find anything that is obviously a url
	end

	return is_url (scheme, domain);												-- return true if value appears to be a valid url
end


--[[-------------------------< C H E C K _ F O R _ U R L >-----------------------------------------------------

loop through a list of parameters and their values.  Look at the value and if it has an external link, emit an error message.

]]

local function check_for_url (parameter_list)
local error_message = '';
	for k, v in pairs (parameter_list) do										-- for each parameter in the list
		if is_parameter_ext_wikilink (v) then									-- look at the value; if there is a url add an error message
			if is_set(error_message) then										-- once we've added the first portion of the error message ...
				error_message=error_message .. ", ";							-- ... add a comma space separator
			end
			error_message=error_message .. "&#124;" .. k .. "=";				-- add the failed parameter
		end
	end
	if is_set (error_message) then												-- done looping, if there is an error message, display it
		table.insert( z.message_tail, { set_error( 'param_has_ext_link', {error_message}, true ) } );
	end
end


--[[--------------------------< S A F E _ F O R _ I T A L I C S >----------------------------------------------

Protects a string that will be wrapped in wiki italic markup '' ... ''

Note: We cannot use <i> for italics, as the expected behavior for italics specified by ''...'' in the title is that
they will be inverted (i.e. unitalicized) in the resulting references.  In addition, <i> and '' tend to interact
poorly under Mediawiki's HTML tidy.

]]

local function safe_for_italics( str )
	if not is_set(str) then
		return str;
	else
		if str:sub(1,1) == "'" then str = "<span></span>" .. str; end
		if str:sub(-1,-1) == "'" then str = str .. "<span></span>"; end
		
		-- Remove newlines as they break italics.
		return str:gsub( '\n', ' ' );
	end
end

--[[--------------------------< S A F E _ F O R _ U R L >------------------------------------------------------

Escape sequences for content that will be used for URL descriptions

]]

local function safe_for_url( str )
	if str:match( "%[%[.-%]%]" ) ~= nil then 
		table.insert( z.message_tail, { set_error( 'wikilink_in_url', {}, true ) } );
	end
	
	return str:gsub( '[%[%]\n]', {	
		['['] = '&#91;',
		[']'] = '&#93;',
		['\n'] = ' ' } );
end

--[[--------------------------< W R A P _ S T Y L E >----------------------------------------------------------

Applies styling to various parameters.  Supplied string is wrapped using a message_list configuration taking one
argument; protects italic styled parameters.  Additional text taken from citation_config.presentation - the reason
this function is similar to but separate from wrap_msg().

]]

local function wrap_style (key, str)
	if not is_set( str ) then
		return "";
	elseif in_array( key, { 'italic-title', 'trans-italic-title' } ) then
		str = safe_for_italics( str );
	end

	return substitute( cfg.presentation[key], {str} );
end

--[[--------------------------< E X T E R N A L _ L I N K >----------------------------------------------------

Format an external link with error checking

]]

local function external_link( URL, label, source )
	local error_str = "";
	if not is_set( label ) then
		label = URL;
		if is_set( source ) then
			error_str = set_error( 'bare_url_missing_title', { wrap_style ('parameter', source) }, false, " " );
		else
			error( cfg.messages["bare_url_no_origin"] );
		end			
	end
	if not check_url( URL ) then
		error_str = set_error( 'bad_url', {wrap_style ('parameter', source)}, false, " " ) .. error_str;
	end
	return table.concat({ "[", URL, " ", safe_for_url( label ), "]", error_str });
end

--[[--------------------------< D E P R E C A T E D _ P A R A M E T E R >--------------------------------------

Categorize and emit an error message when the citation contains one or more deprecated parameters.  The function includes the
offending parameter name to the error message.  Only one error message is emitted regardless of the number of deprecated
parameters in the citation.

]]

local page_in_deprecated_cat;													-- sticky flag so that the category is added only once
local function deprecated_parameter(name)
	if not page_in_deprecated_cat then
		page_in_deprecated_cat = true;											-- note that we've added this category
		table.insert( z.message_tail, { set_error( 'deprecated_params', {name}, true ) } );		-- add error message
	end
end

--[[--------------------------< K E R N _ Q U O T E S >--------------------------------------------------------

Apply kerning to open the space between the quote mark provided by the Module and a leading or trailing quote mark contained in a |title= or |chapter= parameter's value.
This function will positive kern either single or double quotes:
	"'Unkerned title with leading and trailing single quote marks'"
	" 'Kerned title with leading and trailing single quote marks' " (in real life the kerning isn't as wide as this example)
Double single quotes (italic or bold wikimarkup) are not kerned.

Call this function for chapter titles, for website titles, etc; not for book titles.

]]

local function kern_quotes (str)
	local cap='';
	local cap2='';
	
	cap, cap2 = str:match ("^([\"\'])([^\'].+)");								-- match leading double or single quote but not double single quotes
	if is_set (cap) then
		str = substitute (cfg.presentation['kern-left'], {cap, cap2});
	end

	cap, cap2 = str:match ("^(.+[^\'])([\"\'])$")
	if is_set (cap) then
		str = substitute (cfg.presentation['kern-right'], {cap, cap2});
	end
	return str;
end

--[[--------------------------< F O R M A T _ S C R I P T _ V A L U E >----------------------------------------

|script-title= holds title parameters that are not written in Latin based scripts: Chinese, Japanese, Arabic, Hebrew, etc. These scripts should
not be italicized and may be written right-to-left.  The value supplied by |script-title= is concatenated onto Title after Title has been wrapped
in italic markup.

Regardless of language, all values provided by |script-title= are wrapped in <bdi>...</bdi> tags to isolate rtl languages from the English left to right.

|script-title= provides a unique feature.  The value in |script-title= may be prefixed with a two-character ISO639-1 language code and a colon:
	|script-title=ja:*** *** (where * represents a Japanese character)
Spaces between the two-character code and the colon and the colon and the first script character are allowed:
	|script-title=ja : *** ***
	|script-title=ja: *** ***
	|script-title=ja :*** ***
Spaces preceding the prefix are allowed: |script-title = ja:*** ***

The prefix is checked for validity.  If it is a valid ISO639-1 language code, the lang attribute (lang="ja") is added to the <bdi> tag so that browsers can
know the language the tag contains.  This may help the browser render the script more correctly.  If the prefix is invalid, the lang attribute
is not added.  At this time there is no error message for this condition.

Supports |script-title= and |script-chapter=

TODO: error messages when prefix is invalid ISO639-1 code; when script_value has prefix but no script;
]]

local function format_script_value (script_value)
	local lang='';																-- initialize to empty string
	local name;
	if script_value:match('^%l%l%s*:') then										-- if first 3 non-space characters are script language prefix
		lang = script_value:match('^(%l%l)%s*:%s*%S.*');						-- get the language prefix or nil if there is no script
		if not is_set (lang) then
			return '';															-- script_value was just the prefix so return empty string
		end
																				-- if we get this far we have prefix and script
		name = mw.language.fetchLanguageName( lang, mw.getContentLanguage():getCode() );						-- get language name so that we can use it to categorize
		if is_set (name) then													-- is prefix a proper ISO 639-1 language code?
			script_value = script_value:gsub ('^%l%l%s*:%s*', '');				-- strip prefix from script
																				-- is prefix one of these language codes?
			if in_array (lang, {'ar', 'bg', 'bs', 'dv', 'el', 'fa', 'he', 'hy', 'ja', 'ka', 'ko', 'ku', 'mk', 'ps', 'ru', 'sd', 'sr', 'th', 'uk', 'ug', 'yi', 'zh'}) then
				add_prop_cat ('script_with_name', {name, lang})
			else
				add_prop_cat ('script')
			end
			lang = ' lang="' .. lang .. '" ';									-- convert prefix into a lang attribute
		else
			lang = '';															-- invalid so set lang to empty string
		end
	end
	if is_set(script_value) then
		script_value = '-{R|' .. script_value .. '}-';
	end
	script_value = substitute (cfg.presentation['bdi'], {lang, script_value});	-- isolate in case script is rtl

	return script_value;
end

--[[--------------------------< S C R I P T _ C O N C A T E N A T E >------------------------------------------

Initially for |title= and |script-title=, this function concatenates those two parameter values after the script value has been 
wrapped in <bdi> tags.
]]

local function script_concatenate (title, script)
	if is_set(title) then
		title = '-{' .. title .. '}-';
	end
	if is_set (script) then
		script = format_script_value (script);									-- <bdi> tags, lang atribute, categorization, etc; returns empty string on error
		if is_set (script) then
			title = title .. ' ' .. script;										-- concatenate title and script title
		end
	end
	return title;
end


--[[--------------------------< W R A P _ M S G >--------------------------------------------------------------

Applies additional message text to various parameter values. Supplied string is wrapped using a message_list
configuration taking one argument.  Supports lower case text for {{citation}} templates.  Additional text taken
from citation_config.messages - the reason this function is similar to but separate from wrap_style().

]]

local function wrap_msg (key, str, lower)
	if not is_set( str ) then
		return "";
	end
	if true == lower then
		local msg;
		msg = cfg.messages[key]:lower();										-- set the message to lower case before 
		return substitute( msg, str );										-- including template text
	else
		return substitute( cfg.messages[key], str );
	end		
end


--[[-------------------------< I S _ A L I A S _ U S E D >-----------------------------------------------------

This function is used by select_one() to determine if one of a list of alias parameters is in the argument list
provided by the template.

Input:
	args – pointer to the arguments table from calling template
	alias – one of the list of possible aliases in the aliases lists from Module:Citation/CS1/Configuration
	index – for enumerated parameters, identifies which one
	enumerated – true/false flag used choose how enumerated aliases are examined
	value – value associated with an alias that has previously been selected; nil if not yet selected
	selected – the alias that has previously been selected; nil if not yet selected
	error_list – list of aliases that are duplicates of the alias already selected

Returns:
	value – value associated with alias we selected or that was previously selected or nil if an alias not yet selected
	selected – the alias we selected or the alias that was previously selected or nil if an alias not yet selected

]]

local function is_alias_used (args, alias, index, enumerated, value, selected, error_list)
	if enumerated then															-- is this a test for an enumerated parameters?
		alias = alias:gsub ('#', index);										-- replace '#' with the value in index
	else
		alias = alias:gsub ('#', '');											-- remove '#' if it exists
	end

	if is_set(args[alias]) then													-- alias is in the template's argument list
		if value ~= nil and selected ~= alias then								-- if we have already selected one of the aliases
			local skip;
			for _, v in ipairs(error_list) do									-- spin through the error list to see if we've added this alias
				if v == alias then
					skip = true;
					break;														-- has been added so stop looking 
				end
			end
			if not skip then													-- has not been added so
				table.insert( error_list, alias );								-- add error alias to the error list
			end
		else
			value = args[alias];												-- not yet selected an alias, so select this one
			selected = alias;
		end
	end
	return value, selected;														-- return newly selected alias, or previously selected alias
end


--[[--------------------------< S E L E C T _ O N E >----------------------------------------------------------

Chooses one matching parameter from a list of parameters to consider.  The list of parameters to consider is just
names.  For parameters that may be enumerated, the position of the numerator in the parameter name is identified
by the '#' so |author-last1= and |author1-last= are represented as 'author-last#' and 'author#-last'.

Because enumerated parameter |<param>1= is an alias of |<param>= we must test for both possibilities.


Generates an error if more than one match is present.

]]

local function select_one( args, aliases_list, error_condition, index )
	local value = nil;															-- the value assigned to the selected parameter
	local selected = '';														-- the name of the parameter we have chosen
	local error_list = {};

	if index ~= nil then index = tostring(index); end

	for _, alias in ipairs( aliases_list ) do									-- for each alias in the aliases list
		if alias:match ('#') then												-- if this alias can be enumerated
			if '1' == index then												-- when index is 1 test for enumerated and non-enumerated aliases
				value, selected = is_alias_used (args, alias, index, false, value, selected, error_list);	-- first test for non-enumerated alias
			end
			value, selected = is_alias_used (args, alias, index, true, value, selected, error_list);		-- test for enumerated alias
		else
			value, selected = is_alias_used (args, alias, index, false, value, selected, error_list);		--test for non-enumerated alias
		end
	end

	if #error_list > 0 and 'none' ~= error_condition then						-- for cases where this code is used outside of extract_names()
		local error_str = "";
		for _, k in ipairs( error_list ) do
			if error_str ~= "" then error_str = error_str .. cfg.messages['parameter-separator'] end
			error_str = error_str .. wrap_style ('parameter', k);
		end
		if #error_list > 1 then
			error_str = error_str .. cfg.messages['parameter-final-separator'];
		else
			error_str = error_str .. cfg.messages['parameter-pair-separator'];
		end
		error_str = error_str .. wrap_style ('parameter', selected);
		table.insert( z.message_tail, { set_error( error_condition, {error_str}, true ) } );
	end
	
	return value, selected;
end


--[[--------------------------< F O R M A T _ C H A P T E R _ T I T L E >--------------------------------------

Format the four chapter parameters: |script-chapter=, |chapter=, |trans-chapter=, and |chapter-url= into a single Chapter meta-
parameter (chapter_url_source used for error messages).

]]

local function format_chapter_title (scriptchapter, chapter, transchapter, chapterurl, chapter_url_source, no_quotes)
	local chapter_error = '';
	
	if not is_set (chapter) then
		chapter = '';															-- to be safe for concatenation
	else
		if false == no_quotes then
			chapter = kern_quotes (chapter);										-- if necessary, separate chapter title's leading and trailing quote marks from Module provided quote marks
			chapter = wrap_style ('quoted-title', chapter);
		end
	end

	chapter = script_concatenate (chapter, scriptchapter)						-- <bdi> tags, lang atribute, categorization, etc; must be done after title is wrapped

	if is_set (transchapter) then
		transchapter = wrap_style ('trans-quoted-title', transchapter);
		if is_set (chapter) then
			chapter = chapter ..  ' ' .. transchapter;
		else																	-- here when transchapter without chapter or script-chapter
			chapter = transchapter;												-- 
			chapter_error = ' ' .. set_error ('trans_missing_title', {'chapter'});
		end
	end

	if is_set (chapterurl) then
		chapter = external_link (chapterurl, chapter, chapter_url_source);		-- adds bare_url_missing_title error if appropriate
	end

	return chapter .. chapter_error;
end

--[[--------------------------< H A S _ I N V I S I B L E _ C H A R S >----------------------------------------

This function searches a parameter's value for nonprintable or invisible characters.  The search stops at the
first match.

This function will detect the visible replacement character when it is part of the wikisource.

Detects but ignores nowiki and math stripmarkers.  Also detects other named stripmarkers (gallery, math, pre, ref)
and identifies them with a slightly different error message.  See also coins_cleanup().

Detects but ignores the character pattern that results from the transclusion of {{'}} templates.

Output of this function is an error message that identifies the character or the Unicode group, or the stripmarker
that was detected along with its position (or, for multi-byte characters, the position of its first byte) in the
parameter value.

]]

local function has_invisible_chars (param, v)
	local position = '';														-- position of invisible char or starting position of stripmarker
	local dummy;																-- end of matching string; not used but required to hold end position when a capture is returned
	local capture;																-- used by stripmarker detection to hold name of the stripmarker
	local i=1;
	local stripmarker, apostrophe;

	while cfg.invisible_chars[i] do
		local char=cfg.invisible_chars[i][1]									-- the character or group name
		local pattern=cfg.invisible_chars[i][2]									-- the pattern used to find it
		position, dummy, capture = mw.ustring.find (v, pattern)					-- see if the parameter value contains characters that match the pattern
		
		if position then
			if 'nowiki' == capture or 'math' == capture or						-- nowiki and math stripmarkers (not an error condition)
				('templatestyles' == capture) then	-- templatestyles stripmarker allowed
					stripmarker = true;											-- set a flag
			elseif true == stripmarker and 'delete' == char then				-- because stripmakers begin and end with the delete char, assume that we've found one end of a stripmarker
				position = nil;													-- unset
			elseif 'apostrophe' == char then									-- apostrophe template uses &zwj;, hair space and zero-width space
				apostrophe = true;
			elseif true == apostrophe and in_array (char, {'zero width joiner', 'zero width space', 'hair space'}) then
				position = nil;													-- unset
			else
				local err_msg;
				if capture then
					err_msg = capture .. ' ' .. cfg.invisible_chars[i][3] or char;
				else
					err_msg = cfg.invisible_chars[i][3] or (char .. ' character');
				end

				table.insert( z.message_tail, { set_error( 'invisible_char', {err_msg, wrap_style ('parameter', param), position}, true ) } );	-- add error message
				return;															-- and done with this parameter
			end
		end
		i=i+1;																	-- bump our index
	end
end


--[[--------------------------< A R G U M E N T _ W R A P P E R >----------------------------------------------

Argument wrapper.  This function provides support for argument mapping defined in the configuration file so that
multiple names can be transparently aliased to single internal variable.

]]

local function argument_wrapper( args )
	local origin = {};
	
	return setmetatable({
		ORIGIN = function( self, k )
			local dummy = self[k]; --force the variable to be loaded.
			return origin[k];
		end
	},
	{
		__index = function ( tbl, k )
			if origin[k] ~= nil then
				return nil;
			end
			
			local args, list, v = args, cfg.aliases[k];
			
			if type( list ) == 'table' then
				v, origin[k] = select_one( args, list, 'redundant_parameters' );
				if origin[k] == nil then
					origin[k] = ''; -- Empty string, not nil
				end
			elseif list ~= nil then
				v, origin[k] = args[list], list;
			else
				-- maybe let through instead of raising an error?
				-- v, origin[k] = args[k], k;
				error( cfg.messages['unknown_argument_map'] );
			end
			
			-- Empty strings, not nil;
			if v == nil then
				v = cfg.defaults[k] or '';
				origin[k] = '';
			end
			
			tbl = rawset( tbl, k, v );
			return v;
		end,
	});
end

--[[--------------------------< V A L I D A T E >--------------------------------------------------------------
Looks for a parameter's name in the whitelist.

Parameters in the whitelist can have three values:
	true - active, supported parameters
	false - deprecated, supported parameters
	nil - unsupported parameters
	
]]

local function validate( name )
	local name = tostring( name );
	local state = whitelist.basic_arguments[ name ];
	
	-- Normal arguments
	if true == state then return true; end		-- valid actively supported parameter
	if false == state then
		deprecated_parameter (name);				-- parameter is deprecated but still supported
		return true;
	end
	
	-- Arguments with numbers in them
	name = name:gsub( "%d+", "#" );				-- replace digit(s) with # (last25 becomes last#
	state = whitelist.numbered_arguments[ name ];
	if true == state then return true; end		-- valid actively supported parameter
	if false == state then
		deprecated_parameter (name);				-- parameter is deprecated but still supported
		return true;
	end
	
	return false;								-- Not supported because not found or name is set to nil
end


--[[--------------------------< N O W R A P _ D A T E >--------------------------------------------------------

When date is YYYY-MM-DD format wrap in nowrap span: <span ...>YYYY-MM-DD</span>.  When date is DD MMMM YYYY or is
MMMM DD, YYYY then wrap in nowrap span: <span ...>DD MMMM</span> YYYY or <span ...>MMMM DD,</span> YYYY

DOES NOT yet support MMMM YYYY or any of the date ranges.

]]

local function nowrap_date (date)
	local cap='';
	local cap2='';

	if date:match("^%d%d%d%d%-%d%d%-%d%d$") then
		date = substitute (cfg.presentation['nowrap1'], date);
	
	elseif date:match("^%a+%s*%d%d?,%s+%d%d%d%d$") or date:match ("^%d%d?%s*%a+%s+%d%d%d%d$") then
		cap, cap2 = string.match (date, "^(.*)%s+(%d%d%d%d)$");
		date = substitute (cfg.presentation['nowrap2'], {cap, cap2});
	end
	
	return date;
end

--[[--------------------------< S E T _ T I T L E T Y P E >----------------------------------------------------

This function sets default title types (equivalent to the citation including |type=<default value>) for those templates that have defaults.
Also handles the special case where it is desirable to omit the title type from the rendered citation (|type=none).

]]

local function set_titletype (cite_class, title_type)
	if is_set(title_type) then
		if "none" == title_type then
			title_type = "";													-- if |type=none then type parameter not displayed
		end
		return title_type;														-- if |type= has been set to any other value use that value
	end

	return cfg.title_types [cite_class] or '';									-- set template's default title type; else empty string for concatenation
end

--[[--------------------------< C L E A N _ I S B N >----------------------------------------------------------

Removes irrelevant text and dashes from ISBN number
Similar to that used for Special:BookSources

]]

local function clean_isbn( isbn_str )
	return isbn_str:gsub( "[^-0-9X]", "" );
end

--[[--------------------------< E S C A P E _ L U A _ M A G I C _ C H A R S >----------------------------------

Returns a string where all of lua's magic characters have been escaped.  This is important because functions like
string.gsub() treat their pattern and replace strings as patterns, not literal strings.
]]
local function escape_lua_magic_chars (argument)
	argument = argument:gsub("%%", "%%%%");										-- replace % with %%
	argument = argument:gsub("([%^%$%(%)%.%[%]%*%+%-%?])", "%%%1");				-- replace all other lua magic pattern characters
	return argument;
end

--[[--------------------------< S T R I P _ A P O S T R O P H E _ M A R K U P >--------------------------------

Strip wiki italic and bold markup from argument so that it doesn't contaminate COinS metadata.
This function strips common patterns of apostrophe markup.  We presume that editors who have taken the time to
markup a title have, as a result, provided valid markup. When they don't, some single apostrophes are left behind.

]]

local function strip_apostrophe_markup (argument)
	if not is_set (argument) then return argument; end

	while true do
		if argument:match ("%'%'%'%'%'") then									-- bold italic (5)
			argument=argument:gsub("%'%'%'%'%'", "");							-- remove all instances of it
		elseif argument:match ("%'%'%'%'") then									-- italic start and end without content (4)
			argument=argument:gsub("%'%'%'%'", "");
		elseif argument:match ("%'%'%'") then									-- bold (3)
			argument=argument:gsub("%'%'%'", "");
		elseif argument:match ("%'%'") then										-- italic (2)
			argument=argument:gsub("%'%'", "");
		else
			break;
		end
	end
	return argument;															-- done
end

--[[--------------------------< M A K E _ C O I N S _ T I T L E >----------------------------------------------

Makes a title for COinS from Title and / or ScriptTitle (or any other name-script pairs)

Apostrophe markup (bold, italics) is stripped from each value so that the COinS metadata isn't correupted with strings
of %27%27...
]]

local function make_coins_title (title, script)
	if is_set (title) then
		title = strip_apostrophe_markup (title);								-- strip any apostrophe markup
	else
		title='';																-- if not set, make sure title is an empty string
	end
	if is_set (script) then
		script = script:gsub ('^%l%l%s*:%s*', '');								-- remove language prefix if present (script value may now be empty string)
		script = strip_apostrophe_markup (script);								-- strip any apostrophe markup
	else
		script='';																-- if not set, make sure script is an empty string
	end
	if is_set (title) and is_set (script) then
		script = ' ' .. script;													-- add a space before we concatenate
	end
	return title .. script;														-- return the concatenation
end

--[[--------------------------< G E T _ C O I N S _ P A G E S >------------------------------------------------

Extract page numbers from external wikilinks in any of the |page=, |pages=, or |at= parameters for use in COinS.

]]

local function get_coins_pages (pages)
	local pattern;
	if not is_set (pages) then return pages; end								-- if no page numbers then we're done
	
	while true do
		pattern = pages:match("%[(%w*:?//[^ ]+%s+)[%w%d].*%]");					-- pattern is the opening bracket, the url and following space(s): "[url "
		if nil == pattern then break; end										-- no more urls
		pattern = escape_lua_magic_chars (pattern);								-- pattern is not a literal string; escape lua's magic pattern characters
		pages = pages:gsub(pattern, "");										-- remove as many instances of pattern as possible
	end
	pages = pages:gsub("[%[%]]", "");											-- remove the brackets
	pages = pages:gsub("–", "-" );							-- replace endashes with hyphens
	pages = pages:gsub("&%w+;", "-" );						-- and replace html entities (&ndash; etc.) with hyphens; do we need to replace numerical entities like &#32; and the like?
	return pages;
end

-- Gets the display text for a wikilink like [[A|B]] or [[B]] gives B
local function remove_wiki_link( str )
	return (str:gsub( "%[%[([^%[%]]*)%]%]", function(l)
		return l:gsub( "^[^|]*|(.*)$", "%1" ):gsub("^%s*(.-)%s*$", "%1");
	end));
end

-- Converts a hyphen to a dash
local function hyphen_to_dash( str )
	if not is_set(str) or str:match( "[%[%]{}<>]" ) ~= nil then
		return str;
	end	
	return str:gsub( '-', '–' );
end

--[[--------------------------< S A F E _ J O I N >------------------------------------------------------------

Joins a sequence of strings together while checking for duplicate separation characters.

]]

local function safe_join( tbl, duplicate_char )
	--[[
	Note: we use string functions here, rather than ustring functions.
	
	This has considerably faster performance and should work correctly as 
	long as the duplicate_char is strict ASCII.  The strings
	in tbl may be ASCII or UTF8.
	]]
	
	local str = '';																-- the output string
	local comp = '';															-- what does 'comp' mean?
	local end_chr = '';
	local trim;
	for _, value in ipairs( tbl ) do
		if value == nil then value = ''; end
		
		if str == '' then														-- if output string is empty
			str = value;														-- assign value to it (first time through the loop)
		elseif value ~= '' then
			if value:sub(1,1) == '<' then										-- Special case of values enclosed in spans and other markup.
				comp = value:gsub( "%b<>", "" );								-- remove html markup (<span>string</span> -> string)
			else
				comp = value;
			end
																				-- typically duplicate_char is sepc
			if comp:sub(1,1) == duplicate_char then								-- is first charactier same as duplicate_char? why test first character?
																				--   Because individual string segments often (always?) begin with terminal punct for th
																				--   preceding segment: 'First element' .. 'sepc next element' .. etc?
				trim = false;
				end_chr = str:sub(-1,-1);										-- get the last character of the output string
				-- str = str .. "<HERE(enchr=" .. end_chr.. ")"					-- debug stuff?
				if end_chr == duplicate_char then								-- if same as separator
					str = str:sub(1,-2);										-- remove it
				elseif end_chr == "'" then										-- if it might be wikimarkup
					if str:sub(-3,-1) == duplicate_char .. "''" then			-- if last three chars of str are sepc'' 
						str = str:sub(1, -4) .. "''";							-- remove them and add back ''
					elseif str:sub(-5,-1) == duplicate_char .. "]]''" then		-- if last five chars of str are sepc]]'' 
						trim = true;											-- why? why do this and next differently from previous?
					elseif str:sub(-4,-1) == duplicate_char .. "]''" then		-- if last four chars of str are sepc]'' 
						trim = true;											-- same question
					end
				elseif end_chr == "]" then										-- if it might be wikimarkup
					if str:sub(-3,-1) == duplicate_char .. "]]" then			-- if last three chars of str are sepc]] wikilink 
						trim = true;
					elseif str:sub(-2,-1) == duplicate_char .. "]" then			-- if last two chars of str are sepc] external link
						trim = true;
					elseif str:sub(-4,-1) == duplicate_char .. "'']" then		-- normal case when |url=something & |title=Title.
						trim = true;
					end
				elseif end_chr == " " then										-- if last char of output string is a space
					if str:sub(-2,-1) == duplicate_char .. " " then				-- if last two chars of str are <sepc><space>
						str = str:sub(1,-3);									-- remove them both
					end
				end

				if trim then
					if value ~= comp then 										-- value does not equal comp when value contains html markup
						local dup2 = duplicate_char;
						if dup2:match( "%A" ) then dup2 = "%" .. dup2; end		-- if duplicate_char not a letter then escape it
						
						value = value:gsub( "(%b<>)" .. dup2, "%1", 1 )			-- remove duplicate_char if it follows html markup
					else
						value = value:sub( 2, -1 );								-- remove duplicate_char when it is first character
					end
				end
			end
			str = str .. value;													--add it to the output string
		end
	end
	return str;
end  

--[[--------------------------< I S _ G O O D _ V A N C _ N A M E >--------------------------------------------

For Vancouver Style, author/editor names are supposed to be rendered in Latin (read ASCII) characters.  When a name
uses characters that contain diacritical marks, those characters are to converted to the corresponding Latin character.
When a name is written using a non-Latin alphabet or logogram, that name is to be transliterated into Latin characters.
These things are not currently possible in this module so are left to the editor to do.

This test allows |first= and |last= names to contain any of the letters defined in the four Unicode Latin character sets
	[http://www.unicode.org/charts/PDF/U0000.pdf C0 Controls and Basic Latin] 0041–005A, 0061–007A
	[http://www.unicode.org/charts/PDF/U0080.pdf C1 Controls and Latin-1 Supplement] 00C0–00D6, 00D8–00F6, 00F8–00FF
	[http://www.unicode.org/charts/PDF/U0100.pdf Latin Extended-A] 0100–017F
	[http://www.unicode.org/charts/PDF/U0180.pdf Latin Extended-B] 0180–01BF, 01C4–024F

|lastn= also allowed to contain hyphens, spaces, and apostrophes. (http://www.ncbi.nlm.nih.gov/books/NBK7271/box/A35029/)
|firstn= also allowed to contain hyphens, spaces, apostrophes, and periods

At the time of this writing, I had to write the 'if nil == mw.ustring.find ...' test ouside of the code editor and paste it here
because the code editor gets confused between character insertion point and cursor position.

]]

local function is_good_vanc_name (last, first)
	if nil == mw.ustring.find (last, "^[A-Za-zÀ-ÖØ-öø-ƿǄ-ɏ%-%s%']*$") or nil == mw.ustring.find (first, "^[A-Za-zÀ-ÖØ-öø-ƿǄ-ɏ%-%s%'%.]*$") then
		add_vanc_error ();
		return false;															-- not a string of latin characters; Vancouver required Romanization
	end;
	return true;
end

--[[--------------------------< R E D U C E _ T O _ I N I T I A L S >------------------------------------------

Attempts to convert names to initials in support of |name-list-format=vanc.  

Names in |firstn= may be separated by spaces or hyphens, or for initials, a period. See http://www.ncbi.nlm.nih.gov/books/NBK7271/box/A35062/.

Vancouver style requires family rank designations (Jr, II, III, etc) to be rendered as Jr, 2nd, 3rd, etc.  This form is not
currently supported by this code so correctly formed names like Smith JL 2nd are converted to Smith J2. See http://www.ncbi.nlm.nih.gov/books/NBK7271/box/A35085/.

This function uses ustring functions because firstname initials may be any of the unicode Latin characters accepted by is_good_vanc_name ().

]]

local function reduce_to_initials(first)
	if mw.ustring.match(first, "^%u%u$") then return first end;					-- when first contains just two upper-case letters, nothing to do
	local initials = {}
	local i = 0;																-- counter for number of initials
	for word in mw.ustring.gmatch(first, "[^%s%.%-]+") do						-- names separated by spaces, hyphens, or periods
		table.insert(initials, mw.ustring.sub(word,1,1))						-- Vancouver format does not include full stops.
		i = i + 1;																-- bump the counter 
		if 2 <= i then break; end												-- only two initials allowed in Vancouver system; if 2, quit
	end
	return table.concat(initials)												-- Vancouver format does not include spaces.
end

--[[--------------------------< L I S T  _ P E O P L E >-------------------------------------------------------

Formats a list of people (e.g. authors / editors) 

]]

local function list_people(control, people, etal, list_name)					-- TODO: why is list_name here?  not used in this function
	local sep;
	local namesep;
	local format = control.format
	local maximum = control.maximum
	local lastauthoramp = control.lastauthoramp;
	local text = {}

	if 'vanc' == format then													-- Vancouver-like author/editor name styling?
		sep = ',';																-- name-list separator between authors is a comma
		namesep = ' ';															-- last/first separator is a space
	else
		sep = ';'																-- name-list separator between authors is a semicolon
		namesep = ', '															-- last/first separator is <comma><space>
	end
	
	if sep:sub(-1,-1) ~= " " then sep = sep .. " " end
	if is_set (maximum) and maximum < 1 then return "", 0; end					-- returned 0 is for EditorCount; not used for authors
	
	for i,person in ipairs(people) do
		if is_set(person.last) then
			local mask = person.mask
			local one
			local sep_one = sep;
			if is_set (maximum) and i > maximum then
				etal = true;
				break;
			elseif (mask ~= nil) then
				local n = tonumber(mask)
				if (n ~= nil) then
					one = string.rep("&mdash;",n)
				else
					one = mask;
					sep_one = " ";
				end
			else
				one = person.last
				local first = person.first
				if is_set(first) then 
					if ( "vanc" == format ) then								-- if vancouver format
						one = one:gsub ('%.', '');								-- remove periods from surnames (http://www.ncbi.nlm.nih.gov/books/NBK7271/box/A35029/)
						if not person.corporate and is_good_vanc_name (one, first) then					-- and name is all Latin characters; corporate authors not tested
							first = reduce_to_initials(first)					-- attempt to convert first name(s) to initials
						end
					end
					one = one .. namesep .. first 
				end
				if is_set(person.link) and person.link ~= control.page_name then
					one = "[[" .. person.link .. "|" .. one .. "]]"				-- link author/editor if this page is not the author's/editor's page
				end
			end
			table.insert( text, one )
			table.insert( text, sep_one )
		end
	end

	local count = #text / 2;													-- (number of names + number of separators) divided by 2
	if count > 0 then 
		if count > 1 and is_set(lastauthoramp) and not etal then
			text[#text-2] = " & ";												-- replace last separator with ampersand text
		end
		text[#text] = nil;														-- erase the last separator
	end
	
	local result = table.concat(text)											-- construct list
	if etal and is_set (result) then											-- etal may be set by |display-authors=etal but we might not have a last-first list
		result = result .. sep .. ' ' .. cfg.messages['et al'];					-- we've go a last-first list and etal so add et al.
	end
	
	return result, count
end

--[[--------------------------< A N C H O R _ I D >------------------------------------------------------------

Generates a CITEREF anchor ID if we have at least one name or a date.  Otherwise returns an empty string.

namelist is one of the contributor-, author-, or editor-name lists chosen in that order.  year is Year or anchor_year.

]]
local function anchor_id (namelist, year)
	local names={};																-- a table for the one to four names and year
	for i,v in ipairs (namelist) do												-- loop through the list and take up to the first four last names
		names[i] = v.last 
		if i == 4 then break end												-- if four then done
	end
	table.insert (names, year);													-- add the year at the end
	local id = table.concat(names);												-- concatenate names and year for CITEREF id
	if is_set (id) then															-- if concatenation is not an empty string
		return "CITEREF" .. id;													-- add the CITEREF portion
	else
		return '';																-- return an empty string; no reason to include CITEREF id in this citation
	end
end


--[[--------------------------< N A M E _ H A S _ E T A L >----------------------------------------------------

Evaluates the content of author and editor name parameters for variations on the theme of et al.  If found,
the et al. is removed, a flag is set to true and the function returns the modified name and the flag.

This function never sets the flag to false but returns it's previous state because it may have been set by
previous passes through this function or by the parameters |display-authors=etal or |display-editors=etal

]]

local function name_has_etal (name, etal, nocat)

	if is_set (name) then														-- name can be nil in which case just return
		local etal_pattern = "[;,]? *[\"']*%f[%a][Ee][Tt] *[Aa][Ll][%.\"']*$"	-- variations on the 'et al' theme
		local others_pattern = "[;,]? *%f[%a]and [Oo]thers";					-- and alternate to et al.
		
		if name:match (etal_pattern) then										-- variants on et al.
			name = name:gsub (etal_pattern, '');								-- if found, remove
			etal = true;														-- set flag (may have been set previously here or by |display-authors=etal)
			if not nocat then													-- no categorization for |vauthors=
				add_maint_cat ('etal');											-- and add a category if not already added
			end
		elseif name:match (others_pattern) then									-- if not 'et al.', then 'and others'?
			name = name:gsub (others_pattern, '');								-- if found, remove
			etal = true;														-- set flag (may have been set previously here or by |display-authors=etal)
			if not nocat then													-- no categorization for |vauthors=
				add_maint_cat ('etal');											-- and add a category if not already added
			end
		end
	end
	return name, etal;															-- 
end

--[[--------------------------< E X T R A C T _ N A M E S >----------------------------------------------------
Gets name list from the input arguments

Searches through args in sequential order to find |lastn= and |firstn= parameters (or their aliases), and their matching link and mask parameters.
Stops searching when both |lastn= and |firstn= are not found in args after two sequential attempts: found |last1=, |last2=, and |last3= but doesn't
find |last4= and |last5= then the search is done.

This function emits an error message when there is a |firstn= without a matching |lastn=.  When there are 'holes' in the list of last names, |last1= and |last3=
are present but |last2= is missing, an error message is emitted. |lastn= is not required to have a matching |firstn=.

When an author or editor parameter contains some form of 'et al.', the 'et al.' is stripped from the parameter and a flag (etal) returned
that will cause list_people() to add the static 'et al.' text from Module:Citation/CS1/Configuration.  This keeps 'et al.' out of the 
template's metadata.  When this occurs, the page is added to a maintenance category.

]]

local function extract_names(args, list_name)
	local names = {};			-- table of names
	local last;					-- individual name components
	local first;
	local link;
	local mask;
	local i = 1;				-- loop counter/indexer
	local n = 1;				-- output table indexer
	local count = 0;			-- used to count the number of times we haven't found a |last= (or alias for authors, |editor-last or alias for editors)
	local etal=false;			-- return value set to true when we find some form of et al. in an author parameter

	local err_msg_list_name = list_name:match ("(%w+)List") .. 's list';		-- modify AuthorList or EditorList for use in error messages if necessary
	while true do
		last = select_one( args, cfg.aliases[list_name .. '-Last'], 'redundant_parameters', i );		-- search through args for name components beginning at 1
		first = select_one( args, cfg.aliases[list_name .. '-First'], 'redundant_parameters', i );
		link = select_one( args, cfg.aliases[list_name .. '-Link'], 'redundant_parameters', i );
		mask = select_one( args, cfg.aliases[list_name .. '-Mask'], 'redundant_parameters', i );

		last, etal = name_has_etal (last, etal, false);								-- find and remove variations on et al.
		first, etal = name_has_etal (first, etal, false);								-- find and remove variations on et al.

		if first and not last then												-- if there is a firstn without a matching lastn
			table.insert( z.message_tail, { set_error( 'first_missing_last', {err_msg_list_name, i}, true ) } );	-- add this error message
		elseif not first and not last then										-- if both firstn and lastn aren't found, are we done?
			count = count + 1;													-- number of times we haven't found last and first
			if 2 <= count then													-- two missing names and we give up
				break;															-- normal exit or there is a two-name hole in the list; can't tell which
			end
		else																	-- we have last with or without a first
			if is_set (link) and false == link_param_ok (link) then				-- do this test here in case link is missing last
				table.insert( z.message_tail, { set_error( 'bad_paramlink', list_name:match ("(%w+)List"):lower() .. '-link' .. i )});			-- url or wikilink in author link;
			end
			names[n] = {last = last, first = first, link = link, mask = mask, corporate=false};	-- add this name to our names list (corporate for |vauthors= only)
			n = n + 1;															-- point to next location in the names table
			if 1 == count then													-- if the previous name was missing
				table.insert( z.message_tail, { set_error( 'missing_name', {err_msg_list_name, i-1}, true ) } );		-- add this error message
			end
			count = 0;															-- reset the counter, we're looking for two consecutive missing names
		end
		i = i + 1;																-- point to next args location
	end
	
	return names, etal;															-- all done, return our list of names
end



--[[--------------------------< C O I N S _ C L E A N U P >----------------------------------------------------

Cleanup parameter values for the metadata by removing or replacing invisible characters and certain html entities.

2015-12-10: there is a bug in mw.text.unstripNoWiki ().  It replaced math stripmarkers with the appropriate content
when it shouldn't.  See https://phabricator.wikimedia.org/T121085 and Wikipedia_talk:Lua#stripmarkers_and_mw.text.unstripNoWiki.28.29

TODO: move the replacement patterns and replacement values into a table in /Configuration similar to the invisible
characters table?
]]

local function coins_cleanup (value)
	value = mw.text.unstripNoWiki (value);										-- replace nowiki stripmarkers with their content
	value = value:gsub ('<span class="nowrap" style="padding%-left:0%.1em;">&#39;s</span>', "'s");	-- replace {{'s}} template with simple apostrophe-s
	value = value:gsub ('&zwj;\226\128\138\039\226\128\139', "'");				-- replace {{'}} with simple apostrophe
	value = value:gsub ('\226\128\138\039\226\128\139', "'");					-- replace {{'}} with simple apostrophe (as of 2015-12-11)
	value = value:gsub ('&nbsp;', ' ');											-- replace &nbsp; entity with plain space
	value = value:gsub ('\226\128\138', ' ');									-- replace hair space with plain space
	value = value:gsub ('&zwj;', '');											-- remove &zwj; entities
	value = value:gsub ('[\226\128\141\226\128\139]', '')						-- remove zero-width joiner, zero-width space
	value = value:gsub ('[\194\173\009\010\013]', ' ');							-- replace soft hyphen, horizontal tab, line feed, carriage return with plain space
	return value;
end


--[[--------------------------< C O I N S >--------------------------------------------------------------------

COinS metadata (see <http://ocoins.info/>) allows automated tools to parse the citation information.

]]

local function COinS(data, class)
	if 'table' ~= type(data) or nil == next(data) then
		return '';
	end

	for k, v in pairs (data) do													-- spin through all of the metadata parameter values
		if 'ID_list' ~= k and 'Authors' ~= k then								-- except the ID_list and Author tables (author nowiki stripmarker done when Author table processed)
			data[k] = coins_cleanup (v);
		end
	end

	local ctx_ver = "Z39.88-2004";
	
	-- treat table strictly as an array with only set values.
	local OCinSoutput = setmetatable( {}, {
		__newindex = function(self, key, value)
			if is_set(value) then
				rawset( self, #self+1, table.concat{ key, '=', mw.uri.encode( remove_wiki_link( value ) ) } );
			end
		end
	});
	
	if in_array (class, {'arxiv', 'journal', 'news'}) or (in_array (class, {'conference', 'interview', 'map', 'press release', 'web'}) and is_set(data.Periodical)) or 
		('citation' == class and is_set(data.Periodical) and not is_set (data.Encyclopedia)) then
			OCinSoutput.rft_val_fmt = "info:ofi/fmt:kev:mtx:journal";			-- journal metadata identifier
			if 'arxiv' == class then											-- set genre according to the type of citation template we are rendering
				OCinSoutput["rft.genre"] = "preprint";							-- cite arxiv
			elseif 'conference' == class then
				OCinSoutput["rft.genre"] = "conference";						-- cite conference (when Periodical set)
			elseif 'web' == class then
				OCinSoutput["rft.genre"] = "unknown";							-- cite web (when Periodical set)
			else
				OCinSoutput["rft.genre"] = "article";							-- journal and other 'periodical' articles
			end
			OCinSoutput["rft.jtitle"] = data.Periodical;						-- journal only
			if is_set (data.Map) then
				OCinSoutput["rft.atitle"] = data.Map;							-- for a map in a periodical
			else
				OCinSoutput["rft.atitle"] = data.Title;							-- all other 'periodical' article titles
			end
																				-- these used onlu for periodicals
			OCinSoutput["rft.ssn"] = data.Season;								-- keywords: winter, spring, summer, fall
			OCinSoutput["rft.chron"] = data.Chron;								-- free-form date components
			OCinSoutput["rft.volume"] = data.Volume;							-- does not apply to books
			OCinSoutput["rft.issue"] = data.Issue;
			OCinSoutput["rft.pages"] = data.Pages;								-- also used in book metadata

	elseif 'thesis' ~= class then												-- all others except cite thesis are treated as 'book' metadata; genre distinguishes
		OCinSoutput.rft_val_fmt = "info:ofi/fmt:kev:mtx:book";					-- book metadata identifier
		if 'report' == class or 'techreport' == class then						-- cite report and cite techreport
			OCinSoutput["rft.genre"] = "report";
		elseif 'conference' == class then										-- cite conference when Periodical not set
			OCinSoutput["rft.genre"] = "conference";
		elseif in_array (class, {'book', 'citation', 'encyclopaedia', 'interview', 'map'}) then
			if is_set (data.Chapter) then
				OCinSoutput["rft.genre"] = "bookitem";
				OCinSoutput["rft.atitle"] = data.Chapter;						-- book chapter, encyclopedia article, interview in a book, or map title
			else
				if 'map' == class or 'interview' == class then
					OCinSoutput["rft.genre"] = 'unknown';						-- standalone map or interview
				else
					OCinSoutput["rft.genre"] = 'book';							-- book and encyclopedia
				end
			end
		else	--{'audio-visual', 'AV-media-notes', 'DVD-notes', 'episode', 'interview', 'mailinglist', 'map', 'newsgroup', 'podcast', 'press release', 'serial', 'sign', 'speech', 'web'}
			OCinSoutput["rft.genre"] = "unknown";
		end
		OCinSoutput["rft.btitle"] = data.Title;									-- book only
		OCinSoutput["rft.place"] = data.PublicationPlace;						-- book only
		OCinSoutput["rft.series"] = data.Series;								-- book only
		OCinSoutput["rft.pages"] = data.Pages;									-- book, journal
		OCinSoutput["rft.edition"] = data.Edition;								-- book only
		OCinSoutput["rft.pub"] = data.PublisherName;							-- book and dissertation
		
	else																		-- cite thesis
		OCinSoutput.rft_val_fmt = "info:ofi/fmt:kev:mtx:dissertation";			-- dissertation metadata identifier
		OCinSoutput["rft.title"] = data.Title;									-- dissertation (also patent but that is not yet supported)
		OCinSoutput["rft.degree"] = data.Degree;								-- dissertation only
		OCinSoutput['rft.inst'] = data.PublisherName;							-- book and dissertation
	end
																				-- and now common parameters (as much as possible)
	OCinSoutput["rft.date"] = data.Date;										-- book, journal, dissertation
	
	for k, v in pairs( data.ID_list ) do										-- what to do about these? For now assume that they are common to all?
		if k == 'ISBN' then v = clean_isbn( v ) end
		local id = cfg.id_handlers[k].COinS;
		if string.sub( id or "", 1, 4 ) == 'info' then							-- for ids that are in the info:registry
			OCinSoutput["rft_id"] = table.concat{ id, "/", v };
		elseif string.sub (id or "", 1, 3 ) == 'rft' then						-- for isbn, issn, eissn, etc that have defined COinS keywords
			OCinSoutput[ id ] = v;
		elseif id then															-- when cfg.id_handlers[k].COinS is not nil
			OCinSoutput["rft_id"] = table.concat{ cfg.id_handlers[k].prefix, v };	-- others; provide a url
		end
	end

--[[	
	for k, v in pairs( data.ID_list ) do										-- what to do about these? For now assume that they are common to all?
		local id, value = cfg.id_handlers[k].COinS;
		if k == 'ISBN' then value = clean_isbn( v ); else value = v; end
		if string.sub( id or "", 1, 4 ) == 'info' then
			OCinSoutput["rft_id"] = table.concat{ id, "/", v };
		else
			OCinSoutput[ id ] = value;
		end
	end
]]
	local last, first;
	for k, v in ipairs( data.Authors ) do
		last, first = coins_cleanup (v.last), coins_cleanup (v.first or '');	-- replace any nowiki strip markers, non-printing or invisible characers
		if k == 1 then															-- for the first author name only
			if is_set(last)  and is_set(first) then								-- set these COinS values if |first= and |last= specify the first author name
				OCinSoutput["rft.aulast"] = last;								-- book, journal, dissertation
				OCinSoutput["rft.aufirst"] = first;								-- book, journal, dissertation
			elseif is_set(last) then 
				OCinSoutput["rft.au"] = last;									-- book, journal, dissertation -- otherwise use this form for the first name
			end
		else																	-- for all other authors
			if is_set(last) and is_set(first) then
				OCinSoutput["rft.au"] = table.concat{ last, ", ", first };		-- book, journal, dissertation
			elseif is_set(last) then
				OCinSoutput["rft.au"] = last;									-- book, journal, dissertation
			end
		end
	end

	OCinSoutput.rft_id = data.URL;
	OCinSoutput.rfr_id = table.concat{ "info:sid/", mw.site.server:match( "[^/]*$" ), ":", data.RawPage };
	OCinSoutput = setmetatable( OCinSoutput, nil );
	
	-- sort with version string always first, and combine.
	table.sort( OCinSoutput );
	table.insert( OCinSoutput, 1, "ctx_ver=" .. ctx_ver );  -- such as "Z39.88-2004"
	return table.concat(OCinSoutput, "&");
end


--[[--------------------------< G E T _ I S O 6 3 9 _ C O D E >------------------------------------------------

Validates language names provided in |language= parameter if not an ISO639-1 code.  Handles the special case that is Norwegian where
ISO639-1 code 'no' is mapped to language name 'Norwegian Bokmål' by Extention:CLDR.

Returns the language name and associated ISO639-1 code.  Because case of the source may be incorrect or different from the case that Wikimedia
uses, the name comparisons are done in lower case and when a match is found, the Wikimedia version (assumed to be correct) is returned along
with the code.  When there is no match, we return the original language name string.

mw.language.fetchLanguageNames() will return a list of languages that aren't part of ISO639-1. Names that aren't ISO639-1 but that are included
in the list will be found if that name is provided in the |language= parameter.  For example, if |language=Samaritan Aramaic, that name will be
found with the associated code 'sam', not an ISO639-1 code.  When names are found and the associated code is not two characters, this function
returns only the Wikimedia language name.

Adapted from code taken from Module:Check ISO 639-1.

]]

local function get_iso639_code (lang)
	if 'norwegian' == lang:lower() then											-- special case related to Wikimedia remap of code 'no' at Extension:CLDR
		return 'Norwegian', 'no';												-- Make sure rendered version is properly capitalized
	end
	
	local languages = mw.language.fetchLanguageNames(mw.getContentLanguage():getCode(), 'all')				-- get a list of language names known to Wikimedia
																				-- ('all' is required for North Ndebele, South Ndebele, and Ojibwa)
	local langlc = mw.ustring.lower(lang);										-- lower case version for comparisons
	
	for code, name in pairs(languages) do										-- scan the list to see if we can find our language
		if langlc == mw.ustring.lower(name) then
			if 2 ~= code:len() then												-- ISO639-1 codes only
				return name;													-- so return the name but not the code
			end
			return name, code;													-- found it, return name to ensure proper capitalization and the ISO639-1 code
		end
	end
	return lang;																-- not valid language; return language in original case and nil for ISO639-1 code
end

--[[--------------------------< L A N G U A G E _ P A R A M E T E R >------------------------------------------

Get language name from ISO639-1 code value provided.  If a code is valid use the returned name; if not, then use the value that was provided with the language parameter.

There is an exception.  There are three ISO639-1 codes for Norewegian language variants.  There are two official variants: Norwegian Bokmål (code 'nb') and
Norwegian Nynorsk (code 'nn').  The third, code 'no',  is defined by ISO639-1 as 'Norwegian' though in Norway this is pretty much meaningless.  However, it appears
that on enwiki, editors are for the most part unaware of the nb and nn variants (compare page counts for these variants at Category:Articles with non-English-language external links.

Because Norwegian Bokmål is the most common language variant, Media wiki has been modified to return Norwegian Bokmål for ISO639-1 code 'no'. Here we undo that and
return 'Norwegian' when editors use |language=no.  We presume that editors don't know about the variants or can't descriminate between them.

See Help talk:Citation Style_1#An ISO 639-1 language name test

When |language= contains a valid ISO639-1 code, the page is assigned to the category for that code: Category:Norwegian-language sources (no) if
the page is a mainspace page and the ISO639-1 code is not 'en'.  Similarly, if the  parameter is |language=Norwegian, it will be categorized in the same way.

This function supports multiple languages in the form |language=nb, French, th where the language names or codes are separated from each other by commas.

]]

local function language_parameter (lang)
	local code;																	-- the ISO639-1 two character code
	local name;																	-- the language name
	local language_list = {};													-- table of language names to be rendered
	local names_table = {};														-- table made from the value assigned to |language=

	names_table = mw.text.split (lang, '%s*,%s*');								-- names should be a comma separated list

	for _, lang in ipairs (names_table) do										-- reuse lang

		if lang:match ('^%a%a%-') or 2 == lang:len() then													-- ISO639-1 language code are 2 characters (fetchLanguageName also supports 3 character codes)
			if lang:match ('^zh-') then
				name = mw.language.fetchLanguageName( lang:lower(), lang:lower() );
			else
				name = mw.language.fetchLanguageName( lang:lower(), mw.getContentLanguage():getCode() );			-- get ISO 639-1 language name if Language is a proper code
			end
		end
	
		if is_set (name) then													-- if Language specified a valid ISO639-1 code
			code = lang:lower();												-- save it
		else
			name, code = get_iso639_code (lang);								-- attempt to get code from name (assign name here so that we are sure of proper capitalization)
		end
	
		if is_set (code) then
			if 'no' == code then name = '挪威语' end;							-- override wikimedia when code is 'no'
			if 'zh' ~= code and not code:match ('^zh-') then												-- English not the language
				add_prop_cat ('foreign_lang_source', {name, code})
			end
		else
			add_maint_cat ('unknown_lang');										-- add maint category if not already added
		end
		
		table.insert (language_list, name);
		name = '';																-- so we can reuse it
	end
	
	code = #language_list														-- reuse code as number of languages in the list
	if 2 >= code then
		name = table.concat (language_list, '及')							-- insert '及' between two language names
	elseif 2 < code then
		language_list[code] = '及' .. language_list[code];					-- prepend last name with '及'
		name = table.concat (language_list, '、');								-- and concatenate with '<comma><space>' separators
		name = name:gsub ('、及', '及', 1);
	end
	return (" " .. wrap_msg ('language', name));								-- otherwise wrap with '(in ...)'
end

--[[--------------------------< S E T _ C S 1 _ S T Y L E >----------------------------------------------------

Set style settings for CS1 citation templates. Returns separator and postscript settings

]]

local function set_cs1_style (ps)
	if not is_set (ps) then														-- unless explicitely set to something
		ps = '.';																-- terminate the rendered citation with a period
	end
	return '.', ps;																-- separator is a full stop
end

--[[--------------------------< S E T _ C S 2 _ S T Y L E >----------------------------------------------------

Set style settings for CS2 citation templates. Returns separator, postscript, ref settings

]]

local function set_cs2_style (ps, ref)
	if not is_set (ps) then														-- if |postscript= has not been set, set cs2 default
		ps = '';																-- make sure it isn't nil
	end
	if not is_set (ref) then													-- if |ref= is not set
		ref = "harv";															-- set default |ref=harv
	end
	return ',', ps, ref;														-- separator is a comma
end

--[[--------------------------< G E T _ S E T T I N G S _ F R O M _ C I T E _ C L A S S >----------------------

When |mode= is not set or when its value is invalid, use config.CitationClass and parameter values to establish
rendered style.

]]

local function get_settings_from_cite_class (ps, ref, cite_class)
	local sep;
	if (cite_class == "citation") then											-- for citation templates (CS2)
		sep, ps, ref = set_cs2_style (ps, ref);
	else																		-- not a citation template so CS1
		sep, ps = set_cs1_style (ps);
	end

	return sep, ps, ref															-- return them all
end

--[[--------------------------< S E T _ S T Y L E >------------------------------------------------------------

Establish basic style settings to be used when rendering the citation.  Uses |mode= if set and valid or uses
config.CitationClass from the template's #invoke: to establish style.

]]

local function set_style (mode, ps, ref, cite_class)
	local sep;
	if 'cs2' == mode then														-- if this template is to be rendered in CS2 (citation) style
		sep, ps, ref = set_cs2_style (ps, ref);
	elseif 'cs1' == mode then													-- if this template is to be rendered in CS1 (cite xxx) style
		sep, ps = set_cs1_style (ps);
	else																		-- anything but cs1 or cs2
		sep, ps, ref = get_settings_from_cite_class (ps, ref, cite_class);		-- get settings based on the template's CitationClass
	end
	if 'none' == ps:lower() then												-- if assigned value is 'none' then
		ps = '';																-- set to empty string
	end
	
	return sep, ps, ref
end

--[=[-------------------------< I S _ P D F >------------------------------------------------------------------

Determines if a url has the file extension that is one of the pdf file extensions used by [[MediaWiki:Common.css]] when
applying the pdf icon to external links.

returns true if file extension is one of the recognized extension, else false

]=]

local function is_pdf (url)
	return url:match ('%.pdf[%?#]?') or url:match ('%.PDF[%?#]?');
end

--[[--------------------------< S T Y L E _ F O R M A T >------------------------------------------------------

Applies css style to |format=, |chapter-format=, etc.  Also emits an error message if the format parameter does
not have a matching url parameter.  If the format parameter is not set and the url contains a file extension that
is recognized as a pdf document by MediaWiki's commons.css, this code will set the format parameter to (PDF) with
the appropriate styling.

]]

local function style_format (format, url, fmt_param, url_param)
	if is_set (format) then
		format = wrap_style ('format', format);									-- add leading space, parenthases, resize
		if not is_set (url) then
			format = format .. set_error( 'format_missing_url', {fmt_param, url_param} );	-- add an error message
		end
	elseif is_pdf (url) then													-- format is not set so if url is a pdf file then
		format = wrap_style ('format', 'PDF');									-- set format to pdf
	else
		format = '';															-- empty string for concatenation
	end
	return format;
end

--[[--------------------------< G E T _ D I S P L A Y _ A U T H O R S _ E D I T O R S >------------------------

Returns a number that may or may not limit the length of the author or editor name lists.

When the value assigned to |display-authors= is a number greater than or equal to zero, return the number and
the previous state of the 'etal' flag (false by default but may have been set to true if the name list contains
some variant of the text 'et al.').

When the value assigned to |display-authors= is the keyword 'etal', return a number that is one greater than the
number of authors in the list and set the 'etal' flag true.  This will cause the list_people() to display all of
the names in the name list followed by 'et al.'

In all other cases, returns nil and the previous state of the 'etal' flag.

]]

local function get_display_authors_editors (max, count, list_name, etal)
	if is_set (max) then
		if 'etal' == max:lower():gsub("[ '%.]", '') then						-- the :gsub() portion makes 'etal' from a variety of 'et al.' spellings and stylings
			max = count + 1;													-- number of authors + 1 so display all author name plus et al.
			etal = true;														-- overrides value set by extract_names()
		elseif max:match ('^%d+$') then											-- if is a string of numbers
			max = tonumber (max);												-- make it a number
			if max >= count and 'authors' == list_name then	-- AUTHORS ONLY		-- if |display-xxxxors= value greater than or equal to number of authors/editors
				add_maint_cat ('disp_auth_ed', list_name);
			end
		else																	-- not a valid keyword or number
			table.insert( z.message_tail, { set_error( 'invalid_param_val', {'display-' .. list_name, max}, true ) } );		-- add error message
			max = nil;															-- unset
		end
	elseif 'authors' == list_name then		-- AUTHORS ONLY	need to clear implicit et al category
		max = count + 1;														-- number of authors + 1
	end
	
	return max, etal;
end

--[[--------------------------< E X T R A _ T E X T _ I N _ P A G E _ C H E C K >------------------------------

Adds page to Category:CS1 maint: extra text if |page= or |pages= has what appears to be some form of p. or pp. 
abbreviation in the first characters of the parameter content.

check Page and Pages for extraneous p, p., pp, and pp. at start of parameter value:
	good pattern: '^P[^%.P%l]' matches when |page(s)= begins PX or P# but not Px where x and X are letters and # is a dgiit
	bad pattern: '^[Pp][Pp]' matches matches when |page(s)= begins pp or pP or Pp or PP

]]

local function extra_text_in_page_check (page)
--	local good_pattern = '^P[^%.P%l]';
	local good_pattern = '^P[^%.Pp]';											-- ok to begin with uppercase P: P7 (pg 7 of section P) but not p123 (page 123) TODO: add Gg for PG or Pg?
--	local bad_pattern = '^[Pp][Pp]';
	local bad_pattern = '^[Pp]?[Pp]%.?[ %d]';

	if not page:match (good_pattern) and (page:match (bad_pattern) or  page:match ('^[Pp]ages?')) then
		add_maint_cat ('extra_text');
	end
--		if Page:match ('^[Pp]?[Pp]%.?[ %d]') or  Page:match ('^[Pp]ages?[ %d]') or
--			Pages:match ('^[Pp]?[Pp]%.?[ %d]') or  Pages:match ('^[Pp]ages?[ %d]') then
--				add_maint_cat ('extra_text');
--		end
end


--[[--------------------------< P A R S E _ V A U T H O R S _ V E D I T O R S >--------------------------------

This function extracts author / editor names from |vauthors= or |veditors= and finds matching |xxxxor-maskn= and
|xxxxor-linkn= in args.  It then returns a table of assembled names just as extract_names() does.

Author / editor names in |vauthors= or |veditors= must be in Vancouver system style. Corporate or institutional names
may sometimes be required and because such names will often fail the is_good_vanc_name() and other format compliance
tests, are wrapped in doubled paranethese ((corporate name)) to suppress the format tests.

This function sets the vancouver error when a reqired comma is missing and when there is a space between an author's initials.

]]

local function parse_vauthors_veditors (args, vparam, list_name)
	local names = {};															-- table of names assembled from |vauthors=, |author-maskn=, |author-linkn=
	local v_name_table = {};
	local etal = false;															-- return value set to true when we find some form of et al. vauthors parameter
	local last, first, link, mask;
	local corporate = false;

	vparam, etal = name_has_etal (vparam, etal, true);							-- find and remove variations on et al. do not categorize (do it here because et al. might have a period)
	if vparam:find ('%[%[') or vparam:find ('%]%]')	then						-- no wikilinking vauthors names
		add_vanc_error ();
	end
	v_name_table = mw.text.split(vparam, "%s*,%s*")								-- names are separated by commas

	for i, v_name in ipairs(v_name_table) do
		if v_name:match ('^%(%(.+%)%)$') then									-- corporate authors are wrapped in doubled parenthese to supress vanc formatting and error detection
			first = '';															-- set to empty string for concatenation and because it may have been set for previous author/editor
			last = v_name:match ('^%(%((.+)%)%)$')
			corporate = true;
		elseif string.find(v_name, "%s") then
		    lastfirstTable = {}
		    lastfirstTable = mw.text.split(v_name, "%s")
		    first = table.remove(lastfirstTable);								-- removes and returns value of last element in table which should be author intials
		    last  = table.concat(lastfirstTable, " ")							-- returns a string that is the concatenation of all other names that are not initials
		    if mw.ustring.match (last, '%a+%s+%u+%s+%a+') or mw.ustring.match (v_name, ' %u %u$') then
				add_vanc_error ();												-- matches last II last; the case when a comma is missing or a space between two intiials
			end
		else
			first = '';															-- set to empty string for concatenation and because it may have been set for previous author/editor
			last = v_name;														-- last name or single corporate name?  Doesn't support multiword corporate names? do we need this?
		end
																
		if is_set (first) and not mw.ustring.match (first, "^%u?%u$") then		-- first shall contain one or two upper-case letters, nothing else
			add_vanc_error ();
		end
																				-- this from extract_names ()
		link = select_one( args, cfg.aliases[list_name .. '-Link'], 'redundant_parameters', i );
		mask = select_one( args, cfg.aliases[list_name .. '-Mask'], 'redundant_parameters', i );
		names[i] = {last = last, first = first, link = link, mask = mask, corporate=corporate};		-- add this assembled name to our names list
	end
	return names, etal;															-- all done, return our list of names
end

--[[--------------------------< S E L E C T _ A U T H O R _ E D I T O R _ S O U R C E >------------------------

Select one of |authors=, |authorn= / |lastn / firstn=, or |vauthors= as the source of the author name list or
select one of |editors=, |editorn= / editor-lastn= / |editor-firstn= or |veditors= as the source of the editor name list.

Only one of these appropriate three will be used.  The hierarchy is: |authorn= (and aliases) highest and |authors= lowest and
similarly, |editorn= (and aliases) highest and |editors= lowest

When looking for |authorn= / |editorn= parameters, test |xxxxor1= and |xxxxor2= (and all of their aliases); stops after the second
test which mimicks the test used in extract_names() when looking for a hole in the author name list.  There may be a better
way to do this, I just haven't discovered what that way is.

Emits an error message when more than one xxxxor name source is provided.

In this function, vxxxxors = vauthors or veditors; xxxxors = authors or editors as appropriate.

]]

local function select_author_editor_source (vxxxxors, xxxxors, args, list_name)
local lastfirst = false;
	if select_one( args, cfg.aliases[list_name .. '-Last'], 'none', 1 ) or		-- do this twice incase we have a first 1 without a last1
		select_one( args, cfg.aliases[list_name .. '-Last'], 'none', 2 ) then
			lastfirst=true;
	end

	if (is_set (vxxxxors) and true == lastfirst) or								-- these are the three error conditions
		(is_set (vxxxxors) and is_set (xxxxors)) or
		(true == lastfirst and is_set (xxxxors)) then
			local err_name;
			if 'AuthorList' == list_name then									-- figure out which name should be used in error message
				err_name = 'author';
			else
				err_name = 'editor';
			end
			table.insert( z.message_tail, { set_error( 'redundant_parameters',
				{err_name .. '-name-list parameters'}, true ) } );				-- add error message
	end

	if true == lastfirst then return 1 end;										-- return a number indicating which author name source to use
	if is_set (vxxxxors) then return 2 end;
	if is_set (xxxxors) then return 3 end;
	return 1;																	-- no authors so return 1; this allows missing author name test to run in case there is a first without last 
end


--[[--------------------------< I S _ V A L I D _ P A R A M E T E R _ V A L U E >------------------------------

This function is used to validate a parameter's assigned value for those parameters that have only a limited number
of allowable values (yes, y, true, no, etc).  When the parameter value has not been assigned a value (missing or empty
in the source template) the function refurns true.  If the parameter value is one of the list of allowed values returns
true; else, emits an error message and returns false.

]]

local function is_valid_parameter_value (value, name, possible)
	if not is_set (value) then
		return true;															-- an empty parameter is ok
	elseif in_array(value:lower(), possible) then
		return true;
	else
		table.insert( z.message_tail, { set_error( 'invalid_param_val', {name, value}, true ) } );	-- not an allowed value so add error message
		return false
	end
end


--[[--------------------------< T E R M I N A T E _ N A M E _ L I S T >----------------------------------------

This function terminates a name list (author, contributor, editor) with a separator character (sepc) and a space
when the last character is not a sepc character or when the last three characters are not sepc followed by two
closing square brackets (close of a wikilink).  When either of these is true, the name_list is terminated with a
single space character.

]]

local function terminate_name_list (name_list, sepc)
	if (string.sub (name_list,-1,-1) == sepc) or (string.sub (name_list,-3,-1) == sepc .. ']]') then	-- if last name in list ends with sepc char
		return name_list .. " ";												-- don't add another
	else
		return name_list .. sepc .. ' ';										-- otherwise terninate the name list
	end
end


--[[-------------------------< F O R M A T _ V O L U M E _ I S S U E >----------------------------------------

returns the concatenation of the formatted volume and issue parameters as a single string; or formatted volume
or formatted issue, or an empty string if neither are set.

]]
	
local function format_volume_issue (volume, issue, cite_class, origin, sepc, lower)
	if not is_set (volume) and not is_set (issue) then
		return '';
	end
	
	if 'magazine' == cite_class or (in_array (cite_class, {'citation', 'map'}) and 'magazine' == origin) then
		if is_set (volume) and is_set (issue) then
			return wrap_msg ('vol-no', {sepc, volume, issue}, lower);
		elseif is_set (volume) then
			return wrap_msg ('vol', {sepc, volume}, lower);
		else
			return wrap_msg ('issue', {sepc, issue}, lower);
		end
	end
	
	local vol = '';
		
	if is_set (volume) then
		if (6 < mw.ustring.len(volume)) then
			vol = substitute (cfg.messages['j-vol'], {sepc, volume});
		else
			vol = wrap_style ('vol-bold', hyphen_to_dash(volume));
		end
	end
	if is_set (issue) then
		return vol .. substitute (cfg.messages['j-issue'], issue);
	end
	return vol;
end


--[[-------------------------< F O R M A T _ P A G E S _ S H E E T S >-----------------------------------------

adds static text to one of |page(s)= or |sheet(s)= values and returns it with all of the others set to empty strings.
The return order is:
	page, pages, sheet, sheets

Singular has priority over plural when both are provided.

]]

local function format_pages_sheets (page, pages, sheet, sheets, cite_class, origin, sepc, nopp, lower)
	if 'map' == cite_class then													-- only cite map supports sheet(s) as in-source locators
		if is_set (sheet) then
			if 'journal' == origin then
				return '', '', wrap_msg ('j-sheet', sheet, lower), '';
			else
				return '', '', wrap_msg ('sheet', {sepc, sheet}, lower), '';
			end
		elseif is_set (sheets) then
			if 'journal' == origin then
				return '', '', '', wrap_msg ('j-sheets', sheets, lower);
			else
				return '', '', '', wrap_msg ('sheets', {sepc, sheets}, lower);
			end
		end
	end

	local is_journal = 'journal' == cite_class or (in_array (cite_class, {'citation', 'map'}) and 'journal' == origin);

	if is_set (page) then
		if is_journal then
			return substitute (cfg.messages['j-page(s)'], page), '', '', '';
		elseif not nopp then
			return substitute (cfg.messages['p-prefix'], {sepc, page}), '', '', '';
		else
			return substitute (cfg.messages['nopp'], {sepc, page}), '', '', '';
		end
	elseif is_set(pages) then
		if is_journal then
			return substitute (cfg.messages['j-page(s)'], pages), '', '', '';
		elseif tonumber(pages) ~= nil and not nopp then										-- if pages is only digits, assume a single page number
			return '', substitute (cfg.messages['p-prefix'], {sepc, pages}), '', '';
		elseif not nopp then
			return '', substitute (cfg.messages['pp-prefix'], {sepc, pages}), '', '';
		else
			return '', substitute (cfg.messages['nopp'], {sepc, pages}), '', '';
		end
	end
	
	return '', '', '', '';														-- return empty strings
end

--[[--------------------------< C I T A T I O N 0 >------------------------------------------------------------

This is the main function doing the majority of the citation formatting.

]]

local function citation0( config, args)
	--[[ 
	Load Input Parameters
	The argument_wrapper facilitates the mapping of multiple aliases to single internal variable.
	]]
	local A = argument_wrapper( args );
	local i 

	-- Pick out the relevant fields from the arguments.  Different citation templates
	-- define different field names for the same underlying things.	
	local author_etal;
	local a	= {};																-- authors list from |lastn= / |firstn= pairs or |vauthors=
	local Authors;
	local NameListFormat = A['NameListFormat'];

	do																			-- to limit scope of selected
		local selected = select_author_editor_source (A['Vauthors'], A['Authors'], args, 'AuthorList');
		if 1 == selected then
			a, author_etal = extract_names (args, 'AuthorList');				-- fetch author list from |authorn= / |lastn= / |firstn=, |author-linkn=, and |author-maskn=
		elseif 2 == selected then
			NameListFormat = 'vanc';											-- override whatever |name-list-format= might be
			a, author_etal = parse_vauthors_veditors (args, args.vauthors, 'AuthorList');	-- fetch author list from |vauthors=, |author-linkn=, and |author-maskn=
		elseif 3 == selected then
			Authors = A['Authors'];												-- use content of |authors=
		end
	end

	local Coauthors = A['Coauthors'];
	local Others = A['Others'];

	local editor_etal;
	local e	= {};																-- editors list from |editor-lastn= / |editor-firstn= pairs or |veditors=
	local Editors;

	do																			-- to limit scope of selected
		local selected = select_author_editor_source (A['Veditors'], A['Editors'], args, 'EditorList');
		if 1 == selected then
			e, editor_etal = extract_names (args, 'EditorList');				-- fetch editor list from |editorn= / |editor-lastn= / |editor-firstn=, |editor-linkn=, and |editor-maskn=
		elseif 2 == selected then
			NameListFormat = 'vanc';											-- override whatever |name-list-format= might be
			e, editor_etal = parse_vauthors_veditors (args, args.veditors, 'EditorList');	-- fetch editor list from |veditors=, |editor-linkn=, and |editor-maskn=
		elseif 3 == selected then
			Editors = A['Editors'];												-- use content of |editors=
		end
	end

	local t = {};																-- translators list from |translator-lastn= / translator-firstn= pairs
	local Translators;															-- assembled translators name list
	t = extract_names (args, 'TranslatorList');									-- fetch translator list from |translatorn= / |translator-lastn=, -firstn=, -linkn=, -maskn=
	
	local c = {};																-- contributors list from |contributor-lastn= / contributor-firstn= pairs
	local Contributors;															-- assembled contributors name list
	local Contribution = A['Contribution'];
	if in_array(config.CitationClass, {"book","citation"}) and not is_set(A['Periodical']) then	-- |contributor= and |contribution= only supported in book cites
		c = extract_names (args, 'ContributorList');							-- fetch contributor list from |contributorn= / |contributor-lastn=, -firstn=, -linkn=, -maskn=
		
		if 0 < #c then
			if not is_set (Contribution) then									-- |contributor= requires |contribution=
				table.insert( z.message_tail, { set_error( 'contributor_missing_required_param', 'contribution')});	-- add missing contribution error message
				c = {};															-- blank the contributors' table; it is used as a flag later
			end
			if 0 == #a then														-- |contributor= requires |author=
				table.insert( z.message_tail, { set_error( 'contributor_missing_required_param', 'author')});	-- add missing author error message
				c = {};															-- blank the contributors' table; it is used as a flag later
			end
		end
	else																		-- if not a book cite
		if select_one (args, cfg.aliases['ContributorList-Last'], 'redundant_parameters', 1 ) then	-- are there contributor name list parameters?
			table.insert( z.message_tail, { set_error( 'contributor_ignored')});	-- add contributor ignored error message
		end
		Contribution = nil;														-- unset
	end

	if not is_valid_parameter_value (NameListFormat, 'name-list-format', cfg.keywords['name-list-format']) then			-- only accepted value for this parameter is 'vanc'
		NameListFormat = '';													-- anything else, set to empty string
	end

	local Year = A['Year'];
	local PublicationDate = A['PublicationDate'];
	local OrigYear = A['OrigYear'];
	local Date = A['Date'];
	local LayDate = A['LayDate'];
	------------------------------------------------- Get title data
	local Title = A['Title'];
	local ScriptTitle = A['ScriptTitle'];
	local BookTitle = A['BookTitle'];
	local Conference = A['Conference'];
	local TransTitle = A['TransTitle'];
	local TitleNote = A['TitleNote'];
	local TitleLink = A['TitleLink'];
		if is_set (TitleLink) and false == link_param_ok (TitleLink) then
			table.insert( z.message_tail, { set_error( 'bad_paramlink', A:ORIGIN('TitleLink'))});		-- url or wikilink in |title-link=;
		end

	local Chapter = A['Chapter'];
	local ScriptChapter = A['ScriptChapter'];
	local ChapterLink	-- = A['ChapterLink'];									-- deprecated as a parameter but still used internally by cite episode
	local TransChapter = A['TransChapter'];
	local TitleType = A['TitleType'];
	local Degree = A['Degree'];
	local Docket = A['Docket'];
	local ArchiveFormat = A['ArchiveFormat'];
	local ArchiveURL = A['ArchiveURL'];
	local URL = A['URL']
	local URLorigin = A:ORIGIN('URL');											-- get name of parameter that holds URL
	local ChapterURL = A['ChapterURL'];
	local ChapterURLorigin = A:ORIGIN('ChapterURL');							-- get name of parameter that holds ChapterURL
	local ConferenceFormat = A['ConferenceFormat'];
	local ConferenceURL = A['ConferenceURL'];
	local ConferenceURLorigin = A:ORIGIN('ConferenceURL');						-- get name of parameter that holds ConferenceURL
	local Periodical = A['Periodical'];
	local Periodical_origin = A:ORIGIN('Periodical');							-- get the name of the periodical parameter

	local Series = A['Series'];
	
	local Volume;
	local Issue;
	local Page;
	local Pages;
	local At;

	if in_array (config.CitationClass, cfg.templates_using_volume) and not ('conference' == config.CitationClass and not is_set (Periodical)) then
		Volume = A['Volume'];
	end
	if in_array (config.CitationClass, cfg.templates_using_issue) and not (in_array (config.CitationClass, {'conference', 'map'}) and not is_set (Periodical))then
		Issue = A['Issue'];
	end
	local Position = '';
	if not in_array (config.CitationClass, cfg.templates_not_using_page) then
		Page = A['Page'];
		Pages = hyphen_to_dash( A['Pages'] );	
		At = A['At'];
	end

	local Edition = A['Edition'];
	local PublicationPlace = A['PublicationPlace']
	local Place = A['Place'];
	
	local PublisherName = A['PublisherName'];
	local RegistrationRequired = A['RegistrationRequired'];
		if not is_valid_parameter_value (RegistrationRequired, 'registration', cfg.keywords ['yes_true_y']) then
			RegistrationRequired=nil;
		end
	local SubscriptionRequired = A['SubscriptionRequired'];
		if not is_valid_parameter_value (SubscriptionRequired, 'subscription', cfg.keywords ['yes_true_y']) then
			SubscriptionRequired=nil;
		end

	local Via = A['Via'];
	local AccessDate = A['AccessDate'];
	local ArchiveDate = A['ArchiveDate'];
	local Agency = A['Agency'];
	local DeadURL = A['DeadURL']
		if not is_valid_parameter_value (DeadURL, 'dead-url', cfg.keywords ['deadurl']) then	-- set in config.defaults to 'yes'
			DeadURL = '';														-- anything else, set to empty string
		end

	local Language = A['Language'];
	local Format = A['Format'];
	local ChapterFormat = A['ChapterFormat'];
	local DoiBroken = A['DoiBroken'];
	local ID = A['ID'];
	local ASINTLD = A['ASINTLD'];
	local IgnoreISBN = A['IgnoreISBN'];
		if not is_valid_parameter_value (IgnoreISBN, 'ignore-isbn-error', cfg.keywords ['yes_true_y']) then
			IgnoreISBN = nil;													-- anything else, set to empty string
		end
	local Embargo = A['Embargo'];
	local Class = A['Class'];													-- arxiv class identifier

	local ID_list = extract_ids( args );
	local ID_access_levels = extract_id_access_levels( args, ID_list );
	local Quote = A['Quote'];

	local LayFormat = A['LayFormat'];
	local LayURL = A['LayURL'];
	local LaySource = A['LaySource'];
	local Transcript = A['Transcript'];
	local TranscriptFormat = A['TranscriptFormat'];
	local TranscriptURL = A['TranscriptURL'] 
	local TranscriptURLorigin = A:ORIGIN('TranscriptURL');						-- get name of parameter that holds TranscriptURL

	local LastAuthorAmp = A['LastAuthorAmp'];
		if not is_valid_parameter_value (LastAuthorAmp, 'last-author-amp', cfg.keywords ['yes_true_y']) then
			LastAuthorAmp = nil;													-- set to empty string
		end
	local no_tracking_cats = A['NoTracking'];
		if not is_valid_parameter_value (no_tracking_cats, 'no-tracking', cfg.keywords ['yes_true_y']) then
			no_tracking_cats = nil;												-- set to empty string
		end

--these are used by cite interview
	local Callsign = A['Callsign'];
	local City = A['City'];
	local Program = A['Program'];

--local variables that are not cs1 parameters
	local use_lowercase;														-- controls capitalization of certain static text
	local this_page = mw.title.getCurrentTitle();								-- also used for COinS and for language
	local anchor_year;															-- used in the CITEREF identifier
	local COinS_date = {};														-- holds date info extracted from |date= for the COinS metadata by Module:Date verification

-- set default parameter values defined by |mode= parameter.  If |mode= is empty or omitted, use CitationClass to set these values
	local Mode = A['Mode'];
	if not is_valid_parameter_value (Mode, 'mode', cfg.keywords['mode']) then
		Mode = '';
	end
	local sepc;											-- separator between citation elements for CS1 a period, for CS2, a comma
	local PostScript;
	local Ref;
	sepc, PostScript, Ref = set_style (Mode:lower(), A['PostScript'], A['Ref'], config.CitationClass);
	use_lowercase = ( sepc == ',' );					-- used to control capitalization for certain static text

--check this page to see if it is in one of the namespaces that cs1 is not supposed to add to the error categories
	if not is_set (no_tracking_cats) then										-- ignore if we are already not going to categorize this page
		if in_array (this_page.nsText, cfg.uncategorized_namespaces) then
			no_tracking_cats = "true";											-- set no_tracking_cats
		end
		for _,v in ipairs (cfg.uncategorized_subpages) do						-- cycle through page name patterns
			if this_page.text:match (v) then									-- test page name against each pattern
				no_tracking_cats = "true";										-- set no_tracking_cats
				break;															-- bail out if one is found
			end
		end
	end

-- check for extra |page=, |pages= or |at= parameters. (also sheet and sheets while we're at it)
	select_one( args, {'page', 'p', 'pp', 'pages', 'at', 'sheet', 'sheets'}, 'redundant_parameters' );		-- this is a dummy call simply to get the error message and category

	local NoPP = A['NoPP'] 
	if is_set (NoPP) and is_valid_parameter_value (NoPP, 'nopp', cfg.keywords ['yes_true_y']) then
		NoPP = true;
	else
		NoPP = nil;																-- unset, used as a flag later
	end

	if is_set(Page) then
		if is_set(Pages) or is_set(At) then
			Pages = '';															-- unset the others
			At = '';
		end
		extra_text_in_page_check (Page);										-- add this page to maint cat if |page= value begins with what looks like p. or pp.
	elseif is_set(Pages) then
		if is_set(At) then
			At = '';															-- unset
		end
		extra_text_in_page_check (Pages);										-- add this page to maint cat if |pages= value begins with what looks like p. or pp.
	end	

-- both |publication-place= and |place= (|location=) allowed if different
	if not is_set(PublicationPlace) and is_set(Place) then
		PublicationPlace = Place;							-- promote |place= (|location=) to |publication-place
	end
	
	if PublicationPlace == Place then Place = ''; end		-- don't need both if they are the same
	
--[[
Parameter remapping for cite encyclopedia:
When the citation has these parameters:
	|encyclopedia and |title then map |title to |article and |encyclopedia to |title
	|encyclopedia and |article then map |encyclopedia to |title
	|encyclopedia then map |encyclopedia to |title

	|trans_title maps to |trans_chapter when |title is re-mapped
	|url maps to |chapterurl when |title is remapped

All other combinations of |encyclopedia, |title, and |article are not modified

]]

local Encyclopedia = A['Encyclopedia'];

	if ( config.CitationClass == "encyclopaedia" ) or ( config.CitationClass == "citation" and is_set (Encyclopedia)) then	-- test code for citation
		if is_set(Periodical) then												-- Periodical is set when |encyclopedia is set
			if is_set(Title) or is_set (ScriptTitle) then
				if not is_set(Chapter) then
					Chapter = Title;											-- |encyclopedia and |title are set so map |title to |article and |encyclopedia to |title
					ScriptChapter = ScriptTitle;
					TransChapter = TransTitle;
					ChapterURL = URL;
					if not is_set (ChapterURL) and is_set (TitleLink) then
						Chapter= '[[' .. TitleLink .. '|' .. Chapter .. ']]';
					end
					Title = Periodical;
					ChapterFormat = Format;
					Periodical = '';											-- redundant so unset
					TransTitle = '';
					URL = '';
					Format = '';
					TitleLink = '';
					ScriptTitle = '';
				end
			else																-- |title not set
				Title = Periodical;												-- |encyclopedia set and |article set or not set so map |encyclopedia to |title
				Periodical = '';												-- redundant so unset
			end
		end
	end

-- Special case for cite techreport.
	if (config.CitationClass == "techreport") then								-- special case for cite techreport
		if is_set(A['Number']) then													-- cite techreport uses 'number', which other citations alias to 'issue'
			if not is_set(ID) then												-- can we use ID for the "number"?
				ID = A['Number'];													-- yes, use it
			else																-- ID has a value so emit error message
				table.insert( z.message_tail, { set_error('redundant_parameters', {wrap_style ('parameter', 'id') .. ' and ' .. wrap_style ('parameter', 'number')}, true )});
			end
		end	
	end

-- special case for cite interview
	if (config.CitationClass == "interview") then
		if is_set(Program) then
			ID = ' ' .. Program;
		end
		if is_set(Callsign) then
			if is_set(ID) then
				ID = ID .. sepc .. ' ' .. Callsign;
			else
				ID = ' ' .. Callsign;
			end
		end
		if is_set(City) then
			if is_set(ID) then
				ID = ID .. sepc .. ' ' .. City;
			else
				ID = ' ' .. City;
			end
		end

		if is_set(Others) then
			if is_set(TitleType) then
				Others = ' ' .. TitleType .. ' with ' .. Others;
				TitleType = '';
			else
				Others = ' ' .. 'Interview with ' .. Others;
			end
		else
			Others = '(Interview)';
		end
	end

-- special case for cite mailing list
	if (config.CitationClass == "mailinglist") then
		Periodical = A ['MailingList'];
	elseif 'mailinglist' == A:ORIGIN('Periodical') then
		Periodical = '';														-- unset because mailing list is only used for cite mailing list
	end

-- Account for the oddity that is {{cite conference}}, before generation of COinS data.
	if 'conference' == config.CitationClass then
		if is_set(BookTitle) then
			Chapter = Title;
--			ChapterLink = TitleLink;											-- |chapterlink= is deprecated
			ChapterURL = URL;
			ChapterURLorigin = URLorigin;
			URLorigin = '';
			ChapterFormat = Format;
			TransChapter = TransTitle;
			Title = BookTitle;
			Format = '';
--			TitleLink = '';
			TransTitle = '';
			URL = '';
		end
	elseif 'speech' ~= config.CitationClass then
		Conference = '';														-- not cite conference or cite speech so make sure this is empty string
	end

-- cite map oddities
	local Cartography = "";
	local Scale = "";
	local Sheet = A['Sheet'] or '';
	local Sheets = A['Sheets'] or '';
	if config.CitationClass == "map" then
		Chapter = A['Map'];
		ChapterURL = A['MapURL'];
		TransChapter = A['TransMap'];
		ChapterURLorigin = A:ORIGIN('MapURL');
		ChapterFormat = A['MapFormat'];
		
		Cartography = A['Cartography'];
		if is_set( Cartography ) then
			Cartography = sepc .. " " .. wrap_msg ('cartography', Cartography, use_lowercase);
		end		
		Scale = A['Scale'];
		if is_set( Scale ) then
			Scale = sepc .. " " .. Scale;
		end
	end

-- Account for the oddities that are {{cite episode}} and {{cite serial}}, before generation of COinS data.
	if 'episode' == config.CitationClass or 'serial' == config.CitationClass then
		local AirDate = A['AirDate'];
		local SeriesLink = A['SeriesLink'];
			if is_set (SeriesLink) and false == link_param_ok (SeriesLink) then
				table.insert( z.message_tail, { set_error( 'bad_paramlink', A:ORIGIN('SeriesLink'))});
			end
		local Network = A['Network'];
		local Station = A['Station'];
		local s, n = {}, {};
																				-- do common parameters first
		if is_set(Network) then table.insert(n, Network); end
		if is_set(Station) then table.insert(n, Station); end
		ID = table.concat(n, sepc .. ' ');
		
		if not is_set (Date) and is_set (AirDate) then							-- promote airdate to date
			Date = AirDate;
		end

		if 'episode' == config.CitationClass then								-- handle the oddities that are strictly {{cite episode}}
			local Season = A['Season'];
			local SeriesNumber = A['SeriesNumber'];

			if is_set (Season) and is_set (SeriesNumber) then					-- these are mutually exclusive so if both are set
				table.insert( z.message_tail, { set_error( 'redundant_parameters', {wrap_style ('parameter', 'season') .. ' and ' .. wrap_style ('parameter', 'seriesno')}, true ) } );		-- add error message
				SeriesNumber = '';												-- unset; prefer |season= over |seriesno=
			end
																				-- assemble a table of parts concatenated later into Series
			if is_set(Season) then table.insert(s, wrap_msg ('season', Season, use_lowercase)); end
			if is_set(SeriesNumber) then table.insert(s, wrap_msg ('series', SeriesNumber, use_lowercase)); end
			if is_set(Issue) then table.insert(s, wrap_msg ('episode', Issue, use_lowercase)); end
			Issue = '';															-- unset because this is not a unique parameter
	
			Chapter = Title;													-- promote title parameters to chapter
			ScriptChapter = ScriptTitle;
			ChapterLink = TitleLink;											-- alias episodelink
			TransChapter = TransTitle;
			ChapterURL = URL;
			ChapterURLorigin = A:ORIGIN('URL');
			
			Title = Series;														-- promote series to title
			TitleLink = SeriesLink;
			Series = table.concat(s, sepc .. ' ');								-- this is concatenation of season, seriesno, episode number

			if is_set (ChapterLink) and not is_set (ChapterURL) then			-- link but not URL
				Chapter = '[[' .. ChapterLink .. '|' .. Chapter .. ']]';		-- ok to wikilink
			elseif is_set (ChapterLink) and is_set (ChapterURL) then			-- if both are set, URL links episode;
				Series = '[[' .. ChapterLink .. '|' .. Series .. ']]';			-- series links with ChapterLink (episodelink -> TitleLink -> ChapterLink) ugly
			end
			URL = '';															-- unset
			TransTitle = '';
			ScriptTitle = '';
			
		else																	-- now oddities that are cite serial
			Issue = '';															-- unset because this parameter no longer supported by the citation/core version of cite serial
			Chapter = A['Episode'];												-- TODO: make |episode= available to cite episode someday?
			if is_set (Series) and is_set (SeriesLink) then
				Series = '[[' .. SeriesLink .. '|' .. Series .. ']]';
			end
			Series = wrap_style ('italic-title', Series);						-- series is italicized
		end	
	end
-- end of {{cite episode}} stuff

-- Account for the oddities that are {{cite arxiv}}, before generation of COinS data.
	if 'arxiv' == config.CitationClass then
		if not is_set (ID_list['ARXIV']) then									-- |arxiv= or |eprint= required for cite arxiv
			table.insert( z.message_tail, { set_error( 'arxiv_missing', {}, true ) } );		-- add error message
		elseif is_set (Series) then												-- series is an alias of version
			ID_list['ARXIV'] = ID_list['ARXIV'] .. Series;						-- concatenate version onto the end of the arxiv identifier
			Series = '';														-- unset
			deprecated_parameter ('version');									-- deprecated parameter but only for cite arxiv
		end
		
		if first_set ({AccessDate, At, Chapter, Format, Page, Pages, Periodical, PublisherName, URL,	-- a crude list of parameters that are not supported by cite arxiv
			ID_list['ASIN'], ID_list['BIBCODE'], ID_list['DOI'], ID_list['ISBN'], ID_list['ISSN'],
			ID_list['JFM'], ID_list['JSTOR'], ID_list['LCCN'], ID_list['MR'], ID_list['OCLC'], ID_list['OL'],
			ID_list['OSTI'], ID_list['PMC'], ID_list['PMID'], ID_list['RFC'], ID_list['SSRN'], ID_list['USENETID'], ID_list['ZBL']},27) then
				table.insert( z.message_tail, { set_error( 'arxiv_params_not_supported', {}, true ) } );		-- add error message

				AccessDate= '';													-- set these to empty string; not supported in cite arXiv
				PublisherName = '';												-- (if the article has been published, use cite journal, or other)
				Chapter = '';
				URL = '';
				Format = '';
				Page = ''; Pages = ''; At = '';
		end
		Periodical = 'arXiv';													-- set to arXiv for COinS; after that, must be set to empty string
	end

-- handle type parameter for those CS1 citations that have default values
	if in_array(config.CitationClass, {"AV-media-notes", "DVD-notes", "mailinglist", "map", "podcast", "pressrelease", "report", "techreport", "thesis"}) then
		TitleType = set_titletype (config.CitationClass, TitleType);
		if is_set(Degree) and "Thesis" == TitleType then						-- special case for cite thesis
			TitleType = Degree .. "论文";
		end
	end

	if is_set(TitleType) then													-- if type parameter is specified
	TitleType = substitute( cfg.messages['type'], TitleType);					-- display it in parentheses
	end

-- legacy: promote concatenation of |month=, and |year= to Date if Date not set; or, promote PublicationDate to Date if neither Date nor Year are set.
	if not is_set (Date) then
		Date = Year;															-- promote Year to Date
		Year = nil;																-- make nil so Year as empty string isn't used for CITEREF
		if not is_set (Date) and is_set(PublicationDate) then					-- use PublicationDate when |date= and |year= are not set
			Date = PublicationDate;												-- promote PublicationDate to Date
			PublicationDate = '';												-- unset, no longer needed
		end
	end

	if PublicationDate == Date then PublicationDate = ''; end					-- if PublicationDate is same as Date, don't display in rendered citation

--[[
Go test all of the date-holding parameters for valid MOS:DATE format and make sure that dates are real dates. This must be done before we do COinS because here is where
we get the date used in the metadata.

Date validation supporting code is in Module:Citation/CS1/Date_validation
]]
	do	-- create defined block to contain local variables error_message and mismatch
		local error_message = '';
																				-- AirDate has been promoted to Date so not necessary to check it
		anchor_year, error_message = dates({['access-date']=AccessDate, ['archive-date']=ArchiveDate, ['date']=Date, ['doi-broken-date']=DoiBroken,
			['embargo']=Embargo, ['lay-date']=LayDate, ['publication-date']=PublicationDate, ['year']=Year}, COinS_date);

		if is_set (Year) and is_set (Date) then									-- both |date= and |year= not normally needed; 
			local mismatch = year_date_check (Year, Date)
			if 0 == mismatch then												-- |year= does not match a year-value in |date=
				if is_set (error_message) then									-- if there is already an error message
					error_message = error_message .. ', ';						-- tack on this additional message
				end
				error_message = error_message .. '&#124;year= / &#124;date= mismatch';
			elseif 1 == mismatch then											-- |year= matches year-value in |date=
				add_maint_cat ('date_year');
			end
		end

		if is_set(error_message) then
			table.insert( z.message_tail, { set_error( 'bad_date', {error_message}, true ) } );	-- add this error message
		end
	end	-- end of do

-- Account for the oddity that is {{cite journal}} with |pmc= set and |url= not set.  Do this after date check but before COInS.
-- Here we unset Embargo if PMC not embargoed (|embargo= not set in the citation) or if the embargo time has expired. Otherwise, holds embargo date
	Embargo = is_embargoed (Embargo);											-- 

	if config.CitationClass == "journal" and not is_set(URL) and is_set(ID_list['PMC']) then
		if not is_set (Embargo) then											-- if not embargoed or embargo has expired
			URL=cfg.id_handlers['PMC'].prefix .. ID_list['PMC'];				-- set url to be the same as the PMC external link if not embargoed
			URLorigin = cfg.id_handlers['PMC'].parameters[1];					-- set URLorigin to parameter name for use in error message if citation is missing a |title=
		end
	end

-- At this point fields may be nil if they weren't specified in the template use.  We can use that fact.
	-- Test if citation has no title
	if	not is_set(Title) and
		not is_set(TransTitle) and
		not is_set(ScriptTitle) then
			if 'episode' == config.CitationClass then							-- special case for cite episode; TODO: is there a better way to do this?
				table.insert( z.message_tail, { set_error( 'citation_missing_title', {'series'}, true ) } );
			else
				table.insert( z.message_tail, { set_error( 'citation_missing_title', {'title'}, true ) } );
			end
	end
	
	if 'none' == Title and in_array (config.CitationClass, {'journal', 'citation'}) and is_set (Periodical) and 'journal' == A:ORIGIN('Periodical') then	-- special case for journal cites
		Title = '';																-- set title to empty string
		add_maint_cat ('untitled');
	end

	check_for_url ({															-- add error message when any of these parameters contains a URL
		['title']=Title,
		[A:ORIGIN('Chapter')]=Chapter,
		[A:ORIGIN('Periodical')]=Periodical,
		[A:ORIGIN('PublisherName')] = PublisherName,
		});

	-- COinS metadata (see <http://ocoins.info/>) for automated parsing of citation information.
	-- handle the oddity that is cite encyclopedia and {{citation |encyclopedia=something}}. Here we presume that
	-- when Periodical, Title, and Chapter are all set, then Periodical is the book (encyclopedia) title, Title
	-- is the article title, and Chapter is a section within the article.  So, we remap 
	
	local coins_chapter = Chapter;												-- default assuming that remapping not required
	local coins_title = Title;													-- et tu
	if 'encyclopaedia' == config.CitationClass or ('citation' == config.CitationClass and is_set (Encyclopedia)) then
		if is_set (Chapter) and is_set (Title) and is_set (Periodical) then		-- if all are used then
			coins_chapter = Title;												-- remap
			coins_title = Periodical;
		end
	end
	local coins_author = a;														-- default for coins rft.au 
	if 0 < #c then																-- but if contributor list
		coins_author = c;														-- use that instead
	end

	-- this is the function call to COinS()
	local OCinSoutput = COinS({
		['Periodical'] = Periodical,
		['Encyclopedia'] = Encyclopedia,
		['Chapter'] = make_coins_title (coins_chapter, ScriptChapter),			-- Chapter and ScriptChapter stripped of bold / italic wikimarkup
		['Map'] = Map,
		['Degree'] = Degree;													-- cite thesis only
		['Title'] = make_coins_title (coins_title, ScriptTitle),				-- Title and ScriptTitle stripped of bold / italic wikimarkup
		['PublicationPlace'] = PublicationPlace,
		['Date'] = COinS_date.rftdate,											-- COinS_date has correctly formatted date if Date is valid;
		['Season'] = COinS_date.rftssn,
		['Chron'] =  COinS_date.rftchron or (not COinS_date.rftdate and Date) or '',	-- chron but if not set and invalid date format use Date; keep this last bit?
		['Series'] = Series,
		['Volume'] = Volume,
		['Issue'] = Issue,
		['Pages'] = get_coins_pages (first_set ({Sheet, Sheets, Page, Pages, At}, 5)),				-- pages stripped of external links
		['Edition'] = Edition,
		['PublisherName'] = PublisherName,
		['URL'] = first_set ({ChapterURL, URL}, 2),
		['Authors'] = coins_author,
		['ID_list'] = ID_list,
		['RawPage'] = this_page.prefixedText,
	}, config.CitationClass);

-- Account for the oddities that are {{cite arxiv}}, AFTER generation of COinS data.
	if 'arxiv' == config.CitationClass then										-- we have set rft.jtitle in COinS to arXiv, now unset so it isn't displayed
		Periodical = '';														-- periodical not allowed in cite arxiv; if article has been published, use cite journal
	end

-- special case for cite newsgroup.  Do this after COinS because we are modifying Publishername to include some static text
	if 'newsgroup' == config.CitationClass then
		if is_set (PublisherName) then
			PublisherName = substitute (cfg.messages['newsgroup'], external_link( 'news:' .. PublisherName, PublisherName, A:ORIGIN('PublisherName') ));
		end
	end



	-- Now perform various field substitutions.
	-- We also add leading spaces and surrounding markup and punctuation to the
	-- various parts of the citation, but only when they are non-nil.
	local EditorCount;															-- used only for choosing {ed.) or (eds.) annotation at end of editor name-list
	do
		local last_first_list;
		local maximum;
		local control = { 
			format = NameListFormat,											-- empty string or 'vanc'
			maximum = nil,														-- as if display-authors or display-editors not set
			lastauthoramp = LastAuthorAmp,
			page_name = this_page.text											-- get current page name so that we don't wikilink to it via editorlinkn
		};

		do																		-- do editor name list first because coauthors can modify control table
			maximum , editor_etal = get_display_authors_editors (A['DisplayEditors'], #e, 'editors', editor_etal);
			--[[ Preserve old-style implicit et al.
			临时修复"Category:含有旧式缩略标签的引用的页面 in editors"的问题，中文版目前与英文版逻辑不一样，暂时不需要这个分类。等以后更新时再看怎么处理 --2017.6.23 shizhao
			
			if not is_set(maximum) and #e == 4 then 
				maximum = 3;
				table.insert( z.message_tail, { set_error('implict_etal_editor', {}, true) } );
			end
			]]

			control.maximum = maximum;
			
			last_first_list, EditorCount = list_people(control, e, editor_etal, 'editor');

			if is_set (Editors) then
				if editor_etal then
					Editors = Editors .. ' ' .. cfg.messages['et al'];			-- add et al. to editors parameter beause |display-editors=etal
					EditorCount = 2;											-- with et al., |editors= is multiple names; spoof to display (eds.) annotation
				else
					EditorCount = 2;											-- we don't know but assume |editors= is multiple names; spoof to display (eds.) annotation
				end
			else
				Editors = last_first_list;										-- either an author name list or an empty string
			end

			if 1 == EditorCount and (true == editor_etal or 1 < #e) then		-- only one editor displayed but includes etal then 
				EditorCount = 2;												-- spoof to display (eds.) annotation
			end
		end
		do																		-- now do translators
			control.maximum = #t;												-- number of translators
			Translators = list_people(control, t, false, 'translator');			-- et al not currently supported
		end
		do																		-- now do contributors
			control.maximum = #c;												-- number of contributors
			Contributors = list_people(control, c, false, 'contributor');		-- et al not currently supported
		end
		do																		-- now do authors
			control.maximum , author_etal = get_display_authors_editors (A['DisplayAuthors'], #a, 'authors', author_etal);

			if is_set(Coauthors) then											-- if the coauthor field is also used, prevent ampersand and et al. formatting.
				control.lastauthoramp = nil;
				control.maximum = #a + 1;
			end
			
			last_first_list = list_people(control, a, author_etal, 'author');

			if is_set (Authors) then
				Authors, author_etal = name_has_etal (Authors, author_etal, false);	-- find and remove variations on et al.
				if author_etal then
					Authors = Authors .. ' ' .. cfg.messages['et al'];			-- add et al. to authors parameter
				end
			else
				Authors = last_first_list;										-- either an author name list or an empty string
			end
		end																		-- end of do

		if not is_set(Authors) and is_set(Coauthors) then						-- coauthors aren't displayed if one of authors=, authorn=, or lastn= isn't specified
			table.insert( z.message_tail, { set_error('coauthors_missing_author', {}, true) } );	-- emit error message
		end
	end

-- apply |[xx-]format= styling; at the end, these parameters hold correctly styled format annotation,
-- an error message if the associated url is not set, or an empty string for concatenation
	ArchiveFormat = style_format (ArchiveFormat, ArchiveURL, 'archive-format', 'archive-url');
	ConferenceFormat = style_format (ConferenceFormat, ConferenceURL, 'conference-format', 'conference-url');
	Format = style_format (Format, URL, 'format', 'url');
	LayFormat = style_format (LayFormat, LayURL, 'lay-format', 'lay-url');
	TranscriptFormat = style_format (TranscriptFormat, TranscriptURL, 'transcript-format', 'transcripturl');

-- special case for chapter format so no error message or cat when chapter not supported
	if not (in_array(config.CitationClass, {'web','news','journal', 'magazine', 'pressrelease','podcast', 'newsgroup', 'arxiv'}) or
		('citation' == config.CitationClass and is_set (Periodical) and not is_set (Encyclopedia))) then
			ChapterFormat = style_format (ChapterFormat, ChapterURL, 'chapter-format', 'chapter-url');
	end

	if  not is_set(URL) then --and
		if in_array(config.CitationClass, {"web","podcast", "mailinglist"}) then		-- Test if cite web or cite podcast |url= is missing or empty 
			table.insert( z.message_tail, { set_error( 'cite_web_url', {}, true ) } );
		end
		
		-- Test if accessdate is given without giving a URL
		if is_set(AccessDate) and not is_set(ChapterURL)then					-- ChapterURL may be set when the others are not set; TODO: move this to a separate test?
			table.insert( z.message_tail, { set_error( 'accessdate_missing_url', {}, true ) } );
			AccessDate = '';
		end
	end

	local OriginalURL, OriginalURLorigin, OriginalFormat;						-- TODO: swap chapter and title here so that archive applies to most specific if both are set?
	DeadURL = DeadURL:lower();													-- used later when assembling archived text
	if is_set( ArchiveURL ) then
		if is_set (URL) then
			OriginalURL = URL;													-- save copy of original source URL
			OriginalURLorigin = URLorigin;										-- name of url parameter for error messages
			OriginalFormat = Format;											-- and original |format=
			if not in_array (DeadURL, {'no', 'live'}) then												-- if URL set then archive-url applies to it
				URL = ArchiveURL												-- swap-in the archive's url
				URLorigin = A:ORIGIN('ArchiveURL')								-- name of archive url parameter for error messages
				Format = ArchiveFormat or '';									-- swap in archive's format
			end
		elseif is_set (ChapterURL) then 										-- URL not set so if chapter-url is set apply archive url to it
			OriginalURL = ChapterURL;											-- save copy of source chapter's url for archive text
			OriginalURLorigin = ChapterURLorigin;								-- name of chapter-url parameter for error messages
			OriginalFormat = ChapterFormat;										-- and original |format=
			if not in_array (DeadURL, {'no', 'live'}) then
				ChapterURL = ArchiveURL											-- swap-in the archive's url
				ChapterURLorigin = A:ORIGIN('ArchiveURL')						-- name of archive-url parameter for error messages
				ChapterFormat = ArchiveFormat or '';							-- swap in archive's format
			end
		end
	end

	if in_array(config.CitationClass, {'web','news','journal', 'magazine', 'pressrelease','podcast', 'newsgroup', 'arxiv'}) or	-- if any of the 'periodical' cites except encyclopedia
		('citation' == config.CitationClass and is_set (Periodical) and not is_set (Encyclopedia)) then
			local chap_param;
			if is_set (Chapter) then											-- get a parameter name from one of these chapter related meta-parameters
				chap_param = A:ORIGIN ('Chapter')
			elseif is_set (TransChapter) then
				chap_param = A:ORIGIN ('TransChapter')
			elseif is_set (ChapterURL) then
				chap_param = A:ORIGIN ('ChapterURL')
			elseif is_set (ScriptChapter) then
				chap_param = A:ORIGIN ('ScriptChapter')
			else is_set (ChapterFormat)
				chap_param = A:ORIGIN ('ChapterFormat')
			end

			if is_set (chap_param) then											-- if we found one
				table.insert( z.message_tail, { set_error( 'chapter_ignored', {chap_param}, true ) } );		-- add error message
				Chapter = '';													-- and set them to empty string to be safe with concatenation
				TransChapter = '';
				ChapterURL = '';
				ScriptChapter = '';
				ChapterFormat = '';
			end
	else																		-- otherwise, format chapter / article title
		local no_quotes = false;												-- default assume that we will be quoting the chapter parameter value
		if is_set (Contribution) and 0 < #c then								-- if this is a contribution with contributor(s)
			if in_array (Contribution:lower(), cfg.keywords.contribution) then	-- and a generic contribution title
				no_quotes = true;												-- then render it unquoted
			end
		end

		Chapter = format_chapter_title (ScriptChapter, Chapter, TransChapter, ChapterURL, ChapterURLorigin, no_quotes);		-- Contribution is also in Chapter
		if is_set (Chapter) then
			if 'map' == config.CitationClass and is_set (TitleType) then
				Chapter = Chapter .. ' ' .. TitleType;
			end
			Chapter = Chapter .. ChapterFormat .. sepc .. ' ';
		elseif is_set (ChapterFormat) then										-- |chapter= not set but |chapter-format= is so ...
			Chapter = ChapterFormat .. sepc .. ' ';								-- ... ChapterFormat has error message, we want to see it
		end
	end

	-- Format main title.
	if is_set(TitleLink) and is_set(Title) then
		Title = "[[" .. TitleLink .. "|" .. Title .. "]]"
	end

	if in_array(config.CitationClass, {'web','news','journal', 'magazine', 'pressrelease','podcast', 'newsgroup', 'mailinglist', 'arxiv'}) or
		('citation' == config.CitationClass and is_set (Periodical) and not is_set (Encyclopedia)) or
		('map' == config.CitationClass and is_set (Periodical)) then			-- special case for cite map when the map is in a periodical treat as an article
			Title = kern_quotes (Title);										-- if necessary, separate title's leading and trailing quote marks from Module provided quote marks
			Title = wrap_style ('quoted-title', Title);
	
			Title = script_concatenate (Title, ScriptTitle);					-- <bdi> tags, lang atribute, categorization, etc; must be done after title is wrapped
			TransTitle= wrap_style ('trans-quoted-title', TransTitle );
	elseif 'report' == config.CitationClass then								-- no styling for cite report
		Title = script_concatenate (Title, ScriptTitle);						-- <bdi> tags, lang atribute, categorization, etc; must be done after title is wrapped
		TransTitle= wrap_style ('trans-quoted-title', TransTitle );				-- for cite report, use this form for trans-title
	else
		Title = wrap_style ('italic-title', Title);
		Title = script_concatenate (Title, ScriptTitle);						-- <bdi> tags, lang atribute, categorization, etc; must be done after title is wrapped
		TransTitle = wrap_style ('trans-italic-title', TransTitle);
	end

	TransError = "";
	if is_set(TransTitle) then
		if is_set(Title) then
			TransTitle = " " .. TransTitle;
		else
			TransError = " " .. set_error( 'trans_missing_title', {'title'} );
		end
	end
	
	Title = Title .. TransTitle;
	
	if is_set(Title) then
		if not is_set(TitleLink) and is_set(URL) then 
			Title = external_link( URL, Title, URLorigin ) .. TransError .. Format;
			URL = "";
			Format = "";
		else
			Title = Title .. TransError;
		end
	end

	if is_set(Place) then
		Place = " " .. wrap_msg ('written', Place, use_lowercase) .. sepc .. " ";
	end

	if is_set (Conference) then
		if is_set (ConferenceURL) then
			Conference = external_link( ConferenceURL, Conference, ConferenceURLorigin );
		end
		Conference = sepc .. " " .. Conference .. ConferenceFormat;
	elseif is_set(ConferenceURL) then
		Conference = sepc .. " " .. external_link( ConferenceURL, nil, ConferenceURLorigin );
	end

	if not is_set(Position) then
		local Minutes = A['Minutes'];
		local Time = A['Time'];

		if is_set(Minutes) then
			if is_set (Time) then
				table.insert( z.message_tail, { set_error( 'redundant_parameters', {wrap_style ('parameter', 'minutes') .. ' and ' .. wrap_style ('parameter', 'time')}, true ) } );
			end
			Position = " " .. Minutes .. " " .. cfg.messages['minutes'];
		else
			if is_set(Time) then
				local TimeCaption = A['TimeCaption']
				if not is_set(TimeCaption) then
					TimeCaption = cfg.messages['event'];
					if sepc ~= '.' then
						TimeCaption = TimeCaption:lower();
					end
				end
				Position = " " .. TimeCaption .. " " .. Time;
			end
		end
	else
		Position = " " .. Position;
		At = '';
	end

	Page, Pages, Sheet, Sheets = format_pages_sheets (Page, Pages, Sheet, Sheets, config.CitationClass, Periodical_origin, sepc, NoPP, use_lowercase);

	At = is_set(At) and (sepc .. " " .. At) or "";
	Position = is_set(Position) and (sepc .. " " .. Position) or "";
	if config.CitationClass == 'map' then
		local Section = A['Section'];
		local Sections = A['Sections'];
		local Inset = A['Inset'];
		
		if is_set( Inset ) then
			Inset = sepc .. " " .. wrap_msg ('inset', Inset, use_lowercase);
		end			

		if is_set( Sections ) then
			Section = sepc .. " " .. wrap_msg ('sections', Sections, use_lowercase);
		elseif is_set( Section ) then
			Section = sepc .. " " .. wrap_msg ('section', Section, use_lowercase);
		end
		At = At .. Inset .. Section;		
	end	

	if is_set (Language) then
		Language = language_parameter (Language);								-- format, categories, name from ISO639-1, etc
	else
		Language="";															-- language not specified so make sure this is an empty string;
	end

	Others = is_set(Others) and (sepc .. " " .. Others) or "";
	
	if is_set (Translators) then
		Others = sepc .. ' 由' .. Translators .. '翻译' .. Others; 
	end

	TitleNote = is_set(TitleNote) and (sepc .. " " .. TitleNote) or "";
	if is_set (Edition) then
		if Edition:match ('%f[%a][Ee]d%.?$') or Edition:match ('%f[%a][Ee]dition$') then
			add_maint_cat ('extra_text', 'edition');
		end
		Edition = " " .. wrap_msg ('edition', Edition);
	else
		Edition = '';
	end

	Series = is_set(Series) and (sepc .. " " .. Series) or "";
	OrigYear = is_set(OrigYear) and (" [" .. OrigYear .. "]") or "";
	Agency = is_set(Agency) and (sepc .. " " .. Agency) or "";

	Volume = format_volume_issue (Volume, Issue, config.CitationClass, Periodical_origin, sepc, use_lowercase);

	------------------------------------ totally unrelated data
	if is_set(Via) then
		Via = " " .. wrap_msg ('via', Via);
	end

--[[
Subscription implies paywall; Registration does not.  If both are used in a citation, the subscription required link
note is displayed. There are no error messages for this condition.

]]
	if is_set (SubscriptionRequired) then
		SubscriptionRequired = sepc .. " " .. cfg.messages['subscription'];		-- subscription required message
	elseif is_set (RegistrationRequired) then
		SubscriptionRequired = sepc .. " " .. cfg.messages['registration'];		-- registration required message
	else
		SubscriptionRequired = '';												-- either or both might be set to something other than yes true y
	end

	if is_set(AccessDate) then
		local retrv_text = " " .. cfg.messages['retrieved']

		AccessDate = nowrap_date (AccessDate);									-- wrap in nowrap span if date in appropriate format
		if (sepc ~= ".") then retrv_text = retrv_text:lower() end				-- if 'citation', lower case
		AccessDate = substitute (retrv_text, AccessDate);						-- add retrieved text
																				-- neither of these work; don't know why; it seems that substitute() isn't being called	
		AccessDate = substitute (cfg.presentation['accessdate'], {sepc, AccessDate});	-- allow editors to hide accessdates
	end
	
	if is_set(ID) then ID = sepc .." ".. ID; end
   	if "thesis" == config.CitationClass and is_set(Docket) then
		ID = sepc .." Docket ".. Docket .. ID;
	end
   	if "report" == config.CitationClass and is_set(Docket) then					-- for cite report when |docket= is set
		ID = sepc .. ' ' .. Docket;												-- overwrite ID even if |id= is set
	end

	ID_list = build_id_list( ID_list, {IdAccessLevels=ID_access_levels, DoiBroken = DoiBroken, ASINTLD = ASINTLD, IgnoreISBN = IgnoreISBN, Embargo=Embargo, Class = Class} );

	if is_set(URL) then
		URL = " " .. external_link( URL, nil, URLorigin );
	end

	if is_set(Quote) then
		if Quote:sub(1,1) == '"' and Quote:sub(-1,-1) == '"' then				-- if first and last characters of quote are quote marks
			Quote = Quote:sub(2,-2);											-- strip them off
		end
		Quote = sepc .." " .. wrap_style ('quoted-text', Quote ); 				-- wrap in <q>...</q> tags
		PostScript = "";														-- cs1|2 does not supply terminal punctuation when |quote= is set
	end
	
	local Archived
	if is_set(ArchiveURL) then
		if not is_set(ArchiveDate) then
			ArchiveDate = set_error('archive_missing_date');
		end
		if in_array (DeadURL, {'no', 'live'}) then
			local arch_text = cfg.messages['archived'];
			if sepc ~= "." then arch_text = arch_text:lower() end
			Archived = sepc .. " " .. substitute( cfg.messages['archived-not-dead'],
				{ external_link( ArchiveURL, arch_text, A:ORIGIN('ArchiveURL') ) .. ArchiveFormat, ArchiveDate } );
			if not is_set(OriginalURL) then
				Archived = Archived .. " " .. set_error('archive_missing_url');							   
			end
		elseif is_set(OriginalURL) then											-- DeadURL is empty, 'yes', 'true', 'y', 'dead', 'unfit' or 'usurped'
			local arch_text = cfg.messages['archived-dead'];
			if sepc ~= "." then arch_text = arch_text:lower() end
			if in_array (DeadURL, {'unfit', 'usurped'}) then
				Archived = sepc .. " " .. '原始内容存档于' .. ArchiveDate;	-- format already styled
			else																-- DeadURL is empty, 'yes', 'true', 'y' or 'dead'
				Archived = sepc .. " " .. substitute( arch_text,
					{ external_link( OriginalURL, cfg.messages['original'], OriginalURLorigin ) .. OriginalFormat, ArchiveDate } );	-- format already styled
			end	
		else
			local arch_text = cfg.messages['archived-missing'];
			if sepc ~= "." then arch_text = arch_text:lower() end
			Archived = sepc .. " " .. substitute( arch_text, 
				{ set_error('archive_missing_url'), ArchiveDate } );
		end
	elseif is_set (ArchiveFormat) then
		Archived = ArchiveFormat;												-- if set and ArchiveURL not set ArchiveFormat has error message
	else
		Archived = ""
	end
	
	local Lay = '';
	if is_set(LayURL) then
		if is_set(LayDate) then LayDate = " (" .. LayDate .. ")" end
		if is_set(LaySource) then 
			LaySource = " &ndash; ''" .. safe_for_italics(LaySource) .. "''";
		else
			LaySource = "";
		end
		if sepc == '.' then
			Lay = sepc .. " " .. external_link( LayURL, cfg.messages['lay summary'], A:ORIGIN('LayURL') ) .. LayFormat .. LaySource .. LayDate
		else
			Lay = sepc .. " " .. external_link( LayURL, cfg.messages['lay summary']:lower(), A:ORIGIN('LayURL') ) .. LayFormat .. LaySource .. LayDate
		end			
	elseif is_set (LayFormat) then												-- Test if |lay-format= is given without giving a |lay-url=
		Lay = sepc .. LayFormat;												-- if set and LayURL not set, then LayFormat has error message
	end

	if is_set(Transcript) then
		if is_set(TranscriptURL) then
			Transcript = external_link( TranscriptURL, Transcript, TranscriptURLorigin );
		end
		Transcript = sepc .. ' ' .. Transcript .. TranscriptFormat;
	elseif is_set(TranscriptURL) then
		Transcript = external_link( TranscriptURL, nil, TranscriptURLorigin );
	end

	local Publisher;
	if is_set(Periodical) and
		not in_array(config.CitationClass, {"encyclopaedia","web","pressrelease","podcast"}) then
		if is_set(PublisherName) then
			if is_set(PublicationPlace) then
				Publisher = PublicationPlace .. ": " .. PublisherName;
			else
				Publisher = PublisherName;  
			end
		elseif is_set(PublicationPlace) then
			Publisher= PublicationPlace;
		else 
			Publisher = "";
		end
		if is_set(Publisher) then
			Publisher = " (" .. Publisher .. ")";
		end
	else
		if is_set(PublisherName) then
			if is_set(PublicationPlace) then
				Publisher = sepc .. " " .. PublicationPlace .. ": " .. PublisherName;
			else
				Publisher = sepc .. " " .. PublisherName;  
			end			
		elseif is_set(PublicationPlace) then 
			Publisher= sepc .. " " .. PublicationPlace;
		else 
			Publisher = '';
		end
	end
	
	-- Several of the above rely upon detecting this as nil, so do it last.
	if is_set(Periodical) then
		if is_set(Title) or is_set(TitleNote) then 
			Periodical = sepc .. " " .. wrap_style ('italic-title', Periodical) 
		else 
			Periodical = wrap_style ('italic-title', Periodical)
		end
	end

--[[
Handle the oddity that is cite speech.  This code overrides whatever may be the value assigned to TitleNote (through |department=) and forces it to be " (Speech)" so that
the annotation directly follows the |title= parameter value in the citation rather than the |event= parameter value (if provided).
]]
	if "speech" == config.CitationClass then				-- cite speech only
		TitleNote = " (Speech)";							-- annotate the citation
		if is_set (Periodical) then							-- if Periodical, perhaps because of an included |website= or |journal= parameter 
			if is_set (Conference) then						-- and if |event= is set
				Conference = Conference .. sepc .. " ";		-- then add appropriate punctuation to the end of the Conference variable before rendering
			end
		end
	end

	-- Piece all bits together at last.  Here, all should be non-nil.
	-- We build things this way because it is more efficient in LUA
	-- not to keep reassigning to the same string variable over and over.

	local tcommon;
	local tcommon2;																-- used for book cite when |contributor= is set
	
	if in_array(config.CitationClass, {"journal","citation"}) and is_set(Periodical) then
		if is_set(Others) then Others = Others .. sepc .. " " end
		tcommon = safe_join( {Others, Title, TitleNote, Conference, Periodical, Format, TitleType, Series, 
			Edition, Publisher, Agency}, sepc );
		
	elseif in_array(config.CitationClass, {"book","citation"}) and not is_set(Periodical) then		-- special cases for book cites
		if is_set (Contributors) then											-- when we are citing foreword, preface, introduction, etc
			tcommon = safe_join( {Title, TitleNote}, sepc );					-- author and other stuff will come after this and before tcommon2
			tcommon2 = safe_join( {Conference, Periodical, Format, TitleType, Series, Volume, Others, Edition, Publisher, Agency}, sepc );
		else
			tcommon = safe_join( {Title, TitleNote, Conference, Periodical, Format, TitleType, Series, Volume, Others, Edition, Publisher, Agency}, sepc );
		end

	elseif 'map' == config.CitationClass then									-- special cases for cite map
		if is_set (Chapter) then												-- map in a book; TitleType is part of Chapter
			tcommon = safe_join( {Title, Format, Edition, Scale, Series, Cartography, Others, Publisher, Volume}, sepc );
		elseif is_set (Periodical) then											-- map in a periodical
			tcommon = safe_join( {Title, TitleType, Format, Periodical, Scale, Series, Cartography, Others, Publisher, Volume}, sepc );
		else																	-- a sheet or stand-alone map
			tcommon = safe_join( {Title, TitleType, Format, Edition, Scale, Series, Cartography, Others, Publisher}, sepc );
		end
		
	elseif 'episode' == config.CitationClass then								-- special case for cite episode
		tcommon = safe_join( {Title, TitleNote, TitleType, Series, Transcript, Edition, Publisher}, sepc );
	else																		-- all other CS1 templates
		tcommon = safe_join( {Title, TitleNote, Conference, Periodical, Format, TitleType, Series, 
			Volume, Others, Edition, Publisher, Agency}, sepc );
	end
	
	if #ID_list > 0 then
		ID_list = safe_join( { sepc .. " ",  table.concat( ID_list, sepc .. " " ), ID }, sepc );
	else
		ID_list = ID;
	end
	
	-- LOCAL
	local xDate = Date
	local pgtext = Position .. Sheet .. Sheets .. Page .. Pages .. At;
	if ( is_set(Periodical) and Date ~= '' and
		not in_array(config.CitationClass, {"encyclopaedia","web"}) )
		or ( in_array(config.CitationClass, {"book","news"}) ) then
		if in_array(config.CitationClass, {"journal","citation"}) and ( Volume ~= '' or Issue ~= '' ) then
			xDate = xDate .. ',' .. Volume
		end
		xDate = xDate .. pgtext
		pgtext = ''
	end
	if PublicationDate and PublicationDate ~= '' then
		xDate = xDate .. ' (' .. PublicationDate .. ')'
	end
	if OrigYear ~= '' then
		xDate = xDate .. OrigYear
	end
	if AccessDate ~= '' then
		xDate = xDate .. ' ' .. AccessDate
	end
	if xDate ~= '' then
		xDate = sepc .. ' ' .. xDate
	end
	-- END LOCAL
	
	local idcommon = safe_join( { URL, xDate, ID_list, Archived, Via, SubscriptionRequired, Lay, Language, Quote }, sepc );
	local text;

	if is_set(Authors) then
		if is_set(Coauthors) then
			if 'vanc' == NameListFormat then									-- separate authors and coauthors with proper name-list-separator
				Authors = Authors .. ', ' .. Coauthors;
			else
				Authors = Authors .. '; ' .. Coauthors;
			end
		end
		Authors = terminate_name_list (Authors, sepc);						-- when no date, terminate with 0 or 1 sepc and a space
		if is_set(Editors) then
			local in_text = " ";
			local post_text = "";
			if is_set(Chapter) and 0 == #c then
				in_text = in_text .. " " .. cfg.messages['in']
				if (sepc ~= '.') then in_text = in_text:lower() end				-- lowercase for cs2
			else
				if EditorCount <= 1 then
					post_text = ", " .. cfg.messages['editor'];
				else
					post_text = ", " .. cfg.messages['editors'];
				end
			end 
			Editors = terminate_name_list (Editors .. in_text .. post_text, sepc);	-- terminate with 0 or 1 sepc and a space
		end
		if is_set (Contributors) then											-- book cite and we're citing the intro, preface, etc
			local by_text = sepc .. ' ' .. cfg.messages['by'] .. ' ';
			if (sepc ~= '.') then by_text = by_text:lower() end					-- lowercase for cs2
			Authors = by_text .. Authors;										-- author follows title so tweak it here
			if is_set (Editors) then											-- when Editors make sure that Authors gets terminated
				Authors = terminate_name_list (Authors, sepc);					-- terminate with 0 or 1 sepc and a space
			end
			Contributors = terminate_name_list (Contributors, sepc);		-- terminate with 0 or 1 sepc and a space
			text = safe_join( {Contributors, Chapter, tcommon, Authors, Place, Editors, tcommon2, pgtext, idcommon }, sepc );
		else
			text = safe_join( {Authors, Chapter, Place, Editors, tcommon, pgtext, idcommon }, sepc );
		end
	elseif is_set(Editors) then
		if EditorCount <= 1 then
			Editors = Editors .. " (" .. cfg.messages['editor'] .. ")" .. sepc .. " "
		else
			Editors = Editors .. " (" .. cfg.messages['editors'] .. ")" .. sepc .. " "
		end
		text = safe_join( {Editors, Chapter, Place, tcommon, pgtext, idcommon}, sepc );
	else
		if config.CitationClass=="journal" and is_set(Periodical) then
			text = safe_join( {Chapter, Place, tcommon, pgtext, idcommon}, sepc );
		else
			text = safe_join( {Chapter, Place, tcommon, pgtext, idcommon}, sepc );
		end
	end
	
	if is_set(PostScript) and PostScript ~= sepc then
		text = safe_join( {text, sepc}, sepc );  --Deals with italics, spaces, etc.
		text = text:sub(1,-sepc:len()-1);
	end	
	
	text = safe_join( {text, PostScript}, sepc );

	-- Now enclose the whole thing in a <cite/> element
	local options = {};
	
	if is_set(config.CitationClass) and config.CitationClass ~= "citation" then
		options.class = config.CitationClass;
		options.class = "citation " .. config.CitationClass;					-- class=citation required for blue highlight when used with |ref=
	else
		options.class = "citation";
	end
	
	if is_set(Ref) and Ref:lower() ~= "none" then								-- set reference anchor if appropriate
		local id = Ref
		if ('harv' == Ref ) then
			local namelist = {};												-- holds selected contributor, author, editor name list
--			local year = first_set (Year, anchor_year);							-- Year first for legacy citations and for YMD dates that require disambiguation
			local year = first_set ({Year, anchor_year}, 2);					-- Year first for legacy citations and for YMD dates that require disambiguation

			if #c > 0 then														-- if there is a contributor list
				namelist = c;													-- select it
			elseif #a > 0 then													-- or an author list
				namelist = a;
			elseif #e > 0 then													-- or an editor list
				namelist = e;
			end
			id = anchor_id (namelist, year);									-- go make the CITEREF anchor
		end
		options.id = id;
	end
	
	if string.len(text:gsub("<span[^>/]*>.-</span>", ""):gsub("%b<>","")) <= 2 then
		z.error_categories = {};
		text = set_error('empty_citation');
		z.message_tail = {};
	end
	
	if is_set(options.id) then 
		text = '<cite id="' .. mw.uri.anchorEncode(options.id) ..'" class="' .. mw.text.nowiki(options.class) .. '">' .. text .. "</cite>";
	else
		text = '<cite class="' .. mw.text.nowiki(options.class) .. '">' .. text .. "</cite>";
	end		

	local empty_span = '<span style="display:none;">&nbsp;</span>';
	
	-- Note: Using display: none on the COinS span breaks some clients.
	local OCinS = '<span title="' .. OCinSoutput .. '" class="Z3988">' .. empty_span .. '</span>';
	text = text .. OCinS;
	
	if #z.message_tail ~= 0 then
		text = text .. " ";
		for i,v in ipairs( z.message_tail ) do
			if is_set(v[1]) then
				if i == #z.message_tail then
					text = text .. error_comment( v[1], v[2] );
				else
					text = text .. error_comment( v[1] .. "; ", v[2] );
				end
			end
		end
	end

	if #z.maintenance_cats ~= 0 then
		text = text .. '<span class="citation-comment" style="display:none; color:#33aa33">';
		for _, v in ipairs( z.maintenance_cats ) do								-- append maintenance categories
			text = text .. ' ' .. v .. ' ([[:Category:' .. v ..'|link]])';
		end
		text = text .. '</span>';	-- maintenance mesages (realy just the names of the categories for now)
	end
	
	no_tracking_cats = no_tracking_cats:lower();
	if in_array(no_tracking_cats, {"", "no", "false", "n"}) then
		for _, v in ipairs( z.error_categories ) do
			text = text .. '[[Category:' .. v ..']]';
		end
		for _, v in ipairs( z.maintenance_cats ) do								-- append maintenance categories
			text = text .. '[[Category:' .. v ..']]';
		end
		for _, v in ipairs( z.properties_cats ) do								-- append maintenance categories
			text = text .. '[[Category:' .. v ..']]';
		end
	end
	
	return text
end

--[[--------------------------< H A S _ I N V I S I B L E _ C H A R S >----------------------------------------

This function searches a parameter's value for nonprintable or invisible characters.  The search stops at the first match.

Sometime after this module is done with rendering a citation, some C0 control characters are replaced with the
replacement character.  That replacement character is not detected by this test though it is visible to readers
of the rendered citation.  This function will detect the replacement character when it is part of the wikisource.

Output of this function is an error message that identifies the character or the Unicode group that the character
belongs to along with its position in the parameter value.

]]
--[[
local function has_invisible_chars (param, v)
	local position = '';
	local i=1;

	while cfg.invisible_chars[i] do
		local char=cfg.invisible_chars[i][1]									-- the character or group name
		local pattern=cfg.invisible_chars[i][2]									-- the pattern used to find it
		v = mw.text.unstripNoWiki( v );											-- remove nowiki stripmarkers
		position = mw.ustring.find (v, pattern)									-- see if the parameter value contains characters that match the pattern
		if position then
			table.insert( z.message_tail, { set_error( 'invisible_char', {char, wrap_style ('parameter', param), position}, true ) } );	-- add error message
			return;																-- and done with this parameter
		end
		i=i+1;																	-- bump our index
	end
end
]]

--[[--------------------------< Z . C I T A T I O N >----------------------------------------------------------

This is used by templates such as {{cite book}} to create the actual citation text.

]]

function citation(frame)
	local pframe = frame:getParent()
	local validation, identifiers, utilities;
	
	if nil ~= string.find (frame:getTitle(), 'sandbox', 1, true) then			-- did the {{#invoke:}} use sandbox version?
		cfg = mw.loadData ('Module:Citation/CS1/Configuration/sandbox');		-- load sandbox versions of Configuration and Whitelist and ...
		whitelist = mw.loadData ('Module:Citation/CS1/Whitelist/sandbox');
		validation = require ('Module:Citation/CS1/Date_validation/sandbox');	-- ... sandbox version of date validation code
		identifiers = require ('Module:Citation/CS1/Identifiers/sandbox');
		utilities = require ('Module:Citation/CS1/Utilities/sandbox');

	else																		-- otherwise
		cfg = mw.loadData ('Module:Citation/CS1/Configuration');				-- load live versions of Configuration and Whitelist and ...
		whitelist = mw.loadData ('Module:Citation/CS1/Whitelist');
		validation = require ('Module:Citation/CS1/Date_validation');			-- ... live version of date validation code
		identifiers = require ('Module:Citation/CS1/Identifiers');
		utilities = require ('Module:Citation/CS1/Utilities');
	end
	
	utilities.set_selected_modules (cfg);
	identifiers.set_selected_modules (cfg,utilities,validation);

	dates = validation.dates;													-- imported functions
	year_date_check = validation.year_date_check;

	z = utilities.z;
	is_set = utilities.is_set;
	first_set = utilities.first_set;
	is_url = utilities.is_url;
	split_url = utilities.split_url;
	add_maint_cat = utilities.add_maint_cat;
	add_prop_cat = utilities.add_prop_cat;
	error_comment = utilities.error_comment;
	in_array = utilities.in_array;
	substitute = utilities.substitute;
	set_error = utilities.set_error;
	
	extract_ids = identifiers.extract_ids;
	build_id_list = identifiers.build_id_list;
	is_embargoed = identifiers.is_embargoed;
	extract_id_access_levels = identifiers.extract_id_access_levels;
	
	local args = {};
	local suggestions = {};
	local error_text, error_state;

	local config = {};
	for k, v in pairs( frame.args ) do
		config[k] = v;
		args[k] = v;	   
	end	

	local capture;																-- the single supported capture when matching unknown parameters using patterns
	for k, v in pairs( pframe.args ) do
		if v ~= '' then
			if not validate( k ) then			
				error_text = "";
				if type( k ) ~= 'string' then
					-- Exclude empty numbered parameters
					if v:match("%S+") ~= nil then
						error_text, error_state = set_error( 'text_ignored', {v}, true );
					end
				elseif validate( k:lower() ) then 
					error_text, error_state = set_error( 'parameter_ignored_suggest', {k, k:lower()}, true );
				else
					if nil == suggestions.suggestions then						-- if this table is nil then we need to load it
						if nil ~= string.find (frame:getTitle(), 'sandbox', 1, true) then			-- did the {{#invoke:}} use sandbox version?
							suggestions = mw.loadData( 'Module:Citation/CS1/Suggestions/sandbox' );	-- use the sandbox version
						else
							suggestions = mw.loadData( 'Module:Citation/CS1/Suggestions' );			-- use the live version
						end
					end
					for pattern, param in pairs (suggestions.patterns) do		-- loop through the patterns to see if we can suggest a proper parameter
						capture = k:match (pattern);							-- the whole match if no caputre in pattern else the capture if a match
						if capture then											-- if the pattern matches 
							param = substitute( param, capture );				-- add the capture to the suggested parameter (typically the enumerator)
							error_text, error_state = set_error( 'parameter_ignored_suggest', {k, param}, true );	-- set the error message
						end
					end
					if not is_set (error_text) then								-- couldn't match with a pattern, is there an expicit suggestion?
						if suggestions.suggestions[ k:lower() ] ~= nil then
							error_text, error_state = set_error( 'parameter_ignored_suggest', {k, suggestions.suggestions[ k:lower() ]}, true );
						else
							error_text, error_state = set_error( 'parameter_ignored', {k}, true );
						end
					end
				end				  
				if error_text ~= '' then
					table.insert( z.message_tail, {error_text, error_state} );
				end				
			end
			args[k] = v;
		elseif args[k] ~= nil or (k == 'postscript') then
			args[k] = v;
		end		
	end	

	for k, v in pairs( args ) do
		if 'string' == type (k) then											-- don't evaluate positional parameters
			has_invisible_chars (k, v);
		end
	end
	return citation0( config, args)
end
--[[--------------------------< E X P O R T E D   F U N C T I O N S >------------------------------------------
]]

return {citation = citation};