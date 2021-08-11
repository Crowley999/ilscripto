local getByCode = require("Module:languages").getByCode

local langs = {}

-- Auto-create language objects: langs.en -> language object for English.
setmetatable(langs, {
	__index = function(self, key)
		local lang = getByCode(key) or false
		self[key] = lang
		return lang
	end
})

return langs