local export = {}

local m_ja = require("Module:ja")
-- [[Module:scripts]]
-- [[Module:parameters]]
-- [[Module:utilities]]
-- [[Module:links]]
-- [[Module:languages]]
-- [[Module:ja-ruby]]

local pagename = mw.title.getCurrentTitle().text

local HaniHiraKana_characters
local function test_script(text, scriptCode, entirely)
	if type(text) == "string" and type(scriptCode) == "string" then
		local characters
		if scriptCode == "HaniHiraKana" then
			if HaniHiraKana_characters then
				return HaniHiraKana_characters
			end
			local getScriptByCode = require("Module:scripts").getByCode
			characters = ""
			for code in scriptCode:gmatch("%u%l%l%l") do
				characters = characters .. getScriptByCode(code):getCharacters()
			end
		else
			characters = require("Module:scripts").getByCode(scriptCode):getCharacters()
		end

		local out
		if entirely then
			out = mw.ustring.match(text, "^[" .. characters .. "]+$")
		else
			text = mw.ustring.gsub(text, "%W", "")
			out = mw.ustring.find(text, "[" .. characters .. "]")
		end

		return out
	else
		mw.log("Parameters to test_script were incorrect.")
	end
end

-- main entry point
function export.show(frame)
	local params = {
		[1] = {},
		[2] = {},
		[3] = {},
		["lit"] = {},
		["rom"] = {},
		["manyou"] = {},
		["m"] = { alias_of = "manyou" },
		["manyou_kana"] = {},
		["m_kana"] = { alias_of = "manyou_kana" },
		["ref"] = {},
		["sort"] = {},
		["inline"] = {},	-- not currently used
	}
	local args = require("Module:parameters").process(frame:getParent().args, params)

	local literally = args.lit

	local sortkey
	-- Use sort parameter, or title if it consists only of kana.
	if args.sort then
		sortkey = args.sort
	elseif test_script(pagename, "Hira", true) or test_script(pagename, "Kana", true) then
		sortkey = pagename
	else
		-- [[Special:WhatLinksHere/Template:tracking/ja-usex/no sortkey]]
		require("Module:debug").track("ja-usex/no sortkey")
	end

	-- Process sortkey.
	if sortkey then
		sortkey = m_ja.jsort(sortkey)
	end

	local text = {}
	local categories = { "Japanese terms with usage examples" }

	local example, kana, translation

	-- Custom errors are preferable to the generic "These parameters are required.",
	-- which would be generated if "required = true" were added to the tables for parameters 1 and 2.
	if not args[1] then
		error("Usage example text has not been given.")
	elseif test_script(args[1], "Hani") then
		example = args[1]

		if args[2] and test_script(args[2], "HaniHiraKana") then
			kana = args[2]
			translation = args[3]
		else
			error("Kana spelling of the usage example text has not been given.")
		end
	elseif test_script(args[1], "HaniHiraKana") then
		example = args[1]

		if args[2] and test_script(args[2], "HaniHiraKana") then
			kana = args[2]
			translation = args[3]
		else
			kana = args[1]
			translation = args[2]
		end
	end

	if (not translation) then
		translation = '<small>(please add an English translation of this example)</small>'
		table.insert(categories, "Requests for translations of Japanese usage examples")
	end

	local romaji = args["rom"]
	local manyou = args["manyou"]
	local old_kana = args["manyou_kana"]
	local ref = args["ref"]

	local tag_start = " <span style=\"color:darkgreen; font-size:x-small;\">&#91;" -- see also [[module:zh-usex]]
	local tag_end = "&#93;</span>"

	if manyou then
		table.insert(text, ('<span lang="ja" class="Jpan">%s</span>'):format(old_kana ~= "" and require('Module:ja-ruby').ruby_auto{
			term = manyou,
			kana = old_kana,
		} or manyou))
		table.insert(text, tag_start)
		table.insert(text, "[[w:Man'yōgana|Man'yōgana]]")
		table.insert(text, tag_end)
		table.insert(text, "<dd>")
	end

	local ruby_text
	if example and kana and example ~= kana then
		ruby_text = require('Module:ja-ruby').ruby_auto{
			term = example,
			kana = kana,
		}
	else
		ruby_text = m_ja.remove_ruby_markup(kana)
		kana = require("Module:links").remove_links(kana)
	end
	if ruby_text then
		if string.find(ruby_text, "[[", 1, true) then
			ruby_text = require("Module:links").language_link{ term = ruby_text,
				lang = require("Module:languages").getByCode("ja"),
			}
		end
		table.insert(text, ('<span lang="ja" class="Jpan">%s</span>'):format(ruby_text))
	end

	if ref then
		table.insert(text, ref)
	end

	if manyou then
		table.insert(text, tag_start)
		table.insert(text, "Modern spelling")
		table.insert(text, tag_end)
		table.insert(text, "</dd>")
	end

	if kana or romaji or translation then
		table.insert(text, "<dl>")
	end
	if kana or romaji then
		table.insert(text, "<dd><i>")
		if romaji then
			table.insert(text, romaji)
		elseif kana then
			-- add capitalization markup to the kana if manual markup is not present
			if mw.ustring.match(kana, "[。？！]") and not mw.ustring.match(kana, "%^") then
				-- "「テスト」です。"→"「^テスト」^です。"
				kana = mw.ustring.gsub(kana, "([^「」『』。？！]+)", "^%1")

				-- remove "^" in ~other certain circumstances~
				-- TESTS: https://en.wiktionary.org/?oldid=51248532
				kana = mw.ustring.gsub(kana, "([）」』])%^", "%1")
				kana = mw.ustring.gsub(kana, "([^）」』])([（「『])%^", "%1%2")
			end

			-- add romaji
			table.insert(text, m_ja.kana_to_romaji(kana))
		end
		table.insert(text, "</i></dd>")
	end
	if translation then
		table.insert(text, "<dd>" .. translation .. "</dd>")
	end
	if literally then
		table.insert(text, "<dd>(literally, “" ..  literally .. "”)</dd>")
	end
	table.insert(text, "</dl>")

	return table.concat(text) .. require("Module:utilities").format_categories(categories, lang, args.sort)
end

return export