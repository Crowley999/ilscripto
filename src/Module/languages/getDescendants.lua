-- Returns language objects for descendants of a language.

local validateLangCode = mw.loadData("Module:languages/code to canonical name")

local function getProto(family, code)
	return family.protoLanguage or
			validateLangCode[code .. "-pro"] and code .. "-pro"
end

return function(langCode)
	local langs = {}
	local families = {}
	
	local function iterate(dataModule)
		for code, data in pairs(dataModule) do
			if data.ancestors then
				for i, ancestor in pairs(data.ancestors) do
					if ancestor == langCode then
						table.insert(langs, require("Module:languages").getByCode(code))
					end
				end
			elseif data.family then
				local familyCode = data.family
				local familyCodeChain = {}
				
				family = mw.loadData("Module:families/data")[familyCode]
				local protoLanguage = families[familyCode] or
						getProto(family, familyCode)
				if not protoLanguage then
					table.insert(familyCodeChain, familyCode)
				end
				
				while not protoLanguage do
					familyCode = family.family
					table.insert(familyCodeChain, familyCode)
					if family then
						protoLanguage = getProto(family, familyCode)
					else
						break
					end
				end
				
				if familyCodeChain[1] then
					for i, familyCode in pairs(familyCodeChain) do
						families[familyCode] = protoLanguage or "none"
					end
				end
				
				if protoLanguage == langCode then
					table.insert(langs, require("Module:languages").getByCode(code))
				end
			end
		end
	end
	
	iterate(mw.loadData("Module:languages/data2"))
	
	--[[
	for letter in mw.ustring.gmatch("abcdefghijklmnopqrstuvwxyz", "(.)") do
		iterate(mw.loadData("Module:languages/data3/" .. letter))
	end
	
	iterate(mw.loadData("Module:languages/datax"))
	]]
	
	return langs
end