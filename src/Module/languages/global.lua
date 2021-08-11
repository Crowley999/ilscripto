local u = mw.ustring.char
local export = {}

--[=[
Here is a list of the language fields by order of frequency according to [[User:Erutuon/language_stuff]].
If the order changes, change the order here for potentially greater efficiency.
]=]

local fields = {
	"canonical_name",
	"wikidata_item",
	"family",
	"scripts",
	"other_names", 
	"ancestors",
	"type",
	"translit_module",
	"entry_name",
	"sort_key",
	"override_translit",
	"wikimedia_codes",
	"standard_chars",
	"wikipedia_article",
	"link_tr",
}

--[=[
Insert the fields into the table with their values as their frequency ranking
{export.most_common_field = 1, export.second_most_common_field = 2, ... }
]=]

for i, field in ipairs(fields) do
	export[field] = i	
end

export.CHARS = {
	-- UTF-8 encoded strings for some commonly-used diacritics
	GRAVE     = u(0x0300),
	ACUTE     = u(0x0301),
	CIRC      = u(0x0302),
	TILDE     = u(0x0303),
	MACRON    = u(0x0304),
	BREVE     = u(0x0306),
	DOTABOVE  = u(0x0307),
	DIAER     = u(0x0308),
	CARON     = u(0x030C),
	DGRAVE    = u(0x030F),
	INVBREVE  = u(0x0311),
	DOTBELOW  = u(0x0323),
	RINGBELOW = u(0x0325),
	CEDILLA   = u(0x0327),
	OGONEK    = u(0x0328),

	-- Puncuation to be used for standardChars field
	PUNCTUATION = ' \!\#\$\%\&\*\+\,\-\.\/\:\;\<\=\>\?\@\^\_\`\|\~\'\(\)',
}

export.SCRIPTS = {
	ARAB = {"Arab"},
	CYRL = {"Cyrl"},
	DEVA = {"Deva"},
	LATN = {"Latn"},
	LATINX = {"Latinx"},
}

return export