local export = {}

local m_IPA = require("Module:IPA")
local lang = require("Module:languages").getByCode("gem-pro")

local letters_internal = {
	{ "ai", "aj" }, { "au", "aw" }, { "eu", "ew" }, { "iu", "iw" },
	{ "hw", "hʷ" }, { "kw", "kʷ" }, { "gw", "gʷ" },
	{ "ē₂", "ë" }, { "į̄", "ǐ" }, { "ǫ̂", "ơ" },
}

local phonetic_rules = {
	{ "a", "ɑ" },
	{ "ā", "ɑː" }, { "ë", "eː" }, { "ē", "ɛː" }, { "ī", "iː" }, { "ō", "ɔː" }, { "ū", "uː" },
	{ "ê", "ɛːː" }, { "ô", "ɔːː" },
	{ "ą", "ɑ̃" }, { "į", "ĩ" }, { "ų", "ũ" },
	{ "ǐ", "ĩː" }, { "ǭ", "ɔ̃ː" },
	{ "ơ", "ɔ̃ːː" },
	{ "f", "ɸ" }, { "þ", "θ" },
	{ "h", "x" }, { "hʷ", "xʷ" },
	{ "^x", "h" }, { "^xʷ", "hʷ" },
	{ "b", "β" }, { "^β", "b" }, { "mβ", "mb" },
	{ "d", "ð" }, { "^ð", "d" }, { "([nlz])ð", "%1d" },
	{ "g", "ɣ" }, { "nɣʷ", "ŋʷɡʷ" }, { "nɣ", "ŋɡ" },
}

local vowels = {
	"a", "e", "i", "u",
	"ā", "ē", "ë", "ī", "ō", "ū",
	"ê", "ô",
	"ą", "į", "ų",
	"ǐ", "ǭ",
	"ơ",
	"-"
}

local onsets = {
	"b", "p", "d", "t", "þ",
	"g", "k", "kʷ", "gʷ",
	"f", "s", "h", "hʷ", "z",
	"l", "m", "n", "r", "j", "w",
	
	"bl", "pl", "fl", "br", "pr", "fr", "þl", "wl",
	"dr", "tr", "þr",
	"gl", "kl", "hl", "gr", "kr", "hr", "wr",
	"gn", "kn", "hn", "fn",
	"dw", "tw", "þw", "kw", "hw",
	
	"sp", "st", "sk", "sw", "sl", "sm", "sn", "sw",
	"spr", "str", "skr",
	"spl", "skl",
}

local codas = {
	"b", "p", "þ", "d", "t", "f", "g", "k", "h",
	"s", "z",
	"l", "m", "n", "r", "j", "w",
	
	"hʷ", "ww", "wz",
	
	"sp", "st", "sk",
	
	"lp", "lt", "lk",
	"lb", "ld", "lg",
	"lf", "lþ", "lh",
	
	"rp", "rt", "rk",
	"rb", "rd", "rg",
	"rf", "rþ", "rh",
	
	"mp", "nt", "nk", "nn",
	"mb", "nd", "ng",
	"mf", "nþ", "nh", "nhs",
	
	"lm", "rl", "rm", "rn", "wh", "wr", "wl", "fl", "sl",
	
	"ps", "ts", "ks", "hs", "ls", "ns", "rs", "þs", "sts", "hts",
	"lks", "lhs", "nks", "rks", "rgz", "rhs", "nþs", "hsl",
	"lms", "rls", "rms", "rns", "hst", "hsl", "rht", "rkt",
	
	"ht", "rht",
	
	"nz", "ndz", "dz", "gz", "ngz", "rz", "rbz", "rdz", "zn",
	"ndr", "ntr", "ngr", "nkr", "nstr",
	
	"jp", "jb", "js", "jz", "jt", "jd", "jþ", "jf", "jk", "jg", "jh", "jr",
	"jst", "jzd", "jts", "jdz", "jks", "jgz", "jsk", "jzg", "jstr", "jzdr",
	"jn", "jm", "jw", "jþm",
}

for _, val in ipairs(vowels) do
	vowels[val] = true
end

for _, val in ipairs(onsets) do
	onsets[val] = true
end

for _, val in ipairs(codas) do
	codas[val] = true
end

local function letters_to_internal(word)
	local phonemes = {}
	
	for _, rule in ipairs(letters_internal) do
		word = mw.ustring.gsub(word, rule[1], rule[2])
	end
	
	mw.ustring.gsub(word, ".", function(c)
		table.insert(phonemes, c)
	end)
	
	return phonemes
end

local function word_from_internal(word)
	for _, rule in ipairs(letters_internal) do
		word = mw.ustring.gsub(word, rule[2], rule[1])
	end
	
	return word
end

local function get_onset(syll)
	local consonants = {}
	
	for i = 1, #syll do
		if vowels[syll[i]] then
			break
		end
		table.insert(consonants, syll[i])
	end
	
	return table.concat(consonants)
end

local function get_coda(syll)
	local consonants = {}
	
	for i = #syll, 1, -1 do
		if vowels[syll[i]] then
			break
		end
		
		table.insert(consonants, 1, syll[i])
	end
	
	return table.concat(consonants)
end

local function get_vowel(syll)
	for i = 1, #syll do
		if vowels[syll[i]] then return syll[i] end
	end
end

-- Split the word into syllables of CV shape
local function split_syllables(remainder)
	local syllables = {}
	local syll = {}
	
	while #remainder > 0 do
		local phoneme = table.remove(remainder, 1)
		
		if vowels[phoneme] then
			table.insert(syll, phoneme)
			table.insert(syllables, syll)
			syll = {}
		else
			table.insert(syll, phoneme)
		end
	end
	
	-- If there are phonemes left, then the word ends in a consonant
	-- Add them to the last syllable
	for _, phoneme in ipairs(syll) do
		table.insert(syllables[#syllables], phoneme)
	end
	
	-- Split consonant clusters between syllables
	for i, current in ipairs(syllables) do
		if i > 1 then
			local previous = syllables[i - 1]
			local onset = get_onset(current)
			-- Shift over consonants until the syllable onset is valid
			while not (onset == "" or onsets[onset]) do
				table.insert(previous, table.remove(current, 1))
				onset = get_onset(current)
			end
			
			-- If there is no vowel at all in this syllable
			if not get_vowel(current) then
				for j = 1, #current do
					table.insert(syllables[i - 1], table.remove(current, 1))
				end
				table.remove(syllables, i)
			end
		end
	end
	
	for _, syll in ipairs(syllables) do
		local onset = get_onset(syll)
		local coda = get_coda(syll)
		
		if not (onset == "" or onsets[onset]) then
			require("Module:debug").track("gem-ipa/bad onset")
			error("onset error: [" .. onset .. "]")
		end
		
		if not (coda == "" or codas[coda]) then
			require("Module:debug").track("gem-ipa/bad coda")
			error("coda error: [" .. coda .. "]")
		end
	end
	
	return syllables
end

local function convert_word(word)
	-- Convert word to a better internal representation
	local phonemes = letters_to_internal(word)
	
	-- Split into syllables
	local syllables = split_syllables(phonemes)
	
	for i, syll in ipairs(syllables) do
		for j = 1, #syll - 1 do
			if syll[j] == syll[j + 1] then
				syll[j + 1] = ""
			end
		end
		syllables[i] = table.concat(syll)
	end
	
	word = table.concat(syllables, ".")
	
	for _, rule in ipairs(phonetic_rules) do
		word = mw.ustring.gsub(word, rule[1], rule[2])
	end
	
	return word
end

local function convert_words(words)
	words = mw.ustring.lower(words)
	
	local result = {}
	
	for word in mw.text.gsplit(words, " ") do
		table.insert(result, convert_word(word))
	end
	
	return table.concat(result, " ")
end

function export.show_full(frame)
	local params = {
		[1] = { default = mw.title.getCurrentTitle().nsText ~= 'Reconstruction' and 'wurdą' or mw.title.getCurrentTitle().subpagetext }
	}
	local args = require("Module:parameters").process(frame:getParent().args, params)
	local words = args[1]:lower()
	local categories = {}
	
	local out = m_IPA.format_IPA_full(lang, { { pron = '/' .. convert_words(words) .. '/' } })
	
	return out .. require("Module:utilities").format_categories(categories)
end


function export.show(words)
	if type(words) == "table" then -- assume a frame
		words = words.args[1]:lower() or mw.title.getCurrentTitle().subpageText:lower()
	end
	
	return convert_words(words)
end

local function i_mutation(word)
	local upperc = false
	--local dash = false
	if mw.ustring.find(word, "^%u") then
		word = mw.ustring.lower(word)
		upperc = true
	end
	--[[if mw.ustring.find(word, "^%-") then
		word = mw.ustring.sub(word, 2)
		dash = true
	end]]
	local repeated = false
	local phonemes = letters_to_internal(word)
	
	-- Split into syllables
	local syllables = split_syllables(phonemes)
	
	for i, syll in ipairs(syllables) do
		--[[for j=1, #syll-1 do
			if syll[j]==syll[j+1] then
				syll[j+1] = ""
				repeated = true
			end
		end]]
		syllables[i] = table.concat(syll)
	end
	
	for i = #syllables, 1, -1 do
		mw.ustring.gsub(syllables[i], "e([mn])", "i%1")
		if mw.ustring.find(syllables[i], "[iīįǐj]") then
			if not mw.ustring.find(syllables[i], "je") then
				syllables[i] = mw.ustring.gsub(syllables[i], "e", "i")
			end
			if i ~= 1 then
				syllables[i - 1] = mw.ustring.gsub(syllables[i - 1], "e", "i")
			end
		end
	end
	
	local new_word = table.concat(syllables)
	local vowels_s = "aeiuāēëīōūêôąįųǭį̄ǫ̂"
	new_word = word_from_internal(new_word)
	new_word = mw.ustring.gsub(new_word, "uu", "wu")
	new_word = mw.ustring.gsub(new_word, "([" .. vowels_s .. "]i)u", "%1w")
	new_word = mw.ustring.gsub(new_word, "([aei])u([" .. vowels_s .. "w])", "%1w%2")
	new_word = mw.ustring.gsub(new_word, "([aei])i([" .. vowels_s .. "j])", "%1j%2")
	new_word = mw.ustring.gsub(new_word, "([" .. vowels_s .. "])uj", "%1wj")
	-- Exception for compound words
	new_word = mw.ustring.gsub(new_word, "andaulit", "andawlit")
	if upperc then
		return mw.ustring.upper(mw.ustring.sub(new_word, 1, 1)) .. mw.ustring.sub(new_word, 2)
		--elseif dash then
		--	return "-" .. new_word
	else
		return new_word
	end
end

function export.determine_sievers(stem)
	if mw.ustring.find(stem, "[aeiu].[aeiu].$") then
		-- Two light syllables = one heavy
		return "ij"
	elseif mw.ustring.find(stem, "^[aeiu][iubdfgkjklmnprstþwz]$") or mw.ustring.find(stem, "[bdfgkjklmnprstþwz][aeiu][iubdfgkjklmnprstþwz]$") or mw.ustring.find(stem, "[āēīōū]$") then
		return "j"
	else
		return "ij"
	end
end

function export.i_mutations(word)
	local words = mw.text.split(word, " ")
	if #words > 1 then
		local new_word = i_mutation(words[#words])
		table.remove(words)
		table.insert(words, new_word)
		return table.concat(words, " ")
	else
		return i_mutation(word)
	end
end

return export