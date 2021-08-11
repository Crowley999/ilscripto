local export = {}

local m_utilities = require("Module:utilities")
local m_ja = require("Module:ja")
local ShowLabels = require("Module:labels").show_labels
--[=[
	Other modules used: [[Module:parameters]], [[Module:table]]
]=]

local title = mw.title.getCurrentTitle()
local PAGENAME = title.text
local NAMESPACE = title.nsText

local lang = require("Module:languages").getByCode("ja")

local kanji_pattern = "一-鿿㐀-䶿𠀀-𮯯𰀀-𱍏﨎﨏﨑﨓﨔﨟﨡﨣﨤﨧﨨﨩"

local kanji_grade_links = {
	"[[Appendix:Japanese_glossary#kyōiku_kanji|Grade: 1]]",
	"[[Appendix:Japanese_glossary#kyōiku_kanji|Grade: 2]]",
	"[[Appendix:Japanese_glossary#kyōiku_kanji|Grade: 3]]",
	"[[Appendix:Japanese_glossary#kyōiku_kanji|Grade: 4]]",
	"[[Appendix:Japanese_glossary#kyōiku_kanji|Grade: 5]]",
	"[[Appendix:Japanese_glossary#kyōiku_kanji|Grade: 6]]",
	"[[Appendix:Japanese_glossary#jōyō_kanji|Grade: S]]",		-- 7
	"[[Appendix:Japanese_glossary#jinmeiyō_kanji|Jinmeiyō]]",	-- 8
	"[[Appendix:Japanese_glossary#hyōgaiji|Hyōgaiji]]"		-- 9
}

local function quote(text)
	return "“" .. text .. "”"
end

-- this is the function that is called from templates
function export.show(frame)
	local params = {
		[1] = { list = true, allow_holes = true },
		k = { list = true, allow_holes = true },
		o = { list = true, allow_holes = true },
		r = {},
		sort = {},
		yomi = {},
		ateji = {},
		alt = {},
		kyu = { list = true },
		y = {alias_of = 'yomi'},
		clearright = {type = "boolean"},
		pagename = {},
	}
	local args = require("Module:parameters").process(frame:getParent().args, params)

	if args.pagename and NAMESPACE == "" then
		require('Module:debug').track'ja-kanjitab/pagename param in mainspace'
	end
	local pagename = args.pagename or PAGENAME

	local categories = {}
	local cells = {}

	-- extract kanji and non-kanji
	local kanji = {}
	local non_kanji = {}

	local kanji_border = 1
	mw.ustring.gsub(pagename, '()([' .. kanji_pattern .. '々])()', function(p1, w1, p2)
		table.insert(non_kanji, mw.ustring.sub(pagename, kanji_border, p1 - 1))
		kanji_border = p2
		table.insert(kanji, w1)
	end)
	table.insert(non_kanji, mw.ustring.sub(pagename, kanji_border))

	-- kyujitai
	local kyu = args.kyu
	if kyu[1] == '-' then
		kyu = {}
	elseif kyu[1] == nil then
		local form_kyu = {non_kanji[1]}
		local kyu_data = mw.loadData('Module:ja/data/kyu')
		local has_kyu, has_kyu_nonsupple, has_shin = false, false, false
		for i, v in ipairs(kanji) do
			local v_kyu = kyu_data[1]:match(v .. '(%S*)%s')
			if v_kyu == nil then
				table.insert(form_kyu, v)
			elseif v_kyu == '' then
				has_shin = true
				break
			elseif v_kyu:sub(1, 1) == '&' then
				has_kyu = true
				table.insert(form_kyu, v_kyu)
			else
				has_kyu, has_kyu_nonsupple = true, true
				table.insert(form_kyu, v_kyu)
			end
			table.insert(form_kyu, non_kanji[i + 1])
		end

		if not has_shin and has_kyu then
			kyu[1] = (has_kyu_nonsupple and '' or pagename .. '|') .. table.concat(form_kyu)
		end

		if pagename:match'弁' then require('Module:debug').track('ja-kanjitab/ambiguous kyujitai for 弁') end
	end

	-- 々
	for i, v in ipairs(kanji) do
		if v == '々' then kanji[i] = kanji[i - 1] end
	end

	-- process readings
	local readings = {}
	local readings_actual = {}
	local reading_length_total = 0
	for i = 1, args[1].maxindex do
		local reading_kana, reading_length
		_, _, reading_kana, reading_length = mw.ustring.find(args[1][i] or '', '^([^0-9]*)([0-9]*)$')
		reading_kana = reading_kana ~= "" and reading_kana or nil
		reading_length = reading_kana and tonumber(reading_length) or 1

		table.insert(readings, {reading_kana, reading_length})
		reading_length_total = reading_length_total + reading_length
	end
	if reading_length_total > #kanji then
		error('Readings for ' .. reading_length_total .. ' kanji are given, but this word has only ' .. #kanji .. ' kanji.')
	else
		for i = reading_length_total + 1, #kanji do table.insert(readings, {nil, 1}) end
	end

	local table_head = [=[
{| class="wikitable kanji-table" style="text-align: center; font-size: small; float: right;]=] .. (args.clearright and ' clear:right;' or '') .. [=["
! ]=] .. (#kanji > 1 and 'colspan="' .. #kanji .. '" ' or '') .. [=[style="font-weight: normal;" | [[Appendix:Japanese_glossary#kanji|Kanji]] in this term
|- lang="ja" class="Jpan" style="font-size: 2em; background: white; line-height: 1em;"

]=]

	local yomi

	-- on/kun is jūbakoyomi; NOTE: these are only applicable for two-kanji compounds
	-- kun/on is yutōyomi; NOTE: these are only applicable for two-kanji compounds
	if args.yomi then
		yomi = {}
		local extended_yomi_code = {
			o = 'on',			on = 'on',
			kanon = 'kanon',  -- kan is kan'yoon, and ko is kun+on for backward compatibility
			goon = 'goon',
			soon = 'soon',
			toon = 'toon',
			kan = 'kanyoon',	kanyo = 'kanyoon',		kanyoon = 'kanyoon',
			k = 'kun',			kun = 'kun',
			juku = 'jukujikun',	jukuji = 'jukujikun',	jukujikun = 'jukujikun',
			ok = "jūbakoyomi",	j = "jūbakoyomi",
			ko = "yutōyomi",	y = "yutōyomi",			yu = "yutōyomi",
			i = 'irregular',	irr = 'irregular',		irreg = 'irregular',	irregular = 'irregular',
			n = 'nanori',	nanori = 'nanori',
			[''] = '',			none = '',
		}
		for i in mw.text.gsplit(args.yomi, ',') do
			local _, _, a, b = mw.ustring.find(i, '^([a-z]*)([0-9]*)$')
			a = extended_yomi_code[a] or error("The yomi type “" .. args.yomi .. "” is not recognized.")
			b = tonumber(b) or 1
			table.insert(yomi, { a, b })
		end
		if #yomi == 1 and #kanji > 1 then
			yomi[1][2] = #kanji
		end
	else
		require('Module:debug').track'ja-kanjitab/no yomi'
	end

	if yomi and (yomi[1][1] == "jūbakoyomi" or yomi[1][1] == "yutōyomi") and #kanji ~= 2 then
		if mw.title.getCurrentTitle().id <= 8167274 then
			require('Module:debug').track'ja-kanjitab/incorrect yutou or juubako'
		else
			error'incorrect yutou or juubako'
		end
	end

	if args.k.maxindex and args.k.maxindex > args[1].maxindex then
		require('Module:debug').track'ja-kanjitab/too many k'
	end

	if args.o.maxindex and args.o.maxindex > args[1].maxindex then
		require('Module:debug').track'ja-kanjitab/too many o'
	end

	local yomi_type_by_kanji = {}
	if yomi then
		for i = 1, #yomi do
			for j = 1, yomi[i][2] do
				table.insert(yomi_type_by_kanji, yomi[i][1])
			end
		end
	else
		for i = 1, #kanji do
			table.insert(yomi_type_by_kanji, '')
		end
	end

	local is_ateji = {}
	if args.ateji then
		local ateji = args.ateji
		local cat_ateji = false
		if ateji == 'y' then
			for i = 1, #kanji do
				is_ateji[i] = true
			end
			cat_ateji = true
		else
			for i in mw.text.gsplit(ateji, ';') do
				string.gsub(i, '^([0-9]+)$', function(a)
					is_ateji[tonumber(a)] = true
					cat_ateji = true
				end)
				string.gsub(i, '^([0-9]+),([0-9]+)$', function (a, b)
					for j = tonumber(a), tonumber(b) do
						is_ateji[j] = true
					end
					cat_ateji = true
				end)
			end
		end
		if cat_ateji then table.insert(categories, "Japanese terms spelled with ateji") end
	end

	-- if hiragana readings were passed,
	-- make the "spelled with ..." categories, the readings cells on the lower level and build the sort key
	-- otherwise rely on the pagename to make the original kanjitab and categories
	local cells_above = {}
	local cells_below = {}
	local kanji_pos = 1
	for i, reading in ipairs(readings) do
		local reading_kana, reading_length = reading[1], reading[2]
		local cell = {}

		if reading_length <= 1 then
			table.insert(cell, '| rowspan="2" | ')
		else
			table.insert(cell, '| colspan ="' .. reading_length .. '" | ')
		end

		-- display reading, actual reading and okurigana
		if reading_kana then
			if mw.ustring.find(reading_kana, '[ぁ-ゖ]') and not mw.ustring.find(reading_kana, '^[ぁ-ゖ]+$') then
					require('Module:debug').track'ja-kanjitab/not all hiragana'
			end

			local actual_reading = args.k[i]
			local okurigana = args.o[i]

			local okurigana_text = okurigana and "(" .. okurigana .. ")" or ""
			local actual_reading_text = actual_reading and " > " .. actual_reading .. okurigana_text or ""
			local text = reading_kana .. okurigana_text .. actual_reading_text

			readings_actual[i] = {(actual_reading or reading_kana) .. (okurigana or ''), reading_length}

			table.insert(cell, '<span class="Jpan" lang="ja">' .. text .. '</span>')
			if reading_length <= 1 then table.insert(cell, '<br/>') end
		else
			readings_actual[i] = {nil, 1}
		end

		-- display kanji grade, categorize
		for j = kanji_pos, kanji_pos + reading_length - 1 do
			local single_kanji = kanji[j]
			local kanji_grade = m_ja.kanji_grade(single_kanji)
			local ateji_text = is_ateji[j] and '<br/><small>([[Appendix:Japanese glossary#ateji|ateji]])</small>' or ''

			if reading_kana then
				-- subcategorize by reading if this is joyo kanji, not doing that for less common kanji, with exceptions
				if (kanji_grade < 8 or (
					'厭昌之芽昌浩智晃淳敦聡晃旭亮糊桂隘阿唖撫鼠阿耘迂寅已伊餡姦闊礙碍凱亥价謳嘔齧日臣桶抉兎鵜卯綾飴焙肋鮫頚糞軋烏痒捷辰叩橙揃嶋澤菱彦囃覗呑之乃鼠做寅樋堤槌机杖頼辿哉叢狢峯巳卍鱒仄他惚弘宏燕倦經痙圭禽僑鋸醵墟屹綺几翫癌劫膠昂鹸牽喧餐鑽瑣些渾梱坤國壕誦哨蒐杓爾梓荼楕躁綜楚闡閃撰專泄藉棲錘錐祷盪淘點顛填擲擢闖厨蛋潭腿冪碧劈焚祓弗憑誹砒婢挽拔撥剥胚播乃狼牢蓮礫醂龍榴蕾酉祐佑耶也蔓曼沫邁呆硼牡甫步矮狸苔'
				):find(single_kanji)) and yomi_type_by_kanji[j] ~= 'irregular' and yomi_type_by_kanji[j] ~= 'jukujikun' and reading_length == 1 then
					table.insert(categories, "Japanese terms spelled with " .. single_kanji .. " read as " .. reading_kana)
				else
					table.insert(categories, "Japanese terms spelled with " .. single_kanji)
				end
			else
				if yomi_type_by_kanji[j] ~= 'irregular' and yomi_type_by_kanji[j] ~= 'jukujikun' then
					require('Module:debug').track'ja-kanjitab/no reading'
				end
				table.insert(categories, "Japanese terms spelled with " .. single_kanji)
			end

			if reading_length <= 1 then
				table.insert(cell, "<small>" .. kanji_grade_links[kanji_grade] .. "</small>" .. ateji_text)
			else
				table.insert(cells_below, "| <small>" .. kanji_grade_links[kanji_grade] .. "</small>" .. ateji_text)
			end
		end
		table.insert(cells_above, table.concat(cell))
		kanji_pos = kanji_pos + reading_length
	end
	table.insert(cells, '|- style="background: white;"')
	if #cells_below > 0 then
		table.insert(cells, table.concat(cells_above, '\n'))
		table.insert(cells, '|- style="background: white;"')
		table.insert(cells, table.concat(cells_below, '\n'))
	else
		for i, v in ipairs(cells_above) do
			cells_above[i] = v:gsub('| rowspan="2" | ', '| ')
		end
		table.insert(cells, table.concat(cells_above, '\n'))
	end

	local yomi_info = {
		["on"] = {
			text = "on’yomi",
			entry = "Appendix:Japanese_glossary#on'yomi",
			category = "Japanese terms read with on'yomi",
		},
		["kanon"] = {
			text = "kan’on",
			entry = "Appendix:Japanese_glossary#kan'on",
			category = "Japanese terms read with on'yomi",
		},
		["goon"] = {
			text = "goon",
			entry = "Appendix:Japanese_glossary#goon",
			category = "Japanese terms read with on'yomi",
		},
		["soon"] = {
			text = "sōon",
			entry = "Appendix:Japanese_glossary#tōon",
			category = "Japanese terms read with on'yomi",
		},
		["toon"] = {
			text = "tōon",
			entry = "Appendix:Japanese_glossary#tōon",
			category = "Japanese terms read with on'yomi",
		},
		["kun"] = {
			text = "kun’yomi",
			entry = "Appendix:Japanese_glossary#kun'yomi",
			category = "Japanese terms read with kun'yomi",
		},
		["nanori"] = {
			text = "nanori",
			entry = "Appendix:Japanese_glossary#nanori",
			category = "Japanese terms read with nanori",
		},
		["yutōyomi"] = {
			text = "yutōyomi",
			entry = "Appendix:Japanese_glossary#yutōyomi",
			category = "Japanese terms read with yutōyomi",
		},
		["jūbakoyomi"] = {
			text = "jūbakoyomi",
			entry = "Appendix:Japanese_glossary#jūbakoyomi",
			category = "Japanese terms read with jūbakoyomi",
		},
		["jukujikun"] = {
			text = "jukujikun",
			entry = "Appendix:Japanese_glossary#jukujikun",
			category = "Japanese terms read with jukujikun",
		},
		["irregular"] = {
			text = "''Irregular''",
			category = "Japanese terms with irregular kanji readings",
		},
		["kanyoon"] = {
			text = "kan’yōon",
			entry = "Appendix:Japanese_glossary#kan'yoon",
			category = "Japanese terms read with kan'yōon",
		},
	}

	local rendaku = args.r
	if rendaku then
		table.insert(categories, "Japanese terms with rendaku")
	end

	if yomi then
		table.insert(cells, "|-")
		for _, i in ipairs(yomi) do
			local yomi_info = yomi_info[i[1]] or { text = i[1] }
			local text
			if yomi_info.entry then
				text = "[[" .. yomi_info.entry .. "|" .. yomi_info.text .. "]]"
			else
				text = yomi_info.text
			end
			table.insert(cells, '| colspan="' .. i[2] .. '" |' .. text)
		end
		local is_onyomi = { on = true, kanon = true, goon = true, soon = true, toon = true, kanyoon = true }
		-- categories
		local all_onyomi = true
		for i = 1, #yomi do
			if not is_onyomi[yomi[i][1]] then all_onyomi = false; break end
		end
		if all_onyomi then
			table.insert(categories, yomi_info.on.category)
		elseif yomi[1][1] == 'jūbakoyomi' or yomi[1][1] == 'yutōyomi' then
			table.insert(categories, yomi_info[yomi[1][1]].category)
		else
			local all_yomi_of_same_type = true
			for i = 2, #yomi do
				if yomi[i][1] ~= yomi[1][1] then all_yomi_of_same_type = false; break end
			end
			if all_yomi_of_same_type then
				table.insert(categories, yomi_info[yomi[1][1]].category)
			elseif #yomi == 2 and yomi[1][2] == 1 and yomi[2][2] == 1 and mw.ustring.len(pagename) == 2 then
				if is_onyomi[yomi[1][1]] and yomi[2][1] == 'kun' then
					table.insert(categories, yomi_info["jūbakoyomi"].category)
				elseif yomi[1][1] == 'kun' and is_onyomi[yomi[2][1]] then
					table.insert(categories, yomi_info["yutōyomi"].category)
				end
			end
		end
	end

	local kanji_table
	if #kanji > 0 then
		kanji_table = table_head
		for _, v in ipairs(kanji) do
			kanji_table = kanji_table .. '| style="padding: 0.5em;" | [[' .. v .. '#Japanese|' .. v .. ']]\n'
		end
		kanji_table = kanji_table .. table.concat(cells, '\n') .. '\n|}'
	else
		kanji_table = ''
	end

	local forms_table = ""
	if args.alt == '' or args.alt == '-' then args.alt = nil end
	if kyu[1] or args.alt then
		local forms = {}

		-- |kyu=
		for _, form in ipairs(kyu) do
			local form_linkto, form_display = form:match'^(.+)|(.+)$'
			if not form_linkto then form_linkto, form_display = form, form end
			table.insert(forms, table.concat{
				'<span class="Jpan" lang="ja" style="font-family:游ゴシック, HanaMinA, sans-serif; font-size:140%;">[[',
				form_linkto,
				form_linkto == pagename and '|' or '#Japanese|',
				form_display,
				']]</span> <small>',
				ShowLabels({'kyūjitai'}, lang, nil, nil, nil, nil, true),
				'</small>',
			})
		end

		-- |alt=
		if args.alt then
			for form in mw.text.gsplit(args.alt, ',') do
				local i_semicolon = string.find(form, ':')
				if i_semicolon then
					local altform = string.sub(form, 1, i_semicolon - 1)
					local altlabels = mw.text.split(string.sub(form, i_semicolon + 1), ' ')
					table.insert(forms, table.concat{
						'<span class="Jpan" lang="ja" style="font-size:140%">[[',
						altform,
						'#Japanese|',
						altform,
						']]</span> <small>',
						ShowLabels(altlabels, lang, nil, nil, nil, nil, true),
						'</small>',
					})
				else
					table.insert(forms, table.concat{
						'<span class="Jpan" lang="ja" style="font-size:140%">[[',
						form,
						'#Japanese|',
						form,
						']]</span>'
					})
				end
			end
		end

		forms_table = '\n' .. [[{| class="wikitable floatright"
! style="font-weight:normal" | Alternative spelling]] .. (#forms == 1 and "" or "s") .. [[

|-
| style="text-align:center;font-size:108%" | ]] .. table.concat(forms, '<br>') .. '\n|}'
	end


	-- use user-provided sortkey if we got one, otherwise
	-- use the sortkey we've already made by combining the
	-- readings if provided, if we have neither then
	-- default to empty string and don't sort
	local sortkey
	if args.sort then
		sortkey = args.sort
	else
		sortkey = {non_kanji[1]}
		local id = 1
		for _, v in ipairs(readings_actual) do
			id = id + v[2]
			table.insert(sortkey, (v[1] or '') .. (non_kanji[id] or ''))
		end
		sortkey = table.concat(sortkey)
	end
	if sortkey == '' then
		sortkey = nil
	else
		sortkey = m_ja.jsort(sortkey)
	end

	return (forms_table == "" and kanji_table or (kanji_table .. forms_table)) .. m_utilities.format_categories(categories, lang, sortkey)
end

return export