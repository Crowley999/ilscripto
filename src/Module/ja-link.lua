local export = {}

local m_links = require("Module:links")

local lang = require("Module:languages").getByCode("ja")
local sc = require("Module:scripts").getByCode("Jpan")

-- [[Module:parameters]]
-- [[Module:script utilities]]
-- [[Module:ja]]
-- [[Module:ja-ruby]]

function export.link(data, options)
	options = options or {}

	local kana_for_rom = data.kana or data.lemma
	if not data.kana then
		data.lemma = data.lemma:gsub('[ %%%^%-%.]', '')
	end

	if data.lemma:find'%[%[.+%]%]' then
		require("Module:debug").track('ja-link/manual wikilink')
		data.linkto = nil
		data.lemma = m_links.language_link({
			term = data.lemma,
			lang = lang,
		}, not options.disableSelfLink)
	elseif data.linkto == "" or data.linkto == "-" then
		require("Module:debug").track('ja-link/disabled link')
		data.linkto = nil
	else
		data.linkto = data.linkto or data.lemma:gsub('[ %%]', '')
	end

	if data.kana and data.lemma ~= data.kana then
		data.ruby = require('Module:ja-ruby').ruby_auto{
			term = data.lemma,
			kana = data.kana,
			options = options.rubyOptions,
		}
	else
		require("Module:debug").track('ja-link/no ruby')
		data.ruby = data.lemma
	end

	if data.transliteration ~= '-' then
		if not data.transliteration then
			data.transliteration = m_links.remove_links(require("Module:ja").kana_to_romaji(kana_for_rom, {
				hist = options.hist,
			}))
			if options.caps then
				require("Module:debug").track("ja-link/caps")
				data.transliteration = mw.ustring.gsub(data.transliteration, "^%l", mw.ustring.upper)
				data.transliteration = mw.ustring.gsub(data.transliteration, " %l", mw.ustring.upper)
			end
		else
			if options.hist then require("Module:debug").track("ja-link/parameter hist unused") end
		end
		data.transliteration = require("Module:script utilities").tag_translit(data.transliteration, "ja", "term")
	end

	if data.gloss == '' then data.gloss = nil end
	if data.pos == '' then data.pos = nil end
	if data.lit == '' then data.lit = nil end

	return m_links.full_link({
		lang = lang,
		sc = sc,
		term = data.linkto,
		alt = data.ruby,
		tr = data.transliteration,
		gloss = data.gloss,
		lit = data.lit,
		pos = data.pos,
	}, options.face, not options.disableSelfLink)
end

function export.show(frame)
	local args = require("Module:parameters").process(frame:getParent().args, {
		[1] = { required = true },
		[2] = {},
		[3] = {},
		['gloss'] = { alias_of = 3 },
		['t'] = { alias_of = 3 },
		['linkto'] = { allow_empty = true },
		['rom'] = {},
		['lit'] = {},
		['pos'] = {},
		['hist'] = { type = "boolean" },
		['caps'] = { type = "boolean" },
	})

	return export.link({
		lemma = args[1],
		kana = args[2],
		gloss = args[3],
		lit = args["lit"],
		pos = args["pos"],
		linkto = args["linkto"],
		transliteration = args["rom"],
	}, {
		caps = args["caps"],
		hist = args["hist"],
	})
end

return export