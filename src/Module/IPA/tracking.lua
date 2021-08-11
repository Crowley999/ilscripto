local export = {}

--[[
	symb is what is tracked. It can be a literal symbol or a Lua pattern.
	If it is a table, tracking is added for any of the symbols in the list.
	
	cat is the subtemplate that is added to the default path "IPA/" + language code + "/".
]]

local U = mw.ustring.char

local syllabic = U(0x329)

-- The validity of this table is checked by documentation function
-- in [[Module:User:Erutuon/sandbox]].
export.tracking = {
	en = {
		{
			symb = "iə",
			cat = "ambig",
		},
		{
			symb = { "ɪi", "ʊu", "ɪj", "ʊw" },
			cat = "eeoo",
		},
		{
			symb = { "r" },
			cat = "plain r",
		},
	},
	cs = {
		{
			symb = "[mnrl]" .. syllabic,
			cat = "syllabic-consonant",
		},
	},
	ps = {
		{
			symb = "ɤ",
			cat = "Pashto",
		},
	},
	fa = {
		{
			symb = "ʔ",
			cat = "glottal-stop",
		},
	},
	{
		{
			symb = "",
			cat = "",
		},
	},
}

function export.run_tracking(IPA, lang)
	if not IPA or IPA == "" then
		return
	end
	
	lang = lang:getCode()
	
	if not export.tracking[lang] then
		return
	end
	
	for i, arguments in ipairs(export.tracking[lang]) do
		local symbols = arguments.symb
		local category = arguments.cat
		
		if type(symbols) == "string" then
			symbols = { symbols }
		end
		
		for _, symbol in pairs(symbols) do
			if mw.ustring.find(IPA, symbol) then
				require("Module:debug").track("IPA/" .. lang .. "/" .. category)
			end
		end
	end
end

return export