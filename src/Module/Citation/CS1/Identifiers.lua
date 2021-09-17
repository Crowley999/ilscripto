--[[--------------------------< F O R W A R D   D E C L A R A T I O N S >--------------------------------------
]]

local is_set, in_array, set_error, select_one, add_maint_cat, substitute, make_wikilink, is_valid_date_from_a_point;	
																				-- functions in Module:Citation/CS1/Utilities or Module:Citation/CS1/Date_validation

local z;																		-- table of tables defined in Module:Citation/CS1/Utilities

local cfg;																		-- table of configuration tables that are defined in Module:Citation/CS1/Configuration

local wd_int_lang = (mw.site.server:match ('wikidata') and mw.getCurrentFrame():preprocess('{{int:lang}}')) or '';


--============================<< H E L P E R   F U N C T I O N S >>============================================

--[[--------------------------< E X T E R N A L _ L I N K _ I D >----------------------------------------------

Formats a wiki style external link
警告：该函数与英文站CS1模块中相应函数不兼容，请勿盲目替换！
]]

local function external_link_id(options)
	local url_string = options.link_id or options.id;
	local ext_link;
	if options.encode == true or options.encode == nil then
		url_string = mw.uri.encode( url_string );
	end
	ext_link = mw.ustring.format( '[%s%s%s <span title="%s">%s%s%s</span>]',
		options.prefix, url_string, options.suffix or "",
		options.link, options.label, options.separator or "&nbsp;",
		mw.text.nowiki(options.id)
	);
	if is_set (options.access) then
		ext_link = substitute (cfg.presentation['access-signal'], {ext_link, cfg.presentation[options.access]});	-- add the free-to-read / paywall lock
	end
	return ext_link;
end

--[[--------------------------< I N T E R N A L _ L I N K _ I D >----------------------------------------------

 Formats a wiki style internal link
]]
local function internal_link_id(options)
	return mw.ustring.format( '[[%s%s%s|<span title="%s">%s</span>%s%s]]',
		options.prefix, options.id, options.suffix or "",
		options.link, options.label, options.separator or "&nbsp;",
		mw.text.nowiki(options.id)
	);
end


--[[--------------------------< I S _ E M B A R G O E D >------------------------------------------------------

Determines if a PMC identifier's online version is embargoed. Compares the date in |embargo= against today's date.  If embargo date is
in the future, returns the content of |embargo=; otherwise, returns and empty string because the embargo has expired or because
|embargo= was not set in this cite.

]]

local function is_embargoed (embargo)
	if is_set (embargo) then
		local lang = mw.getContentLanguage();
		local good1, embargo_date, good2, todays_date;
		good1, embargo_date = pcall( lang.formatDate, lang, 'U', embargo );
		good2, todays_date = pcall( lang.formatDate, lang, 'U' );
	
		if good1 and good2 then													-- if embargo date and today's date are good dates
			if tonumber( embargo_date ) >= tonumber( todays_date ) then			-- is embargo date is in the future?
				return embargo;													-- still embargoed
			else
				add_maint_cat ('embargo')
				return '';														-- unset because embargo has expired
			end
		end
	end
	return '';																	-- |embargo= not set return empty string
end
--[[--------------------------< IS _ V A L I D _ C H I N E S E _ B O O K _ C A T E G O R Y >----------------------

检查是否为GB/T 9999.1-2018附表B.1规定的合法图书分类

]]
local function is_valid_Chinese_book_category (str)
	return in_array (str, {
		"A",
		"B", "B0", "B1", "B2", "B3", "B4", "B5", "B6", "B7", "B80", "B82", "B83", "B84", "B9",
		"C", "C0", "C1", "C2", "C3", "C4", "C5", "C6", "C7", "C8", "C91", "C92", "C93", "C94", "C95", "C96", "C97",
		"D", "D0", "D1", "D2", "D33", "D4", "D5", "D6", "D73", "D8", "D9", "DF",
		"E", "E0", "E1", "E2", "E3", "E8", "E9", "E99",
		"F", "F0", "F1", "F2", "F3", "F4", "F49", "F5", "F59", "F6", "F7", "F8",
		"G", "G0", "G1", "G2", "G3", "G4", "G8",
		"H", "H0", "H1", "H2", "H3", "H4", "H5", "H61", "H62", "H63", "H64", "H65", "H66", "H67", "H7", "H81", "H83", "H84", "H9",
		"I", "I0", "I1", "I2", "I3", "I7",
		"J", "J0", "J1", "J19", "J2", "J29", "J3", "J4", "J5", "J59", "J6", "J7", "J8", "J9",
		"K", "K0", "K1", "K2", "K3", "K4", "K5", "K6", "K7", "K81", "K85", "K89", "K9",
		"N", "N0", "N1", "N2", "N3", "N4", "N5", "N6", "N7", "N79", "N8", "N91", "N93", "N94", "N99",
		"O", "O1", "O3", "O4", "O6", "O7",
		"P", "P1", "P2", "P3", "P4", "P5", "P6", "P7", "P9",
		"Q", "Q1", "Q2", "Q3", "Q4", "Q5", "Q6", "Q7", "Q81", "Q89", "Q91", "Q93", "Q94", "Q95", "Q96", "Q98",
		"R", "R1", "R2", "R3", "R4", "R5", "R6", "R71", "R72", "R73", "R74", "R75", "R76", "R77", "R78", "R79", "R8", "R9",
		"S", "S1", "S2", "S3", "S4", "S5", "S6", "S7", "S8", "S9",
		"T", "TB", "TD", "TE", "TF", "TG", "TH", "TJ", "TK", "TL", "TM", "TN", "TP", "TQ", "TS", "TU", "TV",
		"U", "U1", "U2", "U4", "U6", "U8",
		"V", "V1", "V2", "V4", "V7",
		"X", "X1", "X2", "X3", "X4", "X5", "X7", "X8", "X9",
		"Z"
		}); 
end

--[[--------------------------< IS _ V A L I D _ I S X N >-----------------------------------------------------

ISBN-10 and ISSN validator code calculates checksum across all isbn/issn digits including the check digit.
ISBN-13 is checked in isbn().

If the number is valid the result will be 0. Before calling this function, issbn/issn must be checked for length
and stripped of dashes, spaces and other non-isxn characters.

]]

local function is_valid_isxn (isxn_str, len)
	local temp = 0;
	isxn_str = { isxn_str:byte(1, len) };	-- make a table of byte values '0' → 0x30 .. '9' → 0x39, 'X' → 0x58
	len = len+1;							-- adjust to be a loop counter
	for i, v in ipairs( isxn_str ) do		-- loop through all of the bytes and calculate the checksum
		if v == string.byte( "X" ) then		-- if checkdigit is X (compares the byte value of 'X' which is 0x58)
			temp = temp + 10*( len - i );	-- it represents 10 decimal
		else
			temp = temp + tonumber( string.char(v) )*(len-i);
		end
	end
	return temp % 11 == 0;					-- returns true if calculation result is zero
end


--[[--------------------------< IS _ V A L I D _ I S X N _ 1 3 >-----------------------------------------------

ISBN-13 and ISMN validator code calculates checksum across all 13 isbn/ismn digits including the check digit.
If the number is valid, the result will be 0. Before calling this function, isbn-13/ismn must be checked for length
and stripped of dashes, spaces and other non-isxn-13 characters.

]]

local function is_valid_isxn_13 (isxn_str)
	local temp=0;
	
	isxn_str = { isxn_str:byte(1, 13) };										-- make a table of byte values '0' → 0x30 .. '9' → 0x39
	for i, v in ipairs( isxn_str ) do
		temp = temp + (3 - 2*(i % 2)) * tonumber( string.char(v) );				-- multiply odd index digits by 1, even index digits by 3 and sum; includes check digit
	end
	return temp % 10 == 0;														-- sum modulo 10 is zero when isbn-13/ismn is correct
end


--[[--------------------------< N O R M A L I Z E _ L C C N >--------------------------------------------------

lccn normalization (http://www.loc.gov/marc/lccn-namespace.html#normalization)
1. Remove all blanks.
2. If there is a forward slash (/) in the string, remove it, and remove all characters to the right of the forward slash.
3. If there is a hyphen in the string:
	a. Remove it.
	b. Inspect the substring following (to the right of) the (removed) hyphen. Then (and assuming that steps 1 and 2 have been carried out):
		1. All these characters should be digits, and there should be six or less. (not done in this function)
		2. If the length of the substring is less than 6, left-fill the substring with zeroes until the length is six.

Returns a normalized lccn for lccn() to validate.  There is no error checking (step 3.b.1) performed in this function.
]]

local function normalize_lccn (lccn)
	lccn = lccn:gsub ("%s", "");									-- 1. strip whitespace

	if nil ~= string.find (lccn,'/') then
		lccn = lccn:match ("(.-)/");								-- 2. remove forward slash and all character to the right of it
	end

	local prefix
	local suffix
	prefix, suffix = lccn:match ("(.+)%-(.+)");						-- 3.a remove hyphen by splitting the string into prefix and suffix

	if nil ~= suffix then											-- if there was a hyphen
		suffix=string.rep("0", 6-string.len (suffix)) .. suffix;	-- 3.b.2 left fill the suffix with 0s if suffix length less than 6
		lccn=prefix..suffix;										-- reassemble the lccn
	end
	
	return lccn;
	end

--============================<< I D E N T I F I E R   F U N C T I O N S >>====================================

--[[--------------------------< A R X I V >--------------------------------------------------------------------

See: http://arxiv.org/help/arxiv_identifier

format and error check arXiv identifier.  There are three valid forms of the identifier:
the first form, valid only between date codes 9108 and 0703 is:
	arXiv:<archive>.<class>/<date code><number><version>
where:
	<archive> is a string of alpha characters - may be hyphenated; no other punctuation
	<class> is a string of alpha characters - may be hyphenated; no other punctuation; not the same as |class= parameter which is not supported in this form
	<date code> is four digits in the form YYMM where YY is the last two digits of the four-digit year and MM is the month number January = 01
		first digit of YY for this form can only 9 and 0
	<number> is a three-digit number
	<version> is a 1 or more digit number preceded with a lowercase v; no spaces (undocumented)
	
the second form, valid from April 2007 through December 2014 is:
	arXiv:<date code>.<number><version>
where:
	<date code> is four digits in the form YYMM where YY is the last two digits of the four-digit year and MM is the month number January = 01
	<number> is a four-digit number
	<version> is a 1 or more digit number preceded with a lowercase v; no spaces

the third form, valid from January 2015 is:
	arXiv:<date code>.<number><version>
where:
	<date code> and <version> are as defined for 0704-1412
	<number> is a five-digit number
]]

local function arxiv (id, class)
	local handler = cfg.id_handlers['ARXIV'];
	local year, month, version;
	local err_cat = false;														-- assume no error message
	local text;																	-- output text
	
	if id:match("^%a[%a%.%-]+/[90]%d[01]%d%d%d%d$") or id:match("^%a[%a%.%-]+/[90]%d[01]%d%d%d%dv%d+$") then	-- test for the 9108-0703 format w/ & w/o version
		year, month = id:match("^%a[%a%.%-]+/([90]%d)([01]%d)%d%d%d[v%d]*$");
		year = tonumber(year);
		month = tonumber(month);
		if ((not (90 < year or 8 > year)) or (1 > month or 12 < month)) or		-- if invalid year or invalid month
			((91 == year and 7 > month) or (7 == year and 3 < month)) then		-- if years ok, are starting and ending months ok?
				err_cat = true;													-- flag for error message
		end

	elseif id:match("^%d%d[01]%d%.%d%d%d%d$") or id:match("^%d%d[01]%d%.%d%d%d%dv%d+$") then	-- test for the 0704-1412 w/ & w/o version
		year, month = id:match("^(%d%d)([01]%d)%.%d%d%d%d[v%d]*$");
		year = tonumber(year);
		month = tonumber(month);
		if ((7 > year) or (14 < year) or (1 > month or 12 < month)) or			-- is year invalid or is month invalid? (doesn't test for future years)
			((7 == year) and (4 > month)) then --or									-- when year is 07, is month invalid (before April)?
				err_cat = true;													-- flag for error message
		end

	elseif id:match("^%d%d[01]%d%.%d%d%d%d%d$") or id:match("^%d%d[01]%d%.%d%d%d%d%dv%d+$") then	-- test for the 1501- format w/ & w/o version
		year, month = id:match("^(%d%d)([01]%d)%.%d%d%d%d%d[v%d]*$");
		year = tonumber(year);
		month = tonumber(month);
		if ((15 > year) or (1 > month or 12 < month)) then						-- is year invalid or is month invalid? (doesn't test for future years)
				err_cat = true;													-- flag for error message
		end

	else
		err_cat = true;															-- not a recognized format; flag for error message
	end

	err_cat = err_cat and table.concat ({' ', set_error ('bad_arxiv')}) or '';	-- set error message if flag is true
	
	text = external_link_id({link = handler.link, label = handler.label, q = handler.q,
			prefix=handler.prefix,id=id,separator=handler.separator, encode=handler.encode, access=handler.access}) .. err_cat;

	if is_set (class) then
		if id:match ('^%d+') then
			text = table.concat ({text, ' [[//arxiv.org/archive/', class, ' ', class, ']]'});	-- external link within square brackets, not wikilink
		else
			text = table.concat ({text, ' ', set_error ('class_ignored')});		
		end
	end

	return text;	
end


--[[--------------------------< B I B C O D E >--------------------------------------------------------------------

Validates (sort of) and formats a bibcode id.

Format for bibcodes is specified here: http://adsabs.harvard.edu/abs_doc/help_pages/data.html#bibcodes

But, this: 2015arXiv151206696F is apparently valid so apparently, the only things that really matter are length, 19 characters
and first four digits must be a year.  This function makes these tests:
	length must be 19 characters
	characters in position
		1–4 must be digits and must represent a year in the range of 1000 – next year
		5 must be a letter
		6 must be letter, ampersand, or dot (ampersand cannot directly precede a dot; &. )
		7–8 must be letter, digit, ampersand, or dot (ampersand cannot directly precede a dot; &. )
		9–18 must be letter, digit, or dot
		19 must be a letter or dot

]]

local function bibcode (id, access)
	local handler = cfg.id_handlers['BIBCODE'];
	local err_type;
	local year;

	local text = external_link_id({link=handler.link, label=handler.label, q = handler.q,
		prefix=handler.prefix, id=id, separator=handler.separator, encode=handler.encode,
		access=access});
	
	if 19 ~= id:len() then
		err_type = 'length';
	else
		year = id:match ("^(%d%d%d%d)[%a][%a&%.][%a&%.%d][%a&%.%d][%a%d%.]+[%a%.]$")	-- 
		if not year then														-- if nil then no pattern match
			err_type = 'value';													-- so value error
		else
			local next_year = tonumber(os.date ('%Y'))+1;						-- get the current year as a number and add one for next year
			year = tonumber (year);												-- convert year portion of bibcode to a number
			if (1000 > year) or (year > next_year) then
				err_type = 'year';												-- year out of bounds
			end
			if id:find('&%.') then
				err_type = 'journal';											-- journal abbreviation must not have '&.' (if it does its missing a letter)
			end
		end
	end

	if is_set (err_type) then													-- if there was an error detected
		text = text .. ' ' .. set_error( 'bad_bibcode', {err_type});
	end
	return text;
end


--[[--------------------------< B I O R X I V >-----------------------------------------------------------------

Format bioRxiv id and do simple error checking.  BiorXiv ids are exactly 6 digits.
The bioRxiv id is the number following the last slash in the bioRxiv-issued DOI:
https://doi.org/10.1101/078733 -> 078733
2019年底，biorxiv更换新格式，故而有必要兼容新旧两种格式，对该函数作出针对性修改
]]

local function biorxiv (id)
	local handler = cfg.id_handlers['BIORXIV'];
	local err_cat = '';															-- presume that bioRxiv id is valid
	local invalid = false;
	id = id:gsub ("^10.1101/","");                                              -- doi前缀10.1101/可填可不填，便利用户使用
	if nil == id:match ("^%d%d%d%d%d%d$") then									-- 不是旧格式
		local date_str;
		if (nil ~= id:match ("^%d%d%d%d%.[01]%d%.[0-3]%d%.%d%d%d%d%d%d$")) then
			date_str = id:match ("^(%d%d%d%d%.[01]%d%.[0-3]%d)%.%d%d%d%d%d%d$");
		else 
			if (nil ~= id:match ("^%d%d%d%d%.[01]%d%.[0-3]%d%.%d%d%d%d%d%dv%d+$")) then
				date_str = id:match ("^(%d%d%d%d%.[01]%d%.[0-3]%d)%.%d%d%d%d%d%dv%d+$");
			else																-- 也不匹配新格式，因而为非法格式
				invalid = true;
			end
		end
		if (not invalid) then
			date_str = date_str:gsub ("%.", "-");
			if(not is_valid_date_from_a_point(date_str, 1576022400)) then
				invalid = true;
			end
		end
	end
	if (invalid) then
		err_cat = ' ' .. set_error( 'bad_biorxiv');								-- set an error message
	end
	return external_link_id({link = handler.link, label = handler.label, q = handler.q,
			prefix = handler.prefix, id = "10.1101/" .. id, separator = handler.separator,
			encode = handler.encode, access = handler.access}) .. err_cat;
end


--[[--------------------------< C I T E S E E R X >------------------------------------------------------------

CiteSeerX use their own notion of "doi" (not to be confused with the identifiers resolved via doi.org).

The description of the structure of this identifier can be found at Help_talk:Citation_Style_1/Archive_26#CiteSeerX_id_structure
]]

local function citeseerx (id)
	local handler = cfg.id_handlers['CITESEERX'];
	local matched;
	
	local text = external_link_id({link=handler.link, label=handler.label, q = handler.q,
		prefix=handler.prefix, id=id, separator=handler.separator, encode=handler.encode,
		access=handler.access});
	
	matched = id:match ("^10%.1%.1%.[1-9]%d?%d?%d?%.[1-9]%d?%d?%d?$");
	if not matched then
		text = text .. ' ' .. set_error( 'bad_citeseerx' );
	end
	return text;
end

--[[--------------------------< C N I D >----------------------------------------------------------------------

判断国内统一刊号的合法性及输出相关内容

]]

local function cnid (id)
	local handler = cfg.id_handlers['CNID'];
	local text;
	local type = 0;
	local invalid = false;
	local AA, BBBB, CC;
	id = id:gsub ("^CN ?", "");
	if nil ~= id:match ("^%d%d%-%d%d%d%d$") then
		AA, BBBB = id:match ("^(%d%d)%-(%d%d%d%d)$");
	else
		if nil ~= id:match ("^%d%d%-%d%d%d%d/[A-Z0-9]+$")  then
			AA, BBBB, CC = id:match ("^(%d%d)%-(%d%d%d%d)/([A-Z0-9]+)$")
		else invalid = true;
		end
	end
	if (not invalid) then
		if not in_array (AA, {"09", "10", "11",                                  -- 北京
			"12", "13", "14", "15",                                              -- 华北
			"21", "22", "23",                                                    -- 东北
			"30", "31", "32", "33", "34", "35", "36", "37",                      -- 华东
			"41", "42", "43", "44", "45", "46",                                  -- 华中华南
			"50", "51", "52", "53", "54",                                        -- 西南
			"61", "62", "63", "64", "65"                                         -- 西北
		}) then
			invalid = true ;
		else
			local BBBB_num = tonumber (BBBB);
			if (BBBB_num >= 1 and BBBB_num <= 999) then
				type = 1;
				if (nil ~= CC) then
					invalid = true;
				end;
			else 
				if (BBBB_num >= 1000 and BBBB_num <= 5999) then
					type = 2;
					if (not is_valid_Chinese_book_category (CC)) then
						invalid = true;
					end
				else
					type = 3;
					if (nil ~= CC and not is_valid_Chinese_book_category (CC)) then
						invalid = true;
					end
				end
			end
		end
	end
	if (not invalid) and (1 == type) then
		local link_id = id:gsub ("-","");
		text = external_link_id({link = handler.link, label = handler.label, 
				q = handler.q, prefix = handler.prefix, suffix = "&typeNum=1", 
				link_id = link_id, id = id, 
				separator = handler.separator, encode = handler.encode});
	else
		if (not invalid) and (2 == type) then
			text = external_link_id({link = handler.link, label = handler.label, 
				q = handler.q, prefix = handler.prefix, suffix = "&typeNum=2",
				id = id, separator = handler.separator, encode = handler.encode});
		else
			text = mw.ustring.format( "<span title="%s">%s%s%s</span>",
					handler.link, handler.label, handler.separator,
					mw.text.nowiki (id)
				);
		end
	end
	if (invalid) then
		text = text .. ' ' .. set_error( 'bad_cnid');
	end
	return text;
end
--[[--------------------------< C S B N >----------------------------------------------------------------------
判断CSBN的合法性及产生指向豆瓣网的链接。
CSBN格式参考《谈谈国家统一书号与国际标准书号》。
]]

local function csbn (id)
	local handler = cfg.id_handlers['CSBN'];
	local text;
	local invalid = false;
	id = id:gsub ("%-","·");
	if (nil == id:match ("^[1-9]%d?%d%d%d·%d+$")) then							
																				-- CSBN由三部分组成，第一部分为中国人民大学图书分类法代号，取值1-17；
																				-- 第二部分为出版社代号，三位；第三部分为种次号，取值不限。
																				-- 二、三部分间有小圆点；若取值不合该格式，则不合法。
																				-- 此外，虽然小圆点用"-"取代不合法，但站内误用较多，这里兼容之。
		invalid = true;
	else
		local category = id:match ("^([1-9]%d?)%d%d%d·%d+$");
		local cat_num = tonumber (category);
		if (cat_num <=0 or cat_num >17) then									
																				-- 若分类号取值不在1-17范围内，则不合法。
			invalid = true;
		end
	end
																				-- 豆瓣网以连接号取代小圆点，故替换之。
	local link_id = id:gsub ("·","%-");	
	text = external_link_id({link = handler.link, label = handler.label, 
				q = handler.q, prefix = handler.prefix,
				link_id = link_id, id = id, 
				separator = handler.separator, encode = handler.encode});
	if (invalid) then
		text = text .. ' ' .. set_error( 'bad_csbn');
	end
	return text;
end

--[[--------------------------< D O I >------------------------------------------------------------------------

Formats a DOI and checks for DOI errors.

DOI names contain two parts: prefix and suffix separated by a forward slash.
	Prefix: directory indicator '10.' followed by a registrant code
	Suffix: character string of any length chosen by the registrant

This function checks a DOI name for: prefix/suffix.  If the doi name contains spaces or endashes, or, if it ends
with a period or a comma, this function will emit a bad_doi error message.

DOI names are case-insensitive and can incorporate any printable Unicode characters so the test for spaces, endash,
and terminal punctuation may not be technically correct but it appears, that in practice these characters are rarely
if ever used in doi names.

]]

local function doi(id, inactive, access)
	local cat = ""
	local handler = cfg.id_handlers['DOI'];
	
	local text;
	if is_set(inactive) then
		local inactive_year = inactive:match("%d%d%d%d") or '';					-- try to get the year portion from the inactive date
		if is_set(inactive_year) then
			table.insert( z.error_categories, "自" .. inactive_year .. "年含有不活躍DOI的頁面" );
		else
			table.insert( z.error_categories, "含有不活躍DOI的頁面" ); -- when inactive doesn't contain a recognizable year
		end
		inactive = " (" .. cfg.messages['inactive'] .. " " .. inactive .. ")" 
	end
	text = external_link_id({link = handler.link, label = handler.label, q = handler.q,
		prefix=handler.prefix,id=id,separator=handler.separator, encode=handler.encode, access=access}) .. (inactive or '')

	if nil == id:match("^10%.[^%s–]-/[^%s–]-[^%.,]$") then						-- doi must begin with '10.', must contain a fwd slash, must not contain spaces or endashes, and must not end with period or comma
		cat = ' ' .. set_error( 'bad_doi' );
	end

	return text .. cat 
end


--[[--------------------------< H D L >------------------------------------------------------------------------

Formats an HDL with minor error checking.

HDL names contain two parts: prefix and suffix separated by a forward slash.
	Prefix: character string using any character in the UCS-2 character set except '/'
	Suffix: character string of any length using any character in the UCS-2 character set chosen by the registrant

This function checks a HDL name for: prefix/suffix.  If the HDL name contains spaces, endashes, or, if it ends
with a period or a comma, this function will emit a bad_hdl error message.

HDL names are case-insensitive and can incorporate any printable Unicode characters so the test for endashes and
terminal punctuation may not be technically correct but it appears, that in practice these characters are rarely
if ever used in HDLs.

]]

local function hdl(id, access)
	local handler = cfg.id_handlers['HDL'];
	
	local text = external_link_id({link = handler.link, label = handler.label, q = handler.q,
			prefix=handler.prefix,id=id,separator=handler.separator, encode=handler.encode, access=access})

	if nil == id:match("^[^%s–]-/[^%s–]-[^%.,]$") then							-- hdl must contain a fwd slash, must not contain spaces, endashes, and must not end with period or comma
		text = text .. ' ' .. set_error( 'bad_hdl' );
	end
	return text;
end


--[[--------------------------< I S B N >----------------------------------------------------------------------

Determines whether an ISBN string is valid

]]

local function isbn( isbn_str )
	if nil ~= isbn_str:match("[^%s-0-9X]") then
		return false, 'invalid character';										-- fail if isbn_str contains anything but digits, hyphens, or the uppercase X
	end
	isbn_str = isbn_str:gsub( "-", "" ):gsub( " ", "" );						-- remove hyphens and spaces
	local len = isbn_str:len();
 
	if len ~= 10 and len ~= 13 then
		return false, 'length';													-- fail if incorrect length
	end

	if len == 10 then
		if isbn_str:match( "^%d*X?$" ) == nil then								-- fail if isbn_str has 'X' anywhere but last position
			return false, 'invalid form';									
		end
		return is_valid_isxn(isbn_str, 10), 'checksum';
	else
		if isbn_str:match( "^%d+$" ) == nil then
			return false, 'invalid character';									-- fail if isbn13 is not all digits
		end
		if isbn_str:match( "^97[89]%d*$" ) == nil then
			return false, 'invalid prefix';										-- fail when isbn13 does not begin with 978 or 979
		end
		return is_valid_isxn_13 (isbn_str), 'checksum';
	end
end


--[[--------------------------< A M A Z O N >------------------------------------------------------------------

Formats a link to Amazon.  Do simple error checking: asin must be mix of 10 numeric or uppercase alpha
characters.  If a mix, first character must be uppercase alpha; if all numeric, asins must be 10-digit
isbn. If 10-digit isbn, add a maintenance category so a bot or awb script can replace |asin= with |isbn=.
Error message if not 10 characters, if not isbn10, if mixed and first character is a digit.

This function is positioned here because it calls isbn()

]]

local function asin(id, domain)
	local err_cat = ""

	if not id:match("^[%d%u][%d%u][%d%u][%d%u][%d%u][%d%u][%d%u][%d%u][%d%u][%d%u]$") then
		err_cat = ' ' .. set_error ('bad_asin');								-- asin is not a mix of 10 uppercase alpha and numeric characters
	else
		if id:match("^%d%d%d%d%d%d%d%d%d[%dX]$") then							-- if 10-digit numeric (or 9 digits with terminal X)
			if isbn( id ) then													-- see if asin value is isbn10
				add_maint_cat ('ASIN');
			elseif not is_set (err_cat) then
				err_cat = ' ' .. set_error ('bad_asin');						-- asin is not isbn10
			end
		elseif not id:match("^%u[%d%u]+$") then
			err_cat = ' ' .. set_error ('bad_asin');							-- asin doesn't begin with uppercase alpha
		end
	end
	if not is_set(domain) then 
		domain = "com";
	elseif in_array (domain, {'jp', 'uk'}) then			-- Japan, United Kingdom
		domain = "co." .. domain;
	elseif in_array (domain, {'au', 'br', 'mx'}) then	-- Australia, Brazil, Mexico
		domain = "com." .. domain;
	end
	local handler = cfg.id_handlers['ASIN'];
	return external_link_id({link=handler.link,
		label=handler.label, q = handler.q, prefix=handler.prefix .. domain .. "/dp/",
		id=id, encode=handler.encode, separator = handler.separator}) .. err_cat;
end


--[[--------------------------< I S M N >----------------------------------------------------------------------

Determines whether an ISMN string is valid.  Similar to isbn-13, ismn is 13 digits begining 979-0-... and uses the
same check digit calculations.  See http://www.ismn-international.org/download/Web_ISMN_Users_Manual_2008-6.pdf
section 2, pages 9–12.

]]

local function ismn (id)
	local handler = cfg.id_handlers['ISMN'];
	local text;
	local valid_ismn = true;
	local id_copy;

	id_copy = id;																-- save a copy because this testing is destructive
	id=id:gsub( "[%s-–]", "" );													-- strip spaces, hyphens, and endashes from the ismn

	if 13 ~= id:len() or id:match( "^9790%d*$" ) == nil then					-- ismn must be 13 digits and begin 9790
		valid_ismn = false;
	else
		valid_ismn=is_valid_isxn_13 (id);										-- validate ismn
	end

--	text = internal_link_id({link = handler.link, label = handler.label,		-- use this (or external version) when there is some place to link to
--		prefix=handler.prefix,id=id,separator=handler.separator, encode=handler.encode})
 
	text="[[" .. handler.link .. "|" .. handler.label .. "]]" .. handler.separator .. id;		
																				-- because no place to link to yet

	if false == valid_ismn then
		text = text .. ' ' .. set_error( 'bad_ismn' )							-- add an error message if the issn is invalid
	end 
	
	return text;
end

--[[--------------------------< I S S N >----------------------------------------------------------------------

Validate and format an issn.  This code fixes the case where an editor has included an ISSN in the citation but
has separated the two groups of four digits with a space.  When that condition occurred, the resulting link looked
like this:

	|issn=0819 4327 gives: [http://www.worldcat.org/issn/0819 4327 0819 4327]	-- can't have spaces in an external link
	
This code now prevents that by inserting a hyphen at the issn midpoint.  It also validates the issn for length
and makes sure that the checkdigit agrees with the calculated value.  Incorrect length (8 digits), characters
other than 0-9 and X, or checkdigit / calculated value mismatch will all cause a check issn error message.  The
issn is always displayed with a hyphen, even if the issn was given as a single group of 8 digits.

]]

local function issn(id, e)
	local issn_copy = id;														-- save a copy of unadulterated issn; use this version for display if issn does not validate
	local handler;
	local text;
	local valid_issn = true;
	
	if e then
		 handler = cfg.id_handlers['EISSN'];
	else
		 handler = cfg.id_handlers['ISSN'];
	end

	id=id:gsub( "[%s-–]", "" );													-- strip spaces, hyphens, and endashes from the issn

	if 8 ~= id:len() or nil == id:match( "^%d*X?$" ) then						-- validate the issn: 8 digits long, containing only 0-9 or X in the last position
		valid_issn=false;														-- wrong length or improper character
	else
		valid_issn=is_valid_isxn(id, 8);										-- validate issn
	end

	if true == valid_issn then
		id = string.sub( id, 1, 4 ) .. "-" .. string.sub( id, 5 );				-- if valid, display correctly formatted version
	else
		id = issn_copy;															-- if not valid, use the show the invalid issn with error message
	end
	
	text = external_link_id({link = handler.link, label = handler.label, q = handler.q,
		prefix=handler.prefix,id=id,separator=handler.separator, encode=handler.encode})
 
	if false == valid_issn then
		text = text .. ' ' .. set_error( 'bad_issn', e and 'e' or '' )			-- add an error message if the issn is invalid
	end 
	
	return text
end


--[[--------------------------< J F M >-----------------------------------------------------------------------

A numerical identifier in the form nn.nnnn.nn

]]

local function jfm (id)
	local handler = cfg.id_handlers['JFM'];
	local id_num;
	local err_cat = '';
	
	id_num = id:match ('^[Jj][Ff][Mm](.*)$');									-- identifier with jfm prefix; extract identifier

	if is_set (id_num) then
		add_maint_cat ('jfm_format');
	else																		-- plain number without mr prefix
		id_num = id;															-- if here id does not have prefix
	end

	if id_num and id_num:match('^%d%d%.%d%d%d%d%.%d%d$') then
		id = id_num;															-- jfm matches pattern
	else
		err_cat = ' ' .. set_error( 'bad_jfm' );								-- set an error message
	end
	
	return external_link_id({link = handler.link, label = handler.label, q = handler.q,
			prefix=handler.prefix,id=id,separator=handler.separator, encode=handler.encode}) .. err_cat;
end


--[[--------------------------< L C C N >----------------------------------------------------------------------

Format LCCN link and do simple error checking.  LCCN is a character string 8-12 characters long. The length of
the LCCN dictates the character type of the first 1-3 characters; the rightmost eight are always digits.
http://info-uri.info/registry/OAIHandler?verb=GetRecord&metadataPrefix=reg&identifier=info:lccn/

length = 8 then all digits
length = 9 then lccn[1] is lower case alpha
length = 10 then lccn[1] and lccn[2] are both lower case alpha or both digits
length = 11 then lccn[1] is lower case alpha, lccn[2] and lccn[3] are both lower case alpha or both digits
length = 12 then lccn[1] and lccn[2] are both lower case alpha

]]

local function lccn(lccn)
	local handler = cfg.id_handlers['LCCN'];
	local err_cat = '';															-- presume that LCCN is valid
	local id = lccn;															-- local copy of the lccn

	id = normalize_lccn (id);													-- get canonical form (no whitespace, hyphens, forward slashes)
	local len = id:len();														-- get the length of the lccn

	if 8 == len then
		if id:match("[^%d]") then												-- if LCCN has anything but digits (nil if only digits)
			err_cat = ' ' .. set_error( 'bad_lccn' );							-- set an error message
		end
	elseif 9 == len then														-- LCCN should be adddddddd
		if nil == id:match("%l%d%d%d%d%d%d%d%d") then							-- does it match our pattern?
			err_cat = ' ' .. set_error( 'bad_lccn' );							-- set an error message
		end
	elseif 10 == len then														-- LCCN should be aadddddddd or dddddddddd
		if id:match("[^%d]") then												-- if LCCN has anything but digits (nil if only digits) ...
			if nil == id:match("^%l%l%d%d%d%d%d%d%d%d") then					-- ... see if it matches our pattern
				err_cat = ' ' .. set_error( 'bad_lccn' );						-- no match, set an error message
			end
		end
	elseif 11 == len then														-- LCCN should be aaadddddddd or adddddddddd
		if not (id:match("^%l%l%l%d%d%d%d%d%d%d%d") or id:match("^%l%d%d%d%d%d%d%d%d%d%d")) then	-- see if it matches one of our patterns
			err_cat = ' ' .. set_error( 'bad_lccn' );							-- no match, set an error message
		end
	elseif 12 == len then														-- LCCN should be aadddddddddd
		if not id:match("^%l%l%d%d%d%d%d%d%d%d%d%d") then						-- see if it matches our pattern
			err_cat = ' ' .. set_error( 'bad_lccn' );							-- no match, set an error message
		end
	else
		err_cat = ' ' .. set_error( 'bad_lccn' );								-- wrong length, set an error message
	end

	if not is_set (err_cat) and nil ~= lccn:find ('%s') then
		err_cat = ' ' .. set_error( 'bad_lccn' );								-- lccn contains a space, set an error message
	end

	return external_link_id({link = handler.link, label = handler.label, q = handler.q,
			prefix=handler.prefix,id=lccn,separator=handler.separator, encode=handler.encode}) .. err_cat;
end


--[[--------------------------< M R >--------------------------------------------------------------------------

A seven digit number; if not seven digits, zero-fill leading digits to make seven digits.

]]

local function mr (id)
	local handler = cfg.id_handlers['MR'];
	local id_num;
	local id_len;
	local err_cat = '';
	
	id_num = id:match ('^[Mm][Rr](%d+)$');										-- identifier with mr prefix

	if is_set (id_num) then
		add_maint_cat ('mr_format');
	else																		-- plain number without mr prefix
		id_num = id:match ('^%d+$');											-- if here id is all digits
	end

	id_len = id_num and id_num:len() or 0;
	if (7 >= id_len) and (0 ~= id_len) then
		id = string.rep ('0', 7-id_len ) .. id_num;								-- zero-fill leading digits
	else
		err_cat = ' ' .. set_error( 'bad_mr' );									-- set an error message
	end
	
	return external_link_id({link = handler.link, label = handler.label, q = handler.q,
			prefix=handler.prefix,id=id,separator=handler.separator, encode=handler.encode}) .. err_cat;
end


--[[--------------------------< O C L C >----------------------------------------------------------------------

Validate and format an oclc id.  https://www.oclc.org/batchload/controlnumber.en.html {{dead link}}
archived at: https://web.archive.org/web/20161228233804/https://www.oclc.org/batchload/controlnumber.en.html

]]

local function oclc (id)
	local handler = cfg.id_handlers['OCLC'];
	local number;
	local err_msg = '';															-- empty string for concatenation
	
	if id:match('^ocm%d%d%d%d%d%d%d%d$') then									-- ocm prefix and 8 digits; 001 field (12 characters)
		number = id:match('ocm(%d+)');											-- get the number
	elseif id:match('^ocn%d%d%d%d%d%d%d%d%d$') then								-- ocn prefix and 9 digits; 001 field (12 characters)
		number = id:match('ocn(%d+)');											-- get the number
	elseif id:match('^on%d%d%d%d%d%d%d%d%d%d+$') then							-- on prefix and 10 or more digits; 001 field (12 characters)
		number = id:match('^on(%d%d%d%d%d%d%d%d%d%d+)$');						-- get the number
	elseif id:match('^%(OCoLC%)[1-9]%d*$') then									-- (OCoLC) prefix and variable number digits; no leading zeros; 035 field
		number = id:match('%(OCoLC%)([1-9]%d*)');								-- get the number
		if 9 < number:len() then
			number = nil;														-- contrain to 1 to 9 digits; change this when oclc issues 10-digit numbers
		end
	elseif id:match('^%d+$') then												-- no prefix
		number = id;															-- get the number
		if 10 < number:len() then
			number = nil;														-- contrain to 1 to 10 digits; change this when oclc issues 11-digit numbers
		end
	end

	if number then																-- proper format
		id = number;															-- exclude prefix, if any, from external link
	else
		err_msg = ' ' .. set_error( 'bad_oclc' )								-- add an error message if the id is malformed
	end
	
	local text = external_link_id({link=handler.link, label=handler.label, q = handler.q,
		prefix=handler.prefix, id=id, separator=handler.separator, encode=handler.encode}) .. err_msg;

	return text;
end


--[[--------------------------< O P E N L I B R A R Y >--------------------------------------------------------

Formats an OpenLibrary link, and checks for associated errors.

]]

local function openlibrary(id, access)
	local code;
	local handler = cfg.id_handlers['OL'];
	local ident;
	
	ident, code = id:match("^(%d+([AMW]))$");					-- optional OL prefix followed immediately by digits followed by 'A', 'M', or 'W'; remove OL prefix

	if not is_set (ident) then													-- if malformed return an error
		return external_link_id({link=handler.link, label=handler.label, q = handler.q,
			prefix=handler.prefix .. 'OL',
			id=id, separator=handler.separator,	encode = handler.encode,
			access = access}) .. ' ' .. set_error( 'bad_ol' );
	end
	
	id = ident;																	-- use ident without the optional OL prefix (it has been removed)
	
	if ( code == "A" ) then
		return external_link_id({link=handler.link, label=handler.label, q = handler.q,
			prefix=handler.prefix .. 'authors/OL',
			id=id, separator=handler.separator,	encode = handler.encode,
			access = access})
	end
	
	if ( code == "M" ) then
		return external_link_id({link=handler.link, label=handler.label, q = handler.q,
			prefix=handler.prefix .. 'books/OL',
			id=id, separator=handler.separator,	encode = handler.encode,
			access = access})
	end

	if ( code == "W" ) then
		return external_link_id({link=handler.link, label=handler.label, q = handler.q,
			prefix=handler.prefix .. 'works/OL',
			id=id, separator=handler.separator,	encode = handler.encode,
			access = access})
	end
end


--[[--------------------------< P M C >------------------------------------------------------------------------

Format a PMC, do simple error checking, and check for embargoed articles.

The embargo parameter takes a date for a value. If the embargo date is in the future the PMC identifier will not
be linked to the article.  If the embargo date is today or in the past, or if it is empty or omitted, then the
PMC identifier is linked to the article through the link at cfg.id_handlers['PMC'].prefix.

PMC embargo date testing is done in function is_embargoed () which is called earlier because when the citation
has |pmc=<value> but does not have a |url= then |title= is linked with the PMC link.  Function is_embargoed ()
returns the embargo date if the PMC article is still embargoed, otherwise it returns an empty string.

PMCs are sequential numbers beginning at 1 and counting up.  This code checks the PMC to see that it contains only digits and is less
than test_limit; the value in local variable test_limit will need to be updated periodically as more PMCs are issued.

]]

local function pmc(id, embargo)
	local test_limit = 10000000;													-- update this value as PMCs approach
	local handler = cfg.id_handlers['PMC'];
	local err_cat = '';															-- presume that PMC is valid
	local id_num;
	local text;
	
	id_num = id:match ('^[Pp][Mm][Cc](%d+)$');									-- identifier with pmc prefix

	if is_set (id_num) then
		add_maint_cat ('pmc_format');
	else																		-- plain number without pmc prefix
		id_num = id:match ('^%d+$');											-- if here id is all digits
	end

	if is_set (id_num) then														-- id_num has a value so test it
		id_num = tonumber(id_num);												-- convert id_num to a number for range testing
		if 1 > id_num or test_limit < id_num then								-- if PMC is outside test limit boundaries
			err_cat = ' ' .. set_error( 'bad_pmc' );							-- set an error message
		else
			id = tostring (id_num);												-- make sure id is a string
		end
	else																		-- when id format incorrect
		err_cat = ' ' .. set_error( 'bad_pmc' );								-- set an error message
	end
	
	if is_set (embargo) then													-- is PMC is still embargoed?
		text = table.concat (													-- still embargoed so no external link
			{
			make_wikilink (handler.link, handler.label),
			handler.separator,
			id,
			err_cat
			});
	else
		text = external_link_id({link = handler.link, label = handler.label, q = handler.q,	-- no embargo date or embargo has expired, ok to link to article
			prefix=handler.prefix,id=id,separator=handler.separator, encode=handler.encode, access=handler.access}) .. err_cat;
	end
	return text;
end


--[[--------------------------< P M I D >----------------------------------------------------------------------

Format PMID and do simple error checking.  PMIDs are sequential numbers beginning at 1 and counting up.  This
code checks the PMID to see that it contains only digits and is less than test_limit; the value in local variable
test_limit will need to be updated periodically as more PMIDs are issued.

]]

local function pmid(id)
	local test_limit = 35000000;												-- update this value as PMIDs approach
	local handler = cfg.id_handlers['PMID'];
	local err_cat = '';															-- presume that PMID is valid
	
	if id:match("[^%d]") then													-- if PMID has anything but digits
		err_cat = ' ' .. set_error( 'bad_pmid' );								-- set an error message
	else																		-- PMID is only digits
		local id_num = tonumber(id);											-- convert id to a number for range testing
		if 1 > id_num or test_limit < id_num then								-- if PMID is outside test limit boundaries
			err_cat = ' ' .. set_error( 'bad_pmid' );							-- set an error message
		end
	end
	
	return external_link_id({link = handler.link, label = handler.label, q = handler.q,
			prefix=handler.prefix,id=id,separator=handler.separator, encode=handler.encode}) .. err_cat;
end

--[[--------------------------< S 2 C I D >--------------------------------------------------------------------

Format an S2CID, do simple error checking

S2CIDs are sequential numbers beginning at 1 and counting up.  This code checks the S2CID to see that it is only
digits and is less than test_limit; the value in local variable test_limit will need to be updated periodically
as more S2CIDs are issued.

]]

local function s2cid (id, access)
	local test_limit = 235000000;
	local handler = cfg.id_handlers['S2CID'];
	local err_cat = '';															-- presume that S2CID is valid
	local id_num = id:match ('^[1-9]%d*$');										-- id must be all digits; must not begin with 0; no open access flag

 	if is_set (id_num) then														-- id_num has a value so test it
		id_num = tonumber (id_num);												-- convert id_num to a number for range testing
		if test_limit < id_num then										        -- if S2CID is outside test limit boundaries
			err_cat = ' ' .. set_error ('bad_s2cid');						    -- set an error message
		end

	else																		-- when id format incorrect
		err_cat = ' ' .. set_error ('bad_s2cid');							    -- set an error message
	end

	return external_link_id ({link = handler.link, label = handler.label, q = handler.q, redirect = handler.redirect,
		prefix = handler.prefix, id = id, separator = handler.separator, encode = handler.encode, access = access}) .. err_cat;
end


--[[--------------------------< S S R N >----------------------------------------------------------------------

Format an ssrn, do simple error checking

SSRNs are sequential numbers beginning at 100? and counting up.  This code checks the ssrn to see that it is
only digits and is greater than 99 and less than test_limit; the value in local variable test_limit will need
to be updated periodically as more SSRNs are issued.

]]

local function ssrn (id)
	local test_limit = 3500000;													-- update this value as SSRNs approach
	local handler = cfg.id_handlers['SSRN'];
	local err_cat = '';															-- presume that SSRN is valid
	local id_num;
	local text;
	
	id_num = id:match ('^%d+$');												-- id must be all digits

	if is_set (id_num) then														-- id_num has a value so test it
		id_num = tonumber(id_num);												-- convert id_num to a number for range testing
		if 100 > id_num or test_limit < id_num then								-- if SSRN is outside test limit boundaries
			err_cat = ' ' .. set_error( 'bad_ssrn' );							-- set an error message
		end
	else																		-- when id format incorrect
		err_cat = ' ' .. set_error( 'bad_ssrn' );								-- set an error message
	end
	
	text = external_link_id({link = handler.link, label = handler.label, q = handler.q,
		prefix=handler.prefix,id=id,separator=handler.separator, encode=handler.encode, access=handler.access}) .. err_cat;

	return text;
end


--[[--------------------------< U S E N E T _ I D >------------------------------------------------------------

Validate and format a usenet message id.  Simple error checking, looks for 'id-left@id-right' not enclosed in
'<' and/or '>' angle brackets.

]]

local function usenet_id (id)
	local handler = cfg.id_handlers['USENETID'];

	local text = external_link_id({link = handler.link, label = handler.label, q = handler.q,
		prefix=handler.prefix,id=id,separator=handler.separator, encode=handler.encode})
 
	if not id:match('^.+@.+$') or not id:match('^[^<].*[^>]$')then				-- doesn't have '@' or has one or first or last character is '< or '>'
		text = text .. ' ' .. set_error( 'bad_message_id' )						-- add an error message if the message id is invalid
	end 
	
	return text
end


--[[--------------------------< Z B L >-----------------------------------------------------------------------

A numerical identifier in the form nnnn.nnnnn - leading zeros in the first quartet optional

]]

local function zbl (id)
	local handler = cfg.id_handlers['ZBL'];
	local err_cat = '';
	id = id:gsub ('^[Zz][Bb][Ll]',"");									    	-- identifier with zbl prefix; extract identifier
	if (nil ~= id:match ("^%d%d%d%d%d%d%d%d$")) then
		add_maint_cat ('zbl_format');											-- temporary
	else
		if (nil == id:match('^%d?%d?%d?%d%.%d%d%d%d%d$')) then					-- id doesn't match the pattern
			err_cat = ' ' .. set_error( 'bad_zbl' );							-- set an error message
		end
	end
	return external_link_id({link = handler.link, label = handler.label, q = handler.q,
			prefix=handler.prefix,id=id,separator=handler.separator, encode=handler.encode}) .. err_cat;
end


--============================<< I N T E R F A C E   F U N C T I O N S >>==========================================

--[[--------------------------< B U I L D _ I D _ L I S T >--------------------------------------------------------

Takes a table of IDs created by extract_ids() and turns it into a table of formatted ID outputs.

inputs:
	id_list – table of identifiers built by extract_ids()
	options – table of various template parameter values used to modify some manually handled identifiers

]]

local function build_id_list( id_list, options )
	local new_list, handler = {};

	local function fallback(k) return { __index = function(t,i) return cfg.id_handlers[k][i] end } end;
	
	for k, v in pairs( id_list ) do												-- k is uc identifier name as index to cfg.id_handlers; e.g. cfg.id_handlers['ISBN'], v is a table
		-- fallback to read-only cfg
		handler = setmetatable( { ['id'] = v, ['access'] = options.IdAccessLevels[k] }, fallback(k) );

		if handler.mode == 'external' then
			table.insert( new_list, {handler.label, external_link_id( handler ) } );
		elseif handler.mode == 'internal' then
			table.insert( new_list, {handler.label, internal_link_id( handler ) } );
		elseif handler.mode ~= 'manual' then
			error( cfg.messages['unknown_ID_mode'] );
		elseif k == 'ARXIV' then
			table.insert( new_list, {handler.label, arxiv( v, options.Class ) } ); 
		elseif k == 'ASIN' then
			table.insert( new_list, {handler.label, asin( v, options.ASINTLD ) } ); 
		elseif k == 'BIBCODE' then
			table.insert( new_list, {handler.label, bibcode( v, handler.access ) } );
		elseif k == 'BIORXIV' then
			table.insert( new_list, {handler.label, biorxiv( v ) } );
		elseif k == 'CITESEERX' then
			table.insert( new_list, {handler.label, citeseerx( v ) } );
		elseif k == 'CNID' then
			table.insert( new_list, {handler.label, cnid( v ) } );
		elseif k == 'CSBN' then
			table.insert( new_list, {handler.label, csbn( v ) } );
		elseif k == 'DOI' then
			table.insert( new_list, {handler.label, doi( v, options.DoiBroken, handler.access ) } );
		elseif k == 'EISSN' then
			table.insert( new_list, {handler.label, issn( v, true ) } );		-- true distinguishes eissn from issn
		elseif k == 'HDL' then
			table.insert( new_list, {handler.label, hdl( v, handler.access ) } );
		elseif k == 'ISBN' then
			local ISBN = internal_link_id( handler );
			local check;
			local err_type = '';
			check, err_type = isbn( v );
			if not check then
				if is_set(options.IgnoreISBN) then								-- ISBN is invalid; if |ignore-isbn-error= set
					add_maint_cat ('ignore_isbn_err');							-- ad a maint category
				else
					ISBN = ISBN .. set_error( 'bad_isbn', {err_type}, false, " ", "" );	-- else display an error message
				end
			elseif is_set(options.IgnoreISBN) then								-- ISBN is OK; if |ignore-isbn-error= set
				add_maint_cat ('ignore_isbn_err');								-- because |ignore-isbn-error= unnecessary
			end
			table.insert( new_list, {handler.label, ISBN } );				
		elseif k == 'ISMN' then
			table.insert( new_list, {handler.label, ismn( v ) } );
		elseif k == 'ISSN' then
			table.insert( new_list, {handler.label, issn( v ) } );
		elseif k == 'JFM' then
			table.insert( new_list, {handler.label, jfm( v ) } );
		elseif k == 'LCCN' then
			table.insert( new_list, {handler.label, lccn( v ) } );
		elseif k == 'MR' then
			table.insert( new_list, {handler.label, mr( v ) } );
		elseif k == 'OCLC' then
			table.insert( new_list, {handler.label, oclc( v ) } );
		elseif k == 'OL' or k == 'OLA' then
			table.insert( new_list, {handler.label, openlibrary( v, handler.access ) } );
		elseif k == 'PMC' then
			table.insert( new_list, {handler.label, pmc( v, options.Embargo ) } );
		elseif k == 'PMID' then
			table.insert( new_list, {handler.label, pmid( v ) } );
		elseif k == 'S2CID' then
			table.insert( new_list, {handler.label, s2cid( v, handler.access ) } );
		elseif k == 'SSRN' then
			table.insert( new_list, {handler.label, ssrn( v ) } );
		elseif k == 'USENETID' then
			table.insert( new_list, {handler.label, usenet_id( v ) } );
		elseif k == 'ZBL' then
			table.insert( new_list, {handler.label, zbl( v ) } );
		else
			error( cfg.messages['unknown_manual_ID'] );
		end
	end
	
	local function comp( a, b )	-- used in following table.sort()
		return a[1] < b[1];
	end
	
	table.sort( new_list, comp );
	for k, v in ipairs( new_list ) do
		new_list[k] = v[2];
	end
	
	return new_list;
end


--[[--------------------------< E X T R A C T _ I D S >------------------------------------------------------------

Populates ID table from arguments using configuration settings. Loops through cfg.id_handlers and searches args for
any of the parameters listed in each cfg.id_handlers['...'].parameters.  If found, adds the parameter and value to
the identifier list.  Emits redundant error message is more than one alias exists in args

]]

local function extract_ids( args )
	local id_list = {};															-- list of identifiers found in args
	for k, v in pairs( cfg.id_handlers ) do										-- k is uc identifier name as index to cfg.id_handlers; e.g. cfg.id_handlers['ISBN'], v is a table
		v = select_one( args, v.parameters, 'redundant_parameters' );			-- v.parameters is a table of aliases for k; here we pick one from args if present
		if is_set(v) then id_list[k] = v; end									-- if found in args, add identifier to our list
	end
	return id_list;
end


--[[--------------------------< E X T R A C T _ I D _ A C C E S S _ L E V E L S >--------------------------------------

Fetches custom id access levels from arguments using configuration settings.
Parameters which have a predefined access level (e.g. arxiv) do not use this
function as they are directly rendered as free without using an additional parameter.

]]

local function extract_id_access_levels( args, id_list )
	local id_accesses_list = {};
	for k, v in pairs( cfg.id_handlers ) do
		local access_param = v.custom_access;
		local k_lower = string.lower(k);
		if is_set(access_param) then
			local access_level = args[access_param];
			if is_set(access_level) then
				if not in_array (access_level:lower(), cfg.keywords['id-access']) then
					table.insert( z.message_tail, { set_error( 'invalid_param_val', {access_param, access_level}, true ) } );	
					access_level = nil;
				end
				if not is_set(id_list[k]) then
					table.insert( z.message_tail, { set_error( 'param_access_requires_param', {k_lower}, true ) } );
				end
				if is_set(access_level) then
					access_level = access_level:lower();
				end
				id_accesses_list[k] = access_level;
			end
		end
	end
	return id_accesses_list;
end


--[[--------------------------< S E T _ S E L E C T E D _ M O D U L E S >--------------------------------------

Sets local cfg table and imported functions table to same (live or sandbox) as that used by the other modules.

]]

local function set_selected_modules (cfg_table_ptr, utilities_page_ptr, validation_page_ptr)
	cfg = cfg_table_ptr;

	is_set = utilities_page_ptr.is_set;											-- import functions from select Module:Citation/CS1/Utilities module
	in_array = utilities_page_ptr.in_array;
	set_error = utilities_page_ptr.set_error;
	select_one = utilities_page_ptr.select_one;
	add_maint_cat = utilities_page_ptr.add_maint_cat;
	substitute = utilities_page_ptr.substitute;
	make_wikilink = utilities_page_ptr.make_wikilink;
	is_valid_date_from_a_point = validation_page_ptr.is_valid_date_from_a_point;
	z = utilities_page_ptr.z;													-- table of tables in Module:Citation/CS1/Utilities
end


--[[--------------------------< E X P O R T E D   F U N C T I O N S >------------------------------------------
]]

return {
	build_id_list = build_id_list,
	extract_ids = extract_ids,
	extract_id_access_levels = extract_id_access_levels,
	is_embargoed = is_embargoed;
	set_selected_modules = set_selected_modules;
	}