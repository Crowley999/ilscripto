local labels = {}
local aliases = {}
local deprecated = {}
local replacements = {
	labels = {},
	aliases = {},
	deprecated = {},
}


--  Helper labels

labels['_'] = {
	display = '',
	omit_preComma = true,
	omit_postComma = true,
}

labels['also'] = {
	omit_postComma = true,
}

labels['and'] = {
	omit_preComma = true,
	omit_postComma = true,
}
aliases['&'] = 'and'

labels['or'] = {
	omit_preComma = true,
	omit_postComma = true,
}

labels[';'] = {
	omit_preComma = true,
	omit_postComma = true,
	omit_preSpace = true,
}

labels['by'] = {
	omit_preComma = true,
	omit_postComma = true,
}

labels['with'] = {
	omit_preComma = true,
	omit_postComma = true,
}
aliases['+'] = 'with'

-- combine with 'except in', 'outside'? or retain for entries like "wnuczę"?
labels['except'] = {
	omit_preComma = true,
	omit_postComma = true,
}

labels['outside'] = {
	omit_preComma = true,
	omit_postComma = true,
}
aliases['except in'] = 'outside'


-- Qualifier labels

labels['chiefly'] = {
	omit_postComma = true,
}
aliases['mainly'] = 'chiefly'
aliases['mostly'] = 'chiefly'
aliases['primarily'] = 'chiefly'

labels['especially'] = {
	omit_postComma = true,
}

labels['particularly'] = {
	omit_postComma = true,
}

labels['excluding'] = {
	omit_postComma = true,
}

labels['extremely'] = {
	omit_postComma = true,
}

labels['frequently'] = {
	omit_postComma = true,
}

labels['humorously'] = { omit_postComma = true,
	-- should be "terms with X senses", leaving "X terms" to the term-context temp?
	pos_categories = { "jocular terms" },
}

labels['including'] = {
	omit_postComma = true,
}

labels['many'] = { -- e.g. "many dialects"
	omit_postComma = true,
}

labels['markedly'] = {
	omit_postComma = true,
}

labels['mildly'] = {
	omit_postComma = true,
}

labels['now'] = {
	omit_postComma = true,
}
aliases['nowadays'] = 'now'
aliases['Now'] = 'now'

labels['occasionally'] = {
	omit_postComma = true,
}

labels['of'] = {
	omit_postComma = true,
}

labels['of a'] = {
	omit_postComma = true,
}

labels['of an'] = {
	omit_postComma = true,
}

labels['often'] = {
	omit_postComma = true,
}

labels['originally'] = {
	omit_postComma = true,
}

labels['possibly'] = {
	omit_postComma = true,
}
-- aliases['perhaps'] = 'possibly'

labels['rarely'] = {
	omit_postComma = true,
}

labels['sentence adverb'] = {
	glossary = true,
	pos_categories = { "sentence adverbs" },
}

labels['slightly'] = {
	omit_postComma = true,
}

labels['sometimes'] = {
	omit_postComma = true,
}

labels['somewhat'] = {
	omit_postComma = true,
}

labels['strongly'] = {
	omit_postComma = true,
}

labels['then'] = {
	omit_postComma = true,
} -- e.g. "then colloquial, now dated"

labels['typically'] = {
	omit_postComma = true,
}

labels['usually'] = {
	omit_postComma = true,
}

labels['very'] = {
	omit_postComma = true,
}


-- Grammatical labels

labels["abbreviation"] = {
	display = "[[abbreviation]]",
	pos_categories = { "abbreviations" },
}

labels["acronym"] = {
	display = "[[acronym]]",
	pos_categories = { "acronyms" },
}

labels["active"] = {
	Wikipedia = "Active voice",
}
aliases["active voice"] = "active"
aliases["in the active"] = "active"

labels["ambitransitive"] = {
	display = "[[transitive]], [[intransitive]]",
	pos_categories = { "transitive verbs", "intransitive verbs" },
}

labels["animate"] = {
	glossary = true
}

labels["indicative"] = {
	glossary = "indicative mood",
}
aliases["in the indicative"] = "indicative"
aliases["indicative mood"] = "indicative"

labels["subjunctive"] = {
	glossary = "subjunctive mood",
}
aliases["in the subjunctive"] = "subjunctive"
aliases["subjunctive mood"] = "subjunctive"

labels["imperative"] = {
	glossary = "imperative mood",
}
aliases["in the imperative"] = "imperative"
aliases["imperative mood"] = "imperative"

labels["jussive"] = {
	glossary = "jussive mood",
}
aliases["in the jussive"] = "jussive"
aliases["jussive mood"] = "jussive"

labels["archaic-verb-form"] = {
	glossary = "archaic",
	pos_categories = { "archaic verb forms" },
}

labels["attributive"] = {
	display = "[[Appendix:English nouns#Attributive|attributive]]",
}

labels["attributively"] = {
	display = "[[Appendix:English nouns#Attributive|attributively]]",
}

labels["auxiliary"] = {
	glossary = true,
	pos_categories = { "auxiliary verbs" }
}

labels["cardinal"] = {
	display = "[[cardinal number|cardinal]]",
	pos_categories = { "cardinal numbers" },
}
deprecated["cardinal"] = true

labels["causative"] = {
	display = "[[causative]]" }

labels["cognate object"] = {
	display = "with [[w:Cognate object|cognate object]]",
	pos_categories = { "verbs used with cognate objects" },
}
aliases["with cognate object"] = "cognate object"

labels["collective"] = {
	glossary = true,
	display = "collective",
	pos_categories = { "collective nouns" },
}

labels["collectively"] = {
	glossary = "collective",
	display = "collectively",
	pos_categories = { "collective nouns" },
}

labels["control verb"] = {
	Wikipedia = true,
	pos_categories = { "control verbs" },
}
aliases["control"] = "control verb"

labels["common"] = {
	glossary = true
}

labels["comparable"] = {
	glossary = true
}

labels["copulative"] = {
	display = "[[copular verb|copulative]]",
	pos_categories = { "copulative verbs" },
}
aliases["copular"] = "copulative"

labels["countable"] = {
	glossary = true,
	pos_categories = { "countable nouns" },
}

labels["deponent"] = {
	glossary = true,
	pos_categories = { "deponent verbs" },
}

labels["ditransitive"] = {
	glossary = true,
	pos_categories = { "ditransitive verbs" },
}

labels["dysphemistic"] = {
	Wikipedia = "Dysphemism",
	pos_categories = { "dysphemisms" },
}
aliases["dysphemism"] = "dysphemistic"

labels["by ellipsis"] = {
	display = "by [[ellipsis]]",
	pos_categories = { "ellipses" },
}

labels["emphatic"] = {
	glossary = true
}

labels["ergative"] = {
	glossary = true,
	pos_categories = { "ergative verbs" },
}

labels["by extension"] = {}
aliases["hence"] = "by extension"

labels["feminine"] = {
	glossary = true
}

labels["focus"] = {
	glossary = true,
	pos_categories = { "focus adverbs" },
}

labels["fractional"] = {
	pos_categories = { "fractional numbers" },
}
deprecated["fractional"] = true

labels["hedge"] = {
	glossary = true,
	pos_categories = { "hedges" },
}
aliases["hedges"] = "hedge"

labels["ideophonic"] = {
	glossary = true,
}
aliases["ideophone"] = "ideophonic"

labels["idiomatic"] = {
	glossary = true,
	pos_categories = { "idioms" },
}
aliases["idiom"] = "idiomatic"
aliases["idiomatically"] = "idiomatic"

labels["imperfect"] = {
	glossary = true,
}

labels["impersonal"] = {
	glossary = true,
	pos_categories = { "impersonal verbs" },
}

labels["in the singular"] = {
	display = "in the [[singular]]",
}
aliases["in singular"] = "in the singular"
aliases["singular"] = "in the singular"

labels["in the dual"] = {
	display = "in the [[dual]]",
}
aliases["in dual"] = "in the dual"
aliases["dual"] = "in the dual"

labels["in the plural"] = {
	display = "in the [[Appendix:Glossary#plural|plural]]",
}
aliases["in plural"] = "in the plural"
aliases["plural"] = "in the plural"

labels["in the mediopassive"] = {
	display = "in the [[mediopassive]]" }
aliases["in mediopassive"] = "in the mediopassive"
aliases["mediopassive"] = "in the mediopassive"

labels["inanimate"] = {
	glossary = true
}

aliases["indef"] = "indefinite"

labels["initialism"] = {
	display = "[[initialism]]",
	pos_categories = { "initialisms" },
}

labels["intransitive"] = {
	glossary = true,
	pos_categories = { "intransitive verbs" },
}

labels["IPA"] = {
	Wikipedia = "International Phonetic Alphabet",
	plain_categories = { "IPA symbols" },
}
aliases["International Phonetic Alphabet"] = "IPA"

labels["litotes"] = {
	glossary = true,
	pos_categories = { "litotes" },
}

labels["masculine"] = {
	glossary = true
}

labels["middle"] = {
	Wikipedia = "Voice (grammar)#Middle",
}
aliases["middle voice"] = "middle"
aliases["in the middle"] = "middle"
aliases["in the middle voice"] = "middle"

labels["mnemonic"] = {
	display = '[[mnemonic]]',
	pos_categories = { "mnemonics" },
}

labels["chiefly in the negative"] = {
	glossary = "negative polarity item",
	pos_categories = {"negative polarity items"},
}
aliases["negative polarity"] = "chiefly in the negative"
aliases["negative polarity item"] = "chiefly in the negative"
aliases["usually in the negative"] = "chiefly in the negative"

labels["neuter"] = {
	glossary = true
}

labels["not comparable"] = {
	display = "[[Appendix:Glossary#uncomparable|not comparable]]"
}
aliases["notcomp"] = "not comparable"
aliases["uncomparable"] = "not comparable"

labels["numeronym"] = {
	glossary = true,
	pos_categories = { "numeronyms" },
}

labels["onomatopoeia"] = {
	display = "[[onomatopoeia]]",
	pos_categories = { "onomatopoeias" },
}

labels["ordinal"] = {
	display = "[[ordinal number|ordinal]]",
	pos_categories = { "ordinal numbers" },
}
deprecated["ordinal"] = true

deprecated["plural"] = true
labels["perfect"] = { glossary = true, }

labels["participle"] = {
	glossary = true,
}

labels["passive"] = {
	Wikipedia = "Passive voice",
}
aliases["passive voice"] = "passive"
aliases["in the passive"] = "passive"

labels["perfect"] = {
	glossary = true,
}

labels["perfective"] = {
	glossary = true,
	pos_categories = { "perfective verbs" },
}

labels["plural only"] = {
	pos_categories = { "pluralia tantum" },
}
aliases["pluralonly"] = "plural only"
aliases["plurale tantum"] = "plural only"

labels["possessive pronoun"] = {
	display = "possessive",
	pos_categories = { "possessive pronouns" },
}

labels["postpositive"] = {
	glossary = true
}

labels["predicative"] = {
	display = "[[Appendix:Glossary#predicative|predicative]]",
}

labels["predicatively"] = {
	display = "[[Appendix:Glossary#predicative|predicatively]]",
}

labels["procedure word"] = {
	display = "[[procedure word]]"
}

labels["productive"] = {
	display = "[[productive]]"
}

-- TODO: This label is probably inappropriate for many languages
labels["pronominal"] = {
	display = "takes a [[Appendix:Glossary#reflexive|reflexive pronoun]]",
}

labels["pro-verb"] = {
	Wikipedia = true
}

labels["reciprocal"] = {
	display = "[[Appendix:Glossary#reciprocal|reciprocal]]",
	pos_categories = { "reciprocal verbs" },
}

labels["reflexive"] = {
	display = "[[Appendix:Glossary#reflexive|reflexive]]",
	pos_categories = { "reflexive verbs" },
}

labels["reflexive pronoun"] = {
	display = "[[Appendix:Glossary#reflexive|reflexive]]",
	pos_categories = { "reflexive pronouns" }
}

labels["relational"] = {
	display = "[[Appendix:Glossary#relational|relational]]",
	pos_categories = { "relational adjectives" },
}

labels["rhetorical question"] = {
	glossary = true,
	pos_categories = { "rhetorical questions" },
}

labels["set phrase"] = {
	display = "[[set phrase]]" }

labels["simile"] = {
	glossary = true,
	pos_categories = { "similes" },
}

deprecated["singular"] = true

labels["singular only"] = {
	display = "singular only",
	pos_categories = { "singularia tantum" },
}
aliases["singulare tantum"] = "singular only"
aliases["no plural"] = "singular only"

labels["snowclone"] = {
	glossary = true,
	pos_categories = { "snowclones" },
}

labels["stative"] = {
	Wikipedia = "stative verb",
	pos_categories = { "stative verbs" },
}
aliases["stative verb"] = "stative"

labels["strictly"] = {
	glossary = true
}
aliases["narrowly"] = "strictly"

labels["substantive"] = {
	track = true
}

labels["transitive"] = {
	glossary = true,
	pos_categories = { "transitive verbs" },
}

labels["unaccusative"] = {
	Wikipedia = "Unaccusative verb",
}

labels["uncountable"] = {
	glossary = true,
	pos_categories = { "uncountable nouns" },
}

labels["unergative"] = {
	Wikipedia = "Unergative verb",
}

labels["usually plural"] = {
	display = "usually in the [[plural]]",
}
aliases["usually in the plural"] = "usually plural"
aliases["usually in plural"] = "usually plural"
deprecated["usually plural"] = true
deprecated["usually in plural"] = true
deprecated["usually the plural"] = true


-- Usage labels

labels["ACG"] = {
	display = "[[ACG]]",
	-- see also "fandom slang"
	pos_categories = { "fandom slang" },
}

labels["advertising slang"] = {
	pos_categories = { "advertising slang" },
}
aliases["ad slang"] = "advertising slang"
aliases["cosmo"] = "advertising slang"

labels["endearing"] = {
	display = "[[endearing]]",
	-- should be "terms with X senses", leaving "X terms" to the term-context temp
	pos_categories = { "endearing terms" },
}
aliases["affectionate"] = "endearing"

labels["pre-classical"] = {
	display = "pre-Classical",
	regional_categories = { "Pre-classical" },
}
aliases["Pre-classical"] = "pre-classical"
aliases["pre-Classical"] = "pre-classical"
aliases["Pre-Classical"] = "pre-classical"
aliases["Preclassical"] = "pre-classical"
aliases["preclassical"] = "pre-classical"
aliases["ante-classical"] = "pre-classical"
aliases["Ante-classical"] = "pre-classical"
aliases["ante-Classical"] = "pre-classical"
aliases["Ante-Classical"] = "pre-classical"
aliases["Anteclassical"] = "pre-classical"
aliases["anteclassical"] = "pre-classical"

labels["archaic"] = {
	glossary = true,
	sense_categories = { "archaic" },
}

labels["Australian slang"] = {
	regional_categories = { "Australian" },
	plain_categories = { "Australian slang" },
}

labels["avoidance"] = {
	glossary = true
}

labels["back slang"] = {
	display = "[[Appendix:Glossary#backslang|back slang]]",
	pos_categories = { "back slang" },
}
aliases["backslang"] = "back slang"
aliases["back-slang"] = "back slang"

labels["Bargoens"] = {
	Wikipedia = true,
	plain_categories = { "Bargoens" },
}

labels["Braille"] = {
	Wikipedia = true,
}

labels["British slang"] = {
	plain_categories = { "British slang" },
}
aliases["UK slang"] = "British slang"

labels["buzzword"] = {
	display = "[[buzzword]]",
	pos_categories = { "buzzwords" },
}

labels["Cambridge University slang"] = {
	plain_categories = { "Cambridge University slang" },
}

labels["cant"] = {
	display = "[[cant]]",
	pos_categories = { "cant" },
}
aliases["argot"] = "cant"
aliases["cryptolect"] = "cant"

labels["capitalized"] = {
	display = "[[capitalisation|capitalized]]" 
}

labels["Castilianism"] = {
	display = "[[Castilianism]]" 
}
aliases["Hispanicism"] = "Castilianism"

labels["childish"] = {
	display = "[[childish]]",
	-- should be "terms with X senses", leaving "X terms" to the term-context temp?
	pos_categories = { "childish terms" },
}
aliases["baby talk"] = "childish"
aliases["child language"] = "childish"

labels["chu Nom"] = {
	display = "[[Vietnamese]] [[chữ Nôm]]",
	plain_categories = { "Vietnamese Han tu" },
}

labels["Classic 1811 Dictionary of the i Tongue"] = {
	display = "[[Appendix:Glossary#archaic|archaic]], [[Appendix:Glossary#slang|slang]]",
	plain_categories = { "Classic 1811 Dictionary of the Vulgar Tongue" },
}
aliases["1811"] = "Classic 1811 Dictionary of the Vulgar Tongue"

labels["Cockney rhyming slang"] = {
	display = "[[Cockney rhyming slang]]",
	plain_categories = { "Cockney rhyming slang" },
}

labels["colloquial"] = {
	glossary = true,
	pos_categories = { "informal terms" },
}
aliases["colloquially"] = "colloquial"

-- FIXME! The following two are apparently for Persian but probably don't belong in this file.
labels["colloquial-um"] = {
	glossary = "colloquial",
	pos_categories = { "colloquialisms containing sequence um" },
}

labels["colloquial-un"] = {
	glossary = "colloquial",
	pos_categories = { "colloquialisms containing sequence un" },
}

labels["costermongers"] = {
	display = "[[Appendix:Costermongers' back slang|costermongers]]",
	plain_categories = { "Costermongers' back slang" },
}
aliases["coster"] = "costermongers"
aliases["costers"] = "costermongers"
aliases["costermonger"] = "costermongers"
aliases["costermongers back slang"] = "costermongers"
aliases["costermongers' back slang"] = "costermongers"

labels["dated"] = {
	glossary = true,
	-- should be "terms with X senses", leaving "X terms" to the term-context temp
	pos_categories = { "dated terms" },
}

labels["dated form"] = {
	glossary = "dated",
	pos_categories = { "dated forms" },
}

labels["dated sense"] = {
	glossary = "dated",
	sense_categories = { "dated" },
} -- combine with previous?

labels["derogatory"] = {
	display = "[[derogatory]]",
	-- should be "terms with X senses", leaving "X terms" to the term-context temp
	pos_categories = { "derogatory terms" },
}
aliases["pejorative"] = "derogatory"
aliases["derogative"] = "derogatory"
aliases["disparaging"] = "derogatory"

labels["dialect"] = { -- separated from "dialectal" so e.g. "obsolete|outside|the|_|dialect|of..." displays right
	display = "[[Appendix:Glossary#dialectal|dialect]]",
	pos_categories = { "dialectal terms" },
}

labels["dialectal"] = {
	glossary = true,
	-- should be "terms with X senses", leaving "X terms" to the term-context temp
	pos_categories = { "dialectal terms" },
}

labels["dialects"] = { -- separated from "dialectal" so e.g. "obsolete|outside|dialects" displays right
	display = "[[Appendix:Glossary#dialectal|dialects]]",
	pos_categories = { "dialectal terms" },
}

labels["dismissal"] = {
	display = "[[dismissal]]",
	pos_categories = { "dismissals" },
}

labels["solemn"] = {
	glossary = true,
	pos_categories = { "solemn terms" },
}
aliases["elevated"] = "solemn"

labels["ethnic slur"] = {
	display = "[[ethnic]] [[slur]]",
	pos_categories = { "ethnic slurs" },
}
aliases["racial slur"] = "ethnic slur"

labels["euphemistic"] = {
	glossary = "euphemism",
	pos_categories = { "euphemisms" },
}
aliases["euphemism"] = "euphemistic"

labels["eye dialect"] = {
	display = "[[eye dialect]]",
	pos_categories = { "eye dialect" },
}

labels["familiar"] = {
	glossary = true,
	-- should be "terms with X senses", leaving "X terms" to the term-context temp?
	pos_categories = { "familiar terms" },
}

labels["fandom slang"] = {
	display = "[[fandom]] [[slang]]",
	pos_categories = { "fandom slang" },
}
aliases["fandom"] = "fandom slang"

labels["figuratively"] = {
	glossary = "figurative"
}
aliases["figurative"] = "figuratively"
aliases["metaphorically"] = "figuratively"
aliases["metaphorical"] = "figuratively"
aliases["metaphor"] = "figuratively"

labels["folk poetic"] = {
	-- should be "terms with X senses", leaving "X terms" to the term-context temp
	pos_categories = { "folk poetic terms", "poetic terms" },
}

labels["formal"] = {
	glossary = true,
	-- should be "terms with X senses", leaving "X terms" to the term-context temp?
	pos_categories = { "formal terms" },
}

labels["gay slang"] = {
	display = "[[gay]] [[slang]]",
	pos_categories = { "gay slang" },
}

labels["gender-neutral"] = {
	pos_categories = { "gender-neutral terms" },
	glossary = "epicene"
}

labels["hapax legomenon"] = {
	display = "hapax",
	pos_categories = { "hapax legomena" },
	glossary = true,
}
aliases["hapax"] = "hapax legomenon"

labels["historical"] = {
	glossary = true,
	sense_categories = { "historical" },
}
aliases["historic"] = "historical"
aliases["history"] = "historical"

labels["non-native speakers"] = { -- language-agnostic version
	display = "[[non-native speaker]]s", -- so preceded by "used by", "error by children and", etc? or reword?
	regional_categories = { "Non-native speakers'" },
}
aliases["NNS"] = "non-native speakers"

labels["non-native speakers' English"] = {
	display = "[[non-native speaker]]s' English",
	regional_categories = { "Non-native speakers'" },
}
aliases["NNES"] = "non-native speakers' English"
aliases["NNSE"] = "non-native speakers' English"

-- used exclusively by languages that use the “Jpan” script code
labels["historical hiragana"] = {
	pos_categories = { "historical hiragana" },
}

-- used exclusively by languages that use the “Jpan” script code
labels["historical katakana"] = {
	pos_categories = { "historical katakana" },
}

-- applies to Japanese and Korean, etc., please do not confuse with "polite"
labels["honorific"] = {
	Wikipedia = "Honorifics (linguistics)",
	-- should be "terms with X senses", leaving "X terms" to the term-context temp?
	pos_categories = { "honorific terms" },
}

-- for Ancient Greek
labels["Homeric epithet"] = {
	display = "[[Homeric Greek|Homeric]] [[w:Homeric epithets|epithet]]",
	plain_categories = { "Epic Greek" },
	omit_postComma = true,
}

-- applies to Japanese and Korean, etc.
labels["humble"] = {
	-- should be "terms with X senses", leaving "X terms" to the term-context temp?
	display = "[[humble]]",
	pos_categories = { "humble terms" },
}

labels["humorous"] = {
	-- should be "terms with X senses", leaving "X terms" to the term-context temp; NB and cf a similar "jocular" label further up on this page
	display = "[[humorous]]",
	pos_categories = { "jocular terms" },
}
aliases["jocular"] = "humorous"

labels["hyperbolic"] = {
	display = "[[Appendix:Glossary#hyperbolic|hyperbolic]]",
	pos_categories = { "hyperboles" },
}
aliases["hyperbole"] = "hyperbolic"

labels["hypercorrect"] = {
	glossary = true,
	pos_categories = { "hypercorrections" },
}

labels["hyperforeign"] = {
	glossary = true,
	pos_categories = { "hyperforeign terms" },
}

labels["informal"] = {
	glossary = true,
	-- should be "terms with X senses", leaving "X terms" to the term-context temp
	pos_categories = { "informal terms" },
}
aliases["informally"] = "informal"

labels["Internet slang"] = {
	display = "[[Internet]] [[slang]]",
	pos_categories = { "internet slang" },
}

aliases["internet slang"] = "Internet slang"

labels["IRC"] = {
	display = "[[IRC]]",
	pos_categories = { "internet slang" },
}

labels["ironic"] = {}

labels["leet"] = {
	display = "[[leetspeak]]",
	pos_categories = { "leet" },
}
aliases["leetspeak"] = "leet"

labels['literally'] = {
	glossary = "literally" 
}
aliases['literal'] = 'literally'

labels["literary"] = {
	-- should be "terms with X senses", leaving "X terms" to the term-context temp
	glossary = true,
	pos_categories = { "literary terms" },
}
aliases["bookish"] = "literary"

labels["loosely"] = {
	glossary = true
}

labels["Lubunyaca"] = {
	display = "[[Lubunyaca]]",
	pos_categories = { "Lubunyaca" },
}

labels["medical slang"] = {
	display = "[[medical]] [[slang]]",
	pos_categories = { "medical slang" },
}

-- for Awetí, Karajá, etc., where men and women use different words
labels["men's speech"] = {
	glossary = "men's speech",
	pos_categories = { "men's speech terms" },
}
aliases["male speech"] = "men's speech"

labels["metonymically"] = {
	glossary = true,
	pos_categories = { "metonyms" },
}
aliases["metonymic"] = "metonymically"
aliases["metonymy"] = "metonymically"
aliases["metonym"] = "metonymically"

labels["military slang"] = {
	display = "[[military]] [[slang]]",
	pos_categories = { "military slang" },
}

labels["minced oath"] = {
	display = "[[minced oath]]",
	pos_categories = { "euphemisms" },
}


labels["nativising coinage"] = {
	display = "[[w:Linguistic purism in Korean|nativising coinage]]",
	pos_categories = { "nativising coinages" },
}

labels["neologism"] = {
	glossary = true,
	pos_categories = { "neologisms" },
}
aliases["neologistic"] = "neologism"

labels["neopronoun"] = {
	display = "[[neopronoun]]",
--	pos_categories = { "neopronouns" },
}

labels["no longer productive"] = {
	display = "no longer [[Appendix:Glossary#productive|productive]]",
}

labels["nonce word"] = {
	-- should be "terms with X senses", leaving "X terms" to the term-context temp?
	display = "[[Appendix:Glossary#nonce word|nonce word]]",
	pos_categories = { "nonce terms" },
}
aliases["nonce"] = "nonce word"

labels["nonstandard"] = {
	glossary = true,
	-- should be "terms with X senses", leaving "X terms" to the term-context temp
	pos_categories = { "nonstandard terms" },
}
aliases["non-standard"] = "nonstandard"

labels["nonstandard form"] = {
	glossary = "nonstandard",
	pos_categories = { "nonstandard forms" },
}

labels["obsolete"] = {
	glossary = true,
	sense_categories = { "obsolete" },
}

labels["obsolete term"] = {
	glossary = "obsolete",
	-- combine with previous two, q.v.
	pos_categories = { "obsolete terms" },
}

labels["offensive"] = {
	display = "[[offensive]]",
	-- should be "terms with X senses", leaving "X terms" to the term-context temp
	pos_categories = { "offensive terms" },
}

labels["officialese"] = {
	display = "[[officialese]]",
	pos_categories = { "officialese terms" },
}

labels["Oxbridge slang"] = {
	display = "[[Oxbridge]] [[slang]]",
	plain_categories = { "Cambridge University slang", "Oxford University slang" },
}

labels["Oxford University slang"] = {
	plain_categories = { "Oxford University slang" },
}

labels["poetic"] = {
	-- should be "terms with X senses", leaving "X terms" to the term-context temp
	display = "[[poetic]]",
	pos_categories = { "poetic terms" },
}

labels["Polari"] = {
	display = "[[Polari]]",
	pos_categories = { "Polari slang" },
}

labels["polite"] = {
	pos_categories = { "polite terms" },
}

labels["post-classical"] = {
	display = "post-Classical",
	regional_categories = { "Post-classical" },
}
aliases["Post-classical"] = "post-classical"
aliases["post-Classical"] = "post-classical"
aliases["Post-Classical"] = "post-classical"
aliases["Postclassical"] = "post-classical"
aliases["postclassical"] = "post-classical"

labels["prison slang"] = {
	display = "[[prison]] [[slang]]",
	pos_categories = { "prison slang" },
}

labels["proscribed"] = {
	glossary = true,
	pos_categories = { "disputed terms" },
}

labels["radio slang"] = {
	display = "[[radio]] [[slang]]",
	pos_categories = { "radio slang" },
}

labels["rare"] = {
	display = "[[Appendix:Glossary#rare|rare]]",
	sense_categories = { "rare" },
}
aliases["rare sense"] = "rare"

labels["rare term"] = {
	display = "rare",
	-- see comments about "obsolete"
	pos_categories = { "rare terms" },
}

labels["religious slur"] = {
	display = "[[religious]] [[slur]]",
	pos_categories = { "religious slurs" },
}
aliases["sectarian slur"] = "religious slur"

labels["retronym"] = {
	glossary = true,
	pos_categories = { "retronyms" },
}

labels["reverential"] = {
	pos_categories = { "reverential terms" },
}

labels["sarcastic"] = {
	display = "[[sarcastic]]",
	pos_categories = { "sarcastic terms" },
}

labels["school slang"] = {
	display = "[[school]] [[slang]]",
	pos_categories = { "school slang" },
}
aliases["public school slang"] = "school slang"

labels["self-deprecatory"] = {
	display = "[[self-deprecatory]]",
	-- should be "terms with X senses", leaving "X terms" to the term-context temp?
	pos_categories = { "self-deprecatory terms" },
}
aliases["self-deprecating"] = "self-deprecatory"

labels["seong-eo"] = {
	display = "[[고사성어|set phrase from Classical Chinese]]",
	pos_categories = { "chengyu" },
}

labels["slang"] = {
	glossary = true,
	pos_categories = { "slang" },
}

labels["college slang"] = {
	display = "[[college]] [[slang]]",
	pos_categories = { "student slang" },
}
aliases["university slang"] = "college slang"
aliases["student slang"] = "college slang"

labels["swear word"] = {
	pos_categories = { "swear words" },
}
aliases["profanity"] = "swear word"
aliases["expletive"] = "swear word"

labels["text messaging"] = {
	display = "[[text messaging]]",
	pos_categories = { "text messaging slang" },
}
aliases["texting"] = "text messaging"

labels["thieves' cant"] = {
	Wikipedia = true,
	plain_categories = { "Thieves' cant" },
}
aliases["thieves cant"] = "thieves' cant"
aliases["thieves'"] = "thieves' cant"
aliases["thieves"] = "thieves' cant"

labels["trademark"] = {
	display = "[[trademark]]",
	pos_categories = { "trademarks" },
}

labels["transferred sense"] = {
	glossary = true,
	pos_categories = { "terms with transferred senses" },
}

labels["transferred senses"] = {
	display = "[[transferred sense#English|transferred senses]]",
	pos_categories = { "terms with transferred senses" },
}

labels["transgender slang"] = {
	display = "[[transgender]] [[slang]]",
	pos_categories = { "transgender slang" },
}

labels["Twitch-speak"] = {
	display = "[[Twitch-speak]]",
	pos_categories = { "Twitch-speak" },
}

labels["uds."] = {
	display = "[[Appendix:Spanish pronouns#Ustedes and vosotros|used formally in Spain]]" }

labels["uncommon"] = {
	sense_categories = { "uncommon" },
}

labels["verlan"] = {
	display = "[[Appendix:Glossary#verlan|verlan]]",
	plain_categories = { "Verlan" },
}

labels["very rare"] = {
	pos_categories = { "rare forms" },
}

labels["vulgar"] = {
	glossary = true,
	pos_categories = { "vulgarities" },
}
aliases["coarse"] = "vulgar"
aliases["obscene"] = "vulgar"
aliases["profane"] = "vulgar"

labels["vesre"] = {
	plain_categories = { "Vesre" },
}

labels["2channel slang"]={
	display ="[[w:2channel|2channel]] [[slang]]",
	pos_categories = { "internet slang" , "2channel slang" },
}

aliases["2ch slang"] = "2channel slang"

-- for Awetí, Karajá, etc., where men & women use different words
labels["women's speech"] = {
	glossary = "women's speech",
	pos_categories = { "women's speech terms" },
}
aliases["female speech"] = "women's speech"

-- swahili sheng cant / argot
labels["Sheng"] = {
	Wikipedia = "Sheng slang",
	plain_categories = { "Sheng" },
}

labels["example1"] = {
	Wikipedia = "Wu Chinese"
}

labels["example2"] = {
	glossary = "palatalization"
}


-- Regional labels
local m_regional = require("Module:labels/data/regional")

for key, val in pairs(m_regional.labels) do
	labels[key] = val
end

for key, val in pairs(m_regional.aliases) do
	aliases[key] = val
end

for key, val in pairs(m_regional.deprecated) do
	deprecated[key] = val
end


-- Topical labels

local m_topical = require("Module:labels/data/topical")

for key, val in pairs(m_topical.labels) do
	labels[key] = val
end

for key, val in pairs(m_topical.aliases) do
	aliases[key] = val
end

for key, val in pairs(m_topical.deprecated) do
	deprecated[key] = val
end

--[[	Add subvariety labels and the corresponding aliases
		and deprecated labels if they have a language code
		in the "languages" field.								]]
local m_subvarieties = require("Module:labels/data/subvarieties")

for key, val in pairs(m_subvarieties.labels) do
	if labels[key] then
		replacements.labels[key] = labels[key]
	end

	if val.languages then
		labels[key] = val
	end
end

for key, val in pairs(m_subvarieties.aliases) do
	if aliases[key] then
		replacements.aliases[key] = aliases[key]
	end

	if labels[val] then
		aliases[key] = val
	end
end

for key, val in pairs(m_subvarieties.deprecated) do
	if deprecated[key] then
		replacements.deprecated[key] = deprecated[key]
	end

	if labels[key] then
		deprecated[key] = val
	end
end

return {
	["labels"] = labels,
	["aliases"] = aliases,
	["deprecated"] = deprecated,
	["replacements"] = replacements,
}