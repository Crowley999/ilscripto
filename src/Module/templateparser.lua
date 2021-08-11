local export = {}

-- local function strip_whitespace(text)
--	local text, _ = mw.ustring.gsub(text, "%s*(.*)%s*", "%1")
--	return text
-- end
local strip_whitespace = mw.text.trim

function export.parseTemplate(text)
	local text, ok = text:gsub("^{{(.+)}}$", "%1")
	if ok == 0 then
		return nil
	end
	
	local prev = 1
	local pos = 1, mend, found, f1
	local in_template = 0
	local in_table = 0
	local search = "(([{|}=<]).)"
	local has_key = false
	local eq_index = 1
	
	local name = nil
	local args = {}
	local next_i = 1
	local function add_param(x, has_key, eq)
		if name == nil then
			name = strip_whitespace(x)
			return
		end

		if has_key then
			local key = strip_whitespace(x:sub(1, eq))
			local value = strip_whitespace(x:sub(eq + 2))
			local num = tonumber(key, 10)
			if num ~= nil and num > 0 then
				key = num
			end
			args[key] = value
		else
			args[next_i] = x
			next_i = next_i + 1
		end
	end

	while true do
		pos, mend, found, f1 = text:find(search, pos)
		if pos == nil then break end

		if found == "{{" then
			-- start of subtemplate
			in_template = in_template + 1
			pos = pos + 2
		elseif found == "{|" then
			-- start of a table
			in_table = in_table + 1
			pos = pos + 2
		elseif found == "}}" then
			-- end of subtemplate
			if in_template > 0 then in_template = in_template - 1 end
			pos = pos + 2
		elseif found == "|}" then
			-- end of table
			if in_table > 0 then in_table = in_table - 1 end
			pos = pos + 2
		elseif in_template == 0 and in_table == 0 then
			if f1 == "|" then
				-- parameter separator
				add_param(text:sub(prev, pos - 1), has_key, eq_index - prev)
				has_key = false
				search = "(([{|}=<]).)" -- allow equals sign again
				prev = pos + 1
			elseif f1 == "=" and not has_key then
				-- parameter key/value separator
				eq_index = pos
				has_key = true
				search = "(([{|}<]).)" -- do not allow further equals signs
			end
			pos = pos + 1
		elseif found == "<n" and text:sub(pos, pos + 7) == "<nowiki>" then
			pos = text:find("</nowiki>", pos)
			if pos == nil then return nil end
			pos = pos + 8
		elseif found == "<-" and text:sub(pos, pos + 3) == "<!--" then
			pos = text:find("-->", pos + 4)
			if pos == nil then return nil end
			pos = pos + 3
		else
			pos = pos + 1
		end
	end

	if in_template ~= 0 or in_table ~= 0 then
		error("Invalid syntax detected!")
	end
	
	add_param(text:sub(prev), has_key, eq_index - prev)

	return name, args
end

function export.findTemplates(text)
	local next = 1

	local function findNextTemplate()
		local pos, mend, found
		local in_template = 0
		local temp_start = 1
		pos = next
		while true do
			pos, mend, found = text:find("([{}<][{}n!])", pos)
			if pos == nil then break end
			if found == "{{" then
				if in_template == 0 then
					temp_start = pos
				end
				pos = pos + 2
				in_template = in_template + 1
			elseif found == "}}" then
				if in_template > 0 then
					in_template = in_template - 1
					if in_template == 0 then
						next = pos + 2
						local src = text:sub(temp_start, pos + 1)
						local name, args = export.parseTemplate(src)
						if name ~= nil then
							return name, args, src, temp_start
						end
					end
				end
				pos = pos + 2
			elseif found == "<n" and text:sub(pos, pos + 7) == "<nowiki>" then
				pos = text:find("</nowiki>", pos)
				if pos == nil then break end
				pos = pos + 8
			elseif found == "<!" and text:sub(pos, pos + 3) == "<!--" then
				pos = text:find("-->", pos + 4)
				if pos == nil then break end
				pos = pos + 3
			else
				pos = pos + 1
			end
		end
	end

	return findNextTemplate
end

return export