local export = {}

local find = mw.ustring.find
local match = mw.ustring.match
local gsub = mw.ustring.gsub

local langname = {
	["cdo"] = "Min Dong",
	["cmn"] = "Mandarin",
	["cjy"] = "Jin",
	["dng"] = "Dungan",
	["gan"] = "Gan",
	["hak"] = "Hakka",
	["hsn"] = "Xiang",
	["mnp"] = "Min Bei",
	["nan"] = "Min Nan",
	["wuu"] = "Wu",
	["yue"] = "Cantonese",
}

local langname_abbr = {
	["m"] = "Mandarin",
	["m-s"] = "Sichuanese",
	["dg"] = "Dungan",
	["c"] = "Cantonese",
	["c-t"] = "Taishanese",
	["g"] = "Gan",
	["h"] = "Hakka",
	["j"] = "Jin",
	["mb"] = "Min Bei",
	["md"] = "Min Dong",
	["mn"] = "Min Nan",
	["mn-t"] = "Teochew",
	["w"] = "Wu",
	["x"] = "Xiang",
}

local pos_aliases_cat = {
	["n"] = "nouns", ["noun"] = "nouns",
	["pn"] = "proper nouns", ["propn"] = "proper nouns", ["proper"] = "proper nouns", ["proper noun"] = "proper nouns",
	["pron"] = "pronouns", ["pronoun"] = "pronouns",
	["v"] = "verbs", ["verb"] = "verbs",
	["a"] = "adjectives", ["adj"] = "adjectives", ["adjective"] = "adjectives",
	["adv"] = "adverbs", ["adverb"] = "adverbs",
	["prep"] = "prepositions", ["pre"] = "prepositions",
	["postp"] = "postpositions", ["post"] = "postpositions",
	["con"] = "conjunctions", ["conj"] = "conjunctions", ["conjunction"] = "conjunctions",
	["part"] = "particles", ["particle"] = "particles",
	["pref"] = "prefixes", ["prefix"] = "prefixes",
	["suf"] = "suffixes", ["suffix"] = "suffixes",
	["infix"] = "infixes",
	["prov"] = "proverbs", ["proverb"] = "proverbs",
	["id"] = "idioms", ["idiom"] = "idioms",
	["ch"] = "chengyu", ["cy"] = "chengyu", ["chengyu"] = "chengyu",
	["ph"] = "phrases", ["phrase"] = "phrases",
	["intj"] = "interjections", ["interj"] = "interjections", ["interjection"] = "interjections",
	["cl"] = "classifiers", ["cls"] = "classifiers", ["classifier"] = "classifiers",
	["num"] = "numerals", ["numeral"] = "numerals",
	["abb"] = "abbreviations", ["abbreviation"] = "abbreviations",
	["det"] = "determiners", ["deter"] = "determiners", ["determiner"] = "determiners",
	["syllable"] = "syllables",
}

-- if not empty
local function ine(val)
	if val == "" then
		return nil
	end
	return val
end

local function makeNote(text)
	if find(text, ": ") then
		text = "\n*" .. gsub(gsub(text, "\n", ".\n*"), "([:;]) ", "%1\n**")
	elseif find(text, "; ") then
		text = "\n*" .. gsub(text, '; ', ";\n*")
	end
	text = gsub(text, '“([^”]+)”', function (a) return '“' .. gsub(a, ";\n%*+", "; ") .. '”' end)
	return "\n<div style=\"border: 1px solid green; padding: 4px; margin: 8px; background: #F7F4ED; font-size: 85%\">'''Note''': " .. text .. ".</div>"
end

local function ipa_format(text)
	local numbers = { [1]='¹',[2]='²',[3]='³',[4]='⁴',[5]='⁵',[0]='⁰',['-']='⁻',['/']='/, /' }
	return gsub(text,'[0-5%-/]',numbers)
end

local function add_audio(text, audio, lang)
	-- This function has side effects
	if audio then
		if audio == "y" then audio = string.format('%s-%s.ogg', lang, mw.title.getCurrentTitle().baseText) end
		table.insert(text, '\n*** [[File:')
		table.insert(text, audio)
		table.insert(text, ']]')
		table.insert(text, '[[Category:')
		table.insert(text, langname[lang:sub(1, 3)])
		table.insert(text, ' terms with audio links]]')
	end
end

local function add_audio_show(text, audio, lang)
	-- This function has side effects
	if audio then
		if audio == "y" then audio = string.format('%s-%s.ogg', lang, mw.title.getCurrentTitle().baseText) end
		table.insert(text, '\n*:: <div style="display:inline-block; position:relative; top:0.5em;">[[File:')
		table.insert(text, audio)
		table.insert(text, ']]</div>')
		table.insert(text, '[[Category:')
		table.insert(text, langname[lang:sub(1, 3)])
		table.insert(text, ' terms with audio links]]')
	end
end

local function Consolas(text)
	return '<span style="font-family: Consolas, monospace;">' .. text .. '</span>'
end

local function format_IPA(text)
	return '<span class="IPA">' .. text .. '</span>'
end

function export.make(frame)
	local args = frame:getParent().args
	local title = mw.title.getCurrentTitle()
	local pagename = ine(args["pagename"]) or title.text
	-- Unicode pattern for single Han character, with non-NFC characters
	-- inserted using mw.ustring.char because they can't be saved in a MediaWiki
	-- page.
	-- https://unicode.org/cldr/utility/regex.jsp?a=%5Cp%7BHani%7D
	local hanzi = "^[⺀-⺙⺛-⻳⼀-⿕々〇〡-〩〸-〻㐀-䶿一-鿼"
		.. mw.ustring.char(0xF900) .. "-" .. mw.ustring.char(0xFA6D)
		.. mw.ustring.char(0xFA70) .. "-" .. mw.ustring.char(0xFAD9)
		.. "𠀀-𪛝𪜀-𫜴𫝀-𫠝𫠠-𬺡𬺰-𮯠" .. mw.ustring.char(0x2F800)
		.. "-" .. mw.ustring.char(0x2FA1D) .. "𰀀-𱍊]$"
	local is_single_hanzi = mw.ustring.find(pagename, hanzi) ~= nil
	local namespace = ine(args["namespace"]) or title.nsText
	local m_rom = ine(args["m"])
	local m_s_rom = ine(args["m-s"])
	local dg_rom = ine(args["dg"])
	local c_rom = ine(args["c"])
	local c_t_rom = ine(args["c-t"])
	local g_rom = ine(args["g"])
	local h_rom = ine(args["h"])
	local j_rom = ine(args["j"])
	local mb_rom = ine(args["mb"])
	local md_rom = ine(args["md"])
	local mn_rom = ine(args["mn"])
	local mn_t_rom = ine(args["mn-t"])
	local w_rom = ine(args["w"])
	local x_rom = ine(args["x"])
	local m_audio = ine(args["ma"])
	local m_audio2 = ine(args["ma2"])
	local m_s_audio = ine(args["m-sa"])
	local dg_audio = ine(args["dga"])
	local c_audio = ine(args["ca"])
	local c_t_audio = ine(args["c-ta"])
	local g_audio = ine(args["ga"])
	local h_audio = ine(args["ha"])
	local j_audio = ine(args["ja"])
	local md_audio = ine(args["mda"])
	local mn_audio = ine(args["mna"])
	local mn_t_audio = ine(args["mn-ta"])
	local w_audio = ine(args["wa"])
	local x_audio = ine(args["xa"])
	local dial = ine(args["dial"])
	local mc = ine(args["mc"]) or false
	local oc = ine(args["oc"]) or false
	local only_cat = args["only_cat"] == "yes"

	local text = {} --the pronunciation table
	if not only_cat then
        --The whole table consists of 4 parts
        --"textShow" contains Part 1, 3 and 4
		local textShow = {'<div class="toccolours zhpron" style="max-width:500px; font-size:100%; overflow: hidden">'}
        --"textHide" is Part 2
		local textHide = {}

		table.insert(textShow, '<div class="vsSwitcher" data-toggle-category="pronunciations">\n<span class="vsToggleElement" style="float: right;"></span>')
        --Part 1 and 2, "Pronunciation" and "Pronunciation expressed in different romanizations"
		if m_rom or m_s_rom or dg_rom then
			table.insert(textShow, '\n* [[w:Mandarin Chinese|Mandarin]]')
		end
		if m_rom or m_audio then
			local m_args = {}
			local m_pron = require("Module:cmn-pron")
			if m_rom then
				local str_analysis = m_pron.str_analysis
				local other_m_vars = { (m_s_rom or ""), (m_s_audio or ""), (dg_rom or ""), (dg_audio or "") }
				table.insert(textShow, '\n' .. str_analysis(m_rom, 'head', table.concat(other_m_vars) ~= ""))

				m_args[1] = str_analysis(m_rom,'')
				local m_args_names = {
					'1n','1na','1nb','1nc','1nd','py','cap','tl','tl2','tl3','a','audio','er','ertl','ertl2','ertl3','era','eraudio',
					'2n','2na','2nb','2nc','2nd','2py','2cap','2tl','2tl2','2tl3','2a','2audio','2er','2ertl','2ertl2','2ertl3','2era','2eraudio',
					'3n','3na','3nb','3nc','3nd','3py','3cap','3tl','3tl2','3tl3','3a','3audio','3er','3ertl','3ertl2','3ertl3','3era','3eraudio',
					'4n','4na','4nb','4nc','4nd','4py','4cap','4tl','4tl2','4tl3','4a','4audio','4er','4ertl','4ertl2','4ertl3','4era','4eraudio',
					'5n','5na','5nb','5nc','5nd','5py','5cap','5tl','5tl2','5tl3','5a','5audio','5er','5ertl','5ertl2','5ertl3','5era','5eraudio',
				}
				for _, name in ipairs(m_args_names) do
					m_args[name] = str_analysis(m_rom, name)
				end
				for i = 2, 5 do
					m_args[i] = str_analysis(m_rom, tostring(i))
				end
			end
			m_args['a'] = m_audio
			m_args['a2'] = m_audio2
			local debug = ""
			for code,name in pairs(m_args) do
				debug = debug .. code .. ":" .. name .. ","
			end
			table.insert(textShow, m_pron.make_audio(m_args))
			table.insert(textHide, m_pron.make_args(m_args))
			if args["m_note"] then table.insert(textHide, makeNote(args["m_note"])) end
		end
		if m_s_rom or m_s_audio then
			local m_s_pron = require("Module:cmn-pron-Sichuan")
			local m_s_processed = gsub(gsub(gsub(m_s_rom, '/', ' / '), '([%d-])([%a])', '%1 %2'), '([%d-]+)', '<sup>%1</sup>')
			if m_s_rom then
				table.insert(textShow, '\n*: <small>(<i>[[w:Sichuanese dialect|Chengdu]], [[w:Sichuanese Pinyin|SP]]</i>)</small>: ')
				table.insert(textShow, Consolas(m_s_processed))
			end
			add_audio_show(textShow, m_s_audio, 'cmn-sichuan')
			if not (m_rom or m_audio) then
				table.insert(textHide, '\n* [[w:Mandarin Chinese|Mandarin]]')
			end
			table.insert(textHide, '\n** <small>(<i>[[w:Chengdu|Chengdu]]</i>)</small>')
			table.insert(textHide, '\n*** <small><i>[[w:Sichuanese Pinyin|Sichuanese Pinyin]]</i></small>: ')
			table.insert(textHide, Consolas(m_s_processed))
			local xinwenz = m_s_pron.convert(m_s_rom, 'SWZ')
			if xinwenz then
				table.insert(textHide, '\n*** <small><i>[[w:zh:四川话拉丁化新文字|Scuanxua Ladinxua Xin Wenz]]</i></small>: ')
				table.insert(textHide, Consolas(m_s_pron.convert(m_s_rom, 'SWZ')))
			end
			table.insert(textHide, '\n*** <small>Sinological [[Wiktionary:International Phonetic Alphabet|IPA]] <sup>([[w:zh:成都话|key]])</sup></small>: ')
			table.insert(textHide, format_IPA(m_s_pron.convert(m_s_rom, 'IPA')))
			-- add_audio(textHide, m_s_audio, 'cmn-sichuan')
			if args["m-s_note"] then table.insert(textHide, makeNote(args["m-s_note"])) end
		end
		if dg_rom or dg_audio then
			local dg_pron = require("Module:dng-pron")
			local dg_processed = dg_pron.process(dg_rom)
			if dg_rom then
				table.insert(textShow, '\n*: <small>(<i>[[w:Dungan language|Dungan]], [[w:Dungan alphabet|Cyrillic]]</i>)</small>: ')
				table.insert(textShow, Consolas(dg_processed))
			end
			add_audio_show(textShow, dg_audio, 'dng')
			if not (m_rom or m_audio or m_s_rom or m_s_audio) then
				table.insert(textHide, '\n* [[w:Mandarin Chinese|Mandarin]]')
			end
			table.insert(textHide, '\n** <small>(<i>[[w:Dungan language|Dungan]]</i>)</small>')
			table.insert(textHide, '\n*** <small><i>[[w:Dungan alphabet|Cyrillic]]</i></small>: ')
			table.insert(textHide, Consolas(dg_processed))
			table.insert(textHide, '\n*** <small>Sinological [[Wiktionary:International Phonetic Alphabet|IPA]] <sup>([[w:Dungan phonology|key]])</sup></small>: ')
			table.insert(textHide, format_IPA(dg_pron.convert(dg_rom, 'IPA')) .. '\n**: <small>(Note: Dungan pronunciation is currently experimental and may be inaccurate.)</small>')
			-- add_audio(textHide, dg_audio, 'dng')
			if args["dg_note"] then table.insert(textHide, makeNote(args["dg_note"])) end
		end
		if c_rom or c_audio or c_t_rom or c_t_audio then
			local c_pron = require("Module:yue-pron")
			if c_rom or c_t_rom then
				table.insert(textShow, '\n* [[w:Cantonese|Cantonese]]')
				table.insert(textHide, '\n* [[w:Cantonese|Cantonese]]')
				if c_rom then
					c_rom = c_rom:gsub("%*","-")
					local c_processed = c_rom:gsub(',([^ ])',', %1')
					if mw.ustring.len(pagename) == 1 then
						c_processed = c_processed:gsub('([^, ]+)','[[%1]]')
						c_processed = c_processed:gsub('%[%[%[%[','[[')
						c_processed = c_processed:gsub('%]%]%]%]',']]')
						c_processed = gsub(c_processed, '%[%[([^%]]+)%]%]', function(a)
							return '[[' .. a .. '|' .. gsub(a, '([1-9-]+)', '<sup>%1</sup>') .. ']]' end)
					else
						c_processed = gsub(c_processed, '([1-9-]+)', '<sup>%1</sup>')
					end
					if not c_t_rom then
						table.insert(textShow, ' <small>(<i>')
					else
						table.insert(textShow, '\n*: <small>(<i>[[w:Guangzhou Cantonese|Guangzhou]], ')
					end
					table.insert(textShow, '[[w:Jyutping|Jyutping]]</i>)</small>: ' .. Consolas(c_processed))
					add_audio_show(textShow, c_audio, 'yue')
					c_rom = c_rom:gsub('[%[%]]','')
					local c_hom = mw.loadData("Module:yue-pron/hom")
					local c_hom_exists = false
					for _,c_first in ipairs(c_pron.jyutping_format(c_rom)) do
						if c_hom[c_first] then
							c_hom_exists = c_first
						end
					end
					table.insert(textHide, '\n** <small>(<i>[[w:Standard Cantonese|Standard Cantonese]], [[w:Guangzhou Cantonese|Guangzhou]]</i>)</small>')
					if not c_hom_exists then
						table.insert(textHide, '<sup><small><abbr title="Add Cantonese homophones"><span class="plainlinks">[')
						table.insert(textHide, tostring(mw.uri.fullUrl("Module:yue-pron/hom",{["action"]="edit"})))
						table.insert(textHide, ' +]</span></abbr></small></sup>')
					end
					local c_comma = gsub(c_rom,',([^ ])',', %1')
					table.insert(textHide, '\n*** <small><i>[[w:Jyutping|Jyutping]]</i></small>: ')
					table.insert(textHide, Consolas(tostring(gsub(c_comma, '([1-9-]+)', '<sup>%1</sup>'))))
					table.insert(textHide, '\n*** <small><i>[[w:Yale romanization of Cantonese|Yale]]</i></small>: ')
					table.insert(textHide, Consolas(c_pron.jyutping_to_yale(c_rom)))
					table.insert(textHide, '\n*** <small><i>[[w:Cantonese Pinyin|Cantonese Pinyin]]</i></small>: ')
					table.insert(textHide, Consolas(tostring(gsub(c_pron.jyutping_to_cantonese_pinyin(c_rom), '([1-9-]+)', '<sup>%1</sup>'))))
					table.insert(textHide, '\n*** <small><i>[[w:Guangdong Romanization|Guangdong Romanization]]</i></small>: ')
					table.insert(textHide, Consolas(tostring(gsub(c_pron.jyutping_to_guangdong(c_rom), '([1-9-]+)', '<sup>%1</sup>'))))
					table.insert(textHide, '\n*** <small>Sinological [[Wiktionary:International Phonetic Alphabet|IPA]] <sup>([[w:Cantonese phonology|key]])</sup></small>: ')
					table.insert(textHide, format_IPA('/' .. c_pron.jyutping_to_ipa(c_rom) .. '/'))
					for _,c_first in ipairs(c_pron.jyutping_format(c_rom)) do
						if c_hom_exists == c_first then
							local hom_textHide = {'\n*** <small>Homophones</small>: <table class="wikitable mw-collapsible mw-collapsed" style="width:15em;margin:0;'}
							local hom_text = {}
							table.insert(hom_textHide, 'position:left; text-align:center"><tr><th></th></tr><tr><td><div style="float: right; clear: right;"><sup>')
							table.insert(hom_textHide, '<span class="plainlinks">[')
							table.insert(hom_textHide, tostring(mw.uri.fullUrl("Module:yue-pron/hom",{["action"]="edit"})))
							table.insert(hom_textHide, ' edit]</span></sup></div><div style="visibility:hidden; float:left"><sup><span style="color:#FFF">edit</span></sup></div>')
							for _,hom in ipairs(c_hom[c_first]) do
								table.insert(hom_text, mw.getCurrentFrame():expandTemplate{ title = "Template:zh-l", args = { hom, tr = "-" } })
							end
							table.insert(hom_textHide, table.concat(hom_text, "<br>"))
							table.insert(hom_textHide, '</td></tr></table>')
							table.insert(textHide, table.concat(hom_textHide))
							table.insert(textHide, '[[Category:Cantonese terms with homophones]]')
						end
					end
					-- add_audio(textHide, c_audio, 'yue')
					if not args["c_note"] and c_rom and (find(c_rom, "^[ao]") or find(c_rom, ",[ao]")) and mw.ustring.len(pagename) == 1 then
						args["c_note"] = "The zero initial " .. format_IPA("/∅-/") .. " is commonly pronounced with a ''ng''-initial " .. format_IPA("/ŋ-/") .. " in some varieties of Cantonese, including Hong Kong Cantonese"
					end
					if args["c_note"] then table.insert(textHide, makeNote(args["c_note"])) end
				end
				if c_t_rom then
					local c_t_processed = c_t_rom:gsub(',([^ ])',', %1')
					c_t_processed = gsub(c_t_processed, '([1-9%*]%-?[1-9%*]?)', '<sup>%1</sup>')
					table.insert(textShow, (c_rom and '\n*:' or '') .. ' <small>(<i>[[w:Taishanese|Taishan]], [[Wiktionary:About Chinese/Cantonese/Taishanese|Wiktionary]]</i>)</small>: ')
					table.insert(textShow, Consolas(c_t_processed))
					add_audio_show(textShow, c_t_audio, 'yue-taishan')
					c_t_rom = c_t_rom:gsub('[%[%]]','')
					local c_t_comma = gsub(c_t_rom,',([^ ])',', %1')
					table.insert(textHide, '\n** <small>(<i>[[w:Taishanese|Taishanese]], [[w:Taicheng Subdistrict|Taicheng]]</i>)</small>')
					table.insert(textHide, '\n*** <small><i>[[Wiktionary:About Chinese/Cantonese/Taishanese|Wiktionary]]</i></small>: ')
					table.insert(textHide, Consolas(tostring(gsub(c_t_comma, '([1-9%*]%-?[1-9%*]?)', '<sup>%1</sup>'))))
					table.insert(textHide, '\n*** <small>Sinological [[Wiktionary:International Phonetic Alphabet|IPA]] <sup>([[w:Taishanese|key]])</sup></small>: ')
					table.insert(textHide, format_IPA(c_pron.hoisanva_to_ipa(c_t_rom)))
					-- add_audio(textHide, c_t_audio, 'yue-taishan')
					if args["c-t_note"] then table.insert(textHide, makeNote(args["c-t_note"])) end
				end
			end
		end
		if g_rom or g_audio then
			local g_pron = require("Module:gan-pron")
			if g_rom then
				table.insert(textShow, '\n* [[w:Gan Chinese|Gan]] <small>(<i>[[Wiktionary:About Chinese/Gan|Wiktionary]]</i>)</small>: ')
				table.insert(textShow, Consolas(g_pron.rom(g_rom)))
			end
			add_audio_show(textShow, g_audio, 'gan')
			table.insert(textHide, '\n* [[w:Gan Chinese|Gan]]')
			table.insert(textHide, '\n** <small>(<i>[[w:Nanchang dialect|Nanchang]]</i>)</small>')
			table.insert(textHide, '\n*** <small><i>[[Wiktionary:About Chinese/Gan|Wiktionary]]</i></small>: ')
			table.insert(textHide, Consolas(g_pron.rom(g_rom)))
			table.insert(textHide, '\n*** <small>Sinological [[Wiktionary:International Phonetic Alphabet|IPA]] <sup>([[w:Nanchang dialect|key]])</sup></small>: ')
			table.insert(textHide, format_IPA('/' .. g_pron.ipa(g_rom) .. '/'))
			-- add_audio(textHide, g_audio, 'gan')
			if args["g_note"] then table.insert(textHide, makeNote(args["g_note"])) end
		end
		if h_rom and (find(h_rom, 'pfs=.') or find(h_rom, 'gd=.')) or h_audio then
			local h_pron = require("Module:hak-pron")
			if find(h_rom, "pfs=.") or find(h_rom, 'gd=.') then
				table.insert(textShow, '\n* [[w:Hakka Chinese|Hakka]]')
				table.insert(textShow, h_pron.rom_display(h_rom,'yes'))
			end
			add_audio_show(textShow, h_audio, 'hak')
			table.insert(textHide, '\n* [[Wiktionary:About Chinese/Hakka|Hakka]]')
			if h_rom then table.insert(textHide, h_pron.rom_display(h_rom,'')) end
			-- add_audio(textHide, h_audio, 'hak')
			if args["h_note"] then table.insert(textHide, makeNote(args["h_note"])) end
		end
		if j_rom or j_audio then
			local j_pron = require("Module:cjy-pron")
			if j_rom then
				table.insert(textShow, '\n* [[w:Jin Chinese|Jin]] <small>(<i>[[Wiktionary:About Chinese/Jin|Wiktionary]]</i>)</small>: ')
				table.insert(textShow, Consolas(j_pron.rom(j_rom)))
			end
			add_audio_show(textShow, j_audio, 'cjy')
			table.insert(textHide, '\n* [[w:Jin Chinese|Jin]]')
			table.insert(textHide, '\n** <small>(<i>[[w:Taiyuan|Taiyuan]]</i>)<sup>[[:w:zh:太原話|+]]</sup></small>')
			if j_rom then
				table.insert(textHide, '\n*** <small><i>[[Wiktionary:About Chinese/Jin|Wiktionary]]</i></small>: ')
				table.insert(textHide, Consolas(j_pron.rom(j_rom)))
			end
			local no_sandhi = false
			local roms = mw.text.split(j_rom, '/')
			for i = 1, table.getn(roms) do
				if find(roms[i], ' [^ ]+ ') then
					no_sandhi = true
					break
				end
			end
			table.insert(textHide, '\n*** <small>Sinological [[Wiktionary:International Phonetic Alphabet|IPA]] (<i>old-style' .. (no_sandhi and ', no sandhi' or '') .. '</i>)</small>: ')
			table.insert(textHide, format_IPA('/' .. j_pron.ipa(j_rom, no_sandhi and "no_sandhi" or "") .. '/'))
			-- add_audio(textHide, j_audio, 'cjy')
			if args["j_note"] then table.insert(textHide, makeNote(args["j_note"])) end
		end
		if mb_rom or mb_audio then
			local mb_pron = require("Module:mnp-pron")
			if mb_rom then
				table.insert(textShow, '\n* [[w:Min Bei|Min Bei]] <small>(<i>[[w:Kienning Colloquial Romanized|KCR]]</i>)</small>: ')
				table.insert(textShow, Consolas(mb_pron.rom(mb_rom)))
			end
			add_audio_show(textShow, mb_audio, 'mnp')
			table.insert(textHide, '\n* [[w:Min Bei|Min Bei]]')
			table.insert(textHide, "\n** <small>(<i>[[w:Jian'ou dialect|Jian'ou]]</i>)</small>")
			if mb_rom then
				table.insert(textHide, '\n*** <small><i>[[w:Kienning Colloquial Romanized|Kienning Colloquial Romanized]]</i></small>: ')
				table.insert(textHide, Consolas(mb_pron.rom(mb_rom)))
				table.insert(textHide, "\n*** <small>Sinological [[Wiktionary:International Phonetic Alphabet|IPA]] <sup>([[w:Jian'ou dialect|key]])</sup></small>: ")
				table.insert(textHide, format_IPA(mb_pron.ipa(mb_rom)))
			end
			-- add_audio(textHide, mb_audio, 'mnp')
			if args["mb_note"] then table.insert(textHide, makeNote(args["mb_note"])) end
		end
		if md_rom or md_audio then
			local md_pron = require("Module:cdo-pron")
			if md_rom then
				table.insert(textShow, '\n* [[w:Min Dong|Min Dong]] <small>(<i>[[Wiktionary:About Chinese/Min Dong|BUC]]</i>)</small>: ')
				table.insert(textShow, Consolas(md_pron.rom(md_rom)))
			end
			add_audio_show(textShow, md_audio, 'cdo')
			table.insert(textHide, '\n* [[w:Min Dong|Min Dong]]')
			table.insert(textHide, '\n** <small>(<i>[[w:Fuzhou dialect|Fuzhou]]</i>)</small>')
			if md_rom then
				table.insert(textHide, '\n*** <small><i>[[Wiktionary:About Chinese/Min Dong|Bàng-uâ-cê]]</i></small>: ')
				table.insert(textHide, Consolas(md_pron.rom(md_rom)))
				if not (md_rom and find(md_rom, '([^/]*)-([^/]*)-([^/]*)-([^/]*)-([^/]*)')) then
					table.insert(textHide, '\n*** <small>Sinological [[Wiktionary:International Phonetic Alphabet|IPA]] <sup>([[w:Fuzhou dialect|key]])</sup></small>: ')
					table.insert(textHide, format_IPA('/' .. md_pron.ipa(md_rom) .. '/'))
				else
					table.insert(textHide, '\n*** <small>Sinological [[Wiktionary:International Phonetic Alphabet|IPA]] <sup>([[w:Fuzhou dialect|key]])</sup> (<i>no sandhi</i>)</small>: ')
					table.insert(textHide, format_IPA('/' .. md_pron.ipa(md_rom, "no_sandhi") .. '/'))
				end
			end
			-- add_audio(textHide, md_audio, 'cdo')
			if args["md_note"] then table.insert(textHide, makeNote(args["md_note"])) end
		end
		if mn_rom or mn_audio or mn_t_rom or mn_t_audio then
			local mn_pron = require("Module:nan-pron")
			if mn_rom or mn_t_rom then
				table.insert(textShow, '\n* [[w:Min Nan|Min Nan]]')
				if mn_rom then
					table.insert(textShow, ( not mn_t_rom and " <small>(<i>" or "\n*: <small>(<i>[[w:Hokkien|Hokkien]], ") .. '[[w:Pe̍h-ōe-jī|POJ]]</i>)</small>: ')
					table.insert(textShow, Consolas(mn_pron.poj_display(mn_pron.poj_check_invalid(mn_rom))))
					add_audio_show(textShow, mn_audio, 'nan')
				end
				if mn_t_rom then
					table.insert(textShow, (mn_rom and '\n*:' or '') .. ' <small>(<i>[[w:Teochew dialect|Teochew]], [[w:Peng\'im|Peng\'im]]</i>)</small>: ')
					table.insert(textShow, Consolas(mn_pron.pengim_display(mn_t_rom)))
					add_audio_show(textShow, mn_t_audio, 'nan-teochew')
				end
			end
			table.insert(textHide, '\n* [[w:Min Nan|Min Nan]]')
			if mn_rom or mn_audio then
				table.insert(textHide, mn_pron.generate_all(mn_rom))
				-- add_audio(textHide, mn_audio, 'nan')
				if args["mn_note"] then table.insert(textHide, makeNote(args["mn_note"])) end
			end
			if mn_t_rom or mn_t_audio then
				table.insert(textHide, '\n** <small>(<i>[[w:Teochew dialect|Teochew]]</i>)</small>')
				table.insert(textHide, '\n*** <small><i>[[w:Peng\'im|Peng\'im]]</i></small>: ')
				table.insert(textHide, Consolas(mn_pron.pengim_display(mn_t_rom)))
				table.insert(textHide, '\n*** <small><i>[[w:Pe̍h-ōe-jī|Pe̍h-ōe-jī]]-like</i></small>: ')
				table.insert(textHide,  Consolas(mn_pron.pengim_to_pojlike_conv(mn_t_rom)))
				table.insert(textHide, '\n*** <small>Sinological [[Wiktionary:International Phonetic Alphabet|IPA]] <sup>([[w:zh:潮州話#語音|key]])</sup></small>: ')
				table.insert(textHide, format_IPA(mn_pron.pengim_to_ipa_conv(mn_t_rom)))
				-- add_audio(textHide, mn_t_audio, 'nan-teochew')
				if args["mn-t_note"] then table.insert(textHide, makeNote(args["mn-t_note"])) end
			end
		end
		if w_rom or w_audio then
			local w_pron = require("Module:wuu-pron")
			if w_rom then
				table.insert(textShow, '\n* [[w:Wu Chinese|Wu]] <small>(<i>[[Wiktionary:About Chinese/Wu|Wiktionary]]</i>)</small>: ')
				table.insert(textShow, Consolas(w_pron.rom(w_rom)))
			end
			add_audio_show(textShow, w_audio, 'wuu')
			table.insert(textHide, '\n* [[w:Wu Chinese|Wu]]')
			table.insert(textHide, '\n** <small>(<i>[[w:Shanghainese|Shanghainese]]</i>)</small>')
			table.insert(textHide, '\n*** <small><i>[[Wiktionary:About Chinese/Wu|Wiktionary]]</i></small>: ')
			table.insert(textHide, Consolas(w_pron.rom(w_rom)))
			table.insert(textHide, '\n*** <small>Sinological [[Wiktionary:International Phonetic Alphabet|IPA]] <sup>([[w:Shanghainese|key]])</sup></small>: ')
			table.insert(textHide, format_IPA('/' .. w_pron.ipa_conv(w_rom) .. '/'))
			-- add_audio(textHide, w_audio, 'wuu')
			if args["w_note"] then table.insert(textHide, makeNote(args["w_note"])) end
		end
		if x_rom or x_audio then
			local x_pron = require("Module:hsn-pron")
			if x_rom then
				table.insert(textShow, '\n* [[w:Xiang Chinese|Xiang]] <small>(<i>[[Wiktionary:About Chinese/Xiang|Wiktionary]]</i>)</small>: ')
				table.insert(textShow, Consolas(x_pron.rom(x_rom)))
			end
			add_audio_show(textShow, x_audio, 'hsn')
			table.insert(textHide, '\n* [[w:Xiang Chinese|Xiang]]')
			table.insert(textHide, '\n** <small>(<i>[[w:Changsha dialect|Changsha]]</i>)</small>')
			if x_rom then
				local x_diff = x_pron.stylediff(x_rom)
				table.insert(textHide, '\n*** <small><i>[[Wiktionary:About Chinese/Xiang|Wiktionary]]</i></small>: ')
				table.insert(textHide, Consolas(x_pron.rom(x_rom)))
				table.insert(textHide, '\n*** <small>Sinological [[Wiktionary:International Phonetic Alphabet|IPA]] <sup>([[w:Changsha dialect|key]])</sup>')
				table.insert(textHide, x_diff and ' (<i>old-style</i>)' or '')
				table.insert(textHide, '</small>: ')
				table.insert(textHide, format_IPA('/' .. x_pron.ipa(x_rom) .. '/'))
				if x_diff then
					table.insert(textHide, '\n*** <small>Sinological [[Wiktionary:International Phonetic Alphabet|IPA]] <sup>([[w:Changsha dialect|key]])</sup> (<i>new-style</i>)</small>: ')
					table.insert(textHide, format_IPA('/' .. x_pron.ipa(x_rom, 'new') .. '/'))
				end
			end
			-- add_audio(textHide, x_audio, 'hsn')
			if args["x_note"] then table.insert(textHide, makeNote(args["x_note"])) end
		end
        -- combine textShow and textHide into text
		text = {
            table.concat(textShow),
            '\n<div class="vsHide">\n----\n',
            table.concat(textHide),
            '</div></div>'
        }
		if not c_rom then table.insert(text, "[[Category:Kenny's testing category 2]]") end

        --Part 3 "Dialectal data"
		if dial ~= "n" and is_single_hanzi then
			local success, m_dial = pcall(mw.loadData, "Module:zh/data/dial-pron/" .. pagename)
			if success then
				local dialPron = {}
				local temporary = {}
				if dial and find(dial, "^[0-9\,]+$") then
					for element in mw.text.gsplit(dial, ",") do
						table.insert(dialPron, m_dial[tonumber(element)])
					end
				else
					for _, element in ipairs(m_dial) do
						table.insert(dialPron, element)
					end
				end
				for _, set in ipairs(dialPron) do
					for _, object in ipairs(set[2]) do
						table.insert(temporary, object)
					end
				end
				local rand = mw.ustring.gsub("-" .. table.concat(temporary), "[^A-Za-z0-9]", mw.ustring.codepoint('%1'))
				table.insert(text,
                    '\n----\n<div class="vsSwitcher" data-toggle-category="pronunciations" style="background-color:#FAFFFA">\n* ' ..
                    '<span style="color:#3366bb">Dialectal data</span>' ..
					'<span class="vsToggleElement" style="float:right; padding:0 0; font-size:90%"></span>\n' ..
                    '<div class="vsHide">'
                )

				table.insert(text, '\n{| class="wikitable" ' ..
					'id="' .. rand .. '" style="width:100%; margin:0; ' ..
					'text-align:center; border-collapse: collapse; border-style: hidden;"')

				local locStart = '\n|-\n!'
				local readingStart = table.concat({'\n!style="background:#E8ECFA; width:9em"|',
				'<div style="float: right; clear: right; font-size:60%"><span class="plainlinks">[', tostring(mw.uri.fullUrl("Module:zh/data/dial-pron/" .. pagename, {["action"]="edit"})), ' edit]</span></div><span lang="zh" class="Hani">'})
				local locEnd = '<span class="IPA">'
				local headclr = 'style="background:#E8ECFA"|'
				local mclr = 'style="background:#FAF5F0"|'
				local jclr = 'style="background:#F0F5FA"|'
				local wclr = 'style="background:#F4F0FA"|'
				local huclr = 'style="background:#FAF9F0"|'
				local xclr = 'style="background:#F0F2FA"|'
				local gclr = 'style="background:#F0FAF3"|'
				local haclr = 'style="background:#FAF0F6"|'
				local cclr = 'style="background:#F0F5FA"|'
				local minclr = 'style="background:#F7FAF0"|'
				local clrList = {
					mclr, mclr, mclr, mclr, mclr, mclr, mclr, mclr, mclr, mclr,
					mclr, mclr, mclr, mclr, mclr, mclr, mclr, jclr, jclr, jclr,
					wclr, wclr, wclr, wclr, huclr, huclr, xclr, xclr, gclr, haclr,
					haclr, cclr, cclr, cclr, minclr, minclr, minclr, minclr, minclr
				}
				local locList = {
					table.concat({headclr, "Variety\n!", headclr, "Location"}),
					table.concat({"rowspan=17 ", mclr,  "Mandarin\n!", mclr, "[[w:Beijing dialect|Beijing]]\n|", mclr}),
					table.concat({mclr, "[[w:Harbin dialect|Harbin]]\n|", mclr}),
					table.concat({mclr, "[[w:Tianjin dialect|Tianjin]]\n|", mclr}),
					table.concat({mclr, "[[w:Jinan dialect|Jinan]]\n|", mclr}),
					table.concat({mclr, "[[w:Qingdao dialect|Qingdao]]\n|", mclr}),
					table.concat({mclr, "[[w:zh:鄭州話|Zhengzhou]]\n|", mclr}),
					table.concat({mclr, "[[w:Xi'an dialect|Xi'an]]\n|", mclr}),
					table.concat({mclr, "[[w:Xining|Xining]]\n|", mclr}),
					table.concat({mclr, "[[w:Yinchuan|Yinchuan]]\n|", mclr}),
					table.concat({mclr, "[[w:zh:蘭州話|Lanzhou]]\n|", mclr}),
					table.concat({mclr, "[[w:zh:烏魯木齊話|Ürümqi]]\n|", mclr}),
					table.concat({mclr, "[[w:zh:武漢話|Wuhan]]\n|", mclr}),
					table.concat({mclr, "[[w:Chengdu dialect|Chengdu]]\n|", mclr}),
					table.concat({mclr, "[[w:zh:貴陽話|Guiyang]]\n|", mclr}),
					table.concat({mclr, "[[w:Kunming dialect|Kunming]]\n|", mclr}),
					table.concat({mclr, "[[w:Nanjing dialect|Nanjing]]\n|", mclr}),
					table.concat({mclr, "[[w:zh:合肥話|Hefei]]\n|", mclr}),
					table.concat({"rowspan=3 ", jclr, "Jin\n!", jclr, "[[w:zh:太原話|Taiyuan]]\n|", jclr}),
					table.concat({jclr, "[[w:Pingyao|Pingyao]]\n|", jclr}),
					table.concat({jclr, "[[w:Hohhot dialect|Hohhot]]\n|", jclr}),
					table.concat({"rowspan=4 ", wclr, "Wu\n!", wclr, "[[w:Shanghai dialect|Shanghai]]\n|", wclr}),
					table.concat({wclr, "[[w:Suzhou dialect|Suzhou]]\n|", wclr}),
					table.concat({wclr, "[[w:Hangzhou dialect|Hangzhou]]\n|" , wclr}),
					table.concat({wclr, "[[w:Wenzhou dialect|Wenzhou]]\n|", wclr}),
					table.concat({"rowspan=2 ", huclr, "Hui\n!", huclr, "[[w:Shexian|Shexian]]\n|", huclr}),
					table.concat({huclr, "[[w:zh:屯溪話|Tunxi]]\n|", huclr}),
					table.concat({"rowspan=2 ", xclr, "Xiang\n!", xclr, "[[w:Changsha dialect|Changsha]]\n|", xclr}),
					table.concat({xclr, "[[w:zh:湘潭話|Xiangtan]]\n|", xclr}),
					table.concat({gclr, "Gan\n!", gclr, "[[w:Nanchang dialect|Nanchang]]\n|", gclr}),
					table.concat({"rowspan=2 ", haclr, "Hakka\n!", haclr, "[[w:Meixian dialect|Meixian]]\n|", haclr}),
					table.concat({haclr, "[[w:Taoyuan, Taiwan|Taoyuan]]\n|", haclr}),
					table.concat({"rowspan=3 ", cclr, "Cantonese\n!", cclr, "[[w:Guangzhou dialect|Guangzhou]]\n|", cclr}),
					table.concat({cclr, "[[w:Nanning|Nanning]]\n|", cclr}),
					table.concat({cclr, "[[w:Hong Kong dialect|Hong Kong]]\n|", cclr}),
					table.concat({"rowspan=5 ", minclr, "Min\n!", minclr, "[[w:Xiamen dialect|Xiamen]] (Min Nan)\n|", minclr}),
					table.concat({minclr, "[[w:Fuzhou dialect|Fuzhou]] (Min Dong)\n|", minclr}),
					table.concat({minclr, "[[w:Jian'ou dialect|Jian'ou]] (Min Bei)\n|", minclr}),
					table.concat({minclr, "[[w:Shantou dialect|Shantou]] (Min Nan)\n|", minclr}),
					table.concat({minclr, "[[w:Haikou dialect|Haikou]] (Min Nan)\n|", minclr})}

				local function ipa_correct(ipa, location)
					if location == 22 then return (gsub(ipa, "13", "23")) else return ipa end
				end

				local function fmtDial(text, location)
					local fmttedPron = {}
					if text == "" then return "" end
					for pronunciation in mw.text.gsplit(text, "|") do
						local ipa = match(pronunciation, "^[^\(\)一-龯㐀-䶵～,]+")
						ipa = gsub(ipa, "([ptk])([0-5])", "%1̚%2")
						local environ = match(pronunciation, "[\(\)一-龯㐀-䶵～,]*$") or false
						table.insert(fmttedPron, "<span class=\"IPA\"><small>/" ..
							tostring(ipa_format(ipa_correct(ipa, location))) .. "/</small></span>" .. (environ
							and " <span class=\"Hani\" lang=\"zh\"><small>"..environ.."</small></span>" or nil))
					end
					return table.concat(fmttedPron, "<br>")
				end

				for locationNo = 1, 40 do
					for readingNo = 1, #dialPron do
						if readingNo == 1 then
							table.insert(text, locStart)
							table.insert(text, locList[locationNo])
						end
						if locationNo == 1 then
							local situation = dialPron[readingNo][1]
							table.insert(text, readingStart)
							table.insert(text, pagename)
							table.insert(text, (pagename ~= situation and " (" ..
								gsub(situation, pagename, "<b>" .. pagename .. "</b>") .. ")" or ""))
							table.insert(text, "</span>")
						else
							table.insert(text, (readingNo == 1 and "" or "\n|" .. clrList[locationNo-1]))
							table.insert(text, locEnd)
							table.insert(text, fmtDial(dialPron[readingNo][2][locationNo-1], locationNo))
							table.insert(text, "</span>")
						end
					end
				end
				table.insert(text, "\n|}</div></div>")
			end
		end

        --Part 4 "Middle Chinese & Old Chinese"
		local mc_preview, oc_preview
		local m_ltc_pron, m_och_pron

		-- !!!
		-- The following function modifies the tables generated by mod:ltc-pron and mod:och-pron, shifting them
		-- from using "mw-collapsible" to using "vsSwitcher", because the former
		-- can not collapse on the mobile site and makes Chinese entries a mess.
		-- It is supposed to be a temporary solution.
		-- !!!
        local function shiftCustomtoggle2Vsswitcher(s)
            local result
            result, _ = s:gsub(
                '\n%* <div title="expand" class="mw%-customtoggle[^>]+">',
                '\n<div class="vsSwitcher" data-toggle-category="pronunciations">\n* '
            ):gsub(
                '<span style="float:right; border:1px solid #ccc; border%-radius:1px; padding:0 0; font%-size:90%%">▼</span>(.-)</div>\n{| class="wikitable',
                '<span class="vsToggleElement" style="float:right; padding:0 0; font-size:90%%"></span>%1\n<div class="vsHide">\n{| class="wikitable'
            ):gsub(
                '{| class="wikitable mw%-collapsible mw%-collapsed" id="[^"]+"',
                '{| class="wikitable"'
            ):gsub(
                '\n|}$',
                '\n|}</div></div>'
            )
            return result
        end

		if mc then
			m_ltc_pron = require("Module:ltc-pron")
			mc_preview = m_ltc_pron.retrieve_pron(pagename, false, mc, true)
			if not mc_preview then
				require('Module:debug').track('zh-pron/Middle Chinese data not found')
				mc = false
			end
		end
		if oc then
			m_och_pron = require("Module:och-pron")
			oc_preview = m_och_pron.generate_show(pagename, oc)
			if not oc_preview then
				require('Module:debug').track('zh-pron/Old Chinese data not found')
				oc = false
			end
		end
		if mc or oc then
			table.insert(text, '\n----\n<div style="background-color:#f7fbff">')
			if mc then
				table.insert(text, shiftCustomtoggle2Vsswitcher(m_ltc_pron.ipa(mc, mc_preview)))
			end
			if oc then
				table.insert(text, shiftCustomtoggle2Vsswitcher(m_och_pron.ipa(oc, oc_preview)))
			end
			table.insert(text, "</div>")
		end
		table.insert(text, "</div>")
		if namespace == ""  then
			if mc then
				mc_sortkey=gsub(gsub(mc_preview, '<[^>]*>', ''), '&[^;]*;', '')
				table.insert(text, '[[Category:Middle Chinese lemmas|' .. mc_sortkey .. ']]')
                if is_single_hanzi then
                    if mc_preview:find'k̚$' then
                        table.insert(text, '[[Category:Middle Chinese -k characters|' .. mc_sortkey .. ']]')
                    elseif mc_preview:find't̚$' then
                        table.insert(text, '[[Category:Middle Chinese -t characters|' .. mc_sortkey .. ']]')
                    elseif mc_preview:find'p̚$' then
                        table.insert(text, '[[Category:Middle Chinese -p characters|' .. mc_sortkey .. ']]')
                    end
                end
			end
			if oc then
				if match(oc_preview, 'Zhengzhang') then
					oc_sortkey=gsub(oc_preview, '^.*Zhengzhang.*/%*([^/]*)/.*$', '%1')
				else
					oc_sortkey=gsub(oc_preview, '^.*/([^/]*)/.*$', '%1')
				end
				oc_sortkey=gsub(gsub(oc_sortkey, '<[^>]*>', ''), '&[^;]*;', '')
				table.insert(text, '[[Category:Old Chinese lemmas|' .. oc_sortkey .. ']]')
			end
			if not ine(args["cat"]) then
				table.insert(text, '[[Category:zh-pron usage missing POS]]')
			end
		end
	end

	local conv_text = {} --categories
	if namespace == "" then
		local catText = args["cat"] or ""
		local cat_start = '[[Category:'
		local cat_end = ']]'
		if w_rom then
			w_rom = gsub(w_rom, '%d', '')
		end

		local sortkey = require("Module:zh-sortkey").makeSortKey(pagename)

		local function add_cat(cat_table, name, cat, rom)
			table.insert(cat_table, cat_start .. name .. cat .. "|" .. rom .. cat_end)
		end

		local cats = mw.text.split(catText, ',', true)
		if pos_aliases_cat[cats[1]] == 'chengyu' then
			table.insert(cats, 2, 'idioms')
		end
		table.insert(cats, 1, "lemmas")
		for i = 1, #cats do
			local cat = cats[i]
			if cat == "" then break end
			cat = gsub(cat, '^ +', '')
			if find(cat, ':') then
				local cat_split = mw.text.split(cat, ':', true)
				local lang_name = langname_abbr[cat_split[1]]
				local category = pos_aliases_cat[cat_split[2]] or cat
				add_cat(conv_text, 'Chinese ', category, sortkey)
				table.insert(conv_text,
					cat_start .. lang_name .. ' ' .. category .. '|'
					.. (lang_name == 'Cantonese' and c_rom or
						(lang_name == 'Min Nan' and mn_rom or mn_t_rom or sortkey)) .. cat_end)
			else
				cat = pos_aliases_cat[cat] or cat
				add_cat(conv_text, 'Chinese ', cat, sortkey)
				if m_rom then add_cat(conv_text, 'Mandarin ', cat, m_rom) end
				if m_s_rom or m_s_audio then add_cat(conv_text, 'Mandarin ', cat, m_s_rom) end
				if dg_rom or dg_audio then add_cat(conv_text, 'Dungan ', cat, dg_rom) end
				if c_rom then add_cat(conv_text, 'Cantonese ', cat, c_rom:gsub('[%[%]]','')) end
				if c_t_rom then add_cat(conv_text, 'Taishanese ', cat, c_t_rom) end
				if g_rom or g_audio then add_cat(conv_text, 'Gan ', cat, g_rom:gsub("'", "")) end
				if h_rom and (find(h_rom, 'pfs=.') or find(h_rom, 'gd=.')) or h_audio then
					add_cat(conv_text, 'Hakka ', cat, mw.ustring.gsub(mw.ustring.gsub(h_rom, 'pfs=', ''), 'gd=', ''))
				end
				if j_rom or j_audio then add_cat(conv_text, 'Jin ', cat, j_rom) end
				if mb_rom or mb_audio then add_cat(conv_text, 'Min Bei ', cat, mb_rom) end
				if md_rom or md_audio then add_cat(conv_text, 'Min Dong ', cat, md_rom) end
				if mn_rom or mn_audio then add_cat(conv_text, 'Min Nan ', cat, mn_rom) end
				if mn_t_rom or mn_t_audio then add_cat(conv_text, 'Teochew ', cat, mn_t_rom) end
				if w_rom or w_audio then add_cat(conv_text, 'Wu ', cat, w_rom) end
				if x_rom or x_audio then add_cat(conv_text, 'Xiang ', cat, x_rom) end
			end
		end
		table.insert(conv_text, cat_start .. 'Chinese terms with IPA pronunciation|' .. sortkey .. cat_end)
		if is_single_hanzi then
			table.insert(conv_text, cat_start .. 'Chinese hanzi|' .. sortkey .. cat_end)
		end
	end

	local output = table.concat(text) .. table.concat(conv_text)
	if namespace ~= '' then
		output = gsub(output, "%[%[Category:[^%]]+%]%]", "")
	end
	return output
end

return export