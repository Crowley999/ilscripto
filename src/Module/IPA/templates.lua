local export = {}

local m_IPA = require("Module:IPA")

local U = mw.ustring.char
local syllabic = U(0x0329)

-- Used for [[Template:IPA]].
function export.IPA(frame)
	local parent_args = frame.getParent and frame:getParent().args or frame
	local compat = parent_args["lang"]
	local offset = compat and 0 or 1
	local params = {
		[compat and "lang" or 1] = {required = true, default = "en"},
		[1 + offset] = {list = true, allow_holes = true},
		["ref"] = {list = true, allow_holes = true},
		-- Came before 'ref' but too obscure
		["n"] = {list = true, allow_holes = true, alias_of = "ref"},
		["qual"] = {list = true, allow_holes = true},
		["nocount"] = {type = "boolean"},
		["sort"] = {},
	}
	
	local args = require("Module:parameters").process(parent_args, params)
	local lang = args[compat and "lang" or 1]
	lang = require("Module:languages").getByCode(lang)
		or require("Module:languages").err(lang, compat and "lang" or 1)

	-- [[Special:WhatLinksHere/Template:tracking/IPA/grc]]
	if lang and lang:getCode() == "grc" then
		require("Module:debug").track("IPA/grc")
	end
	
	local items = {}
	
	for i = 1, math.max(args[1 + offset].maxindex, args["ref"].maxindex, args["qual"].maxindex) do
		local pron = args[1 + offset][i]
		local refs = args["ref"][i]
		if refs then
			refs = require("Module:references").parse_references(refs)
		end
		local qual = args["qual"][i]

		if not pron then
			if refs or qual then
				local param = i == 1 and "" or "" .. i
				error("Specified qual" .. param .. "= or ref" .. param .. "= without corresponding pronunciation")
			end
		else
			if lang then
				require("Module:IPA/tracking").run_tracking(pron, lang)
			end
			
			if pron or refs or qual then
				table.insert(items, {pron = pron, refs = refs, qualifiers = {qual}})
			end
		end
	end
	
	return m_IPA.format_IPA_full(lang, items, nil, nil, args.sort, args.nocount)
end

-- Used for [[Template:IPAchar]].
function export.IPAchar(frame)
	local params = {
		[1] = {list = true, allow_holes = true},
		["ref"] = {list = true, allow_holes = true},
		-- Came before 'ref' but too obscure
		["n"] = {list = true, allow_holes = true, alias_of = "ref"},
		["qual"] = {list = true, allow_holes = true},
		-- FIXME, remove this.
		["lang"] = {}, -- This parameter is not used and does nothing, but is allowed for futureproofing.
	}

	local args = require("Module:parameters").process(frame.getParent and frame:getParent().args or frame, params)
	
	-- [[Special:WhatLinksHere/Template:tracking/IPAchar/lang]]
	if args.lang then
		require("Module:debug").track("IPAchar/lang")
	end

	local items = {}
	
	for i = 1, math.max(args[1].maxindex, args["ref"].maxindex, args["qual"].maxindex) do
		local pron = args[1][i]
		local refs = args["ref"][i]
		if refs then
			refs = require("Module:references").parse_references(refs)
		end
		local qual = args["qual"][i]

		if pron or refs or qual then
			table.insert(items, {pron = pron, refs = refs, qualifiers = {qual}})
		end
	end

	-- Format
	return m_IPA.format_IPA_multiple(nil, items)
end

function export.XSAMPA(frame)
	local params = {
		[1] = { required = true },
	}
	local args = require("Module:parameters").process(frame:getParent().args, params)
	
	return m_IPA.XSAMPA_to_IPA(args[1] or "[Eg'zA:mp5=]")
end

-- Used by [[Template:X2IPA]]
function export.X2IPAtemplate(frame)
	local parent_args = frame.getParent and frame:getParent().args or frame
	local compat = parent_args["lang"]
	local offset = compat and 0 or 1

	local params = {
		[compat and "lang" or 1] = {required = true, default = "und"},
		[1 + offset] = {list = true, allow_holes = true},
		["ref"] = {list = true, allow_holes = true},
		-- Came before 'ref' but too obscure
		["n"] = {list = true, allow_holes = true, alias_of = "ref"},
		["qual"] = { list = true, allow_holes = true },
	}
	
	local args = require("Module:parameters").process(parent_args, params)
	
	local m_XSAMPA = require("Module:IPA/X-SAMPA")
	
	local pronunciations, refs, qualifiers, lang = args[1 + offset], args["ref"], args["qual"], args[compat and "lang" or 1]
	
	local output = {}
	table.insert(output, "{{IPA")
	
	table.insert(output, "|" .. lang)

	for i = 1, math.max(pronunciations.maxindex, refs.maxindex, qualifiers.maxindex) do
		if pronunciations[i] then
			table.insert(output, "|" .. m_XSAMPA.XSAMPA_to_IPA(pronunciations[i]))
		end
		if refs[i] then
			table.insert(output, "|ref" .. i .. "=" .. refs[i])
		end
		if qualifiers[i] then
			table.insert(output, "|qual" .. i .. "=" .. qualifiers[i])
		end
	end
	
	table.insert(output, "}}")

	return table.concat(output)
end

-- Used by [[Template:X2IPAchar]]
function export.X2IPAchar(frame)
	local params = {
		[1] = { list = true, allow_holes = true },
		["ref"] = {list = true, allow_holes = true},
		-- Came before 'ref' but too obscure
		["n"] = {list = true, allow_holes = true, alias_of = "ref"},
		["qual"] = { list = true, allow_holes = true },
		-- FIXME, remove this.
		["lang"] = {},
	}
	
	local args = require("Module:parameters").process(frame:getParent().args, params)
	
	-- [[Special:WhatLinksHere/Template:tracking/X2IPAchar/lang]]
	if args.lang then
		require("Module:debug").track("X2IPAchar/lang")
	end

	local m_XSAMPA = require("Module:IPA/X-SAMPA")
	
	local pronunciations, refs, qualifiers, lang = args[1], args["ref"], args["qual"], args["lang"]
	
	local output = {}
	table.insert(output, "{{IPAchar")
	
	for i = 1, math.max(pronunciations.maxindex, refs.maxindex, qualifiers.maxindex) do
		if pronunciations[i] then
			table.insert(output, "|" .. m_XSAMPA.XSAMPA_to_IPA(pronunciations[i]))
		end
		if refs[i] then
			table.insert(output, "|ref" .. i .. "=" .. refs[i])
		end
		if qualifiers[i] then
			table.insert(output, "|qual" .. i .. "=" .. qualifiers[i])
		end
	end

	if lang then
		table.insert(output, "|lang=" .. lang)
	end
	
	table.insert(output, "}}")
	
	return table.concat(output)
end

-- Used by [[Template:x2rhymes]]
function export.X2rhymes(frame)
	local parent_args = frame.getParent and frame:getParent().args or frame
	local compat = parent_args["lang"]
	local offset = compat and 0 or 1

	local params = {
		[compat and "lang" or 1] = {required = true, default = "und"},
		[1 + offset] = {required = true, list = true, allow_holes = true},
	}
	
	local args = require("Module:parameters").process(parent_args, params)
	
	local m_XSAMPA = require("Module:IPA/X-SAMPA")
	
	pronunciations, lang = args[1 + offset], args[compat and "lang" or 1]
	
	local output =  {}
	table.insert(output, "{{rhymes")
	
	table.insert(output, "|" .. lang)

	for i = 1, pronunciations.maxindex do
		if pronunciations[i] then
			table.insert(output, "|" .. m_XSAMPA.XSAMPA_to_IPA(pronunciations[i]))
		end
	end
	
	table.insert(output, "}}")
	
	return table.concat(output)
end

return export