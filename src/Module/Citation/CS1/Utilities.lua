local z = {
	error_categories = {};														-- for categorizing citations that contain errors
	error_ids = {};
	message_tail = {};
	maintenance_cats = {};														-- for categorizing citations that aren't erroneous per se, but could use a little work
	properties_cats = {};														-- for categorizing citations based on certain properties, language of source for instance
};


--[[--------------------------< F O R W A R D   D E C L A R A T I O N S >--------------------------------------
]]

local cfg;																		-- table of tables imported from selected Module:Citation/CS1/Configuration

--[[--------------------------< I S _ S E T >------------------------------------------------------------------

Returns true if argument is set; false otherwise. Argument is 'set' when it exists (not nil) or when it is not an empty string.
This function is global because it is called from both this module and from Date validation

]]
function is_set( var )
	return not (var == nil or var == '');
end

--[[--------------------------< F I R S T _ S E T >------------------------------------------------------------

Locates and returns the first set value in a table of values where the order established in the table,
left-to-right (or top-to-bottom), is the order in which the values are evaluated.  Returns nil if none are set.

This version replaces the original 'for _, val in pairs do' and a similar version that used ipairs.  With the pairs
version the order of evaluation could not be guaranteed.  With the ipairs version, a nil value would terminate
the for-loop before it reached the actual end of the list.

]]

local function first_set (list, count)
	local i = 1;
	while i <= count do															-- loop through all items in list
		if is_set( list[i] ) then
			return list[i];														-- return the first set list member
		end
		i = i + 1;																-- point to next
	end
end

--[[--------------------------< I S _ S C H E M E >------------------------------------------------------------

does this thing that purports to be a uri scheme seem to be a valid scheme?  The scheme is checked to see if it
is in agreement with http://tools.ietf.org/html/std66#section-3.1 which says:
	Scheme names consist of a sequence of characters beginning with a
   letter and followed by any combination of letters, digits, plus
   ("+"), period ("."), or hyphen ("-").

returns true if it does, else false

]]

local function is_scheme (scheme)
	return scheme and scheme:match ('^%a[%a%d%+%.%-]*:');						-- true if scheme is set and matches the pattern
end


--[=[-------------------------< I S _ D O M A I N _ N A M E >--------------------------------------------------

Does this thing that purports to be a domain name seem to be a valid domain name?

Syntax defined here: http://tools.ietf.org/html/rfc1034#section-3.5
BNF defined here: https://tools.ietf.org/html/rfc4234
Single character names are generally reserved; see https://tools.ietf.org/html/draft-ietf-dnsind-iana-dns-01#page-15;
	see also [[Single-letter second-level domain]]
list of tlds: https://www.iana.org/domains/root/db

rfc952 (modified by rfc 1123) requires the first and last character of a hostname to be a letter or a digit.  Between
the first and last characters the name may use letters, digits, and the hyphen.

Also allowed are IPv4 addresses. IPv6 not supported

domain is expected to be stripped of any path so that the last character in the last character of the tld.  tld
is two or more alpha characters.  Any preceding '//' (from splitting a url with a scheme) will be stripped
here.  Perhaps not necessary but retained incase it is necessary for IPv4 dot decimal.

There are several tests:
	the first character of the whole domain name including subdomains must be a letter or a digit
	single-letter/digit second-level domains in the .org TLD
	q, x, and z SL domains in the .com TLD
	i and q SL domains in the .net TLD
	single-letter SL domains in the ccTLDs (where the ccTLD is two letters)
	two-character SL domains in gTLDs (where the gTLD is two or more letters)
	three-plus-character SL domains in gTLDs (where the gTLD is two or more letters)
	IPv4 dot-decimal address format; TLD not allowed

returns true if domain appears to be a proper name and tld or IPv4 address, else false

]=]

local function is_domain_name (domain)
	if not domain then
		return false;															-- if not set, abandon
	end
	
	domain = domain:gsub ('^//', '');											-- strip '//' from domain name if present; done here so we only have to do it once
	
	if not domain:match ('^[%a%d]') then										-- first character must be letter or digit
		return false;
	end
	
	if domain:match ('%f[%a%d][%a%d]%.org$') then								-- one character .org hostname
		return true;
	elseif domain:match ('%f[%a][qxz]%.com$') then								-- assigned one character .com hostname (x.com times out 2015-12-10)
		return true;
	elseif domain:match ('%f[%a][iq]%.net$') then								-- assigned one character .net hostname (q.net registered but not active 2015-12-10)
		return true;
	elseif domain:match ('%f[%a%d][%a%d][%a%d%-]+[%a%d]%.xn%-%-[%a%d]+$') then	-- internationalized domain name with ACE prefix
		return true;
	elseif domain:match ('%f[%a%d][%a%d]%.cash$') then							-- one character/digit .cash hostname
		return true;
	elseif domain:match ('%f[%a%d][%a%d]%.%a%a$') then							-- one character hostname and cctld (2 chars)
		return true;
	elseif domain:match ('%f[%a%d][%a%d][%a%d]%.%a%a+$') then					-- two character hostname and tld
		return true;
	elseif domain:match ('%f[%a%d][%a%d][%a%d%-]+[%a%d]%.%a%a+$') then			-- three or more character hostname.hostname or hostname.tld
		return true;
	elseif domain:match ('^%d%d?%d?%.%d%d?%d?%.%d%d?%d?%.%d%d?%d?') then		-- IPv4 address
		return true;
	else
		return false;
	end
end


--[[--------------------------< I S _ U R L >------------------------------------------------------------------

returns true if the scheme and domain parts of a url appear to be a valid url; else false.

This function is the last step in the validation process.  This function is separate because there are cases that
are not covered by split_url(), for example is_parameter_ext_wikilink() which is looking for bracketted external
wikilinks.

]]

local function is_url (scheme, domain)
	if is_set (scheme) then														-- if scheme is set check it and domain
		return is_scheme (scheme) and is_domain_name (domain);
	else
		return is_domain_name (domain);											-- scheme not set when url is protocol relative
	end
end


--[[--------------------------< S P L I T _ U R L >------------------------------------------------------------

Split a url into a scheme, authority indicator, and domain.
If protocol relative url, return nil scheme and domain else return nil for both scheme and domain.

When not protocol relative, get scheme, authority indicator, and domain.  If there is an authority indicator (one
or more '/' characters following the scheme's colon), make sure that there are only 2.

]]

local function split_url (url_str)
	local scheme, authority, domain;
	
	url_str = url_str:gsub ('([%a%d])%.?[/%?#].*$', '%1');						-- strip FQDN terminator and path(/), query(?), fragment (#) (the capture prevents false replacement of '//')

	if url_str:match ('^//%S*') then											-- if there is what appears to be a protocol relative url
		domain = url_str:match ('^//(%S*)')
	elseif url_str:match ('%S-:/*%S+') then										-- if there is what appears to be a scheme, optional authority indicator, and domain name
		scheme, authority, domain = url_str:match ('(%S-:)(/*)(%S+)');			-- extract the scheme, authority indicator, and domain portions
		authority = authority:gsub ('//', '', 1);								-- replace place 1 pair of '/' with nothing;
		if is_set(authority) then												-- if anything left (1 or 3+ '/' where authority should be) then
			return scheme;														-- return scheme only making domain nil which will cause an error message
		end
		domain = domain:gsub ('(%a):%d+', '%1');								-- strip port number if present
	end
	
	return scheme, domain;
end


--[[--------------------------< I N _ A R R A Y >--------------------------------------------------------------

Whether needle is in haystack

]]

local function in_array( needle, haystack )
	if needle == nil then
		return false;
	end
	for n,v in ipairs( haystack ) do
		if v == needle then
			return n;
		end
	end
	return false;
end

--[[--------------------------< S U B S T I T U T E >----------------------------------------------------------

Populates numbered arguments in a message string using an argument table.

]]

local function substitute( msg, args )
	return args and mw.message.newRawMessage( msg, args ):plain() or msg;
end

--[[--------------------------< E R R O R _ C O M M E N T >----------------------------------------------------

Wraps error messages with css markup according to the state of hidden.

]]
local function error_comment( content, hidden )
	return substitute( hidden and cfg.presentation['hidden-error'] or cfg.presentation['visible-error'], content );
end

--[[--------------------------< S E T _ E R R O R >--------------------------------------------------------------

Sets an error condition and returns the appropriate error message.  The actual placement of the error message in the output is
the responsibility of the calling function.

]]
local function set_error( error_id, arguments, raw, prefix, suffix )
	local error_state = cfg.error_conditions[ error_id ];
	
	prefix = prefix or "";
	suffix = suffix or "";
	
	if error_state == nil then
		error( cfg.messages['undefined_error'] );
	elseif is_set( error_state.category ) then
		table.insert( z.error_categories, error_state.category );
	end
	
	local message = substitute( error_state.message, arguments );
	
	message = message .. " ([[" .. cfg.messages['help page link'] .. 
		"#" .. error_state.anchor .. "|" ..
		cfg.messages['help page label'] .. "]])";
	
	z.error_ids[ error_id ] = true;
	if in_array( error_id, { 'bare_url_missing_title', 'trans_missing_title' } )
			and z.error_ids['citation_missing_title'] then
		return '', false;
	end
	
	message = table.concat({ prefix, message, suffix });
	
	if raw == true then
		return message, error_state.hidden;
	end		
		
	return error_comment( message, error_state.hidden );
end


--[[--------------------------< H A S _ A C C E P T _ A S _ W R I T T E N >------------------------------------

When <str> is wholly wrapped in accept-as-written markup, return <str> without markup and true; return <str> and false else

with allow_empty = false, <str> must have at least one character inside the markup
with allow_empty = true, <str> the markup frame can be empty like (()) to distinguish an empty template parameter from the specific condition "has no applicable value" in citation-context.

After further evaluation the two cases might be merged at a later stage, but should be kept separated for now.

]]

local function has_accept_as_written (str, allow_empty)
	local count;
	if true == allow_empty then
		str, count = str:gsub ('^%(%((.*)%)%)$', '%1'); 						-- allows (()) to be an empty set
	else
		str, count = str:gsub ('^%(%((.+)%)%)$', '%1');
	end
	return str, 0 ~= count;
end


--[[--------------------------< I S _ S E T >------------------------------------------------------------------

Returns true if argument is set; false otherwise. Argument is 'set' when it exists (not nil) or when it is not an empty string.

]]

local function is_set (var)
	return not (var == nil or var == '');
end


--[[--------------------------< S U B S T I T U T E >----------------------------------------------------------

Populates numbered arguments in a message string using an argument table.

]]

local function substitute (msg, args)
	return args and mw.message.newRawMessage (msg, args):plain() or msg;
end


--[[--------------------------< E R R O R _ C O M M E N T >----------------------------------------------------

Wraps error messages with CSS markup according to the state of hidden.

]]

local function error_comment (content, hidden)
	return substitute (hidden and cfg.presentation['hidden-error'] or cfg.presentation['visible-error'], content);
end


--[=[-------------------------< M A K E _ W I K I L I N K >----------------------------------------------------

Makes a wikilink; when both link and display text is provided, returns a wikilink in the form [[L|D]]; if only
link is provided (or link and display are the same), returns a wikilink in the form [[L]]; if neither are
provided or link is omitted, returns an empty string.

]=]

local function make_wikilink (link, display)
	if not is_set (link) then return '' end

	if is_set (display) and link ~= display then			
		return table.concat ({'[[', link, '|', display, ']]'});			
	else
		return table.concat ({'[[', link, ']]'});
	end
end


--[[--------------------------< S E T _ M E S S A G E >----------------------------------------------------------

Sets an error condition and returns the appropriate error message.  The actual placement of the error message in the output is
the responsibility of the calling function.

TODO: change z.error_categories and z.maintenance_cats to have the form cat_name = true; to avoid dups without having to have an extra cat

]]
local added_maint_cats = {}														-- list of maintenance categories that have been added to z.maintenance_cats; TODO: figure out how to delete this table

local function set_message (error_id, arguments, raw, prefix, suffix)
	local error_state = cfg.error_conditions[error_id];
	
	prefix = prefix or '';
	suffix = suffix or '';
	
	if error_state == nil then
		error (cfg.messages['undefined_error'] .. ': ' .. error_id);			-- because missing error handler in Module:Citation/CS1/Configuration

	elseif is_set (error_state.category) then
		if error_state.message then												-- when error_state.message defined, this is an error message
			table.insert (z.error_categories, error_state.category);
		else
			if not added_maint_cats[error_id] then
				added_maint_cats[error_id] = true;								-- note that we've added this category
				table.insert (z.maintenance_cats, substitute (error_state.category, arguments));	-- make cat name then add to table
			end
			return;																-- because no message, nothing more to do
		end
	end

	local message = substitute (error_state.message, arguments);

	message = table.concat (
		{
		message,
		' (',
		make_wikilink (
			table.concat (
				{
				cfg.messages['help page link'],
				'#',
				error_state.anchor
				}),
			cfg.messages['help page label']),
		')'
		});

	z.error_ids[error_id] = true;
	if z.error_ids['err_citation_missing_title'] and							-- if missing-title error already noted
		in_array (error_id, {'err_bare_url_missing_title', 'err_trans_missing_title'}) then		-- and this error is one of these
			return '', false;													-- don't bother because one flavor of missing title is sufficient
	end
	
	message = table.concat ({prefix, message, suffix});

	if raw == true then
		return message, error_state.hidden;
	end		

	return error_comment (message, error_state.hidden);
end


--[[-------------------------< I S _ A L I A S _ U S E D >-----------------------------------------------------

This function is used by select_one() to determine if one of a list of alias parameters is in the argument list
provided by the template.

Input:
	args – pointer to the arguments table from calling template
	alias – one of the list of possible aliases in the aliases lists from Module:Citation/CS1/Configuration
	index – for enumerated parameters, identifies which one
	enumerated – true/false flag used to choose how enumerated aliases are examined
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

	if is_set (args[alias]) then													-- alias is in the template's argument list
		if value ~= nil and selected ~= alias then								-- if we have already selected one of the aliases
			local skip;
			for _, v in ipairs (error_list) do									-- spin through the error list to see if we've added this alias
				if v == alias then
					skip = true;
					break;														-- has been added so stop looking 
				end
			end
			if not skip then													-- has not been added so
				table.insert (error_list, alias);								-- add error alias to the error list
			end
		else
			value = args[alias];												-- not yet selected an alias, so select this one
			selected = alias;
		end
	end
	return value, selected;														-- return newly selected alias, or previously selected alias
end


--[[--------------------------< A D D _ M A I N T _ C A T >------------------------------------------------------

Adds a category to z.maintenance_cats using names from the configuration file with additional text if any.
To prevent duplication, the added_maint_cats table lists the categories by key that have been added to z.maintenance_cats.

]]

local function add_maint_cat (key, arguments)
	if not added_maint_cats [key] then
		added_maint_cats [key] = true;											-- note that we've added this category
		table.insert( z.maintenance_cats, substitute (cfg.maint_cats [key], arguments));	-- make name then add to table
	end
end

--[[--------------------------< A D D _ P R O P _ C A T >--------------------------------------------------------

Adds a category to z.properties_cats using names from the configuration file with additional text if any.

]]

local added_prop_cats = {}														-- list of property categories that have been added to z.properties_cats
local function add_prop_cat (key, arguments)
	if not added_prop_cats [key] then
		added_prop_cats [key] = true;											-- note that we've added this category
		table.insert( z.properties_cats, substitute (cfg.prop_cats [key], arguments));		-- make name then add to table
	end
end


--[[--------------------------< S A F E _ F O R _ I T A L I C S >----------------------------------------------

Protects a string that will be wrapped in wiki italic markup '' ... ''

Note: We cannot use <i> for italics, as the expected behavior for italics specified by ''...'' in the title is that
they will be inverted (i.e. unitalicized) in the resulting references.  In addition, <i> and '' tend to interact
poorly under Mediawiki's HTML tidy.

]]

local function safe_for_italics (str)
	if not is_set (str) then return str end

	if str:sub (1, 1) == "'" then str = "<span></span>" .. str; end
	if str:sub (-1, -1) == "'" then str = str .. "<span></span>"; end
	
	-- Remove newlines as they break italics.
	return str:gsub ('\n', ' ');

end


--[[--------------------------< W R A P _ S T Y L E >----------------------------------------------------------

Applies styling to various parameters.  Supplied string is wrapped using a message_list configuration taking one
argument; protects italic styled parameters.  Additional text taken from citation_config.presentation - the reason
this function is similar to but separate from wrap_msg().

]]

local function wrap_style (key, str)
	if not is_set (str) then
		return "";
	elseif in_array (key, {'italic-title', 'trans-italic-title'}) then
		str = safe_for_italics (str);
	end

	return substitute (cfg.presentation[key], {str});
end


--[[--------------------------< M A K E _ S E P _ L I S T >------------------------------------------------------------

make a separated list of items using provided separators.
	<sep_list> - typically '<comma><space>'
	<sep_list_pair> - typically '<space>and<space>'
	<sep_list_end> - typically '<comma><space>and<space>' or '<comma><space>&<space>'

defaults to cfg.presentation['sep_list'], cfg.presentation['sep_list_pair'], and cfg.presentation['sep_list_end']
if <sep_list_end> is specified, <sep_list> and <sep_list_pair> must also be supplied

]]

local function make_sep_list (count, list_seq, sep_list, sep_list_pair, sep_list_end)
	local list = '';

	if not sep_list then														-- set the defaults
		sep_list = cfg.presentation['sep_list'];
		sep_list_pair = cfg.presentation['sep_list_pair'];
		sep_list_end = cfg.presentation['sep_list_end'];
	end
	
	if 2 >= count then
		list = table.concat (list_seq, sep_list_pair);							-- insert separator between two items; returns list_seq[1] then only one item
	elseif 2 < count then
		list = table.concat (list_seq, sep_list, 1, count - 1);					-- concatenate all but last item with plain list separator
		list = table.concat ({list, list_seq[count]}, sep_list_end);			-- concatenate last item onto end of <list> with final separator
	end
	
	return list;
end


--[[--------------------------< S E L E C T _ O N E >----------------------------------------------------------

Chooses one matching parameter from a list of parameters to consider.  The list of parameters to consider is just
names.  For parameters that may be enumerated, the position of the numerator in the parameter name is identified
by the '#' so |author-last1= and |author1-last= are represented as 'author-last#' and 'author#-last'.

Because enumerated parameter |<param>1= is an alias of |<param>= we must test for both possibilities.


Generates an error if more than one match is present.

]]

local function select_one (args, aliases_list, error_condition, index)
	local value = nil;															-- the value assigned to the selected parameter
	local selected = '';														-- the name of the parameter we have chosen
	local error_list = {};

	if index ~= nil then index = tostring(index); end

	for _, alias in ipairs (aliases_list) do									-- for each alias in the aliases list
		if alias:match ('#') then												-- if this alias can be enumerated
			if '1' == index then												-- when index is 1 test for enumerated and non-enumerated aliases
				value, selected = is_alias_used (args, alias, index, false, value, selected, error_list);	-- first test for non-enumerated alias
			end
			value, selected = is_alias_used (args, alias, index, true, value, selected, error_list);	-- test for enumerated alias
		else
			value, selected = is_alias_used (args, alias, index, false, value, selected, error_list);	-- test for non-enumerated alias
		end
	end

	if #error_list > 0 and 'none' ~= error_condition then						-- for cases where this code is used outside of extract_names()
		for i, v in ipairs (error_list) do
			error_list[i] = wrap_style ('parameter', v);
		end
		table.insert (error_list, wrap_style ('parameter', selected));
		table.insert (z.message_tail, {set_message (error_condition, {make_sep_list (#error_list, error_list)}, true)});
	end
	
	return value, selected;
end


--[=[-------------------------< R E M O V E _ W I K I _ L I N K >----------------------------------------------

Gets the display text from a wikilink like [[A|B]] or [[B]] gives B

The str:gsub() returns either A|B froma [[A|B]] or B from [[B]] or B from B (no wikilink markup).

In l(), l:gsub() removes the link and pipe (if they exist); the second :gsub() trims whitespace from the label
if str was wrapped in wikilink markup.  Presumably, this is because without wikimarkup in str, there is no match
in the initial gsub, the replacement function l() doesn't get called.

]=]

local function remove_wiki_link (str)
	return (str:gsub ("%[%[([^%[%]]*)%]%]", function(l)
		return l:gsub ("^[^|]*|(.*)$", "%1" ):gsub ("^%s*(.-)%s*$", "%1");
	end));
end


--[=[-------------------------< I S _ W I K I L I N K >--------------------------------------------------------

Determines if str is a wikilink, extracts, and returns the wikilink type, link text, and display text parts.
If str is a complex wikilink ([[L|D]]):
	returns wl_type 2 and D and L from [[L|D]];
if str is a simple wikilink ([[D]])
	returns wl_type 1 and D from [[D]] and L as empty string;
if not a wikilink:
	returns wl_type 0, str as D, and L as empty string.

trims leading and trailing whitespace and pipes from L and D ([[L|]] and [[|D]] are accepted by MediaWiki and
treated like [[D]]; while [[|D|]] is not accepted by MediaWiki, here, we accept it and return D without the pipes).

]=]

local function is_wikilink (str)
	local D, L
	local wl_type = 2;															-- assume that str is a complex wikilink [[L|D]]

	if not str:match ('^%[%[[^%]]+%]%]$') then									-- is str some sort of a wikilink (must have some sort of content)
		return 0, str, '';														-- not a wikilink; return wl_type as 0, str as D, and empty string as L
	end
	
	L, D = str:match ('^%[%[([^|]+)|([^%]]+)%]%]$');							-- get L and D from [[L|D]] 

	if not is_set (D) then														-- if no separate display
		D = str:match ('^%[%[([^%]]*)|*%]%]$');									-- get D from [[D]] or [[D|]]
		wl_type = 1; 
	end
	
	D = mw.text.trim (D, '%s|');												-- trim white space and pipe characters 
	return wl_type, D, L or '';
end


--[[--------------------------< S T R I P _ A P O S T R O P H E _ M A R K U P >--------------------------------

Strip wiki italic and bold markup from argument so that it doesn't contaminate COinS metadata.
This function strips common patterns of apostrophe markup.  We presume that editors who have taken the time to
markup a title have, as a result, provided valid markup. When they don't, some single apostrophes are left behind.

Returns the argument without wiki markup and a number; the number is more-or-less meaningless except as a flag
to indicate that markup was replaced; do not rely on it as an indicator of how many of any kind of markup was
removed; returns the argument and nil when no markup removed

]]

local function strip_apostrophe_markup (argument)
	if not is_set (argument) then
		return argument, nil;													-- no argument, nothing to do
	end

	if nil == argument:find ( "''", 1, true ) then								-- Is there at least one double apostrophe?  If not, exit.
		return argument, nil;
	end

	local flag;
	while true do
		if argument:find ("'''''", 1, true) then								-- bold italic (5)
			argument, flag = argument:gsub ("%'%'%'%'%'", "");						-- remove all instances of it
		elseif argument:find ("''''", 1, true) then							-- italic start and end without content (4)
			argument, flag=argument:gsub ("%'%'%'%'", "");
		elseif argument:find ("'''", 1, true) then							-- bold (3)
			argument, flag=argument:gsub ("%'%'%'", "");
		elseif argument:find ("''", 1, true) then								-- italic (2)
			argument, flag = argument:gsub ("%'%'", "");
		else
			break;
		end
	end

	return argument, flag;														-- done
end


--[[--------------------------< S E T _ S E L E C T E D _ M O D U L E S >--------------------------------------

Sets local cfg table to same (live or sandbox) as that used by the other modules.

]]

local function set_selected_modules (cfg_table_ptr)
	cfg = cfg_table_ptr;
	
end


--[[--------------------------< E X P O R T S >----------------------------------------------------------------
]]

return {
	add_maint_cat = add_maint_cat,												-- exported functions
	add_prop_cat = add_prop_cat,
	error_comment = error_comment,
	first_set = first_set,
	has_accept_as_written = has_accept_as_written,
	in_array = in_array,
	is_set = is_set,
	is_url = is_url,
	is_wikilink = is_wikilink,
	make_sep_list = make_sep_list,
	make_wikilink = make_wikilink,
	remove_wiki_link = remove_wiki_link,
	safe_for_italics = safe_for_italics,
	select_one = select_one,
	set_error = set_error,
	set_message = set_message,
	set_selected_modules = set_selected_modules,
	substitude = substitude,
	split_url = split_url,
	strip_apostrophe_markup = strip_apostrophe_markup,
	substitute = substitute,
	wrap_style = wrap_style,

	z = z,																		-- exported table
	}