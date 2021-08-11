local export = {}

local find = mw.ustring.find
local len = mw.ustring.len
local gsub = mw.ustring.gsub
local match = mw.ustring.match
local gmatch = mw.ustring.gmatch
local split = mw.text.split

local m_ja = require('Module:ja')

local function gmatch_array(s, pattern) local result = {} for e in gmatch(s, pattern) do table.insert(result, e) end return result end
local function map(arr, f) local result = {} for _, e in ipairs(arr) do local fe = f(e) if fe ~= nil then table.insert(result, fe) end end return result end
local function filter(arr, f) local result = {} for _, e in ipairs(arr) do if f(e) then table.insert(result, e) end end return result end
local function contains(arr, item) for _, e in ipairs(arr) do if e == item then return true end end return false end
local function set(arr) local result = {} for _, e in ipairs(arr) do if not contains(result, e) then table.insert(result, e) end end return result end
local function flatten(arrs) local result = {} for _, arr in ipairs(arrs) do for _, e in ipairs(arr) do table.insert(result, e) end end return result end
-- f should be str->str in the following functions
local function memoize(f) local results = {} return function(s) if not results[s] then results[s] = f(s) end return results[s] end end
local getContent_memo = memoize(function(title) return mw.title.new(title):getContent() or '' end)
local function group(arr, f) local r = {} for _, e in ipairs(arr) do local fe = f(e) if r[#r] and r[#r].key == fe then table.insert(r[#r], e) else table.insert(r, { e, key = fe }) end end return r end

local function ja(text) return '<span lang="ja" class="Jpan">' .. text .. '</span>' end
local function link(lemma, display) return ja('[[' .. lemma .. '#Japanese|' .. (display or lemma) .. ']]') end
local function link_bracket(lemma, display) return ja('【[[' .. lemma .. '#Japanese|' .. (display or lemma) .. ']]】') end

--[[ returns an array of definitions, each having the format
	{ def = <definition>,
	  kanji_spellings = <array of alternative kanji spellings listed in {{ja-kanjitab|alt=...}}, can be overrided with {{ja-def|...}}>,
	  kana_spellings = <array of alternative kana spellings listed in the headword template>,
	  historical_kana_spellings = <array of historical kana spellings listed in the headword template>,
	  header = <name of PoS header>,
	  headword_line = <wikicode of headword line> }
]]
local function get_definitions_from_wikicode(wikicode)
	local current_kanji_spellings = {}
	local current_kana_spellings = {}
	local current_historical_kana_spellings = {}
	local current_header
	local current_headword_line
	local currently_under_headword_line = false

	wikicode = gsub(wikicode, '\n*<br */?>\n*({{ja%-altread)', '%1')
	
	local result = {}
	for line in gmatch(match(wikicode, '==Japanese==\n(.*)') or '', '[^\n]+') do
		-- the following branches are ordered by frequency; read backwards
		if currently_under_headword_line and find(line, '^#+[^#:*]') then
			table.insert(result, { def = line,
				kanji_spellings = find(line, '{{ja%-def|') and split(match(line, '{{ja%-def|([^}]+)'), '|')
									or find(line, '<!%-%- kana only %-%->') and {}
									or current_kanji_spellings,
				kana_spellings = current_kana_spellings,
				historical_kana_spellings = current_historical_kana_spellings,
				header = current_header,
				headword_line = current_headword_line })
		elseif find(line, '^{{ja%-noun[|}]')
			or find(line, '^{{ja%-adj[|}]')
			or find(line, '^{{ja%-pos[|}]')
			or find(line, '^{{ja%-phrase[|}]')
			or find(line, '^{{ja%-verb[|}]')
			or find(line, '^{{ja%-verb form[|}]')
			or find(line, '^{{ja%-verb%-suru[|}]')
			or find(line, '{{ja%-altread[|}]') then
				local escaped_line = gsub(gsub(line, '%[%[([^%[%]|]-)|([^%[%]|]-)%]%]', '[[%1`%2]]'), '|hkata=', '|hhira=')
				escaped_line = gsub(escaped_line, '|hira=', '|') -- ja-altread
				escaped_line = gsub(escaped_line, '|kata=', '|') -- ja-altread
				current_kana_spellings = map(gmatch_array(escaped_line, '|([、ぁ-ゖァ-ヺー%^%-%. %%]+)'), m_ja.remove_ruby_markup)
				current_historical_kana_spellings = gmatch_array(escaped_line, '|hhira=([ぁ-ゖァ-ヺー]+)')
				current_headword_line = line
				currently_under_headword_line = true
		elseif find(line, '^===+[^=]+===+$') then
			current_header = match(line, '^===+([^=]+)===+$')
			currently_under_headword_line = false
		elseif find(line, '^{{ja%-kanjitab[|}]') then
			local alt_argument = match(line, '|alt=([^|}]*)')
			current_kanji_spellings = alt_argument and split(gsub(alt_argument, ':[^,]*', ''), ',') or {}
		elseif line == '----' then
			break
		end
	end
	return result
end

-- ditto, except that each definition also contains the title of the page it is from
local function get_definitions_from_entry(title)
	local wikicode = getContent_memo(title)
	local defs = get_definitions_from_wikicode(wikicode)
	map(defs, function(def)
		def.title = title
		table.insert(({ Hira = true, Kana = true, ['Hira+Kana'] = true })[m_ja.script(title)] and def.kana_spellings or def.kanji_spellings, title)
		end)
	return defs
end

local function get_definitions_from_entries(titles)
	return flatten(map(titles, get_definitions_from_entry))
end

local function format_table_content(defs, frame)
	local kanji_grade_labels = {
		'<span class="explain" title="Grade 1 kanji" style="vertical-align: top;">1</span>',
		'<span class="explain" title="Grade 2 kanji" style="vertical-align: top;">2</span>',
		'<span class="explain" title="Grade 3 kanji" style="vertical-align: top;">3</span>',
		'<span class="explain" title="Grade 4 kanji" style="vertical-align: top;">4</span>',
		'<span class="explain" title="Grade 5 kanji" style="vertical-align: top;">5</span>',
		'<span class="explain" title="Grade 6 kanji" style="vertical-align: top;">6</span>',
		'<span class="explain" title="Jōyō kanji" style="vertical-align: top;">S</span>',
		'<span class="explain" title="Jinmeiyō kanji" style="vertical-align: top;">J</span>',
		'<span class="explain" title="Hyōgaiji kanji" style="vertical-align: top;">H</span>' }
	
	local function ruby(kanji, kana) -- this function ought to be in [[Module:ja]]
		local kanji_segments = gsub(kanji, "([A-Za-z0-9々㐀-䶵一-鿌" .. mw.ustring.char(0xF900) .. "-" .. mw.ustring.char(0xFAD9) .. "𠀀-𯨟０-９Ａ-Ｚａ-ｚ]+)", "`%1`")
		
		-- returns possible matches between kanji and kana
		-- for example, match('`物`の`哀`れ', 'もののあわれ') returns { '[物](も)の[哀](のあわ)れ', '[物](もの)の[哀](あわ)れ' }
		local function match(kanji_segments, kana)
			if kanji_segments:find('`') then
				local kana_portion, kanji_portion, rest = mw.ustring.match(kanji_segments, '(.-)`(.-)`(.*)')
				_, _, kana = mw.ustring.find(kana, '^' .. kana_portion .. '(.*)')
				if not kana then return {} end
				local candidates = {}
				for i = 1, mw.ustring.len(kana) do
					for _, candidate in ipairs(match(rest, mw.ustring.sub(kana, i + 1))) do
						table.insert(candidates, kana_portion .. '[' .. kanji_portion .. '](' .. mw.ustring.sub(kana, 1, i) .. ')' .. candidate)
					end
				end
				return candidates
			else
				return (kanji_segments == kana) and { kana } or {}
			end
		end
		
		local matches = match(kanji_segments, kana)
		local result = #matches == 1 and matches[1] or ('[' .. kanji .. '](' .. kana .. ')')
		return gsub(result, "%[([^%[%]]+)%]%(([^%(%)]+)%)", "<ruby><rb>%1</rb><rt>%2</rt></ruby>")
	end
	
	local function format_headword(defs)
		local title = defs[1].title
		local kana = defs[1].kana_spellings[1]
		local headword = link_bracket(title, mw.title.getCurrentTitle().text == kana and title or ruby(title, kana))
		local kanji_grade = len(title) == 1 and m_ja.kanji_grade(title)
		return '<span style="font-size:x-large">' .. headword .. '</span>' .. (kanji_grade and kanji_grade_labels[kanji_grade] or '')
	end
	
	local preprocess_memo = memoize(function (s) return frame:preprocess(s) end)
	local function format_definitions(defs)
		local headword_line_categories = {}
		local alt_forms = {}
		local function format_definition(def)
			local def_text = find(def.def, '{{rfdef[|}]') and "''This term needs a translation to English.''" or preprocess_memo(gsub(def.def, '^#+ *', ''))
			local def_prefix = gsub(match(def.def, '^#+'), '#', ':')
			local def_pos_label = ' <span style="padding-right:.6em;color:#5A5C5A;font-size:80%">[' .. mw.ustring.lower(def.header) .. ']</span> '
			local headword_line = gsub(def.headword_line, '%%', '')
			if ({ Hira = true, Kana = true, ['Hira+Kana'] = true })[m_ja.script(def.title)] then
				headword_line = gsub(headword_line, '}}$', '|hira=' .. def.title .. '}}')
			end
			table.insert(headword_line_categories, table.concat(gmatch_array(preprocess_memo(headword_line), '%[%[Category:.-%]%]')))
			map(def.kanji_spellings, function(s) if s ~= def.title and not contains(alt_forms, s) then table.insert(alt_forms, s) end end)
			map(def.kana_spellings, function(s) if s ~= def.kana_spellings[1] and s ~= mw.title.getCurrentTitle().text and not contains(alt_forms, s) then table.insert(alt_forms, s) end end)
			return def_prefix .. def_pos_label .. def_text
		end
		local formatted_defs = table.concat(map(defs, format_definition), '\n')
		if #alt_forms == 1 and alt_forms[1] == mw.title.getCurrentTitle().text then alt_forms = {} end
		return table.concat(headword_line_categories) .. '\n' .. formatted_defs
			.. (#alt_forms > 0 and '\n: <div style="background:#f8f9fa"><span style="color:#5A5C5A;font-size:80%">'
				.. (#alt_forms == 1 and 'Alternative spelling' or 'Alternative spellings')
				.. '</span><br><span style="margin-left:.8em">'
				.. table.concat(map(alt_forms, link), ', ')
				.. '</span></div>' or '')
	end
	
	local is_first_row = true
	local function format_row(defs)
		local result = '|-\n| style="white-space:nowrap;width:15%;vertical-align:top;' .. (is_first_row and '' or 'border-top:1px solid lightgray;') .. '" | ' .. format_headword(defs)
			.. '\n| style="' .. (is_first_row and '' or 'border-top:1px solid lightgray;') .. '" |\n' .. format_definitions(defs) .. '\n'
		is_first_row = false
		return result
	end
	
	local def_groups = group(defs, function(def) return def.title .. ',' .. def.kana_spellings[1] end)
	local rows = map(def_groups, format_row)
	
	return '{| style="width: 100%"\n' .. table.concat(rows) .. '|}'
end

function export.show(frame, mode)
	local title = mw.title.getCurrentTitle().text
	local lemmas, key
	if not mode or mode == 'kango' then
		local params = {
			[1] = { list = true },
			['key'] = {},
		}
		local args, unrecognized_args = require("Module:parameters").process(frame:getParent().args, params, true)
		for key, value in pairs(unrecognized_args) do error("“" .. key .. "” is not a recognized parameter.") end
		
		lemmas = args[1]
		key = args.key or title
	elseif mode == 'glyphvar' then
		local params = {
			[1] = {},
		}
		local args, unrecognized_args = require("Module:parameters").process(frame:getParent().args, params, true)
		for key, value in pairs(unrecognized_args) do error("“" .. key .. "” is not a recognized parameter.") end
		
		local wikicode = getContent_memo(args[1])
		local _lemmas = flatten({ gmatch_array(wikicode, '{{ja%-see|([^}]+)'), gmatch_array(wikicode, '{{ja%-see%-kango|([^}]+)') })
		_lemmas = flatten(map(_lemmas, function(arglist) return split(arglist, '|') end))
		_lemmas = filter(_lemmas, function(arg) return not find(arg, '=') end)
		_lemmas = set(flatten({ {args[1]}, _lemmas }))
		lemmas = _lemmas
		key = args[1]
	end
	
	local defs = get_definitions_from_entries(lemmas)
	
	local matching_defs = filter(defs, function(def)
		return contains(def.kanji_spellings, key) or contains(def.kana_spellings, key) or contains(def.historical_kana_spellings, key)
		end)
	
	local table_header = 'For pronunciation and definitions of ' .. ja(title) .. ' – see '
		.. (#matching_defs == 0 and (table.concat(map(lemmas, function(title) return '<span style="font-size:120%">' .. link(title) .. '</span>' end), ', '))
			or #group(matching_defs, function(def) return def.title end) == 1 and 'the following entry'
			or 'the following entries')
		.. '.'
	local table_content = format_table_content(matching_defs, frame)
	local table_footer = '(This term, ' .. ja(title) .. ', is '
		.. (#filter(matching_defs, function(def) return contains(def.historical_kana_spellings, key) and not contains(def.kana_spellings, key) end) == 0
			and 'an alternative'
			or ({ Hira = 'a historical hiragana[[Category:Japanese historical hiragana]]',
				  Kana = 'a historical katakana[[Category:Japanese historical katakana]]',
				  ['Hira+Kana'] = 'a historical mixed kana[[Category:Japanese terms spelled with mixed historical kana]]' })[m_ja.script(title)]
				or 'a historical')
		.. ' spelling of the above '
		.. (mode == 'kango' and 'Sino-Japanese ' or '')
		.. (#group(matching_defs, function(def) return def.title .. ',' .. def.kana_spellings[1] end) == 1 and 'term' or 'terms') .. '.'
		.. (m_ja.script(title) == 'Hira' and #filter(matching_defs, function(def) return match(def.title, '^[㐀-䶵一-鿌𠀀-𯨟]$') end) > 0
			and mw.title.new('Category:Japanese kanji read as ' .. title).exists
			and ('<br><span style="font-size:85%;">For a list of all kanji read as ' .. ja(title) .. ', not just those used in Japanese terms, see '
			.. '[[:Category:Japanese kanji read as ' .. title .. ']].)</span>')
			or ')')
	
	local result = '{| class="wikitable" style="min-width:70%"\n|-\n| <b>'
		.. table_header
		.. '</b>' .. (#matching_defs > 0 and ('\n|-\n| style="background-color: white" |\n'
			.. table_content
			.. '\n|-\n| ') or '<br>')
		.. table_footer
		.. '\n|}'
	
	if mode ~= 'glyphvar' then
		local created_entries = set(map(matching_defs, function(def) return def.title end))
		local uncreated_entries = set(filter(lemmas, function(lemma) return not contains(created_entries, lemma) end))
		if #uncreated_entries > 0 then
			result = result .. '\n<small class="attentionseeking">(The following ' .. (#uncreated_entries == 1 and 'entry is' or 'entries are')
				.. ' uncreated: ' .. table.concat(map(uncreated_entries, link), ", ") .. '.)</small>[[Category:Japanese redlinks/ja-see]]'
		end
	end
	result = gsub(result, '%[%[Category:Japanese lemmas([|%]])', '[[Category:Japanese non-lemma forms%1')
	return result
end

function export.show_kango(frame)
	return export.show(frame, 'kango')
end

function export.show_gv(frame)
	return export.show(frame, 'glyphvar')
end

return export
