local export = {}
local m_qualifier = require("Module:qualifier")

function export.format_qualifiers(qualifiers)
	local m_data = mw.loadData("Module:accent qualifier/data")
	
	if type(qualifiers) ~= "table" then
		qualifiers = { qualifiers }
	end
	
	local accents = {}
	local categories = {}
	
	for _, accent in ipairs(qualifiers) do
		local data
		
		-- Replace an alias with the label that has a data table.
		if m_data.aliases[accent] then
			accent = m_data.aliases[accent]
		end
		
		-- Retrieve the label's data table.
		if m_data.labels[accent] then
			data = m_data.labels[accent]
		end
		
		-- Use the link and displayed text in the data table, if they exist.
		if data then
			if data.link then
				table.insert(accents, "[[w:" .. data.link .. "|" ..
					(data.display or data.link) .. "]]")
			elseif data.display then
				table.insert(accents, data.display)
			end
			
			--[[
			if data[accent] then
				if data[accent].type == "sound change" then
					table.insert(categories, lang:getCanonicalName() .. " terms with pronunciations exhibiting " .. accent)
				end
			end
			]]
		else
			table.insert(accents, accent)
		end
	end
	
	return m_qualifier.format_qualifier(accents)
end

-- Called by {{accent}} or {{a}}.
function export.show(frame)
	local args = frame.getParent and frame:getParent().args or frame
	
	if (not args[1] or args[1] == "") and mw.title.getCurrentTitle().nsText == "Template" then
		return m_qualifier.format_qualifier{ '{{{1}}}' }
	end
	
	local params = {
		[1] = {required = true, list = true}
	}
	args = require("Module:parameters").process(args, params)
	
	return export.format_qualifiers(args[1])
end

return export