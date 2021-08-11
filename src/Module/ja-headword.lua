local m_ja = require("Module:ja")
local m_ja_ruby = require('Module:ja-ruby')

local find = mw.ustring.find

local export = {}
local pos_functions = {}

local lang = require("Module:languages").getByCode("ja")
local sc = require("Module:scripts").getByCode("Jpan")
local Latn = require("Module:scripts").getByCode("Latn")

local Japanese_symbols = '%ｰ・＝？！。、'
local katakana_range = 'ァ-ヺーヽヾ'
local hiragana_range = 'ぁ-ゖーゞゝ'
local kana_range = katakana_range .. hiragana_range .. Japanese_symbols
local Japanese_scripts_range = kana_range .. '一-鿌・々'

local katakana_pattern = '^[' .. katakana_range .. Japanese_symbols .. ']*$'
local hiragana_pattern = '^[' .. hiragana_range .. Japanese_symbols .. ']*$'
local kana_pattern = '^[' .. kana_range .. ']*$'
local kana_pattern_full = '^[、' .. kana_range .. '%s%.%-%^%%]*$'

local function remove_links(text)
	return (text:gsub("%[%[[^|%]]-|", ""):gsub("%[%[", ""):gsub("%]%]", ""))
end

local detect_kana_script = require("Module:fun").memoize(function(kana)
	if find(kana, katakana_pattern) then
		return 'kata'
	elseif find(kana, hiragana_pattern) then
		return 'hira'
	elseif find(kana, kana_pattern) then
		return 'both'
	else
		return nil
	end
end)

local en_numerals = {
	"one", "two", "three", "four", "five",
	"six", "seven", "eight", "nine", "ten",
	"eleven", "twelve", "thirteen", "fourteen", "fifteen"
}

local en_grades = {
	"first grade", "second grade", "third grade",
	"fourth grade", "fifth grade", "sixth grade",
	"secondary school", "jinmeiyō", "hyōgaiji"
}

local aliases = {
	['transitive']='tr', ['trans']='tr',
	['intransitive']='in', ['intrans']='in', ['intr']='in',
	['godan']='1', ['ichidan']='2', ['irregular']='irr'
}

local function kana_to_romaji(kana, data, args)
	-- make adjustments for -u verbs and -i adjectives by placing a period before the last character
	-- to prevent romanizing long vowels with macrons
	if (data.pos_category == "verbs") or (data.pos_category == "adjectives" and (args["infl"] == "i" or args["infl"] == "い" or args["infl"] == "is")) then
		kana = mw.ustring.gsub(kana,'([うい])$','.%1')
	end
	-- hyphens for prefixes, suffixes, and counters (classifiers)
	if data.pos_category == "prefixes" then
		kana = kana:gsub('%-?$', '-')
	elseif data.pos_category == "suffixes" or data.pos_category == "counters" or data.pos_category == "classifiers" then
		kana = kana:gsub('^%-?', '-')
	end
	-- automatic caps for proper nouns, if not already specified
	if data.pos_category == "proper nouns" then
		if not find(kana, '%^') then
			kana = mw.ustring.gsub(kana, '^(.)', '^%1')
			kana = mw.ustring.gsub(kana, '([%s%-])(.)', '%1^%2')
		end
	end
	kana = m_ja.kana_to_romaji(kana)
	return kana
end

local function historical_kana(args, data, poscat)
	local hk = args["hhira"] or args["hkata"]
	if hk then
		if hk:match'ゐ' then
			table.insert(data.categories, "Japanese terms historically spelled with ゐ")
		end
		if hk:match'ゑ' then
			table.insert(data.categories, "Japanese terms historically spelled with ゑ")
		end
		if hk:match'を' and not (data.kana and data.kana:match'を') then
			table.insert(data.categories, "Japanese terms historically spelled with を")
		end
		if hk:match'ぢ' and not (data.kana and data.kana:match'ぢ') then
			table.insert(data.categories, "Japanese terms historically spelled with ぢ")
		end
		if hk:match'づ' and not (data.kana and data.kana:match'づ') then
			table.insert(data.categories, "Japanese terms historically spelled with づ")
		end
		return '<sup>←' .. require('Module:ja-link').link({
			lemma = hk,
		}, {
			hist = true,
			face = 'head',
			disableSelfLink = true,
		}) .. '<sup>[[w:Historical kana orthography|?]]</sup></sup> '
	else return '' end
end

local function assign_kana_to_kanji(head, kana, pagename)
	local pat_k = '々㐀-䶵一-鿌' .. mw.ustring.char(0xF900) .. "-" .. mw.ustring.char(0xFAFF)

	if mw.ustring.len(head) == 1 or mw.ustring.match(head, '[^' .. Japanese_scripts_range .. '%[%]|%s]') then
		return head, kana
	end

	local kanji_pos = {[0] = 0}
	local link_border = 0
	local head_nolink = mw.ustring.gsub(head, '()(%b[])()', function(p1, w1, p2)
		if w1:sub(2, 2) ~= '[' or w1:sub(-2, -2) ~= ']' then return w1 end

		for pp1 in mw.ustring.gmatch(mw.ustring.sub(head, link_border + 1, p1 - 1), '()[' .. pat_k .. ']') do
			table.insert(kanji_pos, pp1 + link_border)
		end

		local p_pipe = mw.ustring.find(w1, '|') or 2
		w1 = mw.ustring.sub(w1, p_pipe + 1, -3)

		link_border = p1 - 1 + p_pipe
		for pp1 in mw.ustring.gmatch(w1, '()[' .. pat_k .. ']') do
			table.insert(kanji_pos, pp1 + link_border)
		end

		link_border = p2 - 1

		return w1
	end)
	for pp1 in mw.ustring.gmatch(mw.ustring.sub(head, link_border + 1), '()[' .. pat_k .. ']') do
		table.insert(kanji_pos, pp1 + link_border)
	end

	local pagetext = mw.title.new(pagename):getContent()
	if not pagetext then return head, kana end

	local non_kanji = {}
	local last_kanji = 1
	for p1 in mw.ustring.gmatch(head_nolink, '[' .. pat_k .. ']()') do
		table.insert(non_kanji, mw.ustring.sub(head_nolink, last_kanji, p1 - 2))
		last_kanji = p1
	end
	table.insert(non_kanji, mw.ustring.sub(head_nolink, last_kanji))

	for kanjitab_args in pagetext:gmatch'{{%s*ja%-kanjitab%s*(|.-)}}' do
		local readings = {}
		local readings_len = {}
		local readings_o = {}
		local id = 1
		for ka in kanjitab_args:gmatch'|([^|]*)' do
			if not ka:match'=' then
				local r_kana, r_len = ka:match'^%s*(%D*)(%d*)%s*$'
				readings[id] = readings[id] or r_kana
				readings_len[id] = tonumber(r_len)
				id = id + 1
			else
				local id_t, id_n = ka:match'^%s*([ko]?)(%d+)%s*='
				if id_t then
					id_n = tonumber(id_n)
					local r = ka:match'^.-=%s*(.-)%s*$'
					if id_t == '' then
						local r_kana, r_len = r:match'(%D*)(%d*)'
						readings[id_n] = readings[id_n] or r_kana
						readings_len[id_n] = tonumber(r_len)
					elseif id_t == 'k' then
						readings[id_n] = r
					else
						readings_o[id_n] = r
					end
				end
			end
		end

		local kana_decom = {}
		local reading_id = 1
		local reading_len = 1
		for i = 1, #non_kanji - 1 do
			if reading_len <= 1 then
				reading_len = readings_len[reading_id] or 1

				table.insert(kana_decom, non_kanji[i])
				table.insert(kana_decom, (readings[reading_id] or '') .. (readings_o[reading_id] or ''))

				reading_id = reading_id + 1
			else
				reading_len = reading_len - 1
			end
		end
		table.insert(kana_decom, non_kanji[#non_kanji])

		if table.concat(kana_decom):gsub(' ', '') == kana:gsub('[%.%- ^]', '') then
			local head_decom = {}
			reading_id = 1
			reading_len = 1
			for i = 1, #non_kanji - 1 do
				if reading_len <= 1 then
					reading_len = readings_len[reading_id] or 1

					table.insert(head_decom, mw.ustring.sub(head, kanji_pos[i - 1] + 1, kanji_pos[i] - 1))
					table.insert(head_decom, mw.ustring.sub(head, kanji_pos[i], kanji_pos[i + reading_len - 1]))

					reading_id = reading_id + 1
				else
					reading_len = reading_len - 1
				end
			end
			table.insert(head_decom, mw.ustring.sub(head, kanji_pos[#non_kanji - 1] + 1))

			return table.concat(head_decom, '%'), table.concat(kana_decom, '%')
		end
	end

	return head, kana
end

local function default_seperator(text)
	require('Module:debug').track('ja-headword/default separator used')
	local result = {}
	local p0 = 1
	text = text:gsub('%[%[([^|]-)%]%]', '%1'):gsub('%[%[[^|]-|([^|]-)%]%]', '%1')
	for p1, w1 in mw.ustring.gmatch(text, table.concat{
		'()([々㐀-䶵一-鿌',
		mw.ustring.char(0xF900),
		"-",
		mw.ustring.char(0xFAD9),
		'𠀀-𯨟０-９Ａ-Ｚａ-ｚ〆〇0-9a-zA-Zα-ωΑ-Ω])',
	}) do
		if p0 < p1 then table.insert(result, mw.ustring.sub(text, p0, p1 - 1)) end
		table.insert(result, w1)
		p0 = p1 + 1
	end
	if p0 <= mw.ustring.len(text) then table.insert(result, mw.ustring.sub(text, p0)) end
	return table.concat(result, '%')
end

-- adds category Japanese terms spelled with jōyō kanji or Japanese terms spelled with non-jōyō kanji
-- (if it contains any kanji)
local function categorize_by_kanji(data, PAGENAME)
	-- remove non-kanji characters
	local onlykanji = mw.ustring.gsub(PAGENAME, '[^一-鿌]', '')

	local number_of_kanji = mw.ustring.len(onlykanji)
	if number_of_kanji > 0 then
		for i=1,mw.ustring.len(onlykanji) do
			table.insert(data.categories, ("Japanese terms spelled with %s kanji"):format(en_grades[m_ja.kanji_grade(mw.ustring.sub(onlykanji,i,i))]))
		end

		-- categorize by number of kanji
		if number_of_kanji == 1 then
			table.insert(data.categories, "Japanese terms written with one Han script character")
		elseif en_numerals[number_of_kanji] then
			table.insert(data.categories, ("Japanese terms written with %s Han script characters"):format(en_numerals[number_of_kanji]))
		end
	end

	-- single-kanji terms
	if mw.ustring.len(PAGENAME) == 1 and mw.ustring.match(PAGENAME, '[一-鿌]') then
		table.insert(data.categories, "Japanese terms spelled with " .. PAGENAME)
		table.insert(data.categories, "Japanese single-kanji terms")
	end
end

-- categorize by the script of the pagename or specific characters contained in it
local function extra_categorization(data, PAGENAME, katakana_category)
	-- if PAGENAME is hiragana, put in that category, same for katakana (but do it at the end)
	if detect_kana_script(PAGENAME) == 'hira' then table.insert(data.categories, "Japanese hiragana") end
	if detect_kana_script(PAGENAME) == 'kata' then table.insert(katakana_category, "Japanese katakana") end
	if find(PAGENAME, "[^" .. Japanese_scripts_range .. "]") and find(PAGENAME, '[' .. Japanese_scripts_range .. ']') then
		table.insert(data.categories, "Japanese terms written in multiple scripts") end

	for _,character in ipairs({'々','〆','ヶ','ゝ','ゞ','ヽ','ヾ','ゐ','ヰ','ゑ','ヱ','ゔ','ヷ','ヸ','ヹ','ヺ','・','＝','゠'}) do
		if mw.ustring.match(PAGENAME,character) then
			table.insert(data.categories, ("Japanese terms spelled with %s"):format(character))
		end
	end

	if find(PAGENAME, "[ァ-ヺヽヾ]") and find(PAGENAME, "[ぁ-ゖゞゝ]") and data.pos_category ~= "proverbs" and data.pos_category ~= "phrases" then
		table.insert(data.categories, "Japanese terms spelled with mixed kana")
	end
end

-- go through args and build inflections by finding whatever kanas were given to us
local function format_headword(args, data, head)
	local headword_kana_type = detect_kana_script(remove_links(m_ja.remove_ruby_markup(head)))

	local allkana, romajis = {}, {}
	local rep = {}
	local _insert_kana = headword_kana_type and function(k) -- pure-kana-title entry
		if k == '' then return end
		local key = remove_links(m_ja.remove_ruby_markup(k))
		romajis[1] = kana_to_romaji(remove_links(k), data, args)
		if not rep[key] then
			table.insert(allkana, k)
			rep[key] = true
		end
	end or function(k) -- non-pure-kana-title entry
		if k == '' then return end
		local key = m_ja.kana_to_romaji(remove_links(m_ja.remove_ruby_markup(k)))
		if not rep[key] then
			table.insert(romajis, kana_to_romaji(remove_links(k), data, args))
			table.insert(allkana, k)
			rep[key] = true
		end
	end

	if headword_kana_type then
		_insert_kana(remove_links(head))
		allkana[1] = head
	end

	for i, arg in ipairs(args[1]) do
		-- test for kana: filter out POS designations
		if find(arg, kana_pattern_full) then
			_insert_kana(arg)
		end
	end

	-- accept "hira" and "kata" but let Lua decide if they are really hiragana or katakana
	if args["hira"] and args["hira"] ~= "" then _insert_kana(args["hira"]) end
	if args["kata"] and args["kata"] ~= "" then _insert_kana(args["kata"]) end
	if args["rom"] then romajis[1] = args["rom"] end

	if #allkana == 0 then error('Kana form is required') end
	if #romajis == 0 then error('Romaji is required') end

	local suru_ending = data.pos_category == "suru verbs" and '[[する]]' or ''
	for _, kana in ipairs(allkana) do
		-- add everything to inflections, except historical hiragana which is next
		-- local format_result = headword_kana_type and allkana[i] or format_ruby(PAGENAME, allkana[i], data)
		local format_result, format_result_preserved --<ruby> form, []() form

		if headword_kana_type then
			format_result = m_ja.remove_ruby_markup(kana)
			format_result_preserved = remove_links(format_result) .. suru_ending
			format_result = format_result .. suru_ending
		else
			local head_for_ruby, kana_for_ruby
			if kana:match'%%' then
				if head:match'%%' then
					head_for_ruby, kana_for_ruby = head, kana
				else
					head_for_ruby, kana_for_ruby = default_seperator(head), kana
				end
			else
				head_for_ruby, kana_for_ruby = assign_kana_to_kanji(head, kana, args.pagename)
			end
			local format_table = m_ja_ruby.parse_text(head_for_ruby, kana_for_ruby, {
				try = 'force',
				try_force_limit = 10000
			})
			format_result = m_ja_ruby.to_wiki(format_table, {
				break_link = true,
			}):gsub('<rt>(..-)</rt>', "<rt>[[" .. remove_links(m_ja.remove_ruby_markup(kana)) .."|%1]]</rt>") .. suru_ending
			format_result_preserved = remove_links(m_ja_ruby.to_markup(format_table)) .. suru_ending
		end

		table.insert(data.heads, format_result)
		data.heads_preserved = data.heads_preserved or format_result_preserved
	end

	suru_ending = data.pos_category == "suru verbs" and ' suru' or ''
	for _, rom in ipairs(romajis) do
		table.insert(data.translits, '[[' .. rom .. '#Japanese|' .. rom .. ']]' .. suru_ending)
	end

	if #romajis > 1 then
		table.insert(data.categories, "Japanese words with multiple readings")
	end

	data.kana = allkana[1] and remove_links(m_ja.remove_ruby_markup(allkana[1]))
end

local function add_transitivity(data, tr)
	tr = aliases[tr] or tr
	if tr == "tr" then
		table.insert(data.info_mid, 'transitive')
		table.insert(data.categories, "Japanese transitive verbs")
	elseif tr == "in" then
		table.insert(data.info_mid, 'intransitive')
		table.insert(data.categories, "Japanese intransitive verbs")
	elseif tr == "both" then
		table.insert(data.info_mid, 'transitive or intransitive')
		table.insert(data.categories, "Japanese transitive verbs")
		table.insert(data.categories, "Japanese intransitive verbs")
	else
		table.insert(data.categories, "Japanese verbs without transitivity")
	end
end

local function add_inflections(data, inflection_type, cat_suffix)
	local lemma = data.heads_preserved or data.heads[1]
	local romaji = remove_links(data.translits[1])
	inflection_type = aliases[inflection_type] or inflection_type

	local function replace_suffix(lemma_from, lemma_to, romaji_from, romaji_to)
		-- e.g. 持って来る, lemma = "[持](も)って来(く)る"
		-- lemma_from = "くる", lemma_to = {"き","きた"}
		local p_kr = katakana_range .. hiragana_range
		local lemma_sub
		local romaji_sub
		local key_pos = {}
		local i1, i2

		romaji_from = romaji_from or m_ja.kana_to_romaji(lemma_from)
		if type(lemma_to) ~= 'table' then lemma_to = {lemma_to} end
		if type(romaji_to) ~= 'table' then romaji_to = {romaji_to} end
		for i, v in ipairs(lemma_to) do
			romaji_to[i] = romaji_to[i] or m_ja.kana_to_romaji(v)
		end

		lemma_sub = lemma
		lemma_from = lemma_from ~= '' and mw.text.split(lemma_from, '') or {} -- lemma_from = {"く","る"}
		local len_lemma_from = #lemma_from -- find the last two kana in "[持](も)って来(く)る"
		key_pos[len_lemma_from + 1] = {-1}
		for i = len_lemma_from, 1, -1 do
			i1, _, i2 = mw.ustring.find(lemma_sub, '[' .. m_ja.kata_to_hira(lemma_from[i]) .. m_ja.hira_to_kata(lemma_from[i]) .. ']()[^' .. p_kr .. ']-$')
			if not i1 then return nil end
			i1 = i1 - 1
			key_pos[i] = {i1, i2}
			lemma_sub = mw.ustring.sub(lemma_sub, 1, i1)
		end
		romaji_sub, i1 = romaji:gsub(romaji_from .. '%s*$', '')
		if i1 ~= 1 then return nil end

		local result = {}
		for i, v in ipairs(lemma_to) do
			local result_single = {lemma_sub}
			for j = 1, len_lemma_from do
				table.insert(result_single, mw.ustring.sub(v, j, j))
				table.insert(result_single, mw.ustring.sub(lemma, key_pos[j][2], key_pos[j + 1][1]))
			end
			table.insert(result_single, mw.ustring.sub(v, len_lemma_from + 1))
			result[i] = {lemma = table.concat(result_single), romaji = romaji_sub .. romaji_to[i]}
			-- "[持](も)って来(" .. "き" .. ")" .. "" .. "" and "[持](も)って来(" .. "き" .. ")" .. "た" .. ""
		end
		return result -- {{lemma="[持](も)って来(き)",romaji="motteki"},{lemma="[持](も)って来(き)た",romaji="mottekita"}}
	end

	local function insert_form(label, ...)
		-- label = "stem" or "past" etc.
		-- ... = {lemma=...,romaji=...},{lemma=...,romaji=...}
		local labeled_forms = {label = label}
		for _, v in ipairs{...} do
			local table_form = m_ja_ruby.parse_markup(v.lemma)
			local form_term = m_ja_ruby.to_wiki(table_form)
			if not form_term:find'%[%[.+%]%]' then
				form_term = '[[' .. m_ja_ruby.to_text(table_form) .. '#Japanese|' .. form_term .. ']]'
			end
			table.insert(labeled_forms, {
				term = form_term,
				translit = v.romaji,
			})
		end
		table.insert(data.inflections, labeled_forms)
	end

	local inflected_forms
	if inflection_type == '1' or inflection_type == '1s' then
		table.insert(data.info_mid, '<abbr title="godan (type I) conjugation">godan</abbr>')
		if cat_suffix then
			table.insert(data.categories, "Japanese type 1 " .. cat_suffix)
			if cat_suffix == 'verbs' and data.translits[1] and mw.ustring.find(remove_links(data.translits[1]), '[ieIEīēĪĒ]ru$') then
				table.insert(data.categories, "Japanese type 1 verbs that end in -iru or -eru")
			end
		end
		if inflection_type == '1' then
			inflected_forms =
				replace_suffix('く', {'き', 'いた'}, 'ku', {'ki', 'ita'}) or
				replace_suffix('ぐ', {'ぎ', 'いだ'}, 'gu', {'gi', 'ida'}) or
				replace_suffix('す', {'し', 'した'}, 'su', {'shi', 'shita'}) or
				replace_suffix('つ', {'ち', 'った'}, 'tsu', {'chi', 'tta'}) or
				replace_suffix('ぬ', {'に', 'んだ'}, 'nu', {'ni', 'nda'}) or
				replace_suffix('ぶ', {'び', 'んだ'}, 'bu', {'bi', 'nda'}) or
				replace_suffix('む', {'み', 'んだ'}, 'mu', {'mi', 'nda'}) or
				replace_suffix('る', {'り', 'った'}, 'ru', {'ri', 'tta'}) or
				replace_suffix('う', {'い', 'った'}, 'u', {'i', 'tta'})
			if inflected_forms then
				insert_form('stem', inflected_forms[1])
				insert_form('past', inflected_forms[2])
			else
				require("Module:debug").track("ja-headword/godan conjugation failed")
			end
		else
			inflected_forms =
				replace_suffix('る', {'り', 'った', 'い'}, 'ru', {'ri', 'tta', 'i'}) or --くださる
				replace_suffix('いく', {'いき', 'いった'}, 'iku', {'iki', 'itta'}) or --行く
				replace_suffix('う', {'い', 'うた'}, 'ou', {'oi', 'ōta'}) --問う
			if inflected_forms then
				insert_form('stem', inflected_forms[1], inflected_forms[3])
				insert_form('past', inflected_forms[2])
			else
				require("Module:debug").track("ja-headword/godan conjugation special failed")
			end
		end
	elseif inflection_type == '2' then
		table.insert(data.info_mid, '<abbr title="ichidan (type II) conjugation">ichidan</abbr>')
		if cat_suffix then table.insert(data.categories, "Japanese type 2 " .. cat_suffix) end
		inflected_forms = replace_suffix('る', {'', 'た'}, 'ru', {'', 'ta'})
		if inflected_forms then
			insert_form('stem', inflected_forms[1])
			insert_form('past', inflected_forms[2])
		else
			require("Module:debug").track("ja-headword/ichidan conjugation failed")
		end
	elseif inflection_type == 'suru' then
		table.insert(data.info_mid, '<abbr title="suru (type III) conjugation">suru</abbr>')
		if cat_suffix then table.insert(data.categories, "Japanese suru " .. cat_suffix) end
		inflected_forms =
			replace_suffix('する', {'し', 'した'}, 'suru', {'shi', 'shita'}) or
			replace_suffix('ずる', {'じ', 'じた'}, 'zuru', {'ji', 'jita'})
		if inflected_forms then
			insert_form('stem', inflected_forms[1])
			insert_form('past', inflected_forms[2])
		else
			require("Module:debug").track("ja-headword/suru conjugation failed")
		end
	elseif inflection_type == 'kuru' then
		table.insert(data.info_mid, '<abbr title="kuru (type III) conjugation">kuru</abbr>')
		if cat_suffix then table.insert(data.categories, "Japanese kuru " .. cat_suffix) end
		inflected_forms = replace_suffix('くる', {'き', 'きた'}, 'kuru', {'ki', 'kita'})
		if inflected_forms then
			insert_form('stem', inflected_forms[1])
			insert_form('past', inflected_forms[2])
		else
			require("Module:debug").track("ja-headword/kuru conjugation failed")
		end
	elseif inflection_type == 'i' or inflection_type == 'い' then
		table.insert(data.info_mid, '<abbr title="-i (type I) inflection">-i</abbr>')
		if cat_suffix then table.insert(data.categories, "Japanese い-i " .. cat_suffix) end
		inflected_forms = replace_suffix('い', {'く'}, 'i', {'ku'})
		if inflected_forms then
			insert_form('adverbial', inflected_forms[1])
		else
			require("Module:debug").track("ja-headword/-i inflection failed")
		end
	elseif inflection_type == 'is' then
		table.insert(data.info_mid, '<abbr title="-i (type I) inflection">-i</abbr>')
		if cat_suffix then table.insert(data.categories, "Japanese い-i " .. cat_suffix) end
		inflected_forms = replace_suffix('いい', {'よく'}, 'ii', {'yoku'})
		if inflected_forms then
			insert_form('adverbial', inflected_forms[1])
		else
			require("Module:debug").track("ja-headword/slightly irregular -i inflection failed")
		end
	elseif inflection_type == 'na' or inflection_type == 'な' then
		table.insert(data.info_mid, '<abbr title="-na (type II) inflection">-na</abbr>')
		if cat_suffix then table.insert(data.categories, "Japanese な-na " .. cat_suffix) end
		inflected_forms = replace_suffix('', {'[[な]]', '[[に]]'}, '', {' na', ' ni'})
		insert_form('adnominal', inflected_forms[1])
		insert_form('adverbial', inflected_forms[2])

	elseif inflection_type == "yo" then
		table.insert(data.info_mid, '<abbr title="yodan conjugation (classical)"><sup><small>†</small></sup>yodan</abbr>')
		if cat_suffix then table.insert(data.categories, "Japanese yodan " .. cat_suffix) end
	elseif inflection_type == "kami ni" then
		table.insert(data.info_mid, '<abbr title="kami nidan conjugation (classical)"><sup><small>†</small></sup>nidan</abbr>')
		if cat_suffix then table.insert(data.categories, "Japanese kami nidan " .. cat_suffix) end
	elseif inflection_type == "shimo ni" then
		table.insert(data.info_mid, '<abbr title="shimo nidan conjugation (classical)"><sup><small>†</small></sup>nidan</abbr>')
		if cat_suffix then table.insert(data.categories, "Japanese shimo nidan " .. cat_suffix) end
	elseif inflection_type == "rahen" then
		table.insert(data.info_mid, '<abbr title="r-special conjugation (classical)"><sup><small>†</small></sup>-ri</abbr>')
	elseif inflection_type == "sahen" then
		table.insert(data.info_mid, '<abbr title="s-special conjugation (classical)"><sup><small>†</small></sup>-se</abbr>')
	elseif inflection_type == "kahen" then
		table.insert(data.info_mid, '<abbr title="k-special conjugation (classical)"><sup><small>†</small></sup>-ko</abbr>')
	elseif inflection_type == "nahen" then
		table.insert(data.info_mid, '<abbr title="n-special conjugation (classical)"><sup><small>†</small></sup>-n</abbr>')
	elseif inflection_type == "nari" or inflection_type == "なり" then
		table.insert(data.info_mid, '<abbr title="-nari inflection (classical)"><sup><small>†</small></sup>-nari</abbr>')
		if cat_suffix then table.insert(data.categories, "Japanese なり-nari " .. cat_suffix) end
	elseif inflection_type == 'tari' or inflection_type == 'たり' then
		table.insert(data.info_mid, '<abbr title="-tari inflection (classical)"><sup><small>†</small></sup>-tari</abbr>')
		if cat_suffix then table.insert(data.categories, "Japanese たり-tari " .. cat_suffix) end
		inflected_forms = replace_suffix('', {'[[たる]]', '[[と]]', '[[として]]'}, '', {' taru', ' to', ' toshite'})
		insert_form('adnominal', inflected_forms[1])
		insert_form('adverbial', inflected_forms[2], inflected_forms[3])
	elseif inflection_type == "ku" or inflection_type == "く" then
		table.insert(data.info_mid, '<abbr title="-ku inflection (classical)"><sup><small>†</small></sup>-ku</abbr>')
		if cat_suffix then table.insert(data.categories, "Japanese く-ku " .. cat_suffix) end
	elseif inflection_type == "shiku" or inflection_type == "しく" then
		table.insert(data.info_mid, '<abbr title="-shiku inflection (classical)"><sup><small>†</small></sup>-shiku</abbr>')
		if cat_suffix then table.insert(data.categories, "Japanese しく-shiku " .. cat_suffix) end
	elseif inflection_type == "ka" or inflection_type == "か" then
		table.insert(data.info_mid, '<abbr title="-ka inflection (dialectal)"><sup><small>†</small></sup>-ka</abbr>')
		if cat_suffix then table.insert(data.categories, "Japanese か-ka " .. cat_suffix) end

	elseif inflection_type == 'irr' then
		table.insert(data.info_mid, 'irregular')
		if cat_suffix then table.insert(data.categories, "Japanese irregular " .. cat_suffix) end
	elseif inflection_type == '-' or inflection_type == 'un' then
		table.insert(data.info_mid, 'uninflectable')
	end
end

pos_functions["verbs"] = function(args, data)
	add_transitivity(data, args["tr"])
	add_inflections(data, args["infl"], 'verbs')
end

pos_functions["suffixes"] = function(args, data)
	add_inflections(data, args["infl"])
end

pos_functions["auxiliary verbs"] = function(args, data)
	table.insert(data.categories, "Japanese auxiliary verbs")
	add_inflections(data, args["infl"])
	data.pos_category = "verbs"
end

pos_functions["suru verbs"] = function(args, data)
	add_transitivity(data, args["tr"])
	add_inflections(data, 'suru', 'verbs')
	data.pos_category = "verbs"
end

pos_functions["adjectives"] = function(args, data)
	add_inflections(data, args["infl"], 'adjectives')
end

pos_functions["nouns"] = function(args, data)
	-- the counter (classifier) parameter, only relevant for nouns
	local counter = args["count"] or ""

	if counter == "-" then
		table.insert(data.inflections, {label = "uncountable"})
	elseif counter ~= "" then
		table.insert(data.inflections, {label = "counter", counter})
	end
end

-- For use in soft redirect pages
-- Sortkey is not provided
function export.cat(pagename, categories)
	categorize_by_kanji({categories = categories}, pagename)
	-- categorize by the script of the pagename or specific characters contained in it
	categorize_by_kanji({categories = categories}, pagename, categories)
end

-- The main entry point.
-- This is the only function that can be invoked from a template.
function export.show(frame)
	local poscat = frame.args[1] or error("Part of speech has not been specified. Please pass parameter 1 to the module invocation.")
	local args = require('Module:parameters').process(frame:getParent().args, {
		[1] = {list = true},
		['hira'] = {}, ['kata'] = {},
		['rom'] = {},
		['tr'] = {},
		['infl'] = {}, ['type'] = {alias_of = 'infl'}, ['decl'] = {alias_of = 'infl'},
		['count'] = {},
		['kyu'] = {}, ['shin'] = {},
		['hhira'] = {}, ['hkata'] = {},
		['head'] = {},
		['sort'] = {},
		['pagename'] = {},
	})
	args['pagename'] = args['pagename'] or mw.title.getCurrentTitle().text

	local data = {
		lang = lang,
		sc = sc,
		pos_category = poscat,
		categories = {},
		translits = {},
		heads = {},
		inflections = {},
		genders = {'m'}, -- placeholder
		sort_key = nil,
		--custom info
		info_mid = {},
		heads_preserved = nil,
		kana = nil,
	}
	local katakana_category = {}

	-- sort out all the kanas and do the romanization business
	format_headword(args, data, args["head"] or args['pagename'])

	-- add certain "inflections" and categories for adjectives, verbs, or nouns
	if pos_functions[poscat] then
		pos_functions[poscat](args, data)
	end

	-- the presence of kyūjitai param indicates that this is shinjitai kanji entry and vice versa
	if args["kyu"] then
		if data.pos_category == "suru verbs" then
			table.insert(data.inflections, {label = "[[Appendix:Japanese_glossary#kyūjitai|kyūjitai]]", "[[" .. args["kyu"] .. "]][[する]]"})
		else
			table.insert(data.inflections, {label = "[[Appendix:Japanese_glossary#kyūjitai|kyūjitai]]", args["kyu"]})
		end
		require('Module:debug').track'ja-headword/kyu'
	end
	if args["shin"] then
		table.insert(data.inflections, {label = "[[Appendix:Japanese_glossary#kyūjitai|kyūjitai]]"})
		if data.pos_category == "suru verbs" then
			table.insert(data.inflections, {label = "[[Appendix:Japanese_glossary#shinjitai|shinjitai]]", "[[" .. args["shin"] .. "]][[する]]"})
		else
			table.insert(data.inflections, {label = "[[Appendix:Japanese_glossary#shinjitai|shinjitai]]", args["shin"]})
		end
		require('Module:debug').track'ja-headword/shin'
	end

	local hist_info = historical_kana(args, data, poscat)

	-- categorize by joyo kanji and number of kanji
	categorize_by_kanji(data, args['pagename'])
	-- categorize by the script of the pagename or specific characters contained in it
	extra_categorization(data, args['pagename'], katakana_category)

	data.sort_key = args['sort'] or data.kana and m_ja.jsort(data.kana) or nil

	return
		(data.kana and '<span id="' .. data.kana .. '"></span>' or '') ..
		require('Module:headword').full_headword(data)
			:gsub('<span class="gender">.-</span>', hist_info .. '<i>'..table.concat(data.info_mid, '&nbsp;')..'</i>') ..
		require("Module:utilities").format_categories(katakana_category, lang, data.sort_key and m_ja.hira_to_kata(data.sort_key))
end

return export