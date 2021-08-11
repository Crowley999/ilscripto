local export = {}

local function generate_table(name_to_code)
	local result = {}
	
	local iterate
	if name_to_code then
		function iterate(module)
			for code, data in pairs(require("Module:languages/" .. module)) do
				result[data[1]] = code
			end
		end
	else
		function iterate(module)
			for code, data in pairs(require("Module:languages/" .. module)) do
				result[code] = data[1]
			end
		end
	end
	
	iterate("data2")
	
	for letter in string.gmatch("abcdefghijklmnopqrstuvwxyz", ".") do
		iterate("data3/" .. letter)
	end
	
	iterate("datax")
	
	return result
end

local function dump(data, name_to_code)
	local output = { "return {" }
	local i = 1
	local sorted_pairs = require "Module:table".sortedPairs
	
	for k, v in sorted_pairs(data) do
		i = i + 1
		output[i] = ('\t[%q] = %q,'):format(k, v)
	end
	
	table.insert(output, "}")
	
	return table.concat(output, "\n")
end

local function print_data(name_to_code, args)
	if args[1] == "plain" then
		return dump(generate_table(name_to_code), name_to_code)
	else
		return require "Module:debug".highlight(dump(generate_table(name_to_code), name_to_code))
	end
end

function export.code_to_name(frame)
	return print_data(false, frame.args)
end

function export.name_to_code(frame)
	return print_data(true, frame.args)
end

-- Print list of language names with a hyphen and a lowercase letter for
-- [[MediaWiki:Gadget-OrangeLinks.js]].
function export.hyphen_lowercase_language_names(frame)
	local result = {}
	
	local function iterate(module)
		for code, data in pairs(require("Module:languages/" .. module)) do
			local canonical_name = data[1]
			if canonical_name:find "%-[a-z]" then
				table.insert(result, canonical_name)
			end
		end
	end
	
	iterate("data2")
	
	for letter in string.gmatch("abcdefghijklmnopqrstuvwxyz", ".") do
		iterate("data3/" .. letter)
	end
	
	iterate("datax")
	
	return mw.text.jsonEncode(result)
end

return export