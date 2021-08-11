--[=[
  Module:utils v0.3.1
  Date: 2015-08-14

  This module contains some common useful functions.
  Fill free to add another universal functions here.
]=]--

local export = {}

-- Function to clone table (sometimes it works better then mw.clone)
function export.clone(original)
    local copy = {}
    for key, value in pairs(original) do
        copy[key] = value
    end
    return copy
end

-- Function to get current PAGENAME and related
function export.get_base()
	local PAGENAME = mw.title.getCurrentTitle().text
	local SUBPAGENAME = mw.title.getCurrentTitle().subpageText
	local NAMESPACE = mw.title.getCurrentTitle().nsText
	
	if NAMESPACE == 'User' or NAMESPACE == 'Участник' then
		return SUBPAGENAME
	end
	return PAGENAME
end

-- Function to iterate table with sorted keys (sorting function can be different)
function export.spairs(t, order)
    -- collect the keys
    local keys = {}
    for k in pairs(t) do keys[#keys+1] = k end
    -- sort
    if order then
        table.sort(keys, function(a,b) return order(t, a, b) end)
    else
        table.sort(keys)
    end
    -- return the iterator function
    local i = 0
    return function()
        i = i + 1
        if keys[i] then
            return keys[i], t[keys[i]]
        end
    end
end

-- Functions to measure working time of scripts (start)
function export.start()
	export.started = os.clock()
end

-- Functions to measure working time of scripts (stop)
function export.stop(desc)
	export.stoped = os.clock()
	export.delta = export.stoped - export.started
	if desc == nil then
		desc = 'time delta'
	end
	mw.log('™ ' .. desc .. ' = ' .. export.delta)
end

-- Function to find common part (length) of two strings
-- (common part from the beginning of strings)
function export.find_common(str_1, str_2)
	if not str_1 or not str_2 then
		return 1
	end
	for pos = 1, #str_1 do
	    local char_1 = str_1:sub(pos, pos)
	    local char_2 = str_2:sub(pos, pos)
	    if char_1 ~= char_2 then
	    	return pos
	    end
	end
	return 1
end

-- Function that allows easily add values into dict of dicts of lists
-- Example of this structure:
--   dict = {
--     key1 = {
--       sub_key1 = {value1, value2, value3},
--       sub_key2 = {value4, value5},
--     },
--     key2 = {
--       sub_key3 = {value6},
--       sub_key4 = {value7, value8},
--     },
--   }
function export.put_value(dict, key, sub_key, value)
	if not dict[key] then
		dict[key] = {}
	end
	if not dict[key][sub_key] then
		dict[key][sub_key] = {}
	end
	table.insert(dict[key][sub_key], value)
end

-- Compare two items, recursively comparing lists.
-- FIXME, doesn't work for tables that aren't lists.
function export.equals(x, y)
    if type(x) == "table" and type(y) == "table" then
        if #x ~= #y then
            return false
        end 
        for key, value in ipairs(x) do
            if not export.equals(value, y[key]) then
                return false
            end
        end
        return true
    end
    return x == y
end

-- true if list contains item
function export.contains(tab, item)
    for _, value in pairs(tab) do
        if export.equals(value, item) then
            return true
        end
    end
    return false
end

-- append to list if element not already present
function export.insert_if_not(tab, item, pos)
    if not export.contains(tab, item) then
    	if pos then
        	table.insert(tab, pos, item)
        else
        	table.insert(tab, item)
        end
    end
end

-- convert list to set
function export.list_to_set(list)
	local set = {}
	for _, item in ipairs(list) do
		set[item] = true
	end
	return set
end

-- Inhibit Regular Expression magic characters ^$()%.[]*+-?)
function export.escape(value)
    -- Prefix every non-alphanumeric character (%W) with a % escape character, 
    -- where %% is the % escape, and %1 is original character
    return mw.ustring.gsub(value, "(%W)","%%%1")
end

return export