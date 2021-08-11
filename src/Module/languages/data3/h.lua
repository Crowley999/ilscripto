local u = mw.ustring.char

-- UTF-8 encoded strings for some commonly used diacritics
local GRAVE     = u(0x0300)
local ACUTE     = u(0x0301)
local CIRC      = u(0x0302)
local TILDE     = u(0x0303)
local MACRON    = u(0x0304)
local BREVE     = u(0x0306)
local DOTABOVE  = u(0x0307)
local DIAER     = u(0x0308)
local CARON     = u(0x030C)
local DGRAVE    = u(0x030F)
local INVBREVE  = u(0x0311)
local DOTBELOW  = u(0x0323)
local RINGBELOW = u(0x0325)
local CEDILLA   = u(0x0327)

local Latn = {"Latn"}

local m = {}

m["haa"] = {
	"Hän",
	28272,
	"ath-nor",
	otherNames = {"Han", "Dawson", "Moosehide", "Han-Kutchin"},
	scripts = Latn,
}

m["hab"] = {
	"Hanoi Sign Language",
	12632107,
	"sgn",
	scripts = Latn, -- when documented
}

m["hac"] = {
	"Gurani",
	33733,
	"ira-zgr",
	otherNames = {"Gorani", "Avromani", "Awroman", "Awromani", "Hawramani", "Hawrami", "Hewrami", "Hourami", "Howrami", "Ourami"},
	scripts = {"ku-Arab"},
	translit_module = "ckb-translit",
}

m["had"] = {
	"Hatam",
	56825,
	"paa-wpa",
}

m["haf"] = {
	"Haiphong Sign Language",
	39868240,
	"sgn",
}

m["hag"] = {
	"Hanga",
	35426,
	"nic-dag",
	scripts = Latn,
}

m["hah"] = {
	"Hahon",
	3125730,
	"poz-ocw",
	scripts = Latn,
}

m["hai"] = {
	"Haida",
	33303,
	"qfa-iso",
	scripts = Latn,
}

m["haj"] = {
	"Hajong",
	3350576,
	"qfa-mix",
	scripts = {"as-Beng", "Latn"},
	ancestors = {"inc-oas", "tbq-pro"},
}

m["hak"] = {
	"Hakka",
	33375,
	"zhx",
	scripts = {"Hani"},
	ancestors = {"ltc"},
}

m["hal"] = {
	"Halang",
	56307,
	"mkh",
}

m["ham"] = {
	"Hewa",
	5748345,
	"paa-spk",
}

m["hao"] = {
	"Hakö",
	3125871,
	"poz-ocw",
	scripts = Latn,
}

m["hap"] = {
	"Hupla",
	5946223,
	"ngf",
}

m["har"] = {
	"Harari",
	33626,
	"sem-eth",
	scripts = {"Ethi"},
	translit_module = "Ethi-translit",
}

m["has"] = {
	"Haisla",
	3107399,
	"wak",
}

m["hav"] = {
	"Havu",
	5684097,
	"bnt-shh",
	scripts = Latn,
}

m["haw"] = {
	"Hawaiian",
	33569,
	"poz-pep",
	scripts = Latn,
	sort_key = {
		from = {"ā", "ē", "ī", "ō", "ū" },
		to   = {"a", "e", "i", "o", "u" }} ,
}

m["hax"] = {
	"Southern Haida",
	12953543,
	"qfa-iso",
	ancestors = {"hai"},
}

m["hay"] = {
	"Haya",
	35756,
	"bnt-haj",
}

m["haz"] = {
	"Hazaragi",
	33398,
	"ira-swi",
}

m["hba"] = {
	"Hamba",
	11028905,
	"bnt-tet",
}

m["hbb"] = {
	"Huba",
	56290,
	"cdc-cbm",
	otherNames = {"Kilba"},
}

m["hbn"] = {
	"Heiban",
	35523,
	"alv-hei",
}

m["hbu"] = {
	"Habu",
	1567033,
	"poz-cet",
	scripts = Latn,
}

m["hca"] = {
	"Andaman Creole Hindi",
	7599417,
	"crp",
	ancestors = {"hi", "bn", "ta"},
}

m["hch"] = {
	"Huichol",
	35575,
	"azc",
	scripts = Latn,
}

m["hdn"] = {
	"Northern Haida",
	20054484,
	"qfa-iso",
	ancestors = {"hai"},
}

m["hds"] = {
	"Honduras Sign Language",
	3915496,
	"sgn",
	otherNames = {"Honduran Sign Language"},
	scripts = Latn, -- when documented
}

m["hdy"] = {
	"Hadiyya",
	56613,
	"cus",
}

m["hea"] = {
	"Northern Qiandong Miao",
	3138832,
	"hmn",
	otherNames = {"Black Miao"},
}

m["hed"] = {
	"Herdé",
	56253,
	"cdc-mas",
}

m["heg"] = {
	"Helong",
	35432,
	"poz-tim",
	scripts = Latn,
}

m["heh"] = {
	"Hehe",
	3129390,
	"bnt-bki",
	scripts = Latn,
}

m["hei"] = {
	"Heiltsuk",
	5699507,
	"wak",
}

m["hem"] = {
	"Hemba",
	5711209,
	"bnt-lbn",
}

m["hgm"] = {
	"Haiǁom",
	4494781,
	"khi-khk",
	scripts = Latn,
}

m["hgw"] = {
	"Haigwai",
	5639108,
	"poz-ocw",
	scripts = Latn,
}

m["hhi"] = {
	"Hoia Hoia",
	5877767,
	"ngf",
}

m["hhr"] = {
	"Kerak",
	11010783,
	"alv-jfe",
}

m["hhy"] = {
	"Hoyahoya",
	nil,
	"ngf",
}

m["hia"] = {
	"Lamang",
	35700,
	"cdc-cbm",
	scripts = Latn,
}

m["hib"] = {
	"Hibito",
	3135164,
}

m["hid"] = {
	"Hidatsa",
	3135234,
	"sio-mor",
	scripts = Latn,
}

m["hif"] = {
	"Fiji Hindi",
	46728,
	"inc-hie",
	scripts = Latn,
	ancestors = {"awa"},
}

m["hig"] = {
	"Kamwe",
	56271,
	"cdc-cbm",
	otherNames = {"Higgi", "Higi"},
}

m["hih"] = {
	"Pamosu",
	12953011,
	"ngf-mad",
}

m["hii"] = {
	"Hinduri",
	5766763,
	"him",
}

m["hij"] = {
	"Hijuk",
	35274,
	"bnt-bsa",
}

m["hik"] = {
	"Seit-Kaitetu",
	7446989,
	"poz-cma",
}

m["hil"] = {
	"Hiligaynon",
	35978,
	"phi",
	scripts = Latn,
	entry_name = {
		from = {"Á", "á", "É", "é", "Í", "í", "Ó", "ó", "Ú", "ú", MACRON},
		to   = {"A", "a", "E", "e", "I", "i", "O", "o", "U", "u"}} ,
}

m["hio"] = {
	"Tshwa",
	963636,
	"khi-kal",
	otherNames = {"Tsoa", "Kua", "Cua", "Hiechware", "Cirecire", "Cire-cire", "Cire-Cire", "Cire Cire"},
}

m["hir"] = {
	"Himarimã",
	5765127,
}

m["hit"] = {
	"Hittite",
	35668,
	"ine-ana",
	aliases = {"Hettite", "Kanesite", "Kaneshite", "Kanesian", "Kaneshian", "Nesian", "Neshian", "Nesite", "Nessite", "Neshite"},
	scripts = {"Xsux"},
}

m["hiw"] = {
	"Hiw",
	3138713,
	"poz-vnc",
	scripts = Latn,
}

m["hix"] = {
	"Hixkaryana",
	56522,
	"sai-car",
	otherNames = {"Hixkaryána"},
	scripts = Latn,
}

m["hji"] = {
	"Haji",
	5639933,
	"poz-mly",
}

m["hka"] = {
	"Kahe",
	3892562,
	"bnt-chg",
	scripts = Latn,
}

m["hke"] = {
	"Hunde",
	3065432,
	"bnt-shh",
	scripts = Latn,
}

m["hkk"] = {
	"Hunjara-Kaina Ke",
	nil,
	"ngf",
}

m["hkn"] = {
	"Mel-Khaonh",
	nil,
	"mkh-ban",
	otherNames = {"Mel", "Khaonh"},
}

m["hks"] = {
	"Hong Kong Sign Language",
	17038844,
	"sgn",
}

m["hla"] = {
	"Halia",
	3125959,
	"poz-ocw",
	scripts = Latn,
}

m["hlb"] = {
	"Halbi",
	3695692,
	"inc-eas",
	scripts = {"Deva", "Orya"},
	ancestors = {"inc-mgd"},
}

m["hld"] = {
	"Halang Doan",
	3914632,
	"mkh-ban",
	otherNames = {"Duan", "Doan"},
}

m["hle"] = {
	"Hlersu",
	5873537,
	"tbq-lol",
	otherNames = {"Sansu"},
}

m["hlt"] = {
	"Nga La",
	12952942,
	"tbq-kuk",
	otherNames = {"Matu Chin", "Matu"},
}

m["hma"] = {
	"Southern Mashan Hmong",
	12953560,
	"hmn",
	otherNames = {"Southern Mashan Miao"},
}

m["hmb"] = {
	"Humburi Senni",
	35486,
	"son",
	otherNames = {"Central Songhay"},
}

m["hmc"] = {
	"Central Huishui Hmong",
	12953558,
	"hmn",
	otherNames = {"Central Huishui Miao"},
}

m["hmd"] = {
	"A-Hmao",
	1108934,
	"hmn",
	otherNames = {"A Hmao", "Big Flowery Miao", "Large Flowery Miao"},
	scripts = {"Latn", "Plrd"},
}

m["hme"] = {
	"Eastern Huishui Hmong",
	12953559,
	"hmn",
	otherNames = {"Eastern Huishui Miao"},
}

m["hmf"] = {
	"Hmong Don",
	22911602,
	"hmn",
}

m["hmg"] = {
	"Southwestern Guiyang Hmong",
	27478542,
	"hmn",
}

m["hmh"] = {
	"Southwestern Huishui Hmong",
	12953565,
	"hmn",
	otherNames = {"Southwestern Huishui Miao"},
}

m["hmi"] = {
	"Northern Huishui Hmong",
	27434946,
	"hmn",
	otherNames = {"Northern Huishui Miao"},
}

m["hmj"] = {
	"Ge",
	11251864,
	"hmn",
	otherNames = {"Gedou Miao"},
}

m["hmk"] = {
	"Maek",
	8050724,
	"qfa-kor",
	otherNames = {"Ye-Maek", "Yemaek"},
}

m["hml"] = {
	"Luopohe Hmong",
	14468943,
	"hmn",
}

m["hmm"] = {
	"Central Mashan Hmong",
	12953561,
	"hmn",
	otherNames = {"Central Mashan Miao"},
}

m["hmp"] = {
	"Northern Mashan Hmong",
	12953564,
	"hmn",
	otherNames = {"Northern Mashan Miao"},
}

m["hmq"] = {
	"Eastern Qiandong Miao",
	27431369,
	"hmn",
	otherNames = {"Black Miao"},
}

m["hmr"] = {
	"Hmar",
	2992841,
	"tbq-kuk",
	ancestors = {"lus"},
}

m["hms"] = {
	"Southern Qiandong Miao",
	12953562,
	"hmn",
	otherNames = {"Black Miao"},
}

m["hmt"] = {
	"Hamtai",
	5646436,
	"ngf",
	otherNames = {"Kapau"},
}

m["hmu"] = {
	"Hamap",
	12952484,
	"qfa-tap",
}

m["hmv"] = {
	"Hmong Dô",
	22911598,
	"hmn",
	otherNames = {"Hmong Do"},
}

m["hmw"] = {
	"Western Mashan Hmong",
	12953563,
	"hmn",
	otherNames = {"Western Mashan Miao"},
}

m["hmy"] = {
	"Southern Guiyang Hmong",
	12953553,
	"hmn",
}

m["hmz"] = {
	"Hmong Shua",
	25559603,
	"hmn",
	otherNames = {"Hmong Sua"},
}

m["hna"] = {
	"Mina",
	56532,
	"cdc-cbm",
	otherNames = {"Mina (Cameroon)", "Hina", "Besleri"},
}

m["hnd"] = {
	"Southern Hindko",
	382273,
	"inc-pan",
	ancestors = {"lah"},
}

m["hne"] = {
	"Chhattisgarhi",
	33158,
	"inc-hie",
	scripts = {"Deva"},
	ancestors = {"inc-pra"},
}

m["hnh"] = {
	"ǁAni",
	3832982,
	"khi-kal",
	scripts = {"Latinx"},
}

m["hni"] = {
	"Hani",
	56516,
	"tbq-lol",
}

m["hnj"] = {
	"Green Hmong",
	3138831,
	"hmn",
	otherNames = {"Hmong Njua", "Hmong Leng", "Mong Leng", "Green Miao", "Blue Hmong"},
	scripts = {"Latn", "Hmng"},
}

m["hnn"] = {
	"Hanunoo",
	35435,
	"phi",
	otherNames = {"Hanuno'o"},
	scripts = {"Hano", "Latn"},
}

m["hno"] = {
	"Northern Hindko",
	6346358,
	"inc-pan",
	otherNames = {"Kagani", "Hazara Hindko", "Hindki of Hazara"},
	scripts = {"Arab"},
	ancestors = {"lah"},
}

m["hns"] = {
	"Caribbean Hindustani",
	1843468,
	"inc-hie",
	otherNames = {"Caribbean Bhojpuri"},
	ancestors = {"bho"},
}

m["hnu"] = {
	"Hung",
	12632753,
	"mkh-vie",
}

m["hoa"] = {
	"Hoava",
	3138887,
	"poz-ocw",
	scripts = Latn,
}

m["hob"] = {
	"Austronesian Mari",
	6760941,
	"poz-ocw",
	otherNames = {"Mari (Madang Province)", "Hop"},
	scripts = Latn,
}

m["hoc"] = {
	"Ho",
	33270,
	"mun",
	scripts = {"Wara", "Orya", "Deva", "Latn"},
}

m["hod"] = {
	"Holma",
	56331,
	"cdc-cbm",
	scripts = Latn,
}

m["hoe"] = {
	"Horom",
	3914008,
	"nic-ple",
	scripts = Latn,
}

m["hoh"] = {
	"Hobyót",
	33299,
	"sem-sar",
	scripts = {"Arab", "Latn"},
}

m["hoi"] = {
	"Holikachuk",
	28508,
	"ath-nor",
	scripts = Latn,
}

m["hoj"] = {
	"Hadothi",
	33227,
	"inc-wes",
	otherNames = {"Harauti"},
	ancestors = {"mwr"},
}

m["hol"] = {
	"Holu",
	4121133,
	"bnt-pen",
	scripts = Latn,
}

m["hom"] = {
	"Homa",
	3449953,
	"bnt-boa",
	scripts = Latn,
}

m["hoo"] = {
	"Holoholo",
	3139484,
	"bnt-tkm",
	scripts = Latn,
}

m["hop"] = {
	"Hopi",
	56421,
	"azc",
	otherNames = {"Moqui"},
	scripts = Latn,
}

m["hor"] = {
	"Horo",
	641748,
	"csu-sar",
}

m["hos"] = {
	"Ho Chi Minh City Sign Language",
	16111971,
	"sgn",
	scripts = Latn, -- when documented
}

m["hot"] = {
	"Hote",
	12632404,
	"poz-ocw",
	scripts = Latn,
}

m["hov"] = {
	"Hovongan",
	5917269,
	"poz",
}

m["how"] = {
	"Honi",
	56842,
	"tbq-lol",
	otherNames = {"Haoni", "Baihong", "Hao-Bai", "Ho"},
}

m["hoy"] = {
	"Holiya",
	5880707,
	"dra",
}

m["hoz"] = {
	"Hozo",
	5923010,
	"omv-mao",
}

m["hpo"] = {
	"Hpon",
	5923277,
	"tbq-brm",
}

m["hps"] = {
	"Hawai'i Pidgin Sign Language",
	33358,
	"sgn",
	otherNames = {"Hawaiian Sign Language", "Hula", "Hawaii Sign Language"},
	scripts = Latn, -- when documented
}

m["hra"] = {
	"Hrangkhol",
	5923435,
	"tbq-kuk",
}

m["hrc"] = {
	"Niwer Mil",
	nil,
	"poz-oce",
	otherNames = {"Tangga"}, -- this variety of Tangga macrolanguage is on Tangga island
	scripts = Latn,
}

m["hre"] = {
	"Hre",
	3915794,
	"mkh-nbn",
	otherNames = {"Hrê"},
}

m["hrk"] = {
	"Haruku",
	5675762,
	"poz-cma",
}

m["hrm"] = {
	"Horned Miao",
	nil,
	"hmn",
}

m["hro"] = {
	"Haroi",
	3127568,
	"cmc",
	scripts = Latn,
}

m["hrp"] = {
	"Nhirrpi",
	32571318,
	"aus-kar",
}

m["hrt"] = {
	"Hértevin",
	33290,
	"sem-nna",
	scripts = Latn,
}

m["hru"] = {
	"Hruso",
	5923933,
	"sit-hrs",
}

m["hrw"] = {
	"Warwar Feni",
	nil,
	"poz-oce",
	otherNames = {"Feni"},
	scripts = Latn,
}

m["hrx"] = {
	"Hunsrik",
	304049,
	"gmw",
	otherNames = {"Riograndenser Hunsrückisch"},
	scripts = Latn,
	ancestors = {"gmw-cfr"},
}

m["hrz"] = {
	"Harzani",
	56464,
	"xme-ttc",
	otherNames = {"Harzandi"},
	ancestors = {"xme-ttc-nor"},
}

m["hsb"] = {
	"Upper Sorbian",
	13248,
	"wen",
	aliases = {"Upper Lusatian", "Upper Wendish"},
	scripts = Latn,
	sort_key = {
		from = {"č",  "ć",   "ě",  "ch", "ł",  "ń",  "ó", "ř",  "š",  "ž",  "ź"    },
		to   = {"c~", "c~~", "e~", "h~", "l`", "n~", "o", "r~", "s~", "z~", "z~~" }} , --the digraph ch comes after h; ł comes before l
}

m["hsh"] = {
	"Hungarian Sign Language",
	13636869,
	"sgn",
	scripts = Latn, -- when documented
}

m["hsl"] = {
	"Hausa Sign Language",
	3915462,
	"sgn",
	scripts = Latn, -- when documented
}

m["hsn"] = {
	"Xiang",
	13220,
	"zhx",
	scripts = {"Hani"},
	ancestors = {"ltc"},
}

m["hss"] = {
	"Harsusi",
	33423,
	"sem-sar",
	scripts = {"Arab", "Latn"},
}

m["hti"] = {
	"Hoti",
	5912372,
	"poz-cma",
	scripts = Latn,
}

m["hto"] = {
	"Minica Huitoto",
	948514,
	"sai-wit",
	otherNames = {"Minica", "Minica Witoto"},
	scripts = Latn,
}

m["hts"] = {
	"Hadza",
	33411,
	"qfa-iso",
	scripts = Latn,
}

m["htu"] = {
	"Hitu",
	5872700,
	"poz-cma",
	scripts = Latn,
}

m["hub"] = {
	"Huambisa",
	1526037,
	"sai-jiv",
	otherNames = {"Huambiza", "Wambisa"},
	scripts = Latn,
}

m["huc"] = {
	"ǂHoan",
	2053913,
	"khi-kxa",
	otherNames = {"ǂ’Amkoe", "ǂHȍã", "ǂHȍȁn"},
	scripts = {"Latinx"},
}

m["hud"] = {
	"Huaulu",
	12952504,
	"poz-cma",
	scripts = Latn,
}

m["huf"] = {
	"Humene",
	11732231,
	"ngf",
	scripts = Latn,
}

m["hug"] = {
	"Huachipaeri",
	3446617,
	"sai-har",
	scripts = Latn,
}

m["huh"] = {
	"Huilliche",
	35531,
	"sai-ara",
	scripts = Latn,
}

m["hui"] = {
	"Huli",
	3125121,
	"paa-eng",
	scripts = Latn,
}

m["huj"] = {
	"Northern Guiyang Hmong",
	12953554,
	"hmn",
}

m["huk"] = {
	"Hulung",
	12952505,
	"poz-cet",
}

m["hul"] = {
	"Hula",
	6382179,
	"poz-ocw",
	scripts = Latn,
}

m["hum"] = {
	"Hungana",
	10975396,
	"bnt-yak",
}

m["huo"] = {
	"Hu",
	3141783,
	"mkh-pal",
}

m["hup"] = {
	"Hupa",
	28058,
	"ath-pco",
	scripts = Latn,
}

m["huq"] = {
	"Tsat",
	34133,
	"cmc",
	otherNames = {"Hainan Cham", "Hui", "Huihui", "Sanya Hui", "Utsat", "Utset"},
}

m["hur"] = {
	"Halkomelem",
	35388,
	"sal",
	scripts = Latn,
}

m["hus"] = {
	"Wastek",
	35573,
	"myn",
	otherNames = {"Huastek", "Huasteka", "Huasteque", "Huaxteca", "Huaxteco", "Huaxteque", "Huastecan"},
	scripts = Latn,
}

m["huu"] = {
	"Murui Huitoto",
	2640935,
	"sai-wit",
	otherNames = {"Murui", "Murui Witoto"},
	scripts = Latn,
}

m["huv"] = {
	"Huave",
	12954031,
	"qfa-iso",
	otherNames = {"San Mateo del Mar Huave", "San Dionisio del Mar Huave", "Santa María del Mar Huave", "San Francisco del Mar Huave"},
	scripts = Latn,
}

m["huw"] = {
	"Hukumina",
	3142988,
	"poz-cma",
	otherNames = {"Palumata"},
	scripts = Latn,
}

m["hux"] = {
	"Nüpode Huitoto",
	56333,
	"sai-wit",
	otherNames = {"Nüpode", "Nüpode Witoto"},
	scripts = Latn,
}

m["huy"] = {
	"Hulaulá",
	33426,
	"sem-nna",
}

m["huz"] = {
	"Hunzib",
	56564,
	"cau-tsz",
	scripts = {"Cyrl"},
	translit_module = "huz-translit",
	entry_name = {
		from = {ACUTE},
		to   = {}},
}

m["hvc"] = {
	"Haitian Vodoun Culture Language",
	3504239,
	"crp",
	otherNames = {"Langaj", "Langay"},
	scripts = Latn,
}

m["hvk"] = {
	"Haveke",
	5683513,
	"poz-cln",
	scripts = Latn,
}

m["hvn"] = {
	"Sabu",
	3128792,
	"poz-cet",
	otherNames = {"Savu"},
	scripts = Latn,
}

m["hwa"] = {
	"Wané",
	3914887,
	"kro-ekr",
	scripts = Latn,
}

m["hwc"] = {
	"Hawaiian Creole",
	35602,
	"crp",
	otherNames = {"Hawaiian Creole English", "Hawai'ian Creole English", "Hawaiian Pidgin", "Hawai'ian Creole"},
	scripts = Latn,
}

m["hwo"] = {
	"Hwana",
	56498,
	"cdc-cbm",
	scripts = Latn,
}

m["hya"] = {
	"Hya",
	56798,
	"cdc-cbm",
	scripts = Latn,
}

return m