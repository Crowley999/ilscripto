local export = {}

local m_zh = require("Module:zh")

local conventional_names = {
	["beginning"] = "Beginning Mandarin",
	["elementary"] = "Elementary Mandarin",
	["intermediate"] = "Intermediate Mandarin",
	["advanced"] = "Advanced Mandarin",
	["antonymous"] = "Chinese antonymous compounds",
	["disyllabic"] = "Chinese disyllabic morphemes",
	["variant"] = "Chinese variant forms",
	["simplified"] = "Chinese simplified forms",
	["obsolete"] = "Chinese obsolete terms",
	["wasei kango"] = "Wasei kango",
	["twice-borrowed"] = "Chinese twice-borrowed terms",
	["tcm"] = "zh:Traditional Chinese medicine",
	["phrasebook"] = "Chinese phrasebook",
	["short"] = "Chinese short forms",
	["genericized trademark"] = "Chinese genericized trademarks",
	["taboo"] = "Chinese terms arising from taboo avoidance",
	["triplicated"] = "Triplicated Chinese characters",
	["duplicated"] = "Duplicated Chinese characters",
	["quadruplicated"] = "Quadruplicated Chinese characters",
	["stratagem"] = "Thirty-Six Stratagems",
	["juxtapositional idiom"] = "Chinese juxtapositional idioms",
	["pseudo-idiom"] = "Chinese pseudo-idioms",
	["contranym"] = "Chinese contranyms",
	["xiehouyu"] = "Chinese xiehouyu",
	["character shape word"] = "Chinese terms making reference to character shapes",
	["mandarin informal terms"] = "Mandarin informal terms",

	["reduplicative diminutive nouns"] = "Chinese reduplicative diminutive nouns",
	["reduplicative diminutive proper nouns"] = "Chinese reduplicative diminutive proper nouns",
	["reduplicative diminutive pronouns"] = "Chinese reduplicative diminutive pronouns",
}

function export.generateClsLink(text, doNotUsePagename)
	local trad = doNotUsePagename and text or mw.title.getCurrentTitle().text
	local simp = m_zh.ts(trad)
	return "Category:Chinese nouns classified by " .. (trad ~= simp and (trad .. "/" .. simp) or trad)
end
	
function export.categorize(frame)
	local args = type(frame) == "table" and frame:getParent().args or { frame }
	local PAGENAME = mw.title.getCurrentTitle().text
	local sortkey = require("Module:zh-sortkey").makeSortKey(PAGENAME)
	local text = ""
	for _, cat in ipairs(args) do
		if mw.ustring.match(cat, "Classifier") then
			local parts = mw.text.split(cat, ":")
			text = text .. "[[" .. export.generateClsLink(parts[2], true) .. "|" .. sortkey .. "]]"
		
		elseif conventional_names[mw.ustring.lower(cat)] then
			text = text .. "[[Category:" .. conventional_names[mw.ustring.lower(cat)] .. "|" .. sortkey .. "]]"
		else
			text = text .. "[[Category:zh:" .. cat .. "|" .. sortkey .. "]]"
		end
	end
	return (mw.title.getCurrentTitle().nsText == "" and text or "")
end

function export.clsCat(frame)
	local PAGENAME = mw.title.getCurrentTitle().text
	local part = mw.text.split(PAGENAME, " ")
	local character = part[#part]
	local sortkey = require("Module:zh-sortkey").makeSortKey(character)
	return "Chinese nouns using " .. m_zh.link(frame, nil, { character, tr = "-" }, character) ..
		" as their classifier.\n[[Category:Chinese nouns by classifier|" .. sortkey .. "]]"
end

return export
