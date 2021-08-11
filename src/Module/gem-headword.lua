local export = {}

local lang = require("Module:languages").getByCode("gem-pro")

-- The main entry point.
-- This is the only function that can be invoked from a template.
function export.show(frame)
	local args = frame:getParent().args
	SUBPAGENAME = mw.title.getCurrentTitle().subpageText
	
	local head = args["head"]; if head == "" then head = nil end
	
	-- The part of speech. This is also the name of the category that
	-- entries go in. However, the two are separate (the "cat" parameter)
	-- because you sometimes want something to behave as an adjective without
	-- putting it in the adjectives category.
	local poscat = frame.args[1] or error("Part of speech has not been specified. Please pass parameter 1 to the module invocation.")
	local postype = args["type"]; if postype == "" then postype = nil end
	
	local data = {lang = lang, pos_category = (postype and postype .. " " or "") .. poscat, categories = {}, heads = {head}, genders = {}, inflections = {}}
	
	if poscat == "adjectives" then
		if SUBPAGENAME:find("^-") then
			data.pos_category = "suffixes"
			data.categories = {"Proto-Germanic adjective-forming suffixes"}
		end
		
		adjective(args, data)
	elseif poscat == "adverbs" then
		if SUBPAGENAME:find("^-") then
			data.pos_category = "suffixes"
			data.categories = {"Proto-Germanic adverb-forming suffixes"}
		end
		
		adverb(args, data)
	elseif poscat == "determiners" then
		adjective(args, data)
	elseif poscat == "nouns" then
		if SUBPAGENAME:find("^-") then
			data.pos_category = "suffixes"
			data.categories = {"Proto-Germanic noun-forming suffixes"}
		end
		
		noun_gender(args, data)
	elseif poscat == "proper nouns" then
		noun_gender(args, data)
	elseif poscat == "verbs" then
		if SUBPAGENAME:find("^-") then
			data.pos_category = "suffixes"
			data.categories = {"Proto-Germanic verb-forming suffixes"}
		end
	end
	
	return require("Module:headword").full_headword(data)
end

-- Display information for a noun's gender
-- This is separate so that it can also be used for proper nouns
function noun_gender(args, data)
	local valid_genders = {
		["m"] = true,
		["f"] = true,
		["n"] = true,
		["m-p"] = true,
		["f-p"] = true,
		["n-p"] = true}
	
	-- Iterate over all gn parameters (g2, g3 and so on) until one is empty
	local g = args[1] or ""; if g == "" then g = "?" end
	local i = 2
	
	while g ~= "" do
		if not valid_genders[g] then
			g = "?"
		end
		
		-- If any of the specifications is a "?", add the entry
		-- to a cleanup category.
		if g == "?" then
			table.insert(data.categories, "Requests for gender in Proto-Germanic entries")
		elseif g == "m-p" or g == "f-p" or g == "n-p" then
			table.insert(data.categories, "Proto-Germanic pluralia tantum")
		end
 
		table.insert(data.genders, g)
		g = args["g" .. i] or ""
		i = i + 1
	end
end

function adjective(args, data)
	local adverb = args["adv"]; if adverb == "" then adverb = nil end
	local comparative = args[1]; if comparative == "" then comparative = nil end
	local superlative = args[2]; if superlative == "" then superlative = nil end
	
	if adverb then
		table.insert(data.inflections, {label = "adverb", adverb})
	end
	
	if comparative then
		table.insert(data.inflections, {label = "comparative", comparative})
	end
	
	if superlative then
		table.insert(data.inflections, {label = "superlative", superlative})
	end
end

function adverb(args, data)
	local adjective = args["adj"]; if adjective == "" then adjective = nil end
	local comparative = args[1]; if comparative == "" then comparative = nil end
	local superlative = args[2]; if superlative == "" then superlative = nil end
	
	if adjective then
		table.insert(data.inflections, {label = "adjective", adjective})
	end
	
	if comparative then
		table.insert(data.inflections, {label = "comparative", comparative})
	end
	
	if superlative then
		table.insert(data.inflections, {label = "superlative", superlative})
	end
end

return export