local export = {}

local rmatch = mw.ustring.match

function export.cat(frame)
	local redlink_category = ""

	local m_languages = require("Module:languages")
	local code = frame.args[1] -- language code
	local template = frame.args["template"]

	local lang = m_languages.getByCode(frame.args[1])
	local entry = require("Module:links").getLinkPage(frame.args[2], lang) -- entry name (parameter 2 in Template:m, Template:l)

	local link_object = mw.title.new (entry)
	
	-- Prevent an expensive parser function error. Unfortunately, we can't check
	-- the expensive parser function count before running the preceding code
	-- in this function.
	local success, exists
	if link_object then
		success, exists = pcall(function () return link_object.exists end)
	end

	if success and not exists then
		local langname = lang:getCanonicalName()
		
		redlink_category = "[[Category:" .. langname .. " redlinks]]"
		if template and template ~= "-" then
			redlink_category = redlink_category .. "[[Category:" .. langname .. " redlinks/" .. template .. "]]"
		end
	end

	return redlink_category

end

return export