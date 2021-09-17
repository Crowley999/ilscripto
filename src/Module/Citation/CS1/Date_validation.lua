local p = {}
--[[--------------------------< I S _ V A L I D _ D A T E _ F R O M _ A _ P O I N T >-------------------------
将日期验证的逻辑拆分出来，供其它模块使用
]]
local function is_valid_date_from_a_point (date, point_ts)
	local lang = mw.getContentLanguage();
	local good1, good2;
	local access_ts, tomorrow_ts;												-- to hold unix time stamps representing the dates
	good1, access_ts = pcall( lang.formatDate, lang, 'U', date );				-- convert date value to unix timesatmp 
	good2, tomorrow_ts = pcall( lang.formatDate, lang, 'U', 'today + 2 days' );	-- today midnight + 2 days is one second more than all day tomorrow
	
	if good1 and good2 then
		access_ts = tonumber (access_ts);										-- convert to numbers for the comparison
		tomorrow_ts = tonumber (tomorrow_ts);
	else
		return false;															-- one or both failed to convert to unix time stamp
	end
	
	if point_ts <= access_ts and access_ts < tomorrow_ts then					-- the point <= date < tomorrow's date
		return true;
	else
		return false;															-- date out of range
	end
end

--[[--------------------------< I S _ V A L I D _ A C C E S S D A T E >----------------------------------------

returns true if:
	Wikipedia start date <= accessdate < today + 2 days

Wikipedia start date is 2001-01-15T00:00:00 UTC which is 979516800 seconds after 1970-01-01T00:00:00 UTC (the start of Unix time)
accessdate is the date provided in |accessdate= at time 00:00:00 UTC
today is the current date at time 00:00:00 UTC plus 48 hours
	if today is 2015-01-01T00:00:00 then
		adding 24 hours gives 2015-01-02T00:00:00 – one second more than today
		adding 24 hours gives 2015-01-03T00:00:00 – one second more than tomorrow

]]

local function is_valid_accessdate (accessdate)
	accessdate = accessdate:gsub("年", "-");
	accessdate = accessdate:gsub("月", "-");
	accessdate = accessdate:gsub("日", "-");
	accessdate = accessdate:gsub("-$", "");
	return is_valid_date_from_a_point (accessdate, 979516800);
end

--[[--------------------------< G E T _ M O N T H _ N U M B E R >----------------------------------------------

returns a number according to the month in a date: 1 for January, etc.  Capitalization and spelling must be correct. If not a valid month, returns 0

]]

local function get_month_number (month)
local long_months = {['January']=1, ['February']=2, ['March']=3, ['April']=4, ['May']=5, ['June']=6, ['July']=7, ['August']=8, ['September']=9, ['October']=10, ['November']=11, ['December']=12};
local short_months = {['Jan']=1, ['Feb']=2, ['Mar']=3, ['Apr']=4, ['May']=5, ['Jun']=6, ['Jul']=7, ['Aug']=8, ['Sep']=9, ['Oct']=10, ['Nov']=11, ['Dec']=12};
local zh_months = {['1月']=1, ['2月']=2, ['3月']=3, ['4月']=4, ['5月']=5, ['6月']=6, ['7月']=7, ['8月']=8, ['9月']=9, ['10月']=10, ['11月']=11, ['12月']=12}; -- LOCAL
local temp;
	temp=long_months[month];
	if temp then return temp; end				-- if month is the long-form name
	temp=short_months[month];
	if temp then return temp; end				-- if month is the short-form name
	temp=zh_months[month]; -- LOCAL
	if temp then return temp; end				-- if month is in Chinese -- LOCAL
	return 0;									-- misspelled, improper case, or not a month name
end

--[[--------------------------< G E T _ S E A S O N _ N U M B E R >--------------------------------------------

returns a number according to the sequence of seasons in a year: 1 for Winter, etc.  Capitalization and spelling must be correct. If not a valid season, returns 0

]]

local function get_season_number (season)
local season_list = {['Winter']=21, ['Spring']=22, ['Summer']=23, ['Fall']=24, ['Autumn']=24};	-- make sure these numbers do not overlap month numbers
local temp;
	temp=season_list[season];
	if temp then return temp; end												-- if season is a valid name return its number
	return 0;																	-- misspelled, improper case, or not a season name
end

--[[--------------------------< I S _ P R O P E R _ N A M E >--------------------------------------------------

returns a non-zero number if date contains a recognized proper name.  Capitalization and spelling must be correct.

]]

local function is_proper_name (name)
local name_list = {['Christmas']=31}
local temp;
	temp=name_list[name];
	if temp then return temp; end				-- if name is a valid name return its number
	return 0;									-- misspelled, improper case, or not a proper name
end

--[[--------------------------< I S _ V A L I D _ M O N T H _ O R _ S E A S O N >------------------------------

--returns true if month or season is valid (properly spelled, capitalized, abbreviated)

]]

local function is_valid_month_or_season (month_season)
	if 0 == get_month_number (month_season) then		-- if month text isn't one of the twelve months, might be a season
		if 0 == get_season_number (month_season) then	-- not a month, is it a season?
			return false;								-- return false not a month or one of the five seasons
		end
	end
	return true;
end

--[[--------------------------< I S _ V A L I D _ Y E A R >----------------------------------------------------

Function gets current year from the server and compares it to year from a citation parameter.  Years more than one year in the future are not acceptable.

]]

local function is_valid_year(year)
	if not is_set(year_limit) then
		year_limit = tonumber(os.date("%Y"))+1;			-- global variable so we only have to fetch it once
	end
	return tonumber(year) <= year_limit;				-- false if year is in the future more than one year
end

--[[--------------------------< I S _ V A L I D _ D A T E >----------------------------------------------------
Returns true if day is less than or equal to the number of days in month and year is no farther into the future
than next year; else returns false.

Assumes Julian calendar prior to year 1582 and Gregorian calendar thereafter. Accounts for Julian calendar leap
years before 1582 and Gregorian leap years after 1582. Where the two calendars overlap (1582 to approximately
1923) dates are assumed to be Gregorian.

]]

local function is_valid_date (year, month, day)
local days_in_month = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
local month_length;
	if not is_valid_year(year) then												-- no farther into the future than next year
		return false;
	end
	
	month = tonumber(month);													-- required for YYYY-MM-DD dates
	
	if (2==month) then															-- if February
		month_length = 28;														-- then 28 days unless
		if 1582 > tonumber(year) then											-- Julian calendar
			if 0==(year%4) then
				month_length = 29;
			end
		else																	-- Gregorian calendar
			if (0==(year%4) and (0~=(year%100) or 0==(year%400))) then			-- is a leap year?
				month_length = 29;												-- if leap year then 29 days in February
			end
		end
	else
		month_length=days_in_month[month];
	end

	if tonumber (day) > month_length then
		return false;
	end
	return true;
end

--[[--------------------------< I S _ V A L I D _ M O N T H _ R A N G E _ S T Y L E >--------------------------

Months in a range are expected to have the same style: Jan–Mar or October–December but not February–Mar or Jul–August. 
There is a special test for May because it can be either short or long form.

Returns true when style for both months is the same

]]

local function is_valid_month_range_style (month1, month2)
local len1 = month1:len();
local len2 = month2:len();
	if len1 == len2 then
		return true;															-- both months are short form so return true
	elseif 'May' == month1 or 'May'== month2 then
		return true;															-- both months are long form so return true
	elseif 3 == len1 or 3 == len2 then
		return false;															-- months are mixed form so return false
	else
		return true;															-- both months are long form so return true
	end
end


--[[--------------------------< I S _ V A L I D _ M O N T H _ S E A S O N _ R A N G E >------------------------

Check a pair of months or seasons to see if both are valid members of a month or season pair.

Month pairs are expected to be left to right, earliest to latest in time.

Similarly, seasons are also left to right, earliest to latest in time.  There is an oddity with seasons: winter is assigned a value of 1, spring 2, ...,
fall and autumn 4.  Because winter can follow fall/autumn at the end of a calender year, a special test is made to see if |date=Fall-Winter yyyy (4-1) is the date.

]]

local function is_valid_month_season_range(range_start, range_end)
	local range_start_number = get_month_number (range_start);
	
	if 0 == range_start_number then												-- is this a month range?
		local range_start_number = get_season_number (range_start);				-- not a month; is it a season? get start season number
		local range_end_number = get_season_number (range_end);					-- get end season number

		if 0 ~= range_start_number then											-- is start of range a season?
			if range_start_number < range_end_number then						-- range_start is a season
				return true;													-- return true when range_end is also a season and follows start season; else false
			end
			if 24 == range_start_number and 21 == range_end_number then			-- special case when season range is Fall-Winter or Autumn-Winter
				return true;
			end
		end
		return false;		-- range_start is not a month or a season; or range_start is a season and range_end is not; or improper season sequence
	end

	local range_end_number = get_month_number (range_end);						-- get end month number
	if range_start_number < range_end_number then								-- range_start is a month; does range_start precede range_end?
		if is_valid_month_range_style (range_start, range_end) then				-- do months have the same style?
			return true;														-- proper order and same style
		end
	end
	return false;																-- range_start month number is greater than or equal to range end number; or range end isn't a month
end


--[[--------------------------< M A K E _ C O I N S _ D A T E >------------------------------------------------

This function receives a table of date parts for one or two dates and an empty table reference declared in
Module:Citation/CS1.  The function is called only for |date= parameters and only if the |date=<value> is 
determined to be a valid date format.  The question of what to do with invalid date formats is not answered here.

The date parts in the input table are converted to an ISO 8601 conforming date string:
	single whole dates:		yyyy-mm-dd
	month and year dates:	yyyy-mm
	year dates:				yyyy
	ranges:					yyyy-mm-dd/yyyy-mm-dd
							yyyy-mm/yyyy-mm
							yyyy/yyyy

Dates in the Julian calendar are reduced to year or year/year so that we don't have to do calendar conversion from
Julian to Proleptic Gregorian.

The input table has:
	year, year2 – always present; if before 1582, ignore months and days if present
	month, month2 – 0 if not provided, 1-12 for months, 21-24 for seasons; 31– proper name dates
	day, day2 –  0 if not provided, 1-31 for days
	
the output table receives:
	rftdate:	an IS8601 formatted date
	rftchron:	a free-form version of the date, usually without year which is in rftdate (season ranges and propername dates)
	rftssn:		one of four season keywords: winter, spring, summer, fall (lowercase)

]]

local function make_COinS_date (input, tCOinS_date)
	local date;																	-- one date or first date in a range
	local date2 = '';															-- end of range date
	
	if 1582 > tonumber(input.year) or 20 < tonumber(input.month) then			-- Julian calendar or season so &rft.date gets year only
		date = input.year;
		if 0 ~= input.year2 and input.year ~= input.year2 then					-- if a range, only the second year portion when not the same as range start year
			date = string.format ('%.4d/%.4d', tonumber(input.year), tonumber(input.year2))		-- assemble the date range
		end
		if 20 < tonumber(input.month) then										-- if season or propername date
			local season = {[21]='winter', [22]='spring', [23]='summer', [24]='fall', [31]='Christmas'};	-- seasons lowercase, no autumn; proper names use title case
			if 0 == input.month2 then											-- single season date
				if 30 <tonumber(input.month) then
					tCOinS_date.rftchron = season[input.month];					-- proper name dates
				else
					tCOinS_date.rftssn = season[input.month];					-- seasons
				end
			else																-- season range with a second season specified
				if input.year ~= input.year2 then								-- season year – season year range or season year–year
					tCOinS_date.rftssn = season[input.month];					-- start of range season; keep this?
					if 0~= month2 then
						tCOinS_date.rftchron = string.format ('%s %s – %s %s', season[input.month], input.year, season[input.month2], input.year2);
					end
				else															-- season–season year range
					tCOinS_date.rftssn = season[input.month];					-- start of range season; keep this?
					tCOinS_date.rftchron = season[input.month] .. '–' .. season[input.month2];	-- season–season year range
				end
			end
		end
		tCOinS_date.rftdate = date;
		return;																	-- done
	end
	
	if 0 ~= input.day then
		date = string.format ('%s-%.2d-%.2d', input.year, tonumber(input.month), tonumber(input.day));	-- whole date
	elseif 0 ~= input.month then
		date = string.format ('%s-%.2d', input.year, tonumber(input.month));	-- year and month
	else
		date = string.format ('%s', input.year);								-- just year
	end

	if 0 ~= input.year2 then
		if 0 ~= input.day2 then
			date2 = string.format ('/%s-%.2d-%.2d', input.year2, tonumber(input.month2), tonumber(input.day2));		-- whole date
		elseif 0 ~= input.month2 then
			date2 = string.format ('/%s-%.2d', input.year2, tonumber(input.month2));	-- year and month
		else
			date2 = string.format ('/%s', input.year2);							-- just year
		end
	end
	
	tCOinS_date.rftdate = date .. date2;										-- date2 has the '/' separator
	return;
end


--[[--------------------------< C H E C K _ D A T E >----------------------------------------------------------

Check date format to see that it is one of the formats approved by WP:DATESNO or WP:DATERANGE. Exception: only
allowed range separator is endash.  Additionally, check the date to see that it is a real date: no 31 in 30-day
months; no 29 February when not a leap year.  Months, both long-form and three character abbreviations, and seasons
must be spelled correctly.  Future years beyond next year are not allowed.

If the date fails the format tests, this function returns false and does not return values for anchor_year and
COinS_date.  When this happens, the date parameter is used in the COinS metadata and the CITEREF identifier gets
its year from the year parameter if present otherwise CITEREF does not get a date value.

Inputs:
	date_string - date string from date-holding parameters (date, year, accessdate, embargo, archivedate, etc.)

Returns:
	false if date string is not a real date; else
	true, anchor_year, COinS_date
		anchor_year can be used in CITEREF anchors
		COinS_date is ISO 8601 format date; see make_COInS_date()

]]

local function check_date (date_string, tCOinS_date)
	local year;			-- assume that year2, months, and days are not used;
	local year2=0;		-- second year in a year range
	local month=0;
	local month2=0;		-- second month in a month range
	local day=0;
	local day2=0;		-- second day in a day range
	local anchor_year;
	local coins_date;

	if date_string:match("^%d%d%d%d%-%d%d%-%d%d$") then										-- year-initial numerical year month day format
		year, month, day=string.match(date_string, "(%d%d%d%d)%-(%d%d)%-(%d%d)");
		if 12 < tonumber(month) or 1 > tonumber(month) or 1583 > tonumber(year) then return false; end			-- month number not valid or not Gregorian calendar
		anchor_year = year;

	elseif date_string:match("^%a+ +[1-9]%d?, +[1-9]%d%d%d%a?$") then						-- month-initial: month day, year
		month, day, anchor_year, year=string.match(date_string, "(%a+)%s*(%d%d?),%s*((%d%d%d%d)%a?)");
		month = get_month_number (month);
		if 0 == month then return false; end												-- return false if month text isn't one of the twelve months
				
	elseif date_string:match("^%a+ +[1-9]%d?–[1-9]%d?, +[1-9]%d%d%d%a?$") then				-- month-initial day range: month day–day, year; days are separated by endash
		month, day, day2, anchor_year, year=string.match(date_string, "(%a+) +(%d%d?)–(%d%d?), +((%d%d%d%d)%a?)");
		if tonumber(day) >= tonumber(day2) then return false; end							-- date range order is left to right: earlier to later; dates may not be the same;
		month = get_month_number (month);
		if 0 == month then return false; end												-- return false if month text isn't one of the twelve months
		month2=month;																		-- for metadata
		year2=year;

	elseif date_string:match("^[1-9]%d? +%a+ +[1-9]%d%d%d%a?$") then						-- day-initial: day month year
		day, month, anchor_year, year=string.match(date_string, "(%d%d*)%s*(%a+)%s*((%d%d%d%d)%a?)");
		month = get_month_number (month);
		if 0 == month then return false; end												-- return false if month text isn't one of the twelve months

	elseif date_string:match("^[1-9]%d?–[1-9]%d? +%a+ +[1-9]%d%d%d%a?$") then				-- day-range-initial: day–day month year; days are separated by endash
		day, day2, month, anchor_year, year=string.match(date_string, "(%d%d?)–(%d%d?) +(%a+) +((%d%d%d%d)%a?)");
		if tonumber(day) >= tonumber(day2) then return false; end							-- date range order is left to right: earlier to later; dates may not be the same;
		month = get_month_number (month);
		if 0 == month then return false; end												-- return false if month text isn't one of the twelve months
		month2=month;																		-- for metadata
		year2=year;

	elseif date_string:match("^[1-9]%d? +%a+ – [1-9]%d? +%a+ +[1-9]%d%d%d%a?$") then		-- day initial month-day-range: day month - day month year; uses spaced endash
		day, month, day2, month2, anchor_year, year=date_string:match("(%d%d?) +(%a+) – (%d%d?) +(%a+) +((%d%d%d%d)%a?)");
		if (not is_valid_month_season_range(month, month2)) or not is_valid_year(year) then return false; end	-- date range order is left to right: earlier to later;
		month = get_month_number (month);													-- for metadata
		month2 = get_month_number (month2);
		year2=year;

	elseif date_string:match("^%a+ +[1-9]%d? – %a+ +[1-9]%d?, +[1-9]%d%d%d?%a?$") then		-- month initial month-day-range: month day – month day, year;  uses spaced endash
		month, day, month2, day2, anchor_year, year=date_string:match("(%a+) +(%d%d?) – (%a+) +(%d%d?), +((%d%d%d%d)%a?)");
		if (not is_valid_month_season_range(month, month2)) or not is_valid_year(year) then return false; end
		month = get_month_number (month);													-- for metadata
		month2 = get_month_number (month2);
		year2=year;

	elseif date_string:match("^[1-9]%d? +%a+ +[1-9]%d%d%d – [1-9]%d? +%a+ +[1-9]%d%d%d%a?$") then		-- day initial month-day-year-range: day month year - day month year; uses spaced endash
		day, month, year, day2, month2, anchor_year, year2=date_string:match("(%d%d?) +(%a+) +(%d%d%d%d?) – (%d%d?) +(%a+) +((%d%d%d%d?)%a?)");
		if tonumber(year2) <= tonumber(year) then return false; end												-- must be sequential years, left to right, earlier to later
		if not is_valid_year(year2) or not is_valid_month_range_style(month, month2) then return false; end		-- year2 no more than one year in the future; months same style
		month = get_month_number (month);																		-- for metadata
		month2 = get_month_number (month2);

	elseif date_string:match("^%a+ +[1-9]%d?, +[1-9]%d%d%d – %a+ +[1-9]%d?, +[1-9]%d%d%d%a?$") then		-- month initial month-day-year-range: month day, year – month day, year;  uses spaced endash
		month, day, year, month2, day2, anchor_year, year2=date_string:match("(%a+) +(%d%d?), +(%d%d%d%d) – (%a+) +(%d%d?), +((%d%d%d%d)%a?)");
		if tonumber(year2) <= tonumber(year) then return false; end												-- must be sequential years, left to right, earlier to later
		if not is_valid_year(year2) or not is_valid_month_range_style(month, month2) then return false; end		-- year2 no more than one year in the future; months same style
		month = get_month_number (month);																		-- for metadata
		month2 = get_month_number (month2);

	elseif date_string:match("^%a+ +[1-9]%d%d%d–%d%d%a?$") then								-- special case Winter/Summer year-year (YYYY-YY); year separated with unspaced endash
		local century;
		month, year, century, anchor_year, year2=date_string:match("(%a+) +((%d%d)%d%d)–((%d%d)%a?)");
		if 'Winter' ~= month and 'Summer' ~= month then return false end;					-- 'month' can only be Winter or Summer
		anchor_year=year..'–'..anchor_year;													-- assemble anchor_year from both years
		year2 = century..year2;																-- add the century to year2 for comparisons
		if 1 ~= tonumber(year2) - tonumber(year) then return false; end						-- must be sequential years, left to right, earlier to later
		if not is_valid_year(year2) then return false; end									-- no year farther in the future than next year
		month = get_season_number (month);

	elseif date_string:match("^%a+ +[1-9]%d%d%d–[1-9]%d%d%d%a?$") then						-- special case Winter/Summer year-year; year separated with unspaced endash
		month, year, anchor_year, year2=date_string:match("(%a+) +(%d%d%d%d)–((%d%d%d%d)%a?)");
		if 'Winter' ~= month and 'Summer' ~= month then return false end;					-- 'month' can only be Winter or Summer
		anchor_year=year..'–'..anchor_year;													-- assemble anchor_year from both years
		if 1 ~= tonumber(year2) - tonumber(year) then return false; end						-- must be sequential years, left to right, earlier to later
		if not is_valid_year(year2) then return false; end									-- no year farther in the future than next year
		month = get_season_number (month);													-- for metadata

	elseif date_string:match("^%a+ +[1-9]%d%d%d% – %a+ +[1-9]%d%d%d%a?$") then				-- month/season year - month/season year; separated by spaced endash
		month, year, month2, anchor_year, year2=date_string:match("(%a+) +(%d%d%d%d) – (%a+) +((%d%d%d%d)%a?)");
		anchor_year=year..'–'..anchor_year;													-- assemble anchor_year from both years
		if tonumber(year) >= tonumber(year2) then return false; end							-- left to right, earlier to later, not the same
		if not is_valid_year(year2) then return false; end									-- no year farther in the future than next year
		if 0 ~= get_month_number(month) and 0 ~= get_month_number(month2) and is_valid_month_range_style(month, month2) then 	-- both must be month year, same month style
			month = get_month_number(month);
			month2 = get_month_number(month2);
		elseif 0 ~= get_season_number(month) and 0 ~= get_season_number(month2) then		-- both must be or season year, not mixed
			month = get_season_number(month);
			month2 = get_season_number(month2);
		else
			 return false;
		end

	elseif date_string:match ("^%a+–%a+ +[1-9]%d%d%d%a?$") then					-- month/season range year; months separated by endash 
		month, month2, anchor_year, year=date_string:match ("(%a+)–(%a+)%s*((%d%d%d%d)%a?)");
		if (not is_valid_month_season_range(month, month2)) or (not is_valid_year(year)) then return false; end
		if 0 ~= get_month_number(month) then									-- determined to be a valid range so just check this one to know if month or season
			month = get_month_number(month);
			month2 = get_month_number(month2);
		else
			month = get_season_number(month);
			month2 = get_season_number(month2);
		end
		year2=year;
		
	elseif date_string:match("^%a+ +%d%d%d%d%a?$") then							-- month/season year or proper-name year
		month, anchor_year, year=date_string:match("(%a+)%s*((%d%d%d%d)%a?)");
		if not is_valid_year(year) then return false; end
		if not is_valid_month_or_season (month) and 0 == is_proper_name (month) then return false; end
		if 0 ~= get_month_number(month) then									-- determined to be a valid range so just check this one to know if month or season
			month = get_month_number(month);
		elseif 0 ~= get_season_number(month) then
			month = get_season_number(month);
		else
			month = is_proper_name (month);										-- must be proper name; not supported in COinS
		end

	elseif date_string:match("^[1-9]%d%d%d?–[1-9]%d%d%d?%a?$") then				-- Year range: YYY-YYY or YYY-YYYY or YYYY–YYYY; separated by unspaced endash; 100-9999
		year, anchor_year, year2=date_string:match("(%d%d%d%d?)–((%d%d%d%d?)%a?)");
		anchor_year=year..'–'..anchor_year;										-- assemble anchor year from both years
		if tonumber(year) >= tonumber(year2) then return false; end				-- left to right, earlier to later, not the same
		if not is_valid_year(year2) then return false; end						-- no year farther in the future than next year

	elseif date_string:match("^[1-9]%d%d%d–%d%d%a?$") then						-- Year range: YYYY–YY; separated by unspaced endash
		local century;
		year, century, anchor_year, year2=date_string:match("((%d%d)%d%d)–((%d%d)%a?)");
		anchor_year=year..'–'..anchor_year;										-- assemble anchor year from both years
		if 13 > tonumber(year2) then return false; end							-- don't allow 2003-05 which might be May 2003
		year2 = century..year2;													-- add the century to year2 for comparisons
		if tonumber(year) >= tonumber(year2) then return false; end				-- left to right, earlier to later, not the same
		if not is_valid_year(year2) then return false; end						-- no year farther in the future than next year

	elseif date_string:match("^[1-9]%d%d%d?%a?$") then							-- year; here accept either YYY or YYYY
		anchor_year, year=date_string:match("((%d%d%d%d?)%a?)");
		if false == is_valid_year(year) then
			return false;
		end

	-- LOCAL: do not use mw.ustring: it allows full-width characters for %d.
	elseif date_string:match("^[1-9]%d%d%d年[1-9]%d?月[1-9]%d?日$") then						-- zh: year month day
		year, month, day=date_string:match("(%d%d%d%d)年(%d%d*月)(%d%d*)日");
		month = get_month_number (month);
		if 0 == month then return false; end
		anchor_year = year;

	elseif date_string:match("^[1-9]%d%d%d年[1-9]%d?月$") then							-- zh: year month
		year, month=date_string:match("(%d%d%d%d)年(%d%d*月)");
		month = get_month_number (month);
		if 0 == month then return false; end
		anchor_year = year;

	elseif date_string:match("^[1-9]%d%d%d?年$") then							-- zh: year; here accept either YYY or YYYY
		year=date_string:match("(%d%d%d%d?)年");
		if false == is_valid_year(year) then
			return false;
		end
		anchor_year = year;

	elseif date_string:match("^%d%d%d%d%-%d%d$") then							-- numerical year month format
		year, month=date_string:match("(%d%d%d%d)%-(%d%d)");
		month=tonumber(month);
		if 12 < month or 1 > month or 1583 > tonumber(year) then return false; end			-- month number not valid or not Gregorian calendar
		anchor_year = year;
	-- END LOCAL

	else
		return false;															-- date format not one of the MOS:DATE approved formats
	end

	local result=true;															-- check whole dates for validity; assume true because not all dates will go through this test
	if 0 ~= year and 0 ~= month and 0 ~= day and 0 == year2 and 0 == month2 and 0 == day2 then		-- YMD (simple whole date)
		result=is_valid_date(year,month,day);

	elseif 0 ~= year and 0 ~= month and 0 ~= day and 0 == year2 and 0 == month2 and 0 ~= day2 then	-- YMD-d (day range)
		result=is_valid_date(year,month,day);
		result=result and is_valid_date(year,month,day2);

	elseif 0 ~= year and 0 ~= month and 0 ~= day and 0 == year2 and 0 ~= month2 and 0 ~= day2 then	-- YMD-md (day month range)
		result=is_valid_date(year,month,day);
		result=result and is_valid_date(year,month2,day2);

	elseif 0 ~= year and 0 ~= month and 0 ~= day and 0 ~= year2 and 0 ~= month2 and 0 ~= day2 then	-- YMD-ymd (day month year range)
		result=is_valid_date(year,month,day);
		result=result and is_valid_date(year2,month2,day2);
	end
	
	if false == result then return false; end

	if nil ~= tCOinS_date then													-- this table only passed into this function when testing |date= parameter values
		make_COinS_date ({year=year, month=month, day=day, year2=year2, month2=month2, day2=day2}, tCOinS_date);	-- make an ISO 8601 date string for COinS
	end
	
	return true, anchor_year;													-- format is good and date string represents a real date
end	


--[[--------------------------< D A T E S >--------------------------------------------------------------------

Cycle the date-holding parameters in passed table date_parameters_list through check_date() to check compliance with MOS:DATE. For all valid dates, check_date() returns
true. The |date= parameter test is unique, it is the only date holding parameter from which values for anchor_year (used in CITEREF identifiers) and COinS_date (used in
the COinS metadata) are derived.  The |date= parameter is the only date-holding parameter that is allowed to contain the no-date keywords "n.d." or "nd" (without quotes).

Unlike most error messages created in this module, only one error message is created by this function. Because all of the date holding parameters are processed serially,
a single error message is created as the dates are tested.

]]

local function dates(date_parameters_list, tCOinS_date)
	local anchor_year;		-- will return as nil if the date being tested is not |date=
	local COinS_date;		-- will return as nil if the date being tested is not |date=
	local error_message = "";
	local good_date = false;
	
	for k, v in pairs(date_parameters_list) do									-- for each date-holding parameter in the list
		if is_set(v) then														-- if the parameter has a value
			if v:match("^c%. [1-9]%d%d%d?%a?$") then							-- special case for c. year or with or without CITEREF disambiguator - only |date= and |year=
				local year = v:match("c%. ([1-9]%d%d%d?)%a?");					-- get the year portion so it can be tested
				if 'date'==k then
					anchor_year, COinS_date = v:match("((c%. [1-9]%d%d%d?)%a?)");	-- anchor year and COinS_date only from |date= parameter
					good_date = is_valid_year(year);
				elseif 'year'==k then
					good_date = is_valid_year(year);
				end
			elseif 'date'==k then												-- if the parameter is |date=
				if v:match("^n%.d%.%a?") then									-- if |date=n.d. with or without a CITEREF disambiguator
					good_date, anchor_year, COinS_date = true, v:match("((n%.d%.)%a?)");	--"n.d."; no error when date parameter is set to no date
				elseif v:match("^nd%a?$") then									-- if |date=nd with or without a CITEREF disambiguator
					good_date, anchor_year, COinS_date = true, v:match("((nd)%a?)");	--"nd";	no error when date parameter is set to no date
				else
					good_date, anchor_year, COinS_date = check_date (v, tCOinS_date);	-- go test the date
				end
			elseif 'access-date'==k then										-- if the parameter is |date=
				good_date = check_date (v);										-- go test the date
				if true == good_date then										-- if the date is a valid date
					good_date = is_valid_accessdate (v);						-- is Wikipedia start date < accessdate < tomorrow's date?
				end
			else																-- any other date-holding parameter
				good_date = check_date (v);										-- go test the date
			end
			if false==good_date then											-- assemble one error message so we don't add the tracking category multiple times
				if is_set(error_message) then									-- once we've added the first portion of the error message ...
					error_message=error_message .. ", ";						-- ... add a comma space separator
				end
				error_message=error_message .. "&#124;" .. k .. "=";			-- add the failed parameter
			end
		end
	end
	return anchor_year, error_message;											-- and done
end


--[[--------------------------< Y E A R _ D A T E _ C H E C K >------------------------------------------------

Compare the value provided in |year= with the year value(s) provided in |date=.  This function returns a numeric value:
	0 - year value does not match the year value in date
	1 - (default) year value matches the year value in date or one of the year values when date contains two years
	2 - year value matches the year value in date when date is in the form YYYY-MM-DD and year is disambiguated (|year=YYYYx)

]]

local function year_date_check (year_string, date_string)
	local year;
	local date1;
	local date2;
	local result = 1;															-- result of the test; assume that the test passes
	
	year = year_string:match ('(%d%d%d%d?)');

	if date_string:match ('%d%d%d%d%-%d%d%-%d%d') and year_string:match ('%d%d%d%d%a') then	--special case where date and year required YYYY-MM-DD and YYYYx
		date1 = date_string:match ('(%d%d%d%d)');
		year = year_string:match ('(%d%d%d%d)');
		if year ~= date1 then
			result = 0;															-- years don't match
		else
			result = 2;															-- years match; but because disambiguated, don't add to maint cat
		end
		
	elseif date_string:match ("%d%d%d%d?.-%d%d%d%d?") then						-- any of the standard formats of date with two three- or four-digit years
		date1, date2 = date_string:match ("(%d%d%d%d?).-(%d%d%d%d?)");
		if year ~= date1 and year ~= date2 then
			result = 0;
		end

	elseif date_string:match ("%d%d%d%d[%s%-–]+%d%d") then						-- YYYY-YY date ranges
		local century;
		date1, century, date2 = date_string:match ("((%d%d)%d%d)[%s%-–]+(%d%d)");
		date2 = century..date2;													-- convert YY to YYYY
		if year ~= date1 and year ~= date2 then
			result = 0;
		end

	elseif date_string:match ("%d%d%d%d?") then									-- any of the standard formats of date with one year
		date1 = date_string:match ("(%d%d%d%d?)");
		if year ~= date1 then
			result = 0;
		end
	end
	return result;
end

return {dates = dates, year_date_check = year_date_check, is_valid_date_from_a_point = is_valid_date_from_a_point}						
																				-- return exported functions
