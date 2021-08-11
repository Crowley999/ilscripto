local data = {}

data.invariable = {
	"cmavo",
	"cmene",
	"fu'ivla",
	"gismu",
	"Han tu",
	"hanzi",
	"hanja",
	"jyutping",
	"kanji",
	"lujvo",
	"phrasebook",
	"pinyin",
	"rafsi",
	"romaji",
}

data.lemmas = {
	"abbreviations",
	"acronyms",
	"adjectives",
	"adnominals",
	"adpositions",
	"adverbs",
	"affixes",
	"ambipositions",
	"articles",
	"circumfixes",
	"circumpositions",
	"classifiers",
	"cmavo",
	"cmavo clusters",
	"cmene",
	"combining forms",
	"conjunctions",
	"counters",
	"determiners",
	"diacritical marks",
	"equative adjectives",
	"fu'ivla",
	"gismu",
	"Han characters",
	"Han tu",
	"hanzi",
	"hanja",
	"ideophones",
	"idioms",
	"infixes",
	"interfixes",
	"initialisms",
	"interjections",
	"kanji",
	"letters",
	"ligatures",
	"lujvo",
	"morphemes",
	"non-constituents",
	"nouns",
	"numbers",
	"numeral symbols",
	"numerals",
	"particles",
	"phrases",
	"postpositions",
	"postpositional phrases",
	"predicatives",
	"prefixes",
	"prepositions",
	"prepositional phrases",
	"preverbs",
	"pronominal adverbs",
	"pronouns",
	"proverbs",
	"proper nouns",
	"punctuation marks",
	"relatives",
	"roots",
	"stems",
	"suffixes",
	"syllables",
	"symbols",
	"verbs",
}

data.nonlemmas = {
	"active participles",
	"adjectival participles",
	"adjective forms",
	"adjective feminine forms",
	"adjective plural forms",
	"adverb forms",
	"adverbial participles",
	"agent participles",
	"article forms",
	"circumfix forms",
	"combined forms",
	"comparative adjective forms",
	"comparative adjectives",
	"comparative adverb forms",
	"comparative adverbs",
	"contractions",
	"converbs",
	"determiner comparative forms",
	"determiner forms",
	"determiner superlative forms",
	"diminutive nouns",
	"equative adjective forms",
	"equative adjectives",
	"future participles",
	"gerunds",
	"infinitive forms",
	"infinitives",
	"interjection forms",
	"jyutping",
	"kanji readings",
	"misspellings",
	"negative participles",
	"nominal participles",
	"noun case forms",
	"noun dual forms",
	"noun forms",
	"noun paucal forms",
	"noun plural forms",
	"noun possessive forms",
	"noun singulative forms",
	"numeral forms",
	"participles",
	"participle forms",
	"particle forms",
	"passive participles",
	"past active participles",
	"past participles",
	"past participle forms",
	"past passive participles",
	"perfect active participles",
	"perfect participles",
	"perfect passive participles",
	"pinyin",
	"plurals",
	"postposition forms",
	"prefix forms",
	"preposition contractions",
	"preposition forms",
	"prepositional pronouns",
	"present active participles",
	"present participles",
	"present passive participles",
	"pronoun forms",
	"pronoun possessive forms",
	"proper noun forms",
	"proper noun plural forms",
	"rafsi",
	"romanizations",
	"root forms",
	"singulatives",
	"suffix forms",
	"superlative adjective forms",
	"superlative adjectives",
	"superlative adverb forms",
	"superlative adverbs",
	"verb forms",
	"verbal nouns",
}

-- These languages will not have "LANG multiword terms" categories added.
data.no_multiword_cat = {
	-------- Languages without spaces between words (sometimes spaces between phrases) --------
	"aho", -- Ahom
	"blt", -- Tai Dam
	"ja", -- Japanese
	"khb", -- Lü
	"km", -- Khmer
	"lo", -- Lao
	"mnw", -- Mon
	"my", -- Burmese
	"nan", -- Min Nan (some words in Latin script; hyphens between syllables)
	"nod", -- Northern Thai
	"ojp", -- Old Japanese
	"tdd", -- Tai Nüa
	"th", -- Thai
	"tts", -- Isan
	"twh", -- Tai Dón
	"shn", -- Shan
	"sou", -- Southern Thai
	"zh", -- Chinese (all varieties with Chinese characters)

	-------- Languages with spaces between syllables --------
	"ahk", -- Akha
	"aou", -- A'ou
	"atb", -- Zaiwa
	"byk", -- Biao
	--"duu", -- Drung; not sure
	--"hmx-pro", -- Proto-Hmong-Mien
	--"hnj", -- Green Hmong; not sure
	"huq", -- Tsat
	"ium", -- Iu Mien
	--"lis", -- Lisu; not sure
	"mtq", -- Muong
	--"mww", -- White Hmong; not sure
	--"sit-gkh", -- Gokhy; not sure
	--"swi", -- Sui; not sure
	"tbq-lol-pro", -- Proto-Loloish
	"tdh", -- Thulung
	"ukk", -- Muak Sa-aak
	"vi", -- Vietnamese
	"yig", -- Wusa Nasu
	"zng", -- Mang

	-------- Languages with ~ with surrounding spaces used to separate variants --------
	"mkh-ban-pro", -- Proto-Bahnaric
	"sit-pro", -- Proto-Sino-Tibetan; listed above
	
	-------- Other weirdnesses --------
	"mul", -- Translingual; gestures, Morse code, etc.
	"aot", -- Atong (India); bullet is a letter

	-------- All sign languages	--------
	"ads",
	"aed",
	"aen",
	"afg",
	"ase",
	"asf",
	"asp",
	"asq",
	"asw",
	"bfi",
	"bfk",
	"bog",
	"bqn",
	"bqy",
	"bvl",
	"bzs",
	"cds",
	"csc",
	"csd",
	"cse",
	"csf",
	"csg",
	"csl",
	"csn",
	"csq",
	"csr",
	"doq",
	"dse",
	"dsl",
	"ecs",
	"esl",
	"esn",
	"eso",
	"eth",
	"fcs",
	"fse",
	"fsl",
	"fss",
	"gds",
	"gse",
	"gsg",
	"gsm",
	"gss",
	"gus",
	"hab",
	"haf",
	"hds",
	"hks",
	"hos",
	"hps",
	"hsh",
	"hsl",
	"icl",
	"iks",
	"ils",
	"inl",
	"ins",
	"ise",
	"isg",
	"isr",
	"jcs",
	"jhs",
	"jls",
	"jos",
	"jsl",
	"jus",
	"kgi",
	"kvk",
	"lbs",
	"lls",
	"lsl",
	"lso",
	"lsp",
	"lst",
	"lsy",
	"lws",
	"mdl",
	"mfs",
	"mre",
	"msd",
	"msr",
	"mzc",
	"mzg",
	"mzy",
	"nbs",
	"ncs",
	"nsi",
	"nsl",
	"nsp",
	"nsr",
	"nzs",
	"okl",
	"pgz",
	"pks",
	"prl",
	"prz",
	"psc",
	"psd",
	"psg",
	"psl",
	"pso",
	"psp",
	"psr",
	"pys",
	"rms",
	"rsl",
	"rsm",
	"sdl",
	"sfb",
	"sfs",
	"sgg",
	"sgx",
	"slf",
	"sls",
	"sqk",
	"sqs",
	"ssp",
	"ssr",
	"svk",
	"swl",
	"syy",
	"tse",
	"tsm",
	"tsq",
	"tss",
	"tsy",
	"tza",
	"ugn",
	"ugy",
	"ukl",
	"uks",
	"vgt",
	"vsi",
	"vsl",
	"vsv",
	"xki",
	"xml",
	"xms",
	"ygs",
	"ysl",
	"zib",
	"zsl",
}

-- In these languages, the hyphen is not considered a word separator for the "multiword terms" category.
data.hyphen_not_multiword_sep = {
	"akk", -- Akkadian; hyphens between syllables
	"akl", -- Aklanon; hyphens for mid-word glottal stops
	"ber-pro", -- Proto-Berber; morphemes separated by hyphens
	"ceb", -- Cebuano; hyphens for mid-word glottal stops
	"cnk", -- Khumi Chin; hyphens used in single words
	"cpi", -- Chinese Pidgin English; Chinese-derived words with hyphens between syllables
	"de", -- too many false positives
	"esx-esk-pro", -- hyphen used to separate morphemes
	"fi", -- Finnish; hyphen used to separate components in compound words if the final and initial vowels match, respectively
	"hil", -- Hiligaynon; hyphens for mid-word glottal stops
	"ilo", -- Ilocano; hyphens for mid-word glottal stops
	"lcp", -- Western Lawa; dash as syllable joiner
	"lwl", -- Eastern Lawa; dash as syllable joiner
	"mkh-vie-pro", -- Proto-Vietic; morphemes separated by hyphens
	"msb", -- Masbatenyo; too many false positives
	"tl", -- Tagalog; too many false positives
	"war", -- Waray-Waray; too many false positives
}

-- These languages will not have "LANG masculine nouns" and similar categories added.
data.no_gender_cat = {
	-- Languages without gender but which use the gender field for other purposes
	"ja",
	"th",
}

data.notranslit = {
	"ams",
	"az",
	"bbc",
	"bug",
	"cia",
	"cjm",
	"cmn",
	"hak",
	"ja",
	"kzg",
	"lad",
	"lzh",
	"ms",
	"mul",
	"mvi",
	"nan",
	"oj",
	"okn",
	"pi",
	"ro",
	"ryn",
	"rys",
	"ryu",
	"sh",
	"tgt",
	"th",
	"tkn",
	"tly",
	"und",
	"vi",
	"xug",
	"yue",
	"yoi",
	"yox",
	"za",
	"zh",
}

-- Script codes for which a script-tagged display title will be added.	
data.toBeTagged = {
	"Ahom",
	"Arab",
	"Avst",
	"Bali",
	"Cham",
	"Copt",
	"Kali",
	"Hani",
	"Hebr",
	"Lana",
	"Linb",
	"Mand",
	"Mong",
	"polytonic",
	"Rjng",
	"Samr",
	"Sund",
	"Sylo",
	"Tang",
	"Tavt",
	"Xsux",
}

for key, list in pairs(data) do
	data[key] = require("Module:utils").list_to_set(list)
end

-- Parts of speech for which categories like "German masculine nouns" or "Russian imperfective verbs"
-- will be generated if the headword is of the appropriate gender/number. We put this at the bottom
-- because it's a map, not a list.
data.pos_for_gender_number_cat = {
	["nouns"] = "nouns",
	["proper nouns"] = "nouns",
	["suffixes"] = "suffixes",
	-- We include verbs because impf and pf are valid "genders".
	["verbs"] = "verbs",
}

return data