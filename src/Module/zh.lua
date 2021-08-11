local M = {}

local len = mw.ustring.len
local sub = mw.ustring.sub
local gsub = mw.ustring.gsub
local match = mw.ustring.match
local find = mw.ustring.find
local cmn_pron = nil

local function format_Chinese_text(text) return '<span class="Hani" lang="zh">' .. text .. '</span>' end
local function format_rom(text) return text and '<i><span class="tr Latn">' .. text .. '</span></i>' or nil end
local function format_gloss(text) return text and '“' .. text .. '”' or nil end

local function replace_chars(s, tab)
	-- use UTF-8 character pattern for speed
	return string.gsub(s, "[%z\1-\127\194-\244][\128-\191]*", tab)
end

function M.ts_determ(f)
	local m_ts_data = mw.loadData("Module:zh/data/ts")
	local m_st_data = mw.loadData("Module:zh/data/st")
	local text = type(f) == 'table' and f.args[1] or f
	local i = 0
	for cp in mw.ustring.gcodepoint(text) do
		local ch = mw.ustring.char(cp)
		if m_ts_data.ts[ch] then return 'trad' end
		if m_st_data.st[ch] then if i > 1 then return 'simp' else i = i + 1 end end
	end
	return (i > 0 and 'simp' or 'both')
end

function M.ts(f)
	local m_ts_data = mw.loadData("Module:zh/data/ts")
	local text = type(f) == 'table' and f.args[1] or f
	text = replace_chars(text, m_ts_data.ts)
	return text
end

function M.st(f)
	local m_st_data = mw.loadData("Module:zh/data/st")
	local text = type(f) == 'table' and f.args[1] or f
	text = replace_chars(text, m_st_data.st)
	return text
end

function M.py(text, comp, pos, p, is_erhua)
	local m_cmn_pron = mw.loadData("Module:zh/data/cmn-pron")
	if not is_erhua then is_erhua = false end
	if type(text) == 'table' then
		text, comp, pos, p, is_erhua = text.args[1], text.args[2], text.args[3], text.args[4], text.args[5]
	end
	comp = comp or ''
	local q = {}
	local sum = 0
	local length = len(text)
	if is_erhua then length = length - 1 end
	local textconv = text
	text = ''
	if comp ~= '' and comp ~= '12' and comp ~= '21' and not ((pos == 'cy' or pos == 'Idiom' or pos == 'idiom') and length == 4) and not is_erhua then
		for i = 1, len(comp) do
			sum = sum + tonumber(sub(comp,i,i))
			q[sum] = 'y'
		end
	end
	if not p then p={} end
	local initial = true
	for i = 1, length do
		if p[i] and p[i] ~= '' then --pronunciation supplied
			text = text .. p[i]
		else
			local char = sub(textconv,i,i)
			char = m_cmn_pron.py[char] or m_cmn_pron.py[M.ts(char)] or char
			if not is_erhua and not initial and find(char,'^[aoeāōēáóéǎǒěàòè]') then
				text = text .. "&#39;"
			end
			text = text .. char
			
			initial = char == sub(textconv,i,i)
				and sub(textconv,i-3,i) ~= "</b>" --checks for closing bold tag
				and (i-2 == 1 or sub(textconv,i-2,i) ~= "<b>" or sub(textconv,i-3,i) == "^<b>") --checks for opening bold tag
				and (i-3 == 1 or sub(textconv,i-3,i) ~= "^<b>") --checks for opening bold tag with capitalization
		end
		if q[i] == 'y' and i ~= length and not is_erhua then text = text .. ' ' end
	end
	text = gsub(text, "<b>&#39;", "&#39;<b>") --fix bolding of apostrophe
	
	if is_erhua then text = text .. 'r' end
	if pos == 'pn' or pos == 'propn' then
		local characters = mw.text.split(text,' ')
		for i=1,#characters do
			characters[i] = mw.language.getContentLanguage():ucfirst(characters[i])
		end
		text = table.concat(characters,' ')
	end
	return text
end

function M.py_er(text,comp,pos,p)
	return M.py(text,comp,pos,p,true)
end

function M.extract_pron(title, variety, cap)
	local tr = nil
	local title = mw.title.new(title)
	local content = title:getContent()
	if content then
		content = gsub(content, ",([^ ])", ";%1")
		local template = match(content, "{{zh%-pron[^}]*| ?" .. variety .. "=([^};|\n]+)")
		cap = cap or find(content, "{{zh%-pron[^}]*| ?" .. variety .. "=([^}|\n]+);cap%=y")
		if template and template ~= "" then
			if cmn_pron == nil then
			   cmn_pron = require("Module:cmn-pron")
			end
			tr = cmn_pron.str_analysis(template, 'link')
		end
	end
	if cap then
		tr = gsub(tr, '^(.)', mw.ustring.upper)
	end
	return tr
end

function M.link(frame, mention, args, pagename, no_transcript)
	local params = {
		[1] = {},
		[2] = {},
		[3] = {},
		[4] = {},
		['gloss'] = {},
		['tr'] = {},
		['lit'] = {},
		['t'] = { alias_of = 'gloss' },
	}
	
	if mention then
		params['note'] = {}
	end
	
	local moduleCalled
	if args then
		moduleCalled = true
	end
	args = args or frame:getParent().args
	if not moduleCalled then
		params[1].required = true
	end
	args = require("Module:parameters").process(args, params)
	if moduleCalled then
		if not args[1] then
			return ""
		end
	end
	pagename = pagename or mw.title.getCurrentTitle().text
	
	local text, tr, gloss
	
	if args[2] and match(args[2], '[一-龯㐀-䶵]') then
		gloss = args[4]
		tr = args[3]
		text = args[1] .. '/' .. args[2]
	else
		text = args[1]
		if args['gloss'] then
			tr = args[2]
			gloss = args['gloss']
		else
			if args[3] or (args[2] and (match(args[2], '[āōēīūǖáóéíúǘǎǒěǐǔǚàòèìùǜâêîôû̍ⁿ]') or match(args[2], '[bcdfghjklmnpqrstwz]h?y?[aeiou][aeiou]?[iumnptk]?g?[1-9]'))) then
				tr = args[2]
				gloss = args[3]
			else
				gloss = args[2]
			end
		end
	end
	if args['tr'] then
		tr = args['tr']
		gloss = gloss or args[2]
	end
	if text then
		if not text:match'%[%[.+%]%]' then
			local words = mw.text.split(text, "/", true)
			if #words == 1 and M.ts_determ(words[1]) == 'trad' and not match(words[1], '%*') then
				table.insert(words, M.ts(words[1]))
			end
			if not tr and not no_transcript and words[1] then
				cap = find(words[1], "^%^")
				words[1] = gsub(words[1], "^%^", "")
				if words[2] then
					words[2] = gsub(words[2], "^%^", "")
				end
				tr = M.extract_pron(words[1], "m", cap)
			end
		
			for i, word in ipairs(words) do
				word = gsub(word, '%*', '')
				if mention then
					words[i] = '<i class="Hani mention" lang="zh">[[' .. word .. '#Chinese|' .. word .. ']]</i>'
	--[[ (disabled to allow links to, for example, a link to 冥王星#Chinese from 冥王星#Japanese. 18 May, 2016)
				elseif word == pagename then
					word = format_Chinese_text('<b>' .. word .. '</b>')
	]]
				else
					words[i] = format_Chinese_text('[[' .. word .. '#Chinese|' .. word .. ']]')
				end
			end
			text = table.concat(words, "／")
		else
			text = require("Module:links").language_link{
				term = text,
				lang = require("Module:languages").getByCode("zh"),
			}
			if mention then
				text = '<i class="Hani mention" lang="zh">' .. gsub(text, "%*", "") .. '</i>'
			else
				text = format_Chinese_text(gsub(text, "%*", ""))
			end
		end
	end
	if tr == '-' or no_transcript then
		tr = nil -- allow translit to be disabled: remove translit if it is "-", just like normal {{l}}
	end
	local notes = args['note']
	local lit = args['lit']
	if tr or gloss or notes or lit then
		local annotations = {}
		if tr then
			tr = format_rom(tr)
			tr = gsub(tr, "&#39;", "'")
			tr = gsub(tr, "#", "")
			table.insert(annotations, tr)
		end
		if gloss then
			table.insert(annotations, format_gloss(gloss))
		end
		table.insert(annotations, notes)
		if lit then
			table.insert(annotations, "literally " .. format_gloss(lit))
		end
		annotations = table.concat(annotations, ", ")
		text = text .. " (" .. annotations .. ")"
	end
	return text
end

function M.mention(frame)
	return M.link(frame, true)
end

function M.check_pron(text, variety, length, entry_creation)
	if type(text) == 'table' then text, variety = text.args[1], text.args[2] end
	if not text then
		return
	end
	local startpoint, address = { ['yue'] = 51, ['hak'] = 19968, ['nan'] = 19968 }, { ['yue'] = 'yue-word/%03d', ['hak'] = 'hak-pron/%02d', ['nan'] = 'nan-pron/%03d' }
	local unit = 1000
	local first_char = sub(text, 1, 1)
	local result, success, data
	if length == 1 and variety == "yue" then
		success, data = pcall(mw.loadData, 'Module:zh/data/Jyutping character')
	else
		local page_index = math.floor((mw.ustring.codepoint(first_char) - startpoint[variety]) / unit)
		success, data = pcall(mw.loadData,
			('Module:zh/data/' .. address[variety]):format(page_index)
		)
	end
	if success then
		result = data[text] or false
	else
		result = false
	end
	if result then
		if variety == "nan" and entry_creation then
			result = gsub(result, "%-á%-", "-仔-")
			result = gsub(result, "%-á/", "-仔/")
			result = gsub(result, "%-á$", "-仔")
			result = gsub(result, "^(.+)%-%1%-%1$", "(%1)")
			result = gsub(result, "^(.+)%-%1%-%1([%-%/])", "(%1)%2")
			result = gsub(result, "([%-%/])(.+)%-%1%-%1$", "%1(%2)")
			result = gsub(result, "([%-%/])(.+)%-%1%-%1([%-%/])", "%1(%2)%3")
		end
	end
	return result
end

function M.der(frame)
	local params = {
		[1] = { list = true },
		["fold"] = { type = "boolean" },
		["name"] = {},
		["title"] = {},
		["hide_pron"] = { type = "boolean" },
	}
	
	local args = require("Module:parameters").process(frame:getParent().args, params)
	local pagename = mw.title.getCurrentTitle().text
	local result = {}
	
	local fold = args["fold"]
	local name = args["name"] or "Derived terms from"
	local title = args["title"] and " (<i>" .. args["title"] .. "</i>)" or ""
	local saurus = (mw.title.getCurrentTitle().nsText == "Thesaurus")
	local no_transcript = args["hide_pron"]
	
	if args["hide_pron"] then
		local m_ts_data = mw.loadData("Module:zh/data/ts")
		for _, word in ipairs(args[1]) do
			if word then
				local formatted_word = {}
				if match(word, "/") then
					for w in mw.text.gsplit(word, "/") do
						table.insert(formatted_word, format_Chinese_text("[[" .. w .. "#Chinese|" .. w .. "]]"))
					end
				else
					table.insert(formatted_word, format_Chinese_text("[[" .. word .. "#Chinese|" .. word .. "]]"))
					local word_s = replace_chars(word, m_ts_data.ts)
					if word_s ~= word then
						table.insert(formatted_word, format_Chinese_text("[[" .. word_s .. "#Chinese|" .. word_s .. "]]"))
					end
				end
				table.insert(result, table.concat(formatted_word, "／"))
			end
		end
	else
		for _, word in ipairs(args[1]) do
			note, word = match(word, ";(.+)") or nil, match(word, "^[^;]+")
			if word then
				local colon_pos = word:find(":")
				local split_word = colon_pos and { word:sub(1, colon_pos - 1), word:sub(colon_pos + 1) }
					or { word }
				local slash_pos = split_word[1]:find("/")
				local split_word_main = slash_pos and split_word[1]:sub(1, slash_pos - 1) or split_word[1]
				if split_word_main ~= pagename then  -- synonyms should not be the same as the title
					table.insert(result,
						M.link(frame, nil, split_word, pagename, no_transcript) ..
						(note and " (''" .. note .. "'')" or ""))
				end
			end
		end
	end
	
	return 
		require("Module:columns/old").create_table(
			(len(pagename) > 1 and 2 or 3), -- column number
			result, -- terms
			true, -- alphabetize
			"#F5F5FF", -- background
			(((#result > 72 or fold) and not saurus) and true or false), -- whether to collapse
			"derivedterms", -- class applied to table containing terms
			name .. " " .. format_Chinese_text(pagename) .. title, -- title
			nil, -- column width
			nil, -- line start (??)
			nil -- lang: not needed
		)
end

local lang_abbrev = {
	['m'] = 'Mandarin',
	['c'] = 'Cantonese', ['g'] = 'Gan', ['h'] = 'Hakka', ['j'] = 'Jin',
	['md'] = 'Min Dong', ['mn'] = 'Min Nan', ['mn-t'] = 'Teochew',
	['w'] = 'Wu', ['x'] = 'Xiang',
}

function M.cls(frame)
	local args = frame:getParent().args
	local result, categories = {}, {}
	local m_zh_cat = require("Module:zh-cat")
	local space = '<span style="padding-left:4px; padding-right:4px">&nbsp;</span>'
	for _, combination in ipairs(args) do
		local part = mw.text.split(combination, ":")
		local note
		if #part == 2 then
			local dialect = { "" }
			local function annotate(main_text, annotation)
				return "<span style=\"border-bottom: 1px dotted #000; cursor:help\" " ..
					"title=\"" .. annotation .. "\"><i>" .. main_text .. "</i></span>"
			end
			for variety in mw.text.gsplit(part[1], ",") do
				table.insert(dialect, annotate(variety, lang_abbrev[variety]))
			end
			note = table.concat(dialect, " ")
		else
			note = false
		end
		table.insert(result, M.link(frame, nil, { part[2] or part[1], tr = "-" }, pagename) .. -- pagename is undefined!
			(note or ""))
		table.insert(categories, m_zh_cat.categorize("Classifier:" .. (part[2] or part[1])))
	end
	return "<span style=\"padding-left:15px; font-size:80%\"><span style=\"background:#EDFFFF\">(''Classifier'': " ..
		table.concat(result, ";" .. space) .. ")</span></span>" .. 
		(mw.title.getCurrentTitle().nsText == "" and table.concat(categories) or "")
end

function M.wikipedia(frame)
	local args = frame:getParent().args
	local title = mw.title.getCurrentTitle().text
	local wp_data = {
		["zh"] = { "Written Standard Chinese<sup>[[w:Written vernacular Chinese|?]]</sup>", "zh" },
		["cdo"] = { "Min Dong", "cdo" },
		["gan"] = { "Gan", "zh" },
		["hak"] = { "Hakka", "hak" },
		["lzh"] = { "Classical", "zh" },
		["nan"] = { "Min Nan", "nan" },
		["wuu"] = { "Wu", "zh" },
		["yue"] = { "Cantonese", "zh" },
		["en"] = { "English", "en" },
	}
	
	args = args[1] and args or { "zh" }
	local result = { '<div class="sister-wikipedia sister-project noprint floatright" style="border: 1px solid #aaa; font-size: 90%; background: #f9f9f9; width: 250px; padding: 4px; text-align: left;"><div style="float: left;">[[File:Wikipedia-logo.png|32px|none|link=|alt=]]</div><div style="margin-left: 40px;">[[Wikipedia]] has ' ..
		(args[2] and "articles" or "an article") .. ' on:<ul>' }

	for _, arg in ipairs(args) do
		local lang, pagename = mw.ustring.match(arg, "(.+):(.+)")
		if not pagename then lang, pagename = arg, title end
		if lang == "zh-classical" then error("Please use lzh instead of zh-classical.")
		elseif lang == "zh-yue" then error("Please use yue instead of zh-yue.")
		elseif lang == "zh-min-nan" then error("Please use nan instead of zh-min-nan.") end
		local lang_data = wp_data[lang] or error("" .. lang .. " is not a recognized language.")
		local annotation = lang_data[1] or false
		if lang == "zh" and not args[2] then
			annotation = false
		elseif annotation then
			annotation = " <span style=\"font-size:80%\">(" .. annotation .. ")</span>"
		end
		local script = match(pagename, "[一-龯㐀-䶵]") and "Hani" or "Latn"
		table.insert(result, '<li><b class="' .. script .. '" lang="' .. lang_data[2] .. '">[[w&#x3a;' .. lang .. '&#x3a;' .. pagename .. '|' .. pagename .. ']]</b>' .. (annotation or "") .. '</li>')
	end
	
	table.insert(result, '</ul></div></div>')
	
	return table.concat(result)
end

function M.syn_saurus(frame, kind)
	local args = frame:getParent().args
	local title = mw.title.getCurrentTitle().text
	local word = args[1] or title
	local content = mw.title.new("Thesaurus:" .. word):getContent()
	local temp = kind or "syn"
	local template = match(content, "{{zh%-" .. temp .. "%-list|([^}]+)}}")
	if template and template ~= "" then
		local set = {}
		for item in mw.text.gsplit(template, "|") do
			table.insert(set, item ~= title and item or nil)
		end
		set["name"] = ((args["name"] or kind) == "ant") and "Antonyms of" or "Synonyms of"
		set["title"] = args["title"] or nil
		if args["fold"] or #set > 10 then set["fold"] = 1 end
		return '<div style="float: right; clear: right; font-size:60%"><span class="plainlinks">[' ..
		tostring(mw.uri.fullUrl("Thesaurus:" .. word, { ["action"] = "edit" })) ..
		' edit]</span></div>' .. frame:expandTemplate{ title = "Template:zh-list", args = set }
	else
		return ""
	end
end

function M.ant_saurus(frame)
	return M.syn_saurus(frame, "ant")
end

function M.div(frame)
	local args = frame:getParent().args
	local m_links = require("Module:links")
	local lang = require("Module:languages").getByCode("zh")
	local pagename = mw.title.getCurrentTitle().text
	local i, result = 1, ""
	
	local function add_link(pagename, description)
		local target_page = mw.title.new(pagename .. description)
		if target_page.exists and not target_page.isRedirect then
			return format_Chinese_text(m_links.language_link({ term = pagename .. description, alt = "～" .. description, lang = lang }))
		else
			return format_Chinese_text("～" .. m_links.language_link({ term = description, lang = lang }))
		end
	end

	while args[i] do
		if i ~= 1 then result = result .. "''separator ''" end
		result = result .. add_link(pagename, args[i])
		if i == 1 and args["f"] then
			local j = 2
			result = result .. "'', formerly ''" .. add_link(pagename, args["f"])
			while args["f" .. j] do
				result = result .. "'', ''" .. add_link(pagename, args["f" .. j])
				j = j + 1
			end
		end
		i = i + 1
	end
	result = gsub(result, "separator", match(result, "formerly") and ";" or ",")
	
	return format_Chinese_text("(") .. result .. format_Chinese_text(")")
end

function M.short(frame)
	local args = frame:getParent().args
	local pinyin = args["tr"] or false
	local gloss = args["t"] or false
	local nocap = args["nocap"] or false
	local notext = args["notext"] or false
	local comb = args["and"] or false
	local nodot = args["nodot"] or false
	local ital = frame.args["ital"] or false
	local noterm = not args[1] or false
	local t, s, tr, anno, word = {}, {}, {}, {}, {}
	local start = (ital and "<i>" or "") .. (nocap and "s" or "S") .. "hort for " .. (ital and "</i>" or "")
	local cat = require("Module:zh-cat").categorize("short")
	if comb then
		for _, arg in ipairs(args) do
			table.insert(word, M.link(frame, nil, { arg }))
		end
		return start .. table.concat(word, " + ") .. 
			(gloss and ": " .. format_gloss(gloss) or "") ..
			((ital and not nodot) and "<i>.</i>" or "") .. cat
	end
	for _, arg in ipairs(args) do
		cap = find(arg, "^%^")
		arg = gsub(arg, "^%^", "")
		table.insert(t, "[[" .. arg .. "]]")
		table.insert(s, "[[" .. M.ts(arg) .. "]]")
		if not pinyin then table.insert(tr, M.extract_pron(arg, "m", cap)) end
	end
	local trad = format_Chinese_text(table.concat(t))
	local simp = format_Chinese_text(table.concat(s))
	pinyin = pinyin ~= "-" and pinyin or (#tr == #t and table.concat(tr, " ") or false)
	table.insert(anno, format_rom(pinyin))
	table.insert(anno, format_gloss(gloss))
	return (notext and "" or start) .. (noterm and "" or trad .. (trad ~= simp and "／" .. simp or "") .. 
		((pinyin or gloss) and " (" .. table.concat(anno, ", ") .. ")" or "") .. 
		((ital and not nodot) and "<i>.</i>" or "")) .. cat
end

function M.extract_gloss(content, useetc)
	local senses = {}
	local len = mw.ustring.len
	local literally = match(content, 'zh%-forms[^}]*|lit=([^{|}]+)[|}]')
	local sense_id = 0
	local etc = false
	local translingual_section, zh_section, j, pos, section
	while true do
		-- Find language sections beginning with ==...== and ending with the same
		-- or an empty string. Grab the Chinese and Translingual ones.
		_, j, language_name, section = content:find("%f[=]==%s*([^=]+)%s*==(\n.-)\n==%f[^=]", pos)
		
		if j == nil then
			i, j, language_name, section = content:find("%f[=]==%s*([^=]+)%s*==(\n.+)", pos)
		end
		
		if j == nil then
			break
		else
			-- Move to the beginning of "==" at the end of the current match.
			pos = j - 1
		end
		
		if language_name == 'Translingual' then
			translingual_section = section
		elseif language_name == 'Chinese' then
			zh_section = section
			break
		end
	end
	
	if not zh_section then
		zh_section = translingual_section
		if not zh_section then
			return ""
		end
	elseif translingual_section then -- also use translingual section if Chinese section contains only rfdef
		zh_section = zh_section..translingual_section
	end

	
	-- Delete etymology sections, because they sometimes contain ordered lists,
	-- which would then be interpreted as definitions.
	zh_section = zh_section:gsub("\n===+Etymology.-(\n==)", "%1")
	
	for sense in zh_section:gmatch('\n# ([^\n]+)') do
		if not sense:match('rfdef') and not sense:match('defn') then
			sense_id = sense_id + 1
			if sense_id > 2 then
				etc = true
				break
			end
			table.insert(senses, sense)
		end
	end
	gloss_text = (literally and literally .. "; " or "") .. (senses[1] or "")
	local gloss_text_extend = gloss_text .. (senses[2] and "; " .. senses[2] or "")
	gloss_text = (len(gloss_text) < 80 and len(gloss_text_extend) < 160) and gloss_text_extend or gloss_text
	if gloss_text ~= gloss_text_extend then etc = true end

	local function replace_gloss(text)
		local function replace_wp(text)
			return text:gsub('{{w|([^|}]+)|?([^|}]*)}}',
				function(w_link, w_display)
					return '[[w:'..w_link..'｜'..(w_display~='' and w_display or w_link)..']]'
			end)
		end
		
		if text:find("{{") then
			text = replace_wp(text)
			text = text:gsub(' %({{taxlink[^}%)]+}}%)', '')
				:gsub('{{zh%-l|%*([^}]*)}}', '%1')
				:gsub('{{lb|zh|[^}]*}}', '')
				:gsub('{{zh%-erhua form of|word=[^}]+}}', '')
				:gsub('{{zh%-erhua form of|([^}]+)}}', '%1')
				:gsub('{{zh%-alt%-name|[^}]+|([^\n]+)}}', '%1')
				:gsub('{{zh%-short%-comp|[^}]+|t=([^\n}|]+)[^}]*}}', '%1')
				:gsub('{{zh%-short%-comp|[^}]+}}', '')
				:gsub('{{zh%-classifier|[^}]+|t=([^\n}|]+)[^}]*}}', '%1')
				:gsub('{{zh%-classifier|[^}]+}}', '')
				:gsub('{{zh%-alt%-form|[^}]+}}', '')
				:gsub('{{zh%-[^dm|}][^|}]+|[^|}]+|([^\n}|]+)}}', '%1')
				:gsub('{{place|zh|[^}]*t=([^\n}|]+)[^}]*}}', '%1')
				:gsub('{{vern', '{{w')
				:gsub('｜', "|")
		end
		text = text:gsub('( ?)([{%(]+[^}%){%(]+[}%)]+)', function(space, captured)
			local taxlink = captured:match("{{taxlink|([^|}]+)")
			local wiki_link = 
				 taxlink and "''" .. taxlink .. "''" or 
				(match(captured, "({{w|.+}})") or false)
			return wiki_link and space..wiki_link or "" end)
		text = mw.text.split(text, ';')
		local text_sec = {}
		for _, s in ipairs(text) do
			if s:find'%w' then
				table.insert(text_sec, (s:gsub('^%s+',''):gsub('%s+$','')))
			end
		end
		return table.concat(text_sec, '; ')
	end
	gloss_text = replace_gloss(gloss_text)
	gloss_text = replace_gloss(gloss_text)
	if etc and useetc and gloss_text ~= "" then
		gloss_text = gloss_text .. "; etc."
	elseif gloss_text:find("{{") then --temporary solution to suppress wikitext issues
		gloss_text = ""
	end
	return gloss_text
end

return M
