local data = {}
--[=[	Valid IPA symbols.
		Currently almost all values of "title" and "link" keys
		are just the comments that were used in [[Module:IPA]].
		The "link" fields should be checked (those that start with an uppercase letter are checked). ]=]

local U = mw.ustring.char

data[1] = {
	-- PULMONIC CONSONANTS

	-- nasal
	["m"] = {
		title = "bilabial nasal",
		link = "w:Bilabial nasal",
	},
	["ɱ"] = {
		title = "labiodental nasal",
		link = "w:Labiodental nasal",
	},
	["n"] = {
		title = "alveolar nasal",
		link = "w:Alveolar nasal",
	},
	["ɳ"] = {
		title = "retroflex nasal",
		link = "w:Retroflex nasal",
	},
	["ɲ"] = {
		title = "palatal nasal",
		link = "w:Palatal nasal",
	},
	["ŋ"] = {
		title = "velar nasal",
		link = "w:Velar nasal",
	},
	["ɴ"] = {
		title = "uvular nasal",
		link = "w:Uvular nasal",
	},

	-- plosive
	["p"] = {
		title = "voiceless bilabial plosive",
		link = "w:Voiceless bilabial stop",
	},
	["b"] = {
		title = "voiced bilabial plosive",
		link = "w:Voiced bilabial stop",
	},
	["t"] = {
		title = "voiceless alveolar plosive",
		link = "w:Voiceless alveolar stop",
	},
	["d"] = {
		title = "voiced alveolar plosive",
		link = "w:Voiced alveolar stop",
	},
	["ʈ"] = {
		title = "voiceless retroflex plosive",
		link = "w:Voiceless retroflex stop",
	},
	["ɖ"] = {
		title = "voiced retroflex plosive",
		link = "w:Voiced retroflex stop",
	},
	["c"] = {
		title = "voiceless palatal plosive",
		link = "w:Voiceless palatal stop",
	},
	["ɟ"] = {
		title = "voiced palatal plosive",
		link = "w:Voiced palatal stop",
	},
	["k"] = {
		title = "voiceless velar plosive",
		link = "w:Voiceless velar stop",
	},
	["ɡ"] = {
		title = "voiced velar plosive",
		link = "w:Voiced velar stop",
	},
	["q"] = {
		title = "voiceless uvular plosive",
		link = "w:Voiceless uvular stop",
	},
	["ɢ"] = {
		title = "voiced uvular plosive",
		link = "w:Voiced uvular stop",
	},
	["ʡ"] = {
		title = "epiglottal plosive",
		link = "w:Epiglottal stop",
	},
	["ʔ"] = {
		title = "glottal stop",
		link = "w:Glottal stop",
	},

	-- fricative
	["ɸ"] = {
		title = "voiceless bilabial fricative",
		link = "w:Voiceless bilabial fricative",
	},
	["β"] = {
		title = "voiced bilabial fricative",
		link = "w:Voiced bilabial fricative",
	},
	["f"] = {
		title = "voiceless labiodental fricative",
		link = "w:Voiceless labiodental fricative",
	},
	["v"] = {
		title = "voiced labiodental fricative",
		link = "w:Voiced labiodental fricative",
	},
	["θ"] = {
		title = "voiceless dental fricative",
		link = "w:Voiceless dental fricative",
	},
	["ð"] = {
		title = "voiced dental fricative",
		link = "w:Voiced dental fricative",
	},
	["s"] = {
		title = "voiceless alveolar fricative",
		link = "w:Voiceless alveolar fricative",
	},
	["z"] = {
		title = "voiced alveolar fricative",
		link = "w:Voiced alveolar fricative",
	},
	["ʃ"] = {
		title = "voiceless postalveolar fricative",
		link = "w:Voiceless palato-alveolar sibilant",
	},
	["ʒ"] = {
		title = "voiced postalveolar fricative",
		link = "w:Voiced palato-alveolar sibilant",
	},
	["ʂ"] = {
		title = "voiceless retroflex fricative",
		link = "w:Voiceless retroflex sibilant",
	},
	["ʐ"] = {
		title = "voiced retroflex fricative",
		link = "w:Voiced retroflex sibilant",
	},
	["ɕ"] = {
		title = "voiceless alveolo-palatal fricative",
		link = "w:Voiceless alveolo-palatal sibilant",
	},
	["ʑ"] = {
		title = "voiced alveolo-palatal fricative",
		link = "w:Voiced alveolo-palatal sibilant",
	},
	["ç"] = {
		title = "voiceless palatal fricative",
		link = "w:Voiceless palatal fricative",
	},
	["ʝ"] = {
		title = "voiced palatal fricative",
		link = "w:Voiced palatal fricative",
	},
	["x"] = {
		title = "voiceless velar fricative",
		link = "w:Voiceless velar fricative",
	},
	["ɣ"] = {
		title = "voiced velar fricative",
		link = "w:Voiced velar fricative",
	},
	["χ"] = {
		title = "voiceless uvular fricative",
		link = "w:Voiceless uvular fricative",
	},
	["ʁ"] = {
		title = "voiced uvular fricative",
		link = "w:Voiced uvular fricative",
	},
	["ħ"] = {
		title = "voiceless pharyngeal fricative",
		link = "w:Voiceless pharyngeal fricative",
	},
	["ʕ"] = {
		title = "voiced pharyngeal fricative",
		link = "w:Voiced pharyngeal fricative",
	},
	["ʜ"] = {
		title = "voiceless epiglottal fricative",
		link = "w:Voiceless epiglottal fricative",
	},
	["ʢ"] = {
		title = "voiced epiglottal fricative",
		link = "w:Voiced epiglottal fricative",
	},
	["h"] = {
		title = "voiceless glottal fricative",
		link = "w:Voiceless glottal fricative",
	},
	["ɦ"] = {
		title = "voiced glottal fricative",
		link = "w:Voiced glottal fricative",
	},

	-- approximant
	["ʋ"] = {
		title = "labiodental approximant",
		link = "w:Labiodental approximant",
	},
	["ɹ"] = {
		title = "alveolar approximant",
		link = "w:Alveolar approximant",
	},
	["ɻ"] = {
		title = "retroflex approximant",
		link = "w:Retroflex approximant",
	},
	["j"] = {
		title = "palatal approximant",
		link = "w:Palatal approximant",
	},
	["ɰ"] = {
		title = "velar approximant",
		link = "w:Velar approximant",
	},

	-- tap, flap
	["ⱱ"] = {
		title = "labiodental tap",
		link = "w:Labiodental flap",
	},
	["ɾ"] = {
		title = "alveolar flap",
		link = "w:Alveolar flap",
	},
	["ɽ"] = {
		title = "retroflex flap",
		link = "w:Retroflex flap",
	},

	-- trill
	["ʙ"] = {
		title = "bilabial trill",
		link = "w:Bilabial trill",
	},
	["r"] = {
		title = "alveolar trill",
		link = "w:Alveolar trill",
	},
	["ʀ"] = {
		title = "uvular trill",
		link = "w:Uvular trill",
	},
	["ᴙ"] = {
		title = "epiglottal trill",
		link = "w:Epiglottal trill",
	},

	-- lateral fricative
	["ɬ"] = {
		title = "voiceless alveolar lateral fricative",
		link = "w:Voiceless alveolar lateral fricative",
	},
	["ɮ"] = {
		title = "voiced alveolar lateral fricative",
		link = "w:Voiced alveolar lateral fricative",
	},
	 --	no precomposed Unicode character --TOMOVE
	--["ɬ̢"] = {title = "voiceless retroflex lateral fricative", link = "w:voiceless retroflex lateral fricative"},
	 -- no precomposed Unicode character --TOMOVE:3
	--["ʎ̝̊"] = {title = "voiceless palatal lateral fricative", link = "w:voiceless palatal lateral fricative"},
	 -- no precomposed Unicode character --TOMOVE:3
	--["ʟ̝̊"] = {title = "voiceless velar lateral fricative", link = "w:voiceless velar lateral fricative"},
	-- no precomposed Unicode character --TOMOVE
	--["ʟ̝"] = {title = "voiced velar lateral fricative", link = "w:voiced velar lateral fricative"},

	-- lateral approximant
	["l"] = {
		title = "alveolar lateral approximant",
		link = "w:Alveolar lateral approximant",
	},
	["ɭ"] = {
		title = "retroflex lateral approximant",
		link = "w:Retroflex lateral approximant",
	},
	["ʎ"] = {
		title = "palatal lateral approximant",
		link = "w:Palatal lateral approximant",
	},
	["ʟ"] = {
		title = "velar lateral approximant",
		link = "w:Velar lateral approximant",
	},

	-- lateral flap
	["ɺ"] = {
		title = "alveolar lateral flap",
		link = "w:Alveolar lateral flap",
	},
	--["ɭ̆"] = {title = "retroflex lateral flap", link = "w:retroflex lateral flap"}, -- no precomposed Unicode character --TOMOVE
	--["ɺ˞"] = {title = "retroflex lateral flap", link = "w:retroflex lateral flap"}, -- no precomposed Unicode character --TOMOVE

	-- NON-PULMONIC CONSONANTS

	-- clicks
	["ʘ"] = {
		title = "bilabial click",
		link = "w:Bilabial clicks",
	},
	["ǀ"] = {
		title = "dental click",
		link = "w:Dental clicks",
	},
	["ǃ"] = {
		title = "postalveolar click",
		link = "w:Alveolar clicks",
	},
	["‼"] = {
		title = "subapical retroflex",
		link = "w:Retroflex clicks",
	}, --	NOT IN X-SAMPA
	["ǂ"] = {
		title = "palatal click",
		link = "w:Palatal clicks",
	},
	["ǁ"] = {
		title = "alveolar lateral click",
		link = "w:Lateral clicks",
	},

	-- implosives
	["ɓ"] = {
		title = "voiced bilabial implosive",
		link = "w:Voiced bilabial implosive",
	},
	["ɗ"] = {
		title = "voiced alveolar implosive",
		link = "w:Voiced alveolar implosive",
	},
	-- NOT IN X-SAMPA
	["ᶑ"] = {
		title = "retroflex implosive",
		link = "w:Voiced retroflex implosive",
	},
	["ʄ"] = {
		title = "voiced palatal implosive",
		link = "w:Voiced palatal implosive",
	},
	["ɠ"] = {
		title = "voiced velar implosive",
		link = "w:Voiced velar implosive",
	},
	["ʛ"] = {
		title = "voiced uvular implosive",
		link = "w:Voiced uvular implosive",
	},

	-- ejectives
	["ʼ"] = {
		title = "ejective",
		link = "w:Ejective consonant",
	},

	-- CO-ARTICULATED CONSONANTS
	["ʍ"] = {
		title = "voiceless labial-velar fricative",
		link = "w:Voiceless labio-velar approximant",
	},
	["w"] = {
		title = "labial-velar approximant",
		link = "w:Labio-velar approximant",
	},
	["ɥ"] = {
		title = "labial-palatal approximant",
		link = "w:Labialized palatal approximant",
	},
	["ɧ"] = {
		title = "voiceless palatal-velar fricative",
		link = "w:Sj-sound",
	},

	-- should be handled in [[Module:IPA]] and not through this table
	-- BRACKETS
	--[[
	-- ["//"] = {
		title = "morphophonemic",
		link = "w:morphophonemic",
	},
	["/"] = {
		title = "phonemic",
		link = "w:phonemic",
	},
	["["] = {
		title = "phonetic",
		link = "w:phonetic",
	},
	["["] = {
		title = "phonetic",
		link = "w:phonetic",
	},
	["〈"] = {
		title = "orthographic",
		link = "w:orthographic",
	},
	["〉"] = {
		title = "orthographic",
		link = "w:orthographic",
	},
	["⟨"] = {
		title = "orthographic",
		link = "w:orthographic",
	},
	["⟩"] = {
		title = "orthographic",
		link = "w:orthographic",
	},
	]]

	-- VOWELS

	-- close
	["i"] = {
		title = "close front unrounded vowel",
		link = "w:Close front unrounded vowel",
	},
	["y"] = {
		title = "close front rounded vowel",
		link = "w:Close front rounded vowel",
	},
	["ɨ"] = {
		title = "close central unrounded vowel",
		link = "w:Close central unrounded vowel",
	},
	["ʉ"] = {
		title = "close central rounded vowel",
		link = "w:Close central rounded vowel",
	},
	["ɯ"] = {
		title = "close back unrounded vowel",
		link = "w:Close back unrounded vowel",
	},
	["u"] = {
		title = "close back rounded vowel",
		link = "w:Close back rounded vowel",
	},

	-- near close
	["ɪ"] = {
		title = "near-close near-front unrounded vowel",
		link = "w:Near-close near-front unrounded vowel",
	},
	["ʏ"] = {
		title = "near-close near-front rounded vowel",
		link = "w:Near-close near-front rounded vowel",
	},
	["ᵻ"] = {
		title = "near-close central unrounded vowel",
		link = "w:Near-close central unrounded vowel",
	},
	 -- (alternative) --TOMOVE
	--[[
	["ɪ̈"] = {
		title = "near-close central unrounded vowel",
		link = "w:near-close central unrounded vowel",
	},	]]
	["ᵿ"] = {
		title = "near-close central rounded vowel",
		link = "w:Near-close central rounded vowel",
	},
	 --[[
	 (alternative) TOMOVE
	["ʊ̈"] = {
		title = "near-close central rounded vowel",
		link = "w:near-close central rounded vowel",
	},
	]]
	["ʊ"] = {
		title = "near-close near-back rounded vowel",
		link = "w:Near-close near-back rounded vowel",
	},

	--close mid
	["e"] = {
		title = "close-mid front unrounded vowel",
		link = "w:Close-mid front unrounded vowel",
	},
	["ø"] = {
		title = "close-mid front rounded vowel",
		link = "w:Close-mid front rounded vowel",
	},
	["ɘ"] = {
		title = "close-mid central unrounded vowel",
		link = "w:Close-mid central unrounded vowel",
	},
	["ɵ"] = {
		title = "close-mid central rounded vowel",
		link = "w:Close-mid central rounded vowel",
	},
	["ɤ"] = {
		title = "close-mid back unrounded vowel",
		link = "w:Close-mid back unrounded vowel",
	},
	["o"] = {
		title = "close-mid back rounded vowel",
		link = "w:Close-mid back rounded vowel",
	},

	-- mid
	["ə"] = {
		title = "schwa",
		link = "w:Schwa",
	},
	["ɚ"] = {
		title = "schwa+r",
		link = "w:R-colored vowel",
	},

	-- open mid
	["ɛ"] = {
		title = "open-mid front unrounded vowel",
		link = "w:Open-mid front unrounded vowel",
	},
	["œ"] = {
		title = "open-mid front rounded vowel",
		link = "w:Open-mid front rounded vowel",
	},
	["ɜ"] = {
		title = "open-mid central unrounded vowel",
		link = "w:Open-mid central unrounded vowel",
	},
	["ɝ"] = {
		title = "open-mid central unrounded vowel+r",
		link = "w:R-colored vowel",
	},
	["ɞ"] = {
		title = "open-mid central rounded vowel",
		link = "w:Open-mid central rounded vowel",
	},
	["ʌ"] = {
		title = "open-mid back unrounded vowel",
		link = "w:Open-mid back unrounded vowel",
	},
	["ɔ"] = {
		title = "open-mid back rounded vowel",
		link = "w:Open-mid back rounded vowel",
	},

	-- near open
	["æ"] = {
		title = "near-open front unrounded vowel",
		link = "w:Near-open front unrounded vowel",
	},
	["ɐ"] = {
		title = "near-open central vowel",
		link = "w:Near-open central vowel",
	},

	-- open
	["a"] = {
		title = "open front unrounded vowel",
		link = "w:Open front unrounded vowel",
	},
	["ɶ"] = {
		title = "open front rounded vowel",
		link = "w:Open front rounded vowel",
	},
	["ɑ"] = {
		title = "open back unrounded vowel",
		link = "w:Open back unrounded vowel",
	},
	["ɒ"] = {
		title = "open back rounded vowel",
		link = "w:Open back rounded vowel",
	},

	-- SUPRASEGMENTALS
	["ˈ"] = {title = "primary stress", link = "w:Stress (linguistics)", XSAMPA = "\""},
	--[[
	["???"] = {
		title = "extra stress: no Unicode char; double primary stress instead",
		link = "w:extra stress: no Unicode char; double primary stress instead",
		XSAMPA = ""
	}, --TOMOVE:3 ]]
	["ˌ"] = {
		title = "secondary stress",
		link = "w:Secondary stress",
	},
	["ː"] = {
		title = "long",
		link = "w:Length (phonetics)",
	},
	["ˑ"] = {
		title = "half long",
		link = "w:Length (phonetics)",
	},
	["̆"] = {
		title = "extra-short",
		link = "w:Length (phonetics)",
	},
	--[[
	["%."] = {
		title = "syllable break",
		link = "w:syllable break",
	},
	]]
	--TOMOVE
	["‿"] = {
		title = "linking mark (absence of a break)",
		link = "w:Tie (typography)#International_Phonetic_Alphabet",
	},

	[" "] = {
		title = "separator",
		link = "w:separator",
	},

	-- TONE

	-- level tones
	["˥"] = {
		title = "top",
		link = "w:Tone letter",
	},
	["˦"] = {
		title = "high",
		link = "w:Tone letter",
	},
	["˧"] = {
		title = "mid",
		link = "w:Tone letter",
	},
	["˨"] = {
		title = "low",
		link = "w:Tone letter",
	},
	["˩"] = {
		title = "bottom",
		link = "w:Tone letter",
	},

	["̋"] = {
		title = "extra high tone",
		link = "w:Tone letter",
	},
	["́"] = {
		title = "high tone",
		link = "w:Tone letter",
	},
	["̄"] = {
		title = "mid tone",
		link = "w:Tone letter",
	},
	["̀"] = {
		title = "low tone",
		link = "w:Tone letter",
	},
	["̏"] = {
		title = "extra low tone",
		link = "w:Tone letter",
	},

	-- tone terracing
	["ꜛ"] = {
		title = "upstep",
		link = "w:Upstep",
	},
	["ꜜ"] = {
		title = "downstep",
		link = "w:Downstep",
	},

	-- contour tones
	["̌"] = {
		title = "rising tone",
		link = "w:Tone (linguistics)",
	},
	["̂"] = {
		title = "falling tone",
		link = "w:Tone (linguistics)",
	},
	["᷄"] = {
		title = "high rising tone",
		link = "w:Tone (linguistics)",
	},
	["᷅"] = {
		title = "low rising tone",
		link = "w:Tone (linguistics)",
	},
	["᷇"] = {
		title = "high falling tone",
		link = "w:Tone (linguistics)",
	},
	["᷆"] = {
		title = "low falling tone",
		link = "w:Tone (linguistics)",
	},
	["᷈"] = {
		title = "rising falling tone (peaking)",
		link = "w:Tone (linguistics)",
	},
	["᷉"] = {
		title = "dipping",
		link = "w:Tone (linguistics)",
	}, -- [extrapolated from the chart -- please confirm]

	-- intonation
	["|"] = {
		title = "minor (foot) group",
		link = "w:Prosodic unit",
	},
	["‖"] = {
		title = "major (intonation) group",
		link = "w:Prosodic unit",
	},
	["↗"] = {
		title = "global rise",
		link = "w:Intonation (linguistics)",
	},
	["↘"] = {
		title = "global fall",
		link = "w:Intonation (linguistics)",
	},

	-- DIACRITICS

	-- syllabicity & releases
	["̩"] = {
		title = "syllabi ",
		link = "w:Syllabic consonant",
		withdescender = "̍"
	}, -- (or "_="
	["̯"] = {
		title = "non-syllabic",
		link = "w:Semivowel",
		withdescender = "̑"
	},
	["ʰ"] = {
		title = "aspirated",
		link = "w:Aspirated consonant",
	},
	["ⁿ"] = {
		title = "nasal release",
		link = "w:Nasal release",
	},
	["ˡ"] = {
		title = "lateral release",
		link = "w:Lateral release (phonetics)",
	},
	["̚"] = {
		title = "no audible release",
		link = "w:No audible release",
	},

	-- phonation
	["̥"] = {
		title = "voiceless",
		link = "w:Voicelessness",
		withdescender = "̊"
	},
	["̬"] = {
		title = "voiced",
		link = "w:Voice (phonetics)",
	},
	["̤"] = {
		title = "breathy voice",
		link = "w:Breathy voice",
	},
	["̰"] = {
		title = "creaky voice",
		link = "w:Creaky voice",
	},
	["᷽"] = {
		title = "strident",
		link = "w:Strident vowel",
	},

	-- primary articulation
	["̪"] = {
		title = "dental",
		link = "w:Dental consonant",
	},
	["̺"] = {
		title = "apical",
		link = "w:Apical consonant",
	},
	["̻"] = {
		title = "laminal",
		link = "w:Laminal consonant",
	},
	["̟"] = {
		title = "advanced",
		link = "w:Relative articulation#Advanced_and_retracted",
		withdescender = "˖"
	},
	["̠"] = {
		title = "retracted",
		link = "w:Relative articulation#Retracted",
		withdescender = "˗"
	},
	["̼"] = {
		title = "linguolabial",
		link = "w:Linguolabial consonant",
	},
	["̈"] = {
		title = "centralized",
		link = "w:Relative articulation#Centralized_vowels",
		XSAMPA = "_\""
	},
	["̽"] = {
		title = "mid-centralized",
		link = "Relative articulation#Mid-centralized_vowel",
	},
	["̞"] = {
		title = "lowered",
		link = "w:Relative articulation#Raised_and_lowered",
		withdescender = "˕"
	},
	["̝"] = {
		title = "raised",
		link = "w:Relative articulation#Raised_and_lowered",
		withdescender = "˔"
	},
	["͡"] = {
		title = "coarticulated",
		link = "w:Co-articulated consonant",
	},
	["͈"] = {
		title = "strong articulation",
		link = "w:Fortis and lenis",
	},

	-- secondary articulation
	["ʷ"] = {
		title = "labialized",
		link = "w:Labialization",
	},
	["ʲ"] = {
		title = "palatalized",
		link = "w:Palatalization (phonetics)",
	},
	["ˠ"] = {
		title = "velarized",
		link = "w:Velarization",
	},
	["ˤ"] = {
		title = "pharyngealized",
		link = "w:Pharyngealization",
	},
	-- also see _e
	["ɫ"] = {
		title = "velarized alveolar lateral approximant",
		link = "w:Alveolar lateral approximant",
	},
	["̴"] = {
		title = "velarized or pharyngealized; also see 5",
		link = "w:Velarization",
	},
	["̹"] = {
		title = "more rounded",
		link = "w:Roundedness",
	},
	["̜"] = {
		title = "less rounded",
		link = "w:Roundedness",
	},
	["̃"] = {
		title = "nasalization",
		link = "w:Nasalization",
	},
	["˞"] = {
		title = "rhotacization in vowels, retroflexion in consonants",
		link = "w:R-colored vowel",
	},
	["̘"] = {
		title = "advanced tongue root",
		link = "w:Advanced and retracted tongue root",
	},
	["̙"] = {
		title = "retracted tongue root",
		link = "w:Advanced and retracted tongue root",
	},

}

data[2] = {
	 -- TODO
	--["%("] = {},
	--["%)"] = {},

	["ːː"] = {
		title = "extra long",
		link = "w:Length (phonetics)",
	},

	["r̥"] = {title = "voiceless alveolar trill", link = "w:Voiceless alveolar trill"},
	["ɬ’"] = {title = "alveolar lateral ejective fricative", link = "w:Alveolar lateral ejective fricative"},
}
data[3] = {
	["t͡s"] = {title = "voiceless alveolar sibilant affricate", link = "w:Voiceless alveolar affricate"},
	["d͡z"] = {title = "voiced alveolar sibilant affricate", link = "w:Voiced alveolar affricate"},
	["t͡ʃ"] = {title = "voiceless palato-alveolar affricate", link = "w:Voiceless palato-alveolar affricate", descender = true},
	["d͡ʒ"] = {title = "voiced palato-alveolar affricate", link = "w:Voiced palato-alveolar affricate"},
	["ʈ͡ʂ"] = {title = "voiceless retroflex affricate", link = "w:Voiceless retroflex affricate", descender = true},
	["ɖ͡ʐ"] = {title = "voiced retroflex affricate", link = "w:Voiced retroflex affricate, descender = true"},
	["t͡ɕ"] = {title = "voiceless alveolo-palatal affricate", link = "w:Voiceless alveolo-palatal affricate"},
	["d͡ʑ"] = {title = "voiced alveolo-palatal affricate", link = "w:Voiced alveolo-palatal affricate"},

	["c͡ç"] = {title = "voiceless palatal affricate", link = "w:Voiceless palatal affricate, descender = true"},
	["ɟ͡ʝ"] = {title = "voiced palatal affricate", link = "w:Voiced palatal affricate, descender = true"},
	["k͡x"] = {title = "voiceless velar affricate", link = "w:Voiceless velar affricate"},
	["ɡ͡ɣ"] = {title = "voiced velar affricate", link = "w:Voiced velar affricate, descender = true"},
}
data[4] = {
	["ǃ͡qʼ"] = {title = "alveolar linguo-glottalic stop", link = "w:Ejective-contour clicks, descender = true"},
	["ǁ͡χʼ"] = {title = "lateral linguo-glottalic affricate (homorganic)", link = "w:Ejective-contour clicks", descender = true},
}
data[5] = {
	["k͡ʟ̝̊"] = {title = "voiceless velar lateral affricate", link = "w:Voiceless velar lateral affricate"},
	["ᶢǀ͡qʼ"] = {title = "voiced dental linguo-glottalic stop", link = "w:Ejective-contour clicks"},
	["ǂ͡kxʼ"] = {title = "palatal linguo-glottalic affricate (heterorganic)", link = "w:Ejective-contour clicks"},
}
data[6] = {
	["k͡ʟ̝̊ʼ"] = {title = "velar lateral ejective affricate", link = "w:Velar lateral ejective affricate"},
	["ᶢʘ͡kxʼ"] = {title = "voiced labial linguo-glottalic affricate", link = "w:Ejective-contour clicks"},
}

-- acute and grave tone marks
data["diacritics"] =
	--	grave, 		acute,		circumflex,	tilde,		macron, 	breve
		U(0x300) .. U(0x301) .. U(0x302) .. U(0x303) .. U(0x304) .. U(0x306)
	--	diaeresis,	ring above, 	double acute,	caron,		vertical line above,	double grave,	left tack
	..	U(0x308) .. U(0x30A) ..		U(0x30B) ..		U(0x30C) .. U(0x30D) ..				U(0x30F) ..		U(0x318)
	--	right tack,	left angle,	left half ring below,	up tack below,	down tack below,	plus sign below	
	..	U(0x319) .. U(0x31A) .. U(0x31C) ..				U(0x31D) ..		U(0x31E) ..			U(0x31F)
	--	minus sign below,	rhotic hook below,	dot below, 	diaeresis below,	ring below,	vertical line below, 	bridge below
	..	U(0x320) ..			U(0x322) ..			U(0x323) .. U(0x324) ..			U(0x325) ..	U(0x329) ..				U(0x32A)
	--	caron below, 	inverted breve below
	..	U(0x32C) ..		U(0x32F)
	--	tilde below, 	right half ring below,	inverted bridge below,	square below,	seagull below,	x above
	..	U(0x330) ..		U(0x339) ..				U(0x33A) ..				U(0x33B) ..		U(0x33C) ..		U(0x33D)
	--	grave tone mark,	acute tone mark,	bridge above,	equals sign below,	double vertical line below
	..	U(0x340) ..			U(0x341) ..			U(0x346) ..		U(0x347) ..			U(0x348)
	--	left angle below,	not tilde above,	homothetic above,	almost equal above,	left right arrow below
	..	U(0x349) ..			U(0x34A) ..			U(0x34B) ..			U(0x34C) ..			U(0x34D)
	--	upwards arrow below, 	left arrowhead below, 	right arrowhead below
	..	U(0x34E) ..				U(0x354) ..				U(0x355)
	--	double rightwards arrow below,	combining Latin small letter a
	..	U(0x362) ..						U(0x361)
	--	macron–acute,	grave–macron,	macron–grave,	acute–macron,	grave–acute–grave,	acute–grave–acute
	..	U(0x1DC4) ..	U(0x1DC5) ..	U(0x1DC6) ..	U(0x1DC7) ..	U(0x1DC8) ..		U(0x1DC9)
	
data["tones"] = '˥˦˧˨˩꜒꜓꜔꜕꜖꜈꜉꜊꜋꜌꜍꜎꜏꜐꜑¹²³⁴⁵'
data["vowels"] = 'iyɨʉɯuɪʏʊeøɘɵɤoəɚɛœɜɝɞʌɔæɐaɶɑɒäëïöüÿ'
data["superscripts"] = '¹²³⁴⁵ᵝʰʱʲʳʴʵʶʷʸ˞ˠˡˢꟹᶣᶬᶮᶯᶰᶹˀˤⁿᵇᵈᶢ'
data["valid"] =
	U(0xA0) .. ' %(%)%%{%|%}%-~⁓.◌abcdefhijklmnopqrstuvwxyz¡àáâãāăēäæçèéêëĕěħìíîïĩīĭĺḿǹńňðòóôõöōŏőœøŕùúûüũūŭűýÿŷŋ'
	.. 'ǀǁǂǃǎǐǒǔřǖǘǚǜǟǣǽǿȁȅȉȍȕȫȭȳɐɑɒɓɔɕɖɗɘəɚɛɜɝɞɟɠɡɢɣɤɥɦɧɨɪɫɬɭɮɯɰɱɲɳɴɵɶɸɹɺɻɽɾʀʁʂʃʄʈʉʊʋṽʌʍʎʏʐʑʒʔʕʘʙʛʜʝʟʡʢʬʭ⁻'
	.. 'ʼˈˌːˑˣ˔˕ˬ͗˭ˇ˖β͜θχᴙᵄᵊᵐᵑᶑ᷽ḁḛḭḯṍṏṳṵṹṻạẹẽịọụỳỵỹ‖․‥…‼‿↑↓↗↘ⱱꜛꜜꟸ𝆏𝆑˗' 
	.. data.diacritics .. data.tones .. data.superscripts

data["suggestions"] = {
	["g"] = "ɡ",
	["'"] = "ˈ",
	[""] = "",
	[":"] = "ː",
	["ˁ"] = "ˤ",
	["ǝ"] = "ə",
    ["ә"] = "ə",
	-- Syllabic fricatives
	["ɿ"] = "z̩",
	["ʅ"] = "ʐ̩",
	["ʮ"] = "z̩ʷ",
	["ʯ"] = "ʐ̩ʷ",
	["Ɂ"] = "ʔ",
	-- Deprecated symbols
    ["ɩ"] = "ɪ",
    ["ɷ"] = "ʊ",
    ["ᴜ"] = "ʊ",
	["ʣ"] = "d͡z",
	["ʤ"] = "d͡ʒ",
	["ʥ"] = "d͡ʑ",
	["ʦ"] = "t͡s",
	["ʧ"] = "t͡ʃ",
	["ʨ"] = "t͡ɕ",
	["ʪ"] = "ɬ͡s",
	["ʫ"] = "ɮ͡z",
	-- Greek letters
    ["α"] = "ɑ",
    ["γ"] = "ɣ",
    ["δ"] = "ð",
    ["ε"] = "ɛ",
    ["η"] = "ŋ",
    ["ι"] = "ɪ",
    ["λ"] = "ʎ",
    ["υ"] = "ʋ",
    ["ϕ"] = "ɸ", 
}

return data