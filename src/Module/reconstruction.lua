local export = {}

-- from [[WT:POS]]
local POS_headers = require "Module:table".listToSet {
	"Adjective", "Adverb", "Ambiposition", "Article", "Circumfix",
	"Circumposition", "Classifier", "Combining form", "Conjunction",
	"Contraction", "Counter", "Determiner", "Diacritical mark", "Han character",
	"Hanja", "Hanzi", "Ideophone", "Infix", "Interfix", "Interjection", "Kanji",
	"Letter", "Ligature", "Noun", "Number", "Numeral", "Participle", "Particle",
	"Phrase", "Postposition", "Prefix", "Preposition", "Prepositional phrase",
	"Pronoun", "Proper noun", "Proverb", "Punctuation mark", "Romanization",
	"Root", "Suffix", "Syllable", "Symbol", "Verb", 
}

-- This isn't a perfect pattern, but should work in entries that don't have
-- bad syntax.
local title_pattern = "%f[^\n%z]==+%s*(.-)%s*==+"
local function count_POS_headers(title)
	local POS_count = 0
	
	for header in title:getContent():gmatch(title_pattern) do
		if POS_headers[header] then
			POS_count = POS_count + 1
		end
	end
	
	return POS_count
end

local function has_header(title, header_to_find)
	for header in title:getContent():gmatch(title_pattern) do
		if header == header_to_find then
			return true
		end
	end
	
	return false
end

-- Track Proto-Indo-European entries with more than one part-of-speech header.
-- Invoked by {{reconstruction}}, requested by Victar.
function export.main(frame)
	local title = mw.title.getCurrentTitle()
	local cats = {}
	
	local language = title.text:match "^[^/]+"
	local langcode = require("Module:languages").getByCanonicalName(language)
	if not langcode then
		-- Can happen e.g. if used on a user page
		return
	end
	if language == "Proto-Indo-European" and count_POS_headers(title) > 1 then
		table.insert(cats, "Proto-Indo-European entries with more than one part of speech")
	end
	
	local has_references_header = has_header(title, "References")
	local has_further_reading_header = has_header(title, "Further reading")
	if not has_references_header then
		table.insert(cats, language .. " entries without References header")
	end
	
	if not (has_references_header or has_further_reading_header) then
		table.insert(cats, language .. " entries without References or Further reading header")
	end
	
	return require("Module:utilities").format_categories(cats, langcode)
end

return export