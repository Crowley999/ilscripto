local u = mw.ustring.char

-- UTF-8 encoded strings for some commonly-used diacritics
local GRAVE		= u(0x0300)
local ACUTE		= u(0x0301)
local CIRC		= u(0x0302)
local TILDE		= u(0x0303)
local MACRON	= u(0x0304)
local BREVE		= u(0x0306)
local DOTABOVE	= u(0x0307)
local DIAER		= u(0x0308)
local CARON		= u(0x030C)
local DGRAVE	= u(0x030F)
local INVBREVE	= u(0x0311)
local DOTBELOW	= u(0x0323)
local RINGBELOW	= u(0x0325)
local CEDILLA	= u(0x0327)

local Latn = {"Latn"}

local m = {}

m["aav-khs-pro"] = { 
	"Proto-Khasian",
	nil,
	"aav-khs",
	aliases = {"Proto-Khasic"},
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["aav-nic-pro"] = { 
	"Proto-Nicobarese",
	nil,
	"aav-nic",
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["aav-pkl-pro"] = { 
	"Proto-Pnar-Khasi-Lyngngam",
	nil,
	"aav-pkl",
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["aav-pro"] = { --The mkh-pro will merge into this.
	"Proto-Austroasiatic",
	nil,
	"aav",
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["afa-pro"] = {
	"Proto-Afroasiatic",
	269125,
	"afa",
	aliases = {"Proto-Afro-Asiatic", "Hamito-Semitic"},
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["alg-aga"] = {
	"Agawam",
	nil,
	"alg-eas",
	aliases = {"Agwam", "Agaam"},
	scripts = Latn,
}

m["alg-pro"] = {
	"Proto-Algonquian",
	7251834,
	"alg",
	type = "reconstructed",
	scripts = {"Latinx"},
	sort_key = {
		from = {"·"},
		to   = {""}},
}

m["alv-ama"] = {
	"Amasi",
	4740400,
	"nic-grs",
	scripts = Latn,
	entry_name = {
		from = {"[àáâãā]", "[èéêē]", "[ìíîī]", "[òóôõō]", "[ùúûũū]", GRAVE, ACUTE, CIRC, TILDE, MACRON},
		to   = {"a",       "e",      "i",      "o",       "u"}},
}

m["alv-bgu"] = {
	"Baïnounk Gubëeher",
	17002646,
	"alv-bny",
	otherNames = {"Gubëeher", "Nyun Gubëeher", "Nun Gubëeher"},
	scripts = Latn,
}

m["alv-bua-pro"] = {
	"Proto-Bua",
	nil,
	"alv-bua",
	type = "reconstructed",
	scripts = Latn,
}

m["alv-cng-pro"] = {
	"Proto-Cangin",
	nil,
	"alv-cng",
	type = "reconstructed",
	scripts = Latn,
}

m["alv-edo-pro"] = {
	"Proto-Edoid",
	nil,
	"alv-edo",
	type = "reconstructed",
	scripts = Latn,
}

m["alv-fli-pro"] = {
	"Proto-Fali",
	nil,
	"alv-fli",
	type = "reconstructed",
	scripts = Latn,
}

m["alv-gbe-pro"] = {
	"Proto-Gbe",
	nil,
	"alv-gbe",
	type = "reconstructed",
	scripts = Latn,
}

m["alv-gng-pro"] = {
	"Proto-Guang",
	nil,
	"alv-gng",
	type = "reconstructed",
	scripts = Latn,
}

m["alv-gtm-pro"] = {
	"Proto-Central Togo",
	nil,
	"alv-gtm",
	aliases = {"Proto-Ghana-Togo Mountain"},
	type = "reconstructed",
	scripts = Latn,
}

m["alv-gwa"] = {
	"Gwara",
	16945580,
	"nic-pla",
	scripts = Latn,
}

m["alv-hei-pro"] = {
	"Proto-Heiban",
	nil,
	"alv-hei",
	type = "reconstructed",
	scripts = Latn,
}

m["alv-igb-pro"] = {
	"Proto-Igboid",
	nil,
	"alv-igb",
	type = "reconstructed",
	scripts = Latn,
}

m["alv-kwa-pro"] = {
	"Proto-Kwa",
	nil,
	"alv-kwa",
	type = "reconstructed",
	scripts = Latn,
}

m["alv-mum-pro"] = {
	"Proto-Mumuye",
	nil,
	"alv-mum",
	type = "reconstructed",
	scripts = Latn,
}

m["alv-nup-pro"] = {
	"Proto-Nupoid",
	nil,
	"alv-nup",
	type = "reconstructed",
	scripts = Latn,
}

m["alv-pro"] = {
	"Proto-Atlantic-Congo",
	nil,
	"alv",
	type = "reconstructed",
	scripts = Latn,
}

m["alv-yor-pro"] = {
	"Proto-Yoruboid",
	nil,
	"alv-yor",
	type = "reconstructed",
	scripts = Latn,
}

m["apa-pro"] = {
	"Proto-Apachean",
	nil,
	"apa",
	otherNames = {"Proto-Apache", "Proto-Southern Athabaskan"},
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["aql-pro"] = {
	"Proto-Algic",
	18389588,
	"aql",
	type = "reconstructed",
	scripts = {"Latinx"},
	sort_key = {
		from = {"·"},
		to   = {""}},
}

m["art-blk"] = {
	"Bolak",
	2909283,
	"art",
	type = "appendix-constructed",
	scripts = Latn,
}

m["art-bsp"] = {
	"Black Speech",
	686210,
	"art",
	type = "appendix-constructed",
	scripts = {"Latn", "Teng"},
}

m["art-com"] = {
	"Communicationssprache",
	35227,
	"art",
	type = "appendix-constructed",
	scripts = Latn,
}

m["art-dtk"] = {
	"Dothraki",
	2914733,
	"art",
	type = "appendix-constructed",
	scripts = Latn,
}

m["art-elo"] = {
	"Eloi",
	nil,
	"art",
	type = "appendix-constructed",
	scripts = Latn,
}

m["art-gld"] = {
	"Goa'uld",
	19823,
	"art",
	type = "appendix-constructed",
	scripts = {"Latn", "Egyp", "Mero"},
}

m["art-lap"] = {
	"Lapine",
	6488195,
	"art",
	type = "appendix-constructed",
	scripts = Latn,
}

m["art-man"] = {
	"Mandalorian",
	54289,
	"art",
	type = "appendix-constructed",
	scripts = Latn,
}

m["art-mun"] = {
	"Mundolinco",
	851355,
	"art",
	type = "appendix-constructed",
	scripts = Latn,
}

m["art-nav"] = {
	"Na'vi",
	316939,
	"art",
	type = "appendix-constructed",
	scripts = Latn,
}

m["art-nox"] = {
	"Noxilo",
	nil,
	"art",
	type = "appendix-constructed",
	scripts = Latn,
}

m["art-top"] = {
	"Toki Pona",
	36846,
	"art",
	type = "appendix-constructed",
	scripts = Latn,
}

m["art-una"] = {
	"Unas",
	nil,
	"art",
	type = "appendix-constructed",
	scripts = Latn,
}

m["ath-nic"] = {
	"Nicola",
	20609,
	"ath-nor",
	scripts = Latn,
}

m["ath-pro"] = {
	"Proto-Athabaskan",
	nil,
	"ath",
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["auf-pro"] = {
	"Proto-Arawa",
	nil,
	"auf",
	aliases = {"Proto-Arawan", "Proto-Arauan"},
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["aus-alu"] = {
	"Alungul",
	16827670,
	"aus-pmn",
	otherNames = {"Ogh-Alungul", "Alngula"},
	scripts = Latn,
}

m["aus-and"] = {
	"Andjingith",
	4754509,
	"aus-pmn",
	aliases = {"Adithinngithigh"},
	scripts = Latn,
}

m["aus-ang"] = {
	"Angkula",
	16828520,
	"aus-pmn",
	otherNames = {"Ogh-Anggula", "Anggula", "Ogh-Anggul", "Anggul"},
	scripts = Latn,
}

m["aus-arn-pro"] = {
	"Proto-Arnhem",
	nil,
	"aus-arn",
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["aus-bra"] = {
	"Barranbinya",
	4863220,
	"aus-pmn",
	aliases = {"Barranbinja", "Baranbinya", "Burranbinya", "Burrumbiniya", "Burrunbinya", "Barrumbinya", "Barren-binya", "Parran-binye"},
	scripts = Latn,
}

m["aus-brm"] = {
	"Barunggam",
	4865914,
	"aus-pmn",
	scripts = Latn,
}

m["aus-cww-pro"] = {
	"Proto-Central New South Wales",
	nil,
	"aus-cww",
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["aus-dal-pro"] = {
	"Proto-Daly",
	nil,
	"aus-dal",
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["aus-guw"] = {
	"Guwar",
	6652138,
	"aus-pam",
	otherNames = {"Gowar", "Goowar", "Gooar", "Guar", "Gowr-burra", "Ngugi", "Mugee", "Wogee", "Gnoogee", "Chunchiburri", "Booroo-geen-merrie"},
	scripts = Latn,
}

m["aus-lsw"] = {
	"Little Swanport",
	6652138,
	aliases = {"Little Swanport Tasmanian"},
	scripts = Latn,
}

m["aus-mbi"] = {
	"Mbiywom",
	6799701,
	"aus-pmn",
	otherNames = {"Mbeiwum"},
	scripts = Latn,
}

m["aus-ngk"] = {
	"Ngkoth",
	7022405,
	"aus-pmn",
	otherNames = {"Ngkot", "Nggoth"},
	scripts = Latn,
}

m["aus-nyu-pro"] = {
	"Proto-Nyulnyulan",
	nil,
	"aus-nyu",
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["aus-pam-pro"] = {
	"Proto-Pama-Nyungan",
	33942,
	"aus-pam",
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["aus-tul"] = {
	"Tulua",
	16938541,
	"aus-pam",
	otherNames = {"Dappil", "Dapil", "Toolooa", "Dulua", "Narung", "Dandan"},
	scripts = Latn,
}

m["aus-uwi"] = {
	"Uwinymil",
	7903995,
	"aus-arn",
	otherNames = {"Uwinjmil"},
	scripts = Latn,
}

m["aus-wdj-pro"] = {
	"Proto-Iwaidjan",
	nil,
	"aus-wdj",
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["aus-won"] = {
	"Wong-gie",
	nil,
	"aus-pam",
	scripts = Latn,
}

m["aus-wul"] = {
	"Wulguru",
	8039196,
	"aus-dyb",
	otherNames = {"Manbara", "Wulgurugaba", "Wulgurukaba", "Nhawalgaba"},
	scripts = Latn,
}

m["aus-ynk"] = { -- contrast nny
	"Yangkaal",
	3913770,
	"aus-tnk",
	scripts = Latn,
}

m["awd-amc-pro"] = {
	"Proto-Amuesha-Chamicuro",
	nil,
	"awd",
	otherNames = {"Western Maipuran"},
	scripts = Latn,
	type = "reconstructed",
	ancestors = {"awd-pro"},
}

m["awd-kmp-pro"] = {
	"Proto-Kampa",
	nil,
	"awd",
	otherNames = {"Campa", "Kampan", "Campan", "Pre-Andine Maipurean"},
	scripts = Latn,
	type = "reconstructed",
	ancestors = {"awd-pro"},
}

m["awd-prw-pro"] = {
	"Proto-Paresi-Waura",
	nil,
	"awd",
	otherNames = {"Paresí-Waurá", "Parecí–Xingú", "Paresí–Xingu", "Central Arawak", "Central Maipurean"},
	scripts = Latn,
	type = "reconstructed",
	ancestors = {"awd-pro"},
}

m["awd-ama"] = {
	"Amarizana",
	16827787,
	"awd",
	scripts = Latn,
}

m["awd-ana"] = {
	"Anauyá",
	16828252,
	"awd",
	aliases = {"Anauya"},
	scripts = Latn,
}

m["awd-apo"] = {
	"Apolista",
	16916645,
	"awd",
	otherNames = {"Lapachu"},
	scripts = Latn,
}

m["awd-cav"] = {
	"Cavere",
	nil,
	"awd",
	aliases = {"Cabre", "Cabere", "Cávere"},
	scripts = Latn,
}

m["awd-gnu"] = {
	"Guinau",
	3504087,
	"awd",
	otherNames = {"Guinao", "Inao", "Guniare", "Quinhau", "Guiano"},
	scripts = Latn,
}

m["awd-kar"] = {
	"Cariay",
	16920253,
	"awd",
	aliases = {"Kariaí", "Kariai", "Cariyai", "Carihiahy"},
	scripts = Latn,
}

m["awd-kaw"] = {
	"Kawishana",
	6379993,
	"awd-nwk",
	aliases = {"Cawishana", "Cayuishana", "Kaishana", "Cauixana"},
	scripts = Latn,
}

m["awd-kus"] = {
	"Kustenau",
	5196293,
	"awd",
	aliases = {"Kustenaú", "Custenau", "Kutenabu"},
	scripts = Latn,
}

m["awd-man"] = {
	"Manao",
	6746920,
	"awd",
	scripts = Latn,
}

m["awd-mar"] = {
	"Marawan",
	6755108,
	"awd",
	aliases = {"Marawán"},
	scripts = Latn,
}

m["awd-mpr"] = {
	"Maypure",
	nil,
	"awd",
	aliases = {"Maipure"},
	scripts = Latn,
}

m["awd-mrt"] = {
	"Mariaté",
	16910017,
	"awd-nwk",
	aliases = {"Mariate"},
	scripts = Latn,
}

m["awd-nwk-pro"] = {
	"Proto-Nawiki",
	nil,
	"awd-nwk",
	aliases = {"Proto-Newiki"},
	type = "reconstructed",
	scripts = Latn,
}

m["awd-pai"] = {
	"Paikoneka",
	nil,
	"awd",
	aliases = {"Paiconeca", "Paicone"},
	scripts = Latn,
}

m["awd-pas"] = {
	"Passé",
	nil,
	"awd-nwk",
	aliases = {"Pasé", "Pazé"},
	scripts = Latn,
}

m["awd-pro"] = {
	"Proto-Arawak",
	nil,
	"awd",
	otherNames = {"Proto-Arawakan", "Proto-Maipurean", "Proto-Maipuran"},
	type = "reconstructed",
	scripts = Latn,
}

m["awd-she"] = {
	"Shebayo",
	7492248,
	"awd",
	aliases = {"Shebaya", "Shebaye"},
	scripts = Latn,
}

m["awd-taa-pro"] = {
	"Proto-Ta-Arawak",
	nil,
	"awd-taa",
	otherNames = {"Proto-Ta-Arawakan", "Proto-Caribbean Northern Arawak"},
	type = "reconstructed",
	scripts = Latn,
}

m["awd-wai"] = {
	"Wainumá",
	16910017,
	"awd-nwk",
	otherNames = {"Wainuma", "Wai", "Waima", "Wainumi", "Wainambí", "Waiwana", "Waipi", "Yanuma"},
	scripts = Latn,
}

m["awd-yum"] = {
	"Yumana",
	8061062,
	"awd-nwk",
	aliases = {"Jumana"},
	scripts = Latn,
}

m["azc-caz"] = {
	"Cazcan",
	5055514,
	"azc",
	aliases = {"Caxcan", "Kaskán"},
	scripts = Latn,
}

m["azc-cup-pro"] = {
	"Proto-Cupan",
	nil,
	"azc-cup",
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["azc-ktn"] = {
	"Kitanemuk",
	3197558,
	"azc-tak",
	aliases = {"Gitanemuk"},
	scripts = Latn,
}

m["azc-nah-pro"] = {
	"Proto-Nahuan",
	7251860,
	"azc-nah",
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["azc-num-pro"] = {
	"Proto-Numic",
	nil,
	"azc-num",
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["azc-pro"] = {
	"Proto-Uto-Aztecan",
	96400333,
	"azc",
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["azc-tak-pro"] = {
	"Proto-Takic",
	nil,
	"azc-tak",
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["azc-tat"] = {
	"Tataviam",
	743736,
	"azc",
	scripts = Latn,
}

m["ber-pro"] = {
	"Proto-Berber",
	2855698,
	"ber",
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["ber-fog"] = {
	"Fogaha",
	107610173,
	"ber",
	otherNames = {"El-Fogaha", "El-Foqaha", "Foqaha", "Fuqaha"},
	scripts = Latn,
}

m["bnt-bal"] = {
	"Balong",
	93935237,
	"bnt-bbo",
	scripts = Latn,
}

m["bnt-bon"] = {
	"Boma Nkuu",
	nil,
	"bnt",
	scripts = Latn,
}

m["bnt-boy"] = {
	"Boma Yumu",
	nil,
	"bnt",
	scripts = Latn,
}

m["bnt-cmw"] = {
	"Chimwiini",
	4958328,
	"bnt-swh",
	otherNames = {"Bravanese", "Mwiini", "Mwini", "Chimwini", "Chimini", "Brava"},
	scripts = Latn,
}

m["bnt-ind"] = {
	"Indanga",
	51412803,
	"bnt",
	otherNames = {"Kɔlɔmɔnyi", "Kɔlɛ", "Kasaï Oriental"},
	scripts = Latn,
}

m["bnt-lal"] = {
	"Lala (South Africa)",
	6480154,
	"bnt-ngu",
	scripts = Latn,
}

m["bnt-lwl"] = {
	"Lwel",
	93936908,
	"bnt-bdz",
	otherNames = {"Lwal", "Kelwer"},
	scripts = Latn,
}

m["bnt-mpi"] = {
	"Mpiin",
	93937013,
	"bnt-bdz",
	scripts = Latn,
}

m["bnt-mpu"] = {
	"Mpuono", --not to be confused with Mbuun zmp
	36056,
	"bnt",
	scripts = Latn,
}

m["bnt-ngu-pro"] = {
	"Proto-Nguni",
	961559,
	"bnt-ngu",
	type = "reconstructed",
	scripts = {"Latinx"},
	sort_key = {
		from = {"[àáâǎ]", "[èéêě]", "[ìíîǐ]", "[òóôǒ]", "[ùúûǔ]", "ḿ", "[ǹńň]", ACUTE, GRAVE, CIRC, CARON},
		to   = {"a"     , "e"     , "i"     , "o"     , "u"     , "m", "n"    }
	},
}

m["bnt-phu"] = {
	"Phuthi",
	33796,
	"bnt-ngu",
	aliases = {"Siphuthi"},
	scripts = Latn,
	entry_name = {
		from = {"[àá]", "[èé]", "[ìí]", "[òó]", "[ùú]", "ḿ", "[ǹń]", ACUTE, GRAVE},
		to   = {"a"   , "e"   , "i"   , "o"   , "u"   , "m", "n"   }},
}

m["bnt-pro"] = {
	"Proto-Bantu",
	3408025,
	"bnt",
	type = "reconstructed",
	scripts = {"Latinx"},
	sort_key = {
		from = {"[àá]", "[èé]", "[ìí]", "[òó]", "[ùú]", "[ǹń]", "ɪ" , "ʊ" , ACUTE, GRAVE},
		to   = {"a"   , "e"   , "i2"  , "o"   , "u2"  , "n"   , "i1", "u1"}
	},
}

m["bnt-sbo"] = {
	"South Boma",
	nil,
	"bnt",
	scripts = Latn,
}

m["bnt-sts-pro"] = {
	"Proto-Sotho-Tswana",
	nil,
	"bnt-sts",
	type = "reconstructed",
	scripts = Latn,
}

m["btk-pro"] = {
	"Proto-Batak",
	nil,
	"btk",
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["cau-abz-pro"] = {
	"Proto-Abkhaz-Abaza",
	7251831,
	"cau-abz",
	otherNames = {"Proto-Abazgi", "Proto-Abkhaz-Tapanta"},
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["cau-ava-pro"] = {
	"Proto-Avaro-Andian",
	nil,
	"cau-ava",
	aliases = {"Proto-Avar-Andian", "Proto-Avar-Andi", "Proto-Avar-Andic", "Proto-Andian"},
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["cau-cir-pro"] = {
	"Proto-Circassian",
	7251838,
	"cau-cir",
	otherNames = {"Proto-Adyghe-Kabardian", "Proto-Adyghe-Circassian"},
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["cau-drg-pro"] = {
	"Proto-Dargwa",
	nil,
	"cau-drg",
	otherNames = {"Proto-Dargin"},
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["cau-lzg-pro"] = {
	"Proto-Lezghian",
	nil,
	"cau-lzg",
	aliases = {"Proto-Lezgi", "Proto-Lezgian", "Proto-Lezgic"},
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["cau-nec-pro"] = {
	"Proto-Northeast Caucasian",
	nil,
	"cau-nec",
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["cau-nkh-pro"] = {
	"Proto-Nakh",
	nil,
	"cau-nkh",
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["cau-nwc-pro"] = {
	"Proto-Northwest Caucasian",
	7251861,
	"cau-nwc",
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["cau-tsz-pro"] = {
	"Proto-Tsezian",
	nil,
	"cau-tsz",
	otherNames = {"Proto-Tsezic", "Proto-Didoic"},
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["cba-ata"] = {
	"Atanques",
	4812783,
	"cba",
	otherNames = {"Atanque", "Cancuamo", "Kankuamo", "Kankwe", "Kankuí", "Atanke"},
	scripts = Latn,
}

m["cba-cat"] = {
	"Catío Chibcha",
	7083619,
	"cba",
	otherNames = {"Catio Chibcha", "Old Catio"},
	scripts = Latn,
}

m["cba-dor"] = {
	"Dorasque",
	5297532,
	"cba",
	otherNames = {"Chumulu", "Changuena", "Changuina", "Chánguena", "Gualaca"},
	scripts = Latn,
}

m["cba-dui"] = {
	"Duit",
	3041061,
	"cba",
	scripts = Latn,
}

m["cba-hue"] = {
	"Huetar",
	35514,
	"cba",
	otherNames = {"Güetar", "Guetar", "Brusela"},
	scripts = Latn,
}

m["cba-nut"] = {
	"Nutabe",
	7070405,
	"cba",
	otherNames = {"Nutabane"},
	scripts = Latn,
}

m["cba-pro"] = {
	"Proto-Chibchan",
	nil,
	"cba",
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["ccn-pro"] = {
	"Proto-North Caucasian",
	nil,
	"ccn",
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["ccs-pro"] = {
	"Proto-Kartvelian",
	2608203,
	"ccs",
	type = "reconstructed",
	scripts = {"Latinx"},
	entry_name = {
		from = {"q̣", "p̣", "ʓ", "ċ"},
		to   = {"q̇", "ṗ", "ʒ", "c̣"}},
}

m["ccs-gzn-pro"] = {
	"Proto-Georgian-Zan",
	23808119,
	"ccs-gzn",
	aliases = {"Proto-Karto-Zan"},
	type = "reconstructed",
	scripts = {"Latinx"},
	entry_name = {
		from = {"q̣", "p̣", "ʓ", "ċ"},
		to   = {"q̇", "ṗ", "ʒ", "c̣"}},
}

m["cdc-cbm-pro"] = {
	"Proto-Central Chadic",
	nil,
	"cdc-cbm",
	otherNames = {"Proto-Central-Chadic", "Proto-Biu-Mandara"},
	type = "reconstructed",
	scripts = Latn,
}

m["cdc-mas-pro"] = {
	"Proto-Masa",
	nil,
	"cdc-mas",
	type = "reconstructed",
	scripts = Latn,
}

m["cdc-pro"] = {
	"Proto-Chadic",
	nil,
	"cdc",
	type = "reconstructed",
	scripts = Latn,
}

m["cdd-pro"] = {
	"Proto-Caddoan",
	nil,
	"cdd",
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["cel-bry-pro"] = {
	"Proto-Brythonic",
	156877,
	"cel-bry",
	aliases = {"Proto-Brittonic"},
	scripts = {"Latinx", "Grek"},
	sort_key = {
		from = {"[ββ̃]", "ð",  "ė", "ɣ",  "ɨ", "[ọö]", "[ʉü]", "θ"},
		to   = {"b¯",   "d¯", "e", "g¯", "i", "o",    "u",    "t¯"}},
}

m["cel-gal"] = {
	"Gallaecian",
	3094789,
	"cel",
}

m["cel-gau"] = {
	"Gaulish",
	29977,
	"cel",
	entry_name = {remove_diacritics = MACRON .. BREVE .. DIAER},
	scripts = {"Latn", "Grek", "Ital"},
}

m["cel-pro"] = {
	"Proto-Celtic",
	653649,
	"cel",
	type = "reconstructed",
	scripts = {"Latinx"},
	sort_key = {
		from = {"ā", "ē", "[ɸφ]", "ī", "ū", "ʷ"},
		to   = {"a", "e", "f",    "i", "u", "¯w"}},
}

m["chi-pro"] = {
	"Proto-Chimakuan",
	nil,
	"chi",
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["cmc-pro"] = {
	"Proto-Chamic",
	nil,
	"cmc",
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["cpe-mar"] = {
	"Maroon Spirit Language",
	1093206,
	"crp",
	otherNames = {"Jamaican Maroon Spirit Possession Language"},
	scripts = Latn,
	ancestors = {"en"},
}

m["cpe-spp"] = {
	"Samoan Plantation Pidgin",
	7409948,
	"crp",
	scripts = Latn,
	ancestors = {"en"},
}

m["crp-gep"] = {
	"West Greenlandic Pidgin",
	17036301,
	"crp",
	aliases = {"Greenlandic Pidgin", "Greenlandic Eskimo Pidgin"},
	scripts = Latn,
	ancestors = {"kl"},
}

m["crp-mpp"] = {
	"Macau Pidgin Portuguese",
	nil,
	"crp",
	scripts = {"Hani", "Latn"},
	ancestors = {"pt"},
}

m["crp-rsn"] = {
	"Russenorsk",
	505125,
	"crp",
	scripts = {"Cyrl", "Latn"},
	ancestors = {"no", "ru"},
}

m["crp-tpr"] = {
	"Taimyr Pidgin Russian",
	16930506,
	"crp",
	scripts = {"Cyrl"},
	ancestors = {"ru"},
}

m["csu-bba-pro"] = {
	"Proto-Bongo-Bagirmi",
	nil,
	"csu-bba",
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["csu-maa-pro"] = {
	"Proto-Mangbetu",
	nil,
	"csu-maa",
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["csu-pro"] = {
	"Proto-Central Sudanic",
	nil,
	"csu",
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["csu-sar-pro"] = {
	"Proto-Sara",
	nil,
	"csu-sar",
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["ctp-san"] = {
	"San Juan Quiahije Chatino",
	nil,
	"omq-cha",
	scripts = {"Latinx"},
}

m["cus-ash"] = {
	"Ashraaf",
	4805855,
	"cus",
	otherNames = {"Ashraf", "Af-Ashraaf"},
	varieties = { {"Marka, Lower Shabelle"}, "Shingani"},
	scripts = {"Latn"},
}

m["cus-pro"] = {
	"Proto-Cushitic",
	nil,
	"cus",
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["dmn-dam"] = {
	"Dama (Sierra Leone)",
	19601574,
	"dmn",
	scripts = {"Latn"},
}

m["dra-mkn"] = {
	"Middle Kannada",
	nil,
	"dra",
	aliases = {"Nadugannada"},
	scripts = {"Knda"},
	ancestors = {"dra-okn"},
	translit_module = "kn-translit",
}

m["dra-okn"] = {
	"Old Kannada",
	15723156,
	"dra",
	aliases = {"Halegannada"},
	scripts = {"Knda"},
	ancestors = {"dra-pro"},
	translit_module = "kn-translit",
}

m["dra-pro"] = {
	"Proto-Dravidian",
	1702853,
	"dra",
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["egx-dem"] = {
	"Demotic",
	36765,
	"egx",
	aliases = {"Demotic Egyptian", "Enchorial"},
	scripts = {"Latinx", "Egyd"},
	ancestors = {"egy"},
	sort_key = {
		from = {"ṱ", "t"},
		to   = {"h̭" , "ḫ"}},
}

m["elu-prk"] = {
	"Helu",
	15080869,
	"inc-mid",
	aliases = {"Hela", "Elu Prakrit", "Helu Prakrit", "Hela Prakrit", "Eḷu"},
	scripts = {"Brah"},
	ancestors = {"inc-pra"},
}

m["dmn-pro"] = {
	"Proto-Mande",
	nil,
	"dmn",
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["dmn-mdw-pro"] = {
	"Proto-Western Mande",
	nil,
	"dmn-mdw",
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["dru-pro"] = {
	"Proto-Rukai",
	nil,
	"map",
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["esx-esk-pro"] = {
	"Proto-Eskimo",
	7251842,
	"esx-esk",
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["esx-ink"] = {
	"Inuktun",
	1671647,
	"esx-inu",
	scripts = Latn,
}

m["esx-inq"] = {
	"Inuinnaqtun",
	28070,
	"esx-inu",
	scripts = Latn,
}

m["esx-inu-pro"] = {
	"Proto-Inuit",
	nil,
	"esx-inu",
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["esx-pro"] = {
	"Proto-Eskimo-Aleut",
	7251843,
	"esx",
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["esx-tut"] = {
	"Tunumiisut",
	15665389,
	"esx-inu",
	scripts = Latn,
}

m["euq-pro"] = {
	"Proto-Basque",
	938011,
	"euq",
	aliases = {"Proto-Vasconic"},
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["fiu-fin-pro"] = {
	"Proto-Finnic",
	11883720,
	"fiu-fin",
	type = "reconstructed",
	scripts = Latn,
}

m["gem-bur"] = {
	"Burgundian",
	nil,
	"gme",
	aliases = {"Burgundish", "Burgundic"},
	scripts = Latn,
}

m["gem-pro"] = {
	"Proto-Germanic",
	669623,
	"gem",
	aliases = {"Common Germanic"},
	type = "reconstructed",
	scripts = {"Latinx"},
	sort_key = {
		from = {"ā", "[ēê]", "ī", "[ōô]", "ū", "ą" , "į" , "ǫ" , "ų" , CIRC, MACRON},
		to   = {"a" , "e"  , "i", "o"   , "u", "an", "in", "on", "un"}},
}

m["gme-cgo"] = {
	"Crimean Gothic",
	36211,
	"gme",
	scripts = Latn,
}

m["gmq-bot"] = {
	"Westrobothnian",
	7989641,
	"gmq",
	scripts = Latn,
	ancestors = {"non"},
}

m["gmq-gut"] = {
	"Gutnish",
	1256646,
	"gmq",
	scripts = Latn,
	ancestors = {"non"},
}

m["gmq-jmk"] = {
	"Jamtish",
	nil,
	"gmq",
	aliases = {"Jamtlandic"},
	scripts = Latn,
	ancestors = {"non"},
}

m["gmq-mno"] = {
	"Middle Norwegian",
	3417070,
	"gmq",
	scripts = Latn,
	ancestors = {"non"},
}

-- Used for both gmq-oda (Old Danish) and gmq-osw (Old Swedish).
-- Ensure any changes are appropriate for both languages, or copy to each
-- language's table before making any changes.
local gmq_oda_entry_name = {
	from = {"Ā", "ā", "Ē", "ē", "Ī", "ī", "Ō", "ō", "Ū", "ū", "Ȳ", "ȳ", "Ǣ", "ǣ", MACRON},
	to   = {"A", "a", "E", "e", "I", "i", "O", "o", "U", "u", "Y", "y", "Æ", "æ"}}

m["gmq-oda"] = {
	"Old Danish",
	nil,
	"gmq",
	scripts = Latn,
	ancestors = {"non"},
	entry_name = gmq_oda_entry_name,
}

m["gmq-osw"] = {
	"Old Swedish",
	2417210,
	"gmq",
	scripts = Latn,
	ancestors = {"non"},
	entry_name = gmq_oda_entry_name,
}

m["gmq-pro"] = {
	"Proto-Norse",
	1671294,
	"gmq",
	aliases = {"Proto-Scandinavian", "Primitive Norse", "Proto-Nordic",
		"Ancient Nordic", "Ancient Scandinavian", "Old Nordic", "Old Scandinavian",
		"Proto-North Germanic", "North Proto-Germanic", "Common Scandinavian"},
	scripts = {"Runr"},
	translit_module = "Runr-translit",
}

m["gmq-scy"] = {
	"Scanian",
	768017,
	"gmq",
	scripts = Latn,
	ancestors = {"non"},
}

m["gmw-cfr"] = {
	"Central Franconian",
	nil,
	"gmw",
	otherNames = {"Mittelfränkisch", "Ripuarian", "Moselle Franconian", "Colognian", "Kölsch"},
	scripts = Latn,
	ancestors = {"gmh"},
	wikimedia_codes = {"ksh"},
}

m["gmw-ecg"] = {
	"East Central German",
	499344, -- subsumes Q699284, Q152965
	"gmw",
	otherNames = {"Thuringian", "Thüringisch", "Upper Saxon", "Upper Saxon German", "Obersächsisch", "Lusatian", "Erzgebirgisch", "Silesian", "Silesian German", "High Prussian"},
	scripts = Latn,
	ancestors = {"gmh"},
}

m["gmw-gts"] = {
	"Gottscheerish",
	533109,
	"gmw",
	aliases = {"Gottscheerisch"},
	scripts = Latn,
	ancestors = {"bar"},
}

m["gmw-jdt"] = {
	"Jersey Dutch",
	1687911,
	"gmw",
	scripts = Latn,
	ancestors = {"nl"},
}

m["gmw-pro"] = {
	"Proto-West Germanic",
	78079021,
	"gmw",
	type = "reconstructed",
	scripts = {"Latinx"},
	sort_key = {
		from = {"[āą]", "ē", "[īį]", "ō", "[ūų]", "ʀ", MACRON},
		to   = {"a"   , "e", "i"   , "o", "u", "r"}
	},
}

m["gmw-rfr"] = {
	"Rhine Franconian",
	707007,
	"gmw",
	otherNames = {"Rheinfränkisch", "Rhenish Franconian", "Hessian", "Lorraine Franconian", "Lorrainian", "Lothringisch", "Palatine German", "Pfälzisch", "Pälzisch", "Palatinate German"},
	scripts = Latn,
	ancestors = {"gmh"},
}

m["gmw-stm"] = {
	"Sathmar Swabian",
	2223059,
	"gmw",
	aliases = {"Satu Mare Swabian", "Sathmarschwäbisch", "Sathmarisch"},
	scripts = Latn,
	ancestors = {"swg"},
}

m["gmw-tsx"] = {
	"Transylvanian Saxon",
	260942,
	"gmw",
	otherNames = {"Siebenbürger Saxon"},
	scripts = Latn,
	ancestors = {"gmw-cfr"},
}

m["gmw-vog"] = {
	"Volga German",
	312574,
	"gmw",
	scripts = Latn,
	ancestors = {"gmw-rfr"},
}

m["gmw-zps"] = {
	"Zipser German",
	205548,
	"gmw",
	otherNames = {"Zipser", "Zipserisch", "Outzäpsersch"},
	scripts = Latn,
	ancestors = {"gmh"},
}

m["grk-cal"] = {
	"Calabrian Greek",
	1146398,
	"grk",
	otherNames = {"Italian Greek", "Bova"},
	scripts = Latn,
	ancestors = {"grc"},
}

m["grk-ita"] = {
	"Italiot Greek",
	nil,
	"grk",
	otherNames = {"Griko", "Grico", "Grecanic"},
	scripts = {"Latn", "Grek"},
	ancestors = {"grc"},
}

m["grk-mar"] = {
	"Mariupol Greek",
	4400023,
	"grk",
	aliases = {"Mariupolitan Greek", "Rumeíka", "Rumeika"},
	scripts = {"Cyrl", "Latn", "Grek"},
	ancestors = {"grc"},
	entry_name = {
		from = {ACUTE},
		to   = {}} ,
}

m["grk-pro"] = {
	"Proto-Hellenic",
	aliases = {"Proto-Greek"},
	1231805,
	"grk",
	type = "reconstructed",
	scripts = {"Latinx"},
	sort_key = {
		from = {"[áā]", "[éēḗ]", "[íī]", "[óōṓ]", "[úū]", "ď", "ľ", "ň", "ř", "ʰ", "ʷ", ACUTE, MACRON},
		to   = {"a"   , "e"	, "i"   , "o"	, "u"   , "d", "l", "n", "r", "¯h", "¯w"}},
}

m["hmn-pro"] = {
	"Proto-Hmong",
	nil,
	"hmn",
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["hmx-mie-pro"] = {
	"Proto-Mien",
	nil,
	"hmx-mie",
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["hmx-pro"] = {
	"Proto-Hmong-Mien",
	7251846,
	"hmx",
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["hyx-pro"] = {
	"Proto-Armenian",
	3848498,
	"hyx",
	type = "reconstructed",
	scripts = Latn,
}

m["iir-nur-pro"] = {
	"Proto-Nuristani",
	nil,
	"iir-nur",
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["iir-pro"] = {
	"Proto-Indo-Iranian",
	966439,
	"iir",
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["ijo-pro"] = {
	"Proto-Ijoid",
	nil,
	"ijo",
	type = "reconstructed",
	otherNames = {"Proto-Ijaw"},
	scripts = {"Latinx"},
}

m["inc-ash"] = {
	"Ashokan Prakrit",
	nil,
	"inc-mid",
	scripts = {"Brah", "Khar"},
	ancestors = {"sa"},
	translit_module = "translit-redirect",
}

m["inc-gup"] = {
	"Gurjar Apabhramsa",
	nil,
	"inc-wes",
	scripts = {"Deva"},
	ancestors = {"psu"},
}

m["inc-kam"] = {
	"Kamarupi Prakrit",
	6356097,
	"inc-mid",
	scripts = {"Brah", "Sidd"},
	ancestors = {"inc-mgd"},
}

m["inc-kha"] = {
	"Khasa Prakrit",
	nil,
	"inc-nor",
	scripts = {"Latn"},
	ancestors = {"inc-pra"},
}

m["inc-kho"] = {
	"Kholosi",
	24952008,
	"inc-snd",
	scripts = {"Latn"},
	ancestors = {"inc-vra"},
}

m["inc-mas"] = {
	"Middle Assamese",
	nil,
	"inc-eas",
	scripts = {"as-Beng"},
	ancestors = {"inc-oas"},
	translit_module = "inc-mas-translit",
}

m["inc-mbn"] = {
	"Middle Bengali",
	nil,
	"inc-eas",
	scripts = {"Beng"},
	ancestors = {"inc-obn"},
	translit_module = "inc-mbn-translit",
}

m["inc-mgd"] = {
	"Magadhi Prakrit",
	2652214,
	"inc-mid",
	scripts = {"Brah"},
	ancestors = {"inc-pra"},
	translit_module = "Brah-translit",
}

m["inc-mgu"] = {
	"Middle Gujarati",
	24907429,
	"inc-wes",
	scripts = {"Deva"},
	ancestors = {"inc-ogu"},
}

m["inc-mor"] = {
	"Middle Oriya",
	nil,
	"inc-eas",
	scripts = {"Orya"},
	ancestors = {"inc-oor"},
}

m["inc-oas"] = {
	"Early Assamese",
	nil,
	"inc-eas",
	scripts = {"as-Beng"},
	ancestors = {"inc-kam"},
	translit_module = "inc-oas-translit",
}

m["inc-obn"] = {
	"Old Bengali",
	nil,
	"inc-eas",
	scripts = {"Beng"},
	ancestors = {"inc-mgd"},
}

m["inc-ogu"] = {
	"Old Gujarati",
	24907427,
	"inc-wes",
	otherNames = {"Old Western Rajasthani"},
	scripts = {"Deva"},
	ancestors = {"inc-gup"},
	translit_module = "sa-translit",
}

m["inc-ohi"] = {
	"Old Hindi",
	48767781,
	"inc-hiw",
	scripts = {"Deva"},
	ancestors = {"inc-sap"},
	translit_module = "sa-translit",
}

m["inc-oor"] = {
	"Old Oriya",
	nil,
	"inc-eas",
	scripts = {"Orya"},
	ancestors = {"inc-mgd"},
}

m["inc-opa"] = {
	"Old Punjabi",
	nil,
	"inc-pan",
	scripts = {"Guru", "pa-Arab"},
	ancestors = {"inc-tak"},
	translit_module = "translit-redirect",
	entry_name = {
		from = {u(0x064B), u(0x064C), u(0x064D), u(0x064E), u(0x064F), u(0x0650), u(0x0651), u(0x0652)},
		to   = {}} ,
}

m["inc-ork"] = {
	"Old Kamta",
	nil,
	"inc-eas",
	scripts = {"as-Beng"},
	ancestors = {"inc-kam"},
	translit_module = "as-translit",
}

m["inc-pra"] = {
	"Prakrit",
	192170,
	"inc-mid",
	scripts = {"Brah", "Deva", "Knda"},
	ancestors = {"inc-ash"},
	translit_module = "translit-redirect",
}

m["inc-pro"] = {
	"Proto-Indo-Aryan",
	23808344,
	"inc",
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["inc-psc"] = {
	"Paisaci Prakrit",
	2995607,
	"inc-mid",
	scripts = {"Brah"},
	ancestors = {"inc-ash"},
	translit_module = "Brah-translit",
}

m["inc-sap"] = {
	"Sauraseni Apabhramsa",
	nil,
	"inc-cen",
	scripts = {"Deva"},
	ancestors = {"psu"},
}

m["inc-tak"] = {
	"Takka Apabhramsa",
	nil,
	"inc-pan",
	scripts = {"Deva"},
	ancestors = {"inc-pra"},
	translit_module = "sa-translit",
}

m["inc-vra"] = {
	"Vracada Apabhramsa",
	nil,
	"inc-snd",
	scripts = {"Deva"},
	ancestors = {"inc-pra"},
	translit_module = "sa-translit",
}

m["inc-dar-pro"] = {
	"Proto-Dardic",
	nil,
	"inc-dar",
	otherNames = {"Proto-Rigvedic"},
	type = "reconstructed",
	scripts = {"Latinx"},
	ancestors = {"sa"}, -- to be specific "an unattested Old Indo-Aryan dialect"
}

m["inc-cen-pro"] = {
	"Proto-Central Indo-Aryan",
	nil,
	"inc-cen",
	type = "reconstructed",
	scripts = {"Latinx"},
	ancestors = {"psu"},
}

m["inc-dar-pro"] = {
	"Proto-Dardic",
	nil,
	"inc-dar",
	otherNames = {"Proto-Rigvedic"},
	type = "reconstructed",
	scripts = {"Latinx"},
	ancestors = {"sa"},
}

m["ine-ana-pro"] = {
	"Proto-Anatolian",
	7251833,
	"ine-ana",
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["ine-bsl-pro"] = {
	"Proto-Balto-Slavic",
	1703347,
	"ine-bsl",
	type = "reconstructed",
	scripts = {"Latinx"},
	sort_key = {
		from = {"[áā]", "[éēḗ]", "[íī]", "[óōṓ]", "[úū]", ACUTE, MACRON, "ˀ"},
		to   = {"a", "e", "i", "o", "u"}},
}

m["ine-pae"] = {
	"Paeonian",
	2705672,
	"ine",
	scripts = {"polytonic"},
	translit_module = "grc-translit",
	sort_key = {  -- Keep this synchronized with grc and others synced to it
		from = {"[ᾳάᾴὰᾲᾶᾷἀᾀἄᾄἂᾂἆᾆἁᾁἅᾅἃᾃἇᾇᾱᾍ]", "[έὲἐἔἒἑἕἓ]", "[ῃήῄὴῂῆῇἠᾐἤᾔἢᾒἦᾖἡᾑἥᾕἣᾓἧᾗ]", "[ίὶῖἰἴἲἶἱἵἳἷϊΐῒῗῑ]", "[όὸὀὄὂὁὅὃ]", "[ύὺῦὐὔὒὖὑὕὓὗϋΰῢῧῡ]", "[ῳώῴὼῲῶῷὠᾠὤᾤὢᾢὦᾦὡᾡὥᾥὣᾣὧᾧᾨ]", "ῥ", "ς"},
		to   = {"α"						, "ε"		 , "η"						, "ι"				, "ο"		 , "υ"				, "ω"						, "ρ", "σ"}},
	entry_name = {
		from = {"[ᾸᾹ]", "[ᾰᾱ]", "[ῘῙ]", "[ῐῑ]", "[ῨῩ]", "[ῠῡ]"},
		to   = {"Α", "α", "Ι", "ι", "Υ", "υ"}},
}

m["ine-pro"] = {
	"Proto-Indo-European",
	37178,
	"ine",
	type = "reconstructed",
	scripts = {"Latinx"},
	sort_key = {
		from = {"[áā]", "[éēḗ]", "[íī]", "[óōṓ]", "[úū]", "ĺ", "ḿ", "ń", "ŕ", "ǵ" , "ḱ" , "ʰ", "ʷ", "₁", "₂", "₃", RINGBELOW, ACUTE, MACRON},
		to   = {"a"   , "e"	, "i"   , "o"	, "u"   , "l", "m", "n", "r", "g'", "k'", "¯h", "¯w", "1", "2", "3"}},
}

m["ine-toc-pro"] = {
	"Proto-Tocharian",
	37029,
	"ine-toc",
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["xme-old"] = {
	"Old Median",
	36461,
	"xme",
	scripts = {"Grek", "Latn"},
}

m["xme-mid"] = {
	"Middle Median",
	nil,
	"xme",
	scripts = {"Latn"},
	ancestors = {"xme-old"},
}

m["xme-ker"] = {
	"Kermanic",
	129850,
	"xme",
	otherNames = {"Kermanian", "Central Dialects", "Central Iranian Dialects", "Central Plateau Dialects", "Central Iranian", "South Median", "Gazi", "Soi", "Sohi", "Abuzeydabadi", "Abyanehi", "Farizandi", "Jowshaqani", "Nashalji", "Qohrudi", "Yarandi", "Tari", "Sedehi", "Ardestani", "Zefrehi", "Isfahani", "Kafroni", "Varzenehi", "Khuri", "Nayini", "Anaraki", "Zoroastrian Dari", "Behdināni", "Behdinani", "Gabri", "Gavrŭni", "Gavruni", "Gabrōni", "Gabroni", "Kermani", "Yazdi", "Bidhandi", "Bijagani", "Chimehi", "Hanjani", "Komjani", "Naraqi", "Qalhari", "Varani", "Zori"},
	scripts = {"fa-Arab", "Latn"},
	ancestors = {"xme-mid"},
}

m["xme-taf"] = {
	"Tafreshi",
	nil,
	"xme",
	scripts = {"fa-Arab", "Latn"},
	ancestors = {"xme-mid"},
}

m["xme-ttc-pro"] = {
	"Proto-Tatic",
	nil,
	"xme-ttc",
	scripts = {"Latn"},
	ancestors = {"xme-mid"},
}

m["xme-kls"] = {
	"Kalasuri",
	nil,
	"xme-ttc",
	aliases = {"Kalāsuri", "Kalasur", "Kalāsur"},
	ancestors = {"xme-ttc-nor"},
}

m["xme-klt"] = {
	"Kilit",
	3612452,
	"xme-ttc",
	scripts = {"Cyrl"}, -- and fa-Arab?
	ancestors = {"xme-ttc-pro"},
}

m["xme-ott"] = {
	"Old Tati",
	434697,
	"xme-ttc",
	otherNames = {"Old Tatic", "Old Azeri", "Azari", "Azeri", "Āḏarī", "Adari", "Adhari"},
	scripts = {"fa-Arab", "Latinx"},
	ancestors = {"xme-ttc-pro"},
}

m["ira-pro"] = {
	"Proto-Iranian",
	4167865,
	"ira",
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["ira-mpr-pro"] = {
	"Proto-Medo-Parthian",
	nil,
	"ira-mpr",
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["ira-kms-pro"] = {
	"Proto-Komisenian",
	nil,
	"ira-kms",
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["ira-zgr-pro"] = {
	"Proto-Zaza-Gorani",
	nil,
	"ira-zgr",
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["ira-pat-pro"] = {
	"Proto-Pathan",
	nil,
	"ira-pat",
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["os-pro"] = {
	"Proto-Ossetic",
	otherNames = {"Sarmatian"},
	nil,
	"xsc",
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["xsc-pro"] = {
	"Proto-Scythian",
	nil,
	"xsc",
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["xsc-skw-pro"] = {
	"Proto-Saka-Wakhi",
	nil,
	"xsc-skw",
	type = "reconstructed",
	scripts = {"Latinx"},
	ancestors = {"xsc-pro"},
}

m["xsc-sak-pro"] = {
	"Proto-Saka",
	nil,
	"xsc-sak",
	aliases = {"Proto-Sakan"},
	type = "reconstructed",
	scripts = {"Latinx"},
	ancestors = {"xsc-skw-pro"},
}

m["ira-sym-pro"] = {
	"Proto-Shughni-Yazghulami-Munji",
	nil,
	"ira-sym",
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["ira-sgi-pro"] = {
	"Proto-Sanglechi-Ishkashimi",
	nil,
	"ira-sgi",
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["ira-mny-pro"] = {
	"Proto-Munji-Yidgha",
	nil,
	"ira-mny",
	type = "reconstructed",
	scripts = {"Latinx"},
	ancestors = {"ira-sym-pro"},
}

m["ira-shy-pro"] = {
	"Proto-Shughni-Yazghulami",
	nil,
	"ira-shy",
	type = "reconstructed",
	scripts = {"Latinx"},
	ancestors = {"ira-sym-pro"},
}

m["ira-shr-pro"] = {
	"Proto-Shughni-Roshani",
	nil,
	"ira-shy",
	type = "reconstructed",
	scripts = {"Latinx"},
	ancestors = {"ira-shy-pro"},
}

m["ira-sgc-pro"] = {
	"Proto-Sogdic",
	nil,
	"ira-sgc",
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["ira-wnj"] = {
	"Vanji",
	nil,
	"ira-shy",
	aliases = {"Old Vanji", "Vanchi", "Vanži", "Wanji"},
	scripts = {"Latinx"},
	ancestors = {"ira-shy-pro"},
}

m["iro-ere"] = {
	"Erie",
	5388365,
	"iro",
	scripts = Latn,
}

m["iro-min"] = {
	"Mingo",
	128531,
	"iro",
	scripts = Latn,
}

m["iro-pro"] = {
	"Proto-Iroquoian",
	7251852,
	"iro",
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["itc-ola"] = {
	"Old Latin",
	12289,
	"itc",
	aliases = {"Archaic Latin", "Early Latin", "Pre-Classical Latin", "Ante-Classical Latin"},
	scripts = {"Latn", "Ital"},
	entry_name = {
		from = {"Ā", "ā", "Ē", "ē", "Ī", "ī", "Ō", "ō", "Ū", "ū", "Ȳ", "ȳ"},
		to   = {"A", "a", "E", "e", "I", "i", "O", "o", "U", "u", "Y", "y"}},
	translit_module = "Ital-translit",
}

m["itc-pro"] = {
	"Proto-Italic",
	17102720,
	"itc",
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["jpx-pro"] = {
	"Proto-Japonic",
	nil,
	"jpx",
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["jpx-ryu-pro"] = {
	"Proto-Ryukyuan",
	nil,
	"jpx-ryu",
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["kar-pro"] = {
	"Proto-Karen",
	nil,
	"kar",
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["khi-kho-pro"] = {
	"Proto-Khoe",
	nil,
	"khi-kho",
	type = "reconstructed",
	scripts = Latn,
}

m["khi-kun"] = {
	"ǃKung",
	32904,
	"khi-kxa",
	otherNames = {"ǃOǃKung", "ǃ'OǃKung", "Kung", "Ekoka ǃKung", "Ekoka Kung", "Sekele"},
	scripts = Latn,
}

m["kro-pro"] = {
	"Proto-Kru",
	nil,
	"kro",
	type = "reconstructed",
	scripts = Latn,
}

m["ku-pro"] = {
	"Proto-Kurdish",
	nil,
	"ku",
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["map-ata-pro"] = {
	"Proto-Atayalic",
	nil,
	"map-ata",
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["map-bms"] = {
	"Banyumasan",
	33219,
	"map",
	scripts = Latn,
}

m["map-pro"] = {
	"Proto-Austronesian",
	49230,
	"map",
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["mkh-asl-pro"] = {
	"Proto-Aslian",
	55630680,
	"mkh-asl",
	type = "reconstructed",
	scripts = Latn,
}

m["mkh-ban-pro"] = {
	"Proto-Bahnaric",
	nil,
	"mkh-ban",
	type = "reconstructed",
	scripts = Latn,
}

m["mkh-kat-pro"] = {
	"Proto-Katuic",
	nil,
	"mkh-kat",
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["mkh-khm-pro"] = {
	"Proto-Khmuic",
	nil,
	"mkh-khm",
	type = "reconstructed",
	scripts = Latn,
}

m["mkh-kmr-pro"] = {
	"Proto-Khmeric",
	55630684,
	"mkh-kmr",
	type = "reconstructed",
	scripts = Latn,
}

m["mkh-mkm"] = {
	"Middle Khmer",
	25226861,
	"mkh-kmr",
	scripts = {"Latinx", "Khmr"}, --and also Pallava
	ancestors = {"mkh-okm"},
}

m["mkh-mmn"] = {
	"Middle Mon",
	nil,
	"mkh-mnc",
	scripts = {"Latinx", "Mymr"}, --and also Pallava
	ancestors = {"omx"},
}

m["mkh-mnc-pro"] = {
	"Proto-Monic",
	nil,
	"mkh-mnc",
	type = "reconstructed",
	scripts = Latn,
}

m["mkh-mvi"] = {
	"Middle Vietnamese",
	9199,
	"mkh-vie",
	scripts = {"Latinx", "Hani"},
}

m["mkh-okm"] = {
	"Old Khmer",
	9205,
	"mkh-kmr",
	scripts = {"Latinx", "Khmr"}, --and also Pallava
}

m["mkh-pal-pro"] = {
	"Proto-Palaungic",
	nil,
	"mkh-pal",
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["mkh-pea-pro"] = {
	"Proto-Pearic",
	nil,
	"mkh-pea",
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["mkh-pkn-pro"] = {
	"Proto-Pakanic",
	nil,
	"mkh-pkn",
	type = "reconstructed",
	scripts = Latn,
}

m["mkh-pro"] = { --This will be merged into 2015 aav-pro.
	"Proto-Mon-Khmer",
	7251859,
	"mkh",
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["mkh-vie-pro"] = {
	"Proto-Vietic",
	nil,
	"mkh-vie",
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["mun-pro"] = {
	"Proto-Munda",
	nil,
	"mun",
	aliases = {"Proto-Mundan"},
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["myn-chl"] = { -- the stage after ''emy''
	"Ch'olti'",
	873995,
	"myn",
	otherNames = {"Cholti", "Colonial Ch'olti'", "Colonial Cholti"},
	scripts = {"Latinx"},
}

m["myn-pro"] = {
	"Proto-Mayan",
	3321532,
	"myn",
	aliases = {"Proto-Maya"},
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["nai-ala"] = {
	"Alazapa",
	nil,
	otherNames = {"Alasapa", "Pinto"},
	scripts = Latn,
}

m["nai-bay"] = {
	"Bayogoula",
	1563704,
	otherNames = {"Bayougoula", "Bayou Goula", "Ischenoca"}, -- tribe merged with "Mougulasha", "Mongoulacha", "Mugulasha", "Mougulasha", "Muglahsa", "Muglasha", "Muguasha", "Imongolosha", "Houma", "Acolapissa"
	scripts = Latn,
}

m["nai-bvy"] = {
	"Buena Vista Yokuts",
	4985474,
	"nai-yok",
	otherNames = {"Tulamni-Hometwoli", "Tulamni", "Tulamne", "Tuolumne", "Tawitchi", "Hometwoli", "Taneshach"},
	scripts = Latn,
}

m["nai-cal"] = {
	"Calusa",
	51782,
	scripts = Latn,
}

m["nai-chi"] = {
	"Chiquimulilla",
	25339627,
	"nai-xin",
	scripts = Latn,
}

m["nai-chu-pro"] = {
	"Proto-Chumash",
	nil,
	"nai-chu",
	aliases = {"Proto-Chumashan"},
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["nai-cig"] = {
	"Ciguayo",
	20741700,
	scripts = Latn,
}

m["nai-ckn-pro"] = {
	"Proto-Chinookan",
	nil,
	"nai-ckn",
	aliases = {"Proto-Chinook"},
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["nai-dly"] = {
	"Delta Yokuts",
	nil,
	"nai-yok",
	otherNames = {"Far Northern Valley Yokuts", "Yachikumne", "Yachikumni", "Chulamni", "Lower San Joaquin", "Lakisamni", "Tawalimni"},
	scripts = Latn,
}

m["nai-gsy"] = {
	"Gashowu",
	nil,
	"nai-yok",
	scripts = Latn,
}

m["nai-guz"] = {
	"Guazacapán",
	19572028,
	"nai-xin",
	aliases = {"Guazacapan"},
	scripts = Latn,
}

m["nai-hit"] = {
	"Hitchiti",
	1542882,
	"nai-mus",
	otherNames = {"Atcik-hata", "At-pasha-shliha"},
	scripts = Latn,
}

m["nai-ipa"] = {
	"Ipai",
	3027474,
	"nai-yuc",
	otherNames = {"'Iipay 'aa", "Northern Diegueño", "Diegueño"},
	scripts = Latn,
}

m["nai-jtp"] = {
	"Jutiapa",
	nil,
	"nai-xin",
	otherNames = {"Xutiapa", "Jalapa", "Xalapa"},
	scripts = Latn,
}

m["nai-jum"] = {
	"Jumaytepeque",
	25339626,
	"nai-xin",
	aliases = {"Jumaitepeque", "Jumaytepec"},
	scripts = Latn,
}

m["nai-kat"] = {
	"Kathlamet",
	6376639,
	"nai-ckn",
	otherNames = {"Kathlamet Chinook"},
	scripts = Latn,
}

m["nai-klp-pro"] = {
	"Proto-Kalapuyan",
	nil,
	"nai-klp",
	type = "reconstructed",
}

m["nai-knm"] = {
	"Konomihu",
	3198734,
	"nai-shs",
	scripts = Latn,
}

m["nai-kry"] = {
	"Kings River Yokuts",
	6413014,
	"nai-yok",
	otherNames = {"Choinimni", "Choynimni", "Ayticha", "Kocheyali", "Ayitcha", "Michahay", "Chukaymina", "Chukaimina"},
	scripts = Latn,
}

m["nai-kum"] = {
	"Kumeyaay",
	4910139,
	"nai-yuc",
	otherNames = {"Kumiai", "Central Diegueño", "Diegueño"},
	scripts = Latn,
}

m["nai-mac"] = {
	"Macoris",
	21070851,
	aliases = {"Macorís", "Macorix", "Mazorij", "Mazorig", "Mazoriges"},
	scripts = Latn,
}

m["nai-mdu-pro"] = {
	"Proto-Maidun",
	nil,
	"nai-mdu",
	aliases = {"Proto-Maiduan"},
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["nai-miz-pro"] = {
	"Proto-Mixe-Zoque",
	nil,
	"nai-miz",
	aliases = {"Proto-Mixe-Zoquean"},
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["nai-nao"] = {
	"Naolan",
	6964594,
	scripts = Latn,
}

m["nai-nrs"] = {
	"New River Shasta",
	7011254,
	"nai-shs",
	scripts = Latn,
}

m["nai-nvy"] = {
	"Northern Valley Yokuts",
	nil,
	"nai-yok",
	otherNames = {"Chukchansi", "Kechayi", "Dumna", "Chawchila", "Noptinte", "Nopṭinṭe", "Nopthrinthre", "Nopchinchi", "Takin"},
	scripts = Latn,
}

m["nai-okw"] = {
	"Okwanuchu",
	3350126,
	"nai-shs",
	scripts = Latn,
}

m["nai-per"] = {
	"Pericú",
	3375369,
	scripts = Latn,
}

m["nai-pic"] = {
	"Picuris",
	7191257,
	"nai-kta",
	scripts = Latn,
}

m["nai-plp-pro"] = {
	"Proto-Plateau Penutian",
	nil,
	"nai-plp",
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["nai-ply"] = {
	"Palewyami",
	2387391,
	"nai-yok",
	otherNames = {"Paleuyami", "Altinin", "Poso Creek", "Poso Creek Yokuts"},
	scripts = Latn,
}

m["nai-pom-pro"] = {
	"Proto-Pomo",
	nil,
	"nai-pom",
	aliases = {"Proto-Pomoan"},
	type = "reconstructed",
	scripts = Latn,
}

m["nai-qng"] = {
	"Quinigua",
	36360,
	scripts = Latn,
}

m["nai-sca-pro"] = { -- NB 'sio-pro' "Proto-Siouan" which is Proto-Western Siouan
	"Proto-Siouan-Catawban",
	nil,
	"nai-sca",
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["nai-sin"] = {
	"Sinacantán",
	24190249,
	"nai-xin",
	aliases = {"Sinacantan", "Zinacantán", "Zinacantan"},
	scripts = Latn,
}

m["nai-sln"] = {
	"Salvadoran Lenca",
	3229434,
	"nai-len",
	scripts = Latn,
}

m["nai-spt"] = {
	"Sahaptin",
	3833015,
	"nai-shp",
	aliases = {"Shahaptin"},
	scripts = Latn,
}

m["nai-svy"] = {
	"Southern Valley Yokuts",
	nil,
	"nai-yok",
	otherNames = {"Yawelmani", "Tachi", "Koyeti", "Nutunutu", "Chunut", "Wo'lasi", "Choynok", "Choinok", "Wechihit"},
	scripts = Latn,
}

m["nai-tap"] = {
	"Tapachultec",
	7684401,
	"nai-miz",
	otherNames = {"Tapachulteca", "Tapachulteco", "Tapachula"},
	scripts = Latn,
}

m["nai-taw"] = {
	"Tawasa",
	7689233,
	scripts = Latn,
}

m["nai-teq"] = {
	"Tequistlatec",
	2964454,
	"nai-tqn",
	otherNames = {"Tequistlateco", "Tequistlateca", "Chontal", "Chontol of Oaxaca", "Oaxaca Chontal", "Oaxacan Chontal"},
	scripts = Latn,
}

m["nai-tip"] = {
	"Tipai",
	3027471,
	"nai-yuc",
	otherNames = {"Tipay", "Tiipai", "Tiipay", "Jamul Tiipay", "Southern Digueño", "Diegueño"},
	scripts = Latn,
}

m["nai-tky"] = {
	"Tule-Kaweah Yokuts",
	7851988,
	"nai-yok",
	otherNames = {"Wikchamni", "Wukchamni", "Wukchumni", "Yawdanchi"},
	scripts = Latn,
}

m["nai-tot-pro"] = {
	"Proto-Totozoquean",
	nil,
	"nai-tot",
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["nai-tsi-pro"] = {
	"Proto-Tsimshianic",
	nil,
	"nai-tsi",
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["nai-utn-pro"] = {
	"Proto-Utian",
	nil,
	"nai-utn",
	otherNames = {"Proto-Miwok-Costanoan"},
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["nai-wai"] = {
	"Waikuri",
	3118702,
	aliases = {"Guaycura", "Waicura"},
	scripts = Latn,
}

m["nai-yav"] = {
	"Yavapai",
	34202,
	"nai-yuc",
	otherNames = {"Kwevkepaya", "Wipukpaya", "Tolkepaya", "Yavepe"},
	scripts = Latn,
}

m["nai-yup"] = {
	"Yupiltepeque",
	25339628,
	"nai-xin",
	aliases = {"Jupiltepeque", "Yupiltepec", "Jupiltepec", "Xupiltepec"},
	scripts = Latn,
}

m["nds-de"] = {
	"German Low German",
	25433,
	"gmw",
	scripts = Latn,
	ancestors = {"nds"},
	wikimedia_codes = {"nds"},
}

m["nds-nl"] = {
	"Dutch Low Saxon",
	516137,
	"gmw",
	scripts = Latn,
	ancestors = {"nds"},
}

m["ngf-pro"] = {
	"Proto-Trans-New Guinea",
	nil,
	"ngf",
	type = "reconstructed",
	scripts = Latn,
}

m["nic-bco-pro"] = {
	"Proto-Benue-Congo",
	nil,
	"nic-bco",
	type = "reconstructed",
	scripts = Latn,
}

m["nic-bod-pro"] = {
	"Proto-Bantoid",
	nil,
	"nic-bod",
	type = "reconstructed",
	scripts = Latn,
}

m["nic-eov-pro"] = {
	"Proto-Eastern Oti-Volta",
	nil,
	"nic-eov",
	type = "reconstructed",
	scripts = Latn,
}

m["nic-gns-pro"] = {
	"Proto-Gurunsi",
	nil,
	"nic-gns",
	type = "reconstructed",
	scripts = Latn,
}

m["nic-grf-pro"] = {
	"Proto-Grassfields",
	nil,
	"nic-grf",
	type = "reconstructed",
	scripts = Latn,
}

m["nic-gur-pro"] = {
	"Proto-Gur",
	nil,
	"nic-gur",
	type = "reconstructed",
	scripts = Latn,
}

m["nic-jkn-pro"] = {
	"Proto-Jukunoid",
	nil,
	"nic-jkn",
	type = "reconstructed",
	scripts = Latn,
}

m["nic-lcr-pro"] = {
	"Proto-Lower Cross River",
	nil,
	"nic-lcr",
	type = "reconstructed",
	scripts = Latn,
}

m["nic-ogo-pro"] = {
	"Proto-Ogoni",
	nil,
	"nic-ogo",
	type = "reconstructed",
	scripts = Latn,
}

m["nic-ovo-pro"] = {
	"Proto-Oti-Volta",
	nil,
	"nic-ovo",
	type = "reconstructed",
	scripts = Latn,
}

m["nic-plt-pro"] = {
	"Proto-Plateau",
	nil,
	"nic-plt",
	type = "reconstructed",
	scripts = Latn,
}

m["nic-pro"] = {
	"Proto-Niger-Congo",
	nil,
	"nic",
	type = "reconstructed",
	scripts = Latn,
}

m["nic-ubg-pro"] = {
	"Proto-Ubangian",
	nil,
	"nic-ubg",
	type = "reconstructed",
	scripts = Latn,
}

m["nic-ucr-pro"] = {
	"Proto-Upper Cross River",
	nil,
	"nic-ucr",
	type = "reconstructed",
	scripts = Latn,
}

m["nic-vco-pro"] = {
	"Proto-Volta-Congo",
	nil,
	"nic-vco",
	type = "reconstructed",
	scripts = Latn,
}

m["nub-har"] = {
	"Haraza",
	19572059,
	"nub",
	aliases = {"Ḥarāza"},
	scripts = {"Arab", "Latn"},
}

m["nub-pro"] = {
	"Proto-Nubian",
	nil,
	"nub",
	type = "reconstructed",
	scripts = Latn,
}

m["omq-cha-pro"] = {
	"Proto-Chatino",
	nil,
	"omq-cha",
	type = "reconstructed",
	scripts = Latn,
}

m["omq-maz-pro"] = {
	"Proto-Mazatec",
	nil,
	"omq-maz",
	aliases = {"Proto-Mazatecan"},
	type = "reconstructed",
	scripts = Latn,
}

m["omq-mix-pro"] = {
	"Proto-Mixtecan",
	nil,
	"omq-mix",
	type = "reconstructed",
	scripts = Latn,
}

m["omq-mxt-pro"] = {
	"Proto-Mixtec",
	nil,
	"omq-mxt",
	type = "reconstructed",
	scripts = Latn,
}

m["omq-otp-pro"] = {
	"Proto-Oto-Pamean",
	nil,
	"omq-otp",
	type = "reconstructed",
	scripts = Latn,
	ancestors = {"omq-pro"},
}

m["omq-pro"] = {
	"Proto-Oto-Manguean",
	33669,
	"omq",
	aliases = {"Proto-Otomanguean", "Proto-Oto-Mangue"},
	type = "reconstructed",
	scripts = Latn,
}

m["omq-tel"] = {
	"Teposcolula Mixtec",
	nil,
	"omq-mxt",
	scripts = Latn,
}

m["omq-teo"] = {
	"Teojomulco Chatino",
	25340451,
	"omq-cha",
	scripts = Latn,
}

m["omq-tri-pro"] = {
	"Proto-Trique",
	nil,
	"omq-tri",
	type = "reconstructed",
	scripts = Latn,
}

m["omq-zap-pro"] = {
	"Proto-Zapotecan",
	nil,
	"omq-zap",
	type = "reconstructed",
	scripts = Latn,
}

m["omq-zpc-pro"] = {
	"Proto-Zapotec",
	nil,
	"omq-zpc",
	type = "reconstructed",
	scripts = Latn,
}

m["omv-aro-pro"] = {
	"Proto-Aroid",
	nil,
	"omv-aro",
	type = "reconstructed",
	scripts = Latn,
}

m["omv-diz-pro"] = {
	"Proto-Dizoid",
	nil,
	"omv-diz",
	aliases = {"Proto-Maji"},
	type = "reconstructed",
	scripts = Latn,
}

m["omv-pro"] = {
	"Proto-Omotic",
	nil,
	"omv",
	type = "reconstructed",
	scripts = Latn,
}

m["oto-otm-pro"] = {
	"Proto-Otomi",
	nil,
	"oto-otm",
	type = "reconstructed",
	scripts = Latn,
	ancestors = {"oto-pro"},
}

m["oto-pro"] = {
	"Proto-Otomian",
	nil,
	"oto",
	type = "reconstructed",
	scripts = Latn,
	ancestors = {"omq-otp-pro"},
}

m["paa-kom"] = {
	"Kómnzo",
	18344310,
	"paa-yam",
	aliases = {"Komnzo", "Kómnjo", "Komnjo", "Kamundjo"},
	scripts = Latn,
}

m["paa-kwn"] = {
	"Kuwani",
	6449056,
	"paa",
	scripts = Latn,
}

m["paa-nun"] = {
	"Nungon",
	nil,
	"paa",
	scripts = Latn,
}

m["phi-din"] = {
	"Dinapigue Agta",
	16945774,
	"phi",
	scripts = Latn,
}

m["phi-kal-pro"] = {
	"Proto-Kalamian",
	nil,
	"phi-kal",
	aliases = {"Proto-Calamian"},
	type = "reconstructed",
	scripts = Latn,
}

m["phi-nag"] = {
	"Nagtipunan Agta",
	16966111,
	"phi",
	scripts = Latn,
}

m["phi-pro"] = {
	"Proto-Philippine",
	18204898,
	"phi",
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["poz-abi"] = {
	"Abai",
	19570729,
	"poz-san",
	otherNames = {"Sembuak", "Tubu"},
	scripts = Latn,
}

m["poz-bal"] = {
	"Baliledo",
	4850912,
	"poz",
	scripts = Latn,
}

m["poz-btk-pro"] = {
	"Proto-Bungku-Tolaki",
	nil,
	"poz-btk",
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["poz-cet-pro"] = {
	"Proto-Central-Eastern Malayo-Polynesian",
	2269883,
	"poz-cet",
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["poz-hce-pro"] = {
	"Proto-Halmahera-Cenderawasih",
	nil,
	"poz-hce",
	otherNames = {"Proto-South Halmahera - West New Guinea"},
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["poz-lgx-pro"] = {
	"Proto-Lampungic",
	nil,
	"poz-lgx",
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["poz-mcm-pro"] = {
	"Proto-Malayo-Chamic",
	nil,
	"poz-mcm",
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["poz-mly-pro"] = {
	"Proto-Malayic",
	nil,
	"poz-mly",
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["poz-msa-pro"] = {
	"Proto-Malayo-Sumbawan",
	nil,
	"poz-msa",
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["poz-oce-pro"] = {
	"Proto-Oceanic",
	141741,
	"poz-oce",
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["poz-pep-pro"] = {
	"Proto-Eastern Polynesian",
	nil,
	"poz-pep",
	aliases = {"Proto-Eastern-Polynesian", "Proto-East Polynesian", "Proto-East-Polynesian"},
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["poz-pnp-pro"] = {
	"Proto-Nuclear Polynesian",
	nil,
	"poz-pnp",
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["poz-pol-pro"] = {
	"Proto-Polynesian",
	1658709,
	"poz-pol",
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["poz-pro"] = {
	"Proto-Malayo-Polynesian",
	3832960,
	"poz",
	otherNames = {"Proto-Western Malayo-Polynesian"}, -- Western is subsumed into general Proto-MP
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["poz-ssw-pro"] = {
	"Proto-South Sulawesi",
	nil,
	"poz-ssw",
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["poz-sus-pro"] = {
	"Proto-Sunda-Sulawesi",
	nil,
	"poz-sus",
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["poz-swa-pro"] = {
	"Proto-North Sarawak",
	nil,
	"poz-swa",
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["pqe-pro"] = {
	"Proto-Eastern Malayo-Polynesian",
	2269883,
	"pqe",
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["pra-niy"] = {

	"Niya Prakrit",
	nil,
	"inc-mid",
	scripts = {"Khar"},
	ancestors = {"inc-ash"},
	translit_module = "Khar-translit",
}

m["qfa-adm-pro"] = {
	"Proto-Great Andamanese",
	nil,
	"qfa-adm",
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["qfa-bet-pro"] = {
	"Proto-Be-Tai",
	nil,
	"qfa-bet",
	aliases = {"Proto-Tai-Be"},
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["qfa-cka-pro"] = {
	"Proto-Chukotko-Kamchatkan",
	7251837,
	"qfa-cka",
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["qfa-hur-pro"] = {
	"Proto-Hurro-Urartian",
	nil,
	"qfa-hur",
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["qfa-kad-pro"] = {
	"Proto-Kadu",
	nil,
	"qfa-kad",
	type = "reconstructed",
	scripts = Latn,
}

m["qfa-kms-pro"] = {
	"Proto-Kam-Sui",
	nil,
	"qfa-kms",
	type = "reconstructed",
	scripts = Latn,
}

m["qfa-kor-pro"] = {
	"Proto-Korean",
	467883,
	"qfa-kor",
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["qfa-kra-pro"] = {
	"Proto-Kra",
	7251854,
	"qfa-kra",
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["qfa-lic-pro"] = {
	"Proto-Hlai",
	7251845,
	"qfa-lic",
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["qfa-onb-pro"] = {
	"Proto-Be",
	nil,
	"qfa-onb",
	aliases = {"Proto-Ong-Be", "Proto-Bê"},
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["qfa-ong-pro"] = {
	"Proto-Ongan",
	nil,
	"qfa-ong",
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["qfa-tak-pro"] = {
	"Proto-Kra-Dai",
	nil,
	"qfa-tak",
	aliases = {"Proto-Tai-Kadai"},
	type = "reconstructed",
	scripts = Latn,
}

m["qfa-yen-pro"] = {
	"Proto-Yeniseian",
	27639,
	"qfa-yen",
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["qfa-yuk-pro"] = {
	"Proto-Yukaghir",
	nil,
	"qfa-yuk",
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["qwe-kch"] = {
	"Kichwa",
	1740805,
	"qwe",
	ancestors = {"qu"},
	otherNames = {"Kichwa shimi", "Runashimi", "Runa", "Quichua", "Quecha", "Inga", "Chimborazo", "Imbabura Highland Kichwa", "Cañar Highland Quecha", "Quechua"},
	scripts = Latn,
}

m["roa-ang"] = {
	"Angevin",
	56782,
	"roa-oil",
	otherNames = {"Craonnais", "Baugeois", "Saumurois"},
	scripts = Latn,
	sort_key = {
		from = {"[áàâä]", "[éèêë]", "[íìîï]", "[óòôö]", "[úùûü]", "[ýỳŷÿ]", "ç", "æ" , "œ" , "'"},
		to   = {"a"	    , "e"	  , "i"	    , "o"	  , "u"	    , "y"	  , "c", "ae", "oe"}},
}

m["roa-bbn"] = {
	"Bourbonnais-Berrichon",
	nil,
	"roa-oil",
	otherNames = {"Bourbonnais", "Berrichon", "Moulins", "Allier", "Nivernais", "Haut-Berrichon", "Bas-Berrichon"},
	scripts = Latn,
	sort_key = {
		from = {"[áàâä]", "[éèêë]", "[íìîï]", "[óòôö]", "[úùûü]", "[ýỳŷÿ]", "ç", "æ" , "œ" , "'"},
		to   = {"a"	    , "e"	  , "i"	    , "o"	  , "u"	    , "y"	  , "c", "ae", "oe"}},
}

m["roa-brg"] = {
	"Bourguignon",
	508332,
	"roa-oil",
	otherNames = {"Burgundian", "Bregognon", "Dijonnais", "Morvandiau", "Morvandeau", "Morvan", "Bourguignon-Morvandiau", "Mâconnais", "Brionnais", "Brionnais-Charolais", "Auxerrois", "Beaunois", "Langrois", "Valsaônois", "Verduno-Chalonnais", "Sédelocien"},
	scripts = Latn,
	sort_key = {
		from = {"[áàâä]", "[éèêë]", "[íìîï]", "[óòôö]", "[úùûü]", "[ýỳŷÿ]", "ç", "'"},
		to   = {"a"     , "e"     , "i"     , "o"     , "u"     , "y"     , "c"}},
}

m["roa-cha"] = {
	"Champenois",
	430018,
	"roa-oil",
	otherNames = {"Bassignot", "Langrois", "Sennonais", "Vallage", "Troyen", "Briard", "Der", "Perthois", "Rémois", "Argonnais", "Porcien", "Ardennais", "Sugny"},
	scripts = Latn,
	sort_key = {
		from = {"[áàâä]", "[éèêë]", "[íìîï]", "[óòôö]", "[úùûü]", "[ýỳŷÿ]", "ç", "æ" , "œ" , "'"},
		to   = {"a"	    , "e"	  , "i"	    , "o"	  , "u"	    , "y"	  , "c", "ae", "oe"}},
}

m["roa-fcm"] = {
	"Franc-Comtois",
	510561,
	"roa-oil",
	otherNames = {"Frainc-Comtou", "Comtois", "Jurassien", "Ajoulot", "Vâdais", "Taignon", "Bisontin", "Bousbot"},
	scripts = Latn,
	sort_key = {
		from = {"[áàâä]", "[éèêë]", "[íìîï]", "[óòôö]", "[úùûü]", "[ýỳŷÿ]", "ç", "æ" , "œ" , "'"},
		to   = {"a"	    , "e"	  , "i"	    , "o"	  , "u"	    , "y"	  , "c", "ae", "oe"}},
}

m["roa-gal"] = {
	"Gallo",
	37300,
	"roa-oil",
	scripts = Latn,
	sort_key = {
		from = {"[áàâä]", "[éèêë]", "[íìîï]", "[óòôö]", "[úùûü]", "[ýỳŷÿ]", "ç", "'"},
		to   = {"a"     , "e"     , "i"     , "o"     , "u"     , "y"     , "c"}},
}

m["roa-leo"] = {
	"Leonese",
	34108,
	"roa-ibe",
	scripts = Latn,
	ancestors = {"roa-ole"},
}

m["roa-lor"] = {
	"Lorrain",
	671198,
	"roa-oil",
	otherNames = {"Gaumais", "Vosgien", "Welche", "Argonnais", "Longovicien", "Messin", "Nancéien", "Spinalien", "Déodatien"},
	scripts = Latn,
	sort_key = {
		from = {"[áàâä]", "[éèêë]", "[íìîï]", "[óòôö]", "[úùûü]", "[ýỳŷÿ]", "ç", "æ" , "œ" , "'"},
		to   = {"a"	    , "e"	  , "i"	    , "o"	  , "u"	    , "y"	  , "c", "ae", "oe"}},
}

m["roa-oan"] = {
	"Navarro-Aragonese",
	2736184,
	"roa-ibe",
	otherNames = {"Old Aragonese"},
	scripts = Latn,
}

m["roa-oca"] = {
	"Old Catalan",
	15478520,
	"roa",
	scripts = Latn,
	ancestors = {"pro"},
	sort_key = {
		from = {"à", "[èé]", "[íï]", "[òó]", "[úü]", "ç", "·"},
		to   = {"a", "e"   , "i"   , "o"   , "u"   , "c"}},
}

m["roa-ole"] = {
	"Old Leonese",
	nil,
	"roa-ibe",
	scripts = Latn,
}

m["roa-opt"] = {
	"Old Portuguese",
	1072111,
	"roa-ibe",
	aliases = {"Galician-Portuguese", "Galician Portuguese", "Medieval Galician"},
	scripts = Latn,
}

m["roa-orl"] = {
	"Orléanais",
	nil,
	"roa-oil",
	otherNames = {"Beauceron", "Solognot", "Gâtinais", "Blaisois", "Vendômois"},
	scripts = Latn,
	sort_key = {
		from = {"[áàâä]", "[éèêë]", "[íìîï]", "[óòôö]", "[úùûü]", "[ýỳŷÿ]", "ç", "æ" , "œ" , "'"},
		to   = {"a"	    , "e"	  , "i"	    , "o"	  , "u"	    , "y"	  , "c", "ae", "oe"}},
}

m["roa-poi"] = {
	"Poitevin-Saintongeais",
	514123,
	"roa-oil",
	otherNames = {"Poitevin", "Saintongeais", "Maraîchin"},
	scripts = Latn,
	sort_key = {
		from = {"[áàâä]", "[éèêë]", "[íìîï]", "[óòôö]", "[úùûü]", "[ýỳŷÿ]", "ç", "æ" , "œ" , "'"},
		to   = {"a"	    , "e"	  , "i"	    , "o"	  , "u"	    , "y"	  , "c", "ae", "oe"}},
}

m["roa-tar"] = {
	"Tarantino",
	695526,
	"roa-itd",
	scripts = Latn,
	ancestors = {"nap"},
	wikimedia_codes = {"roa-tara"},
}

m["roa-tou"] = {
	"Tourangeau",
	nil,
	"roa-oil",
	aliases = {"Tourangian", "Tourangean"},
	scripts = Latn,
	sort_key = {
		from = {"[áàâä]", "[éèêë]", "[íìîï]", "[óòôö]", "[úùûü]", "[ýỳŷÿ]", "ç", "æ" , "œ" , "'"},
		to   = {"a"	    , "e"	  , "i"	    , "o"	  , "u"	    , "y"	  , "c", "ae", "oe"}},
}

m["sai-ajg"] = {
	"Ajagua",
	nil,
	aliases = {"Axagua", "Jagua"},
	scripts = Latn,
}

m["sai-all"] = {
	"Allentiac",
	19570789,
	"sai-hrp",
	otherNames = {"Alyentiyak", "Huarpe", "Warpe"},
	scripts = Latn,
}

m["sai-and"] = { -- not to be confused with 'cbc' or 'ano'
	"Andoquero",
	16828359,
	"sai-wit",
	otherNames = {"Miranya", "Miranha", "Miranha Carapana-Tapuya", "Miraña-Carapana-Tapuyo", "Andokero", "Miranya-Karapana-Tapuyo", "Miraña", "Carapana"},
	scripts = Latn,
}

m["sai-ayo"] = {
	"Ayomán",
	16937754,
	"sai-jir",
	aliases = {"Ayoman", "Ayamán", "Ayaman"},
	scripts = Latn,
}

m["sai-bae"] = {
	"Baenan",
	3401998,
	aliases = {"Baenã", "Baenán", "Baena"},
	scripts = Latn,
}

m["sai-bag"] = {
	"Bagua",
	5390321,
	otherNames = {"Patagón de Bagua"},
	scripts = Latn,
}

m["sai-bet"] = {
	"Betoi",
	926551,
	"qfa-iso",
	otherNames = {"Betoy", "Betoya", "Betoye", "Betoi-Jirara", "Jirara"},
	scripts = Latn,
}


m["sai-bor-pro"] = {
	"Proto-Boran",
	nil,
	"sai-bor",
	otherNames = {"Proto-Bora-Muinane", "Proto-Bora-Muiname"},
	scripts = Latn,
}

m["sai-cac"] = {
	"Cacán",
	945482,
	otherNames = {"Kakán", "Diaguita", "Cacan", "Kakan", "Calchaquí", "Chaka", "Kaka", "Kaká", "Caca", "Caca-Diaguita", "Catamarcano", "Capayán", "Capayana", "Yacampis"},
	scripts = Latn,
}

m["sai-caq"] = {
	"Caranqui",
	2937753,
	"sai-bar",
	otherNames = {"Cara", "Kara"},
	scripts = Latn,
}

m["sai-cat"] = {
	"Catacao",
	5051136,
	"sai-ctc",
	scripts = {"Latinx"},
}

m["sai-cer-pro"] = {
	"Proto-Cerrado",
	nil,
	"sai-cer",
	otherNames = {"Proto-Amazonian Jê"},
	type = "reconstructed",
	scripts = Latn,
}

m["sai-chi"] = {
	"Chirino",
	5390321,
	scripts = Latn,
}

m["sai-chn"] = {
	"Chaná",
	5072718,
	"sai-crn",
	aliases = {"Chana"},
	scripts = Latn,
}

m["sai-chp"] = {
	"Chapacura",
	5072884,
	"sai-cpc",
	aliases = {"Txapacura", "Xapacura", "Guapore", "Šapakura", "Txapakura", "Txapakúra", "Xapakúra"},
	scripts = Latn,
}

m["sai-chr"] = {
	"Charrua",
	5086680,
	"sai-crn",
	aliases = {"Charrúa", "Charruá"},
	scripts = Latn,
}

m["sai-chu"] = {
	"Churuya",
	5118339,
	"sai-guh",
	aliases = {"Churoya"},
	scripts = Latn,
}

m["sai-cje-pro"] = {
	"Proto-Central Jê",
	nil,
	"sai-cje",
	otherNames = {"Proto-Akuwẽ"},
	type = "reconstructed",
	scripts = Latn,
}

m["sai-cmg"] = {
	"Comechingon",
	6644203,
	aliases = {"Comechingón", "Comechingona", "Comechingone"},
	scripts = Latn,
}

m["sai-cno"] = {
	"Chono",
	5104704,
	otherNames = {"Chonos", "Caucau"},
	scripts = Latn,
}

m["sai-cnr"] = {
	"Cañari",
	5055572,
	aliases = {"Cañar"},
	scripts = Latn,
}

m["sai-coe"] = {
	"Coeruna",
	6425639,
	"sai-wit",
	aliases = {"Koeruna"},
	scripts = Latn,
}

m["sai-col"] = {
	"Colán",
	5141893,
	"sai-ctc",
	aliases = {"Colan"},
	scripts = {"Latinx"},
}

m["sai-cop"] = {
	"Copallén",
	5390321,
	scripts = Latn,
}

m["sai-crd"] = {
	"Coroado Puri",
	24191321,
	"sai-mje",
	otherNames = {"Coroado"},
	scripts = Latn,
}

m["sai-ctq"] = {
	"Catuquinaru",
	16858455,
	aliases = {"Catuquinarú", "Katukinaru"},
	scripts = Latn,
}

m["sai-cul"] = {
	"Culli",
	2879660,
	otherNames = {"Culle", "Kulyi", "Ilinga", "Linga"},
	scripts = Latn,
}

m["sai-cva"] = {
	"Cueva",
	nil,
	scripts = Latn,
}

m["sai-esm"] = {
	"Esmeralda",
	3058083,
	otherNames = {"Esmeraldeño", "Atacame", "Takame"},
	scripts = Latn,
}

m["sai-ewa"] = {
	"Ewarhuyana",
	16898104,
	scripts = Latn,
}

m["sai-gam"] = {
	"Gamela",
	5403661,
	aliases = {"Gamella", "Acobu", "Curinsi", "Barbados"},
	scripts = Latn,
}

m["sai-gay"] = {
	"Gayón",
	5528902,
	"sai-jir",
	aliases = {"Gayon"},
	scripts = Latn,
}

m["sai-gmo"] = {
	"Guamo",
	5613495,
	otherNames = {"Wamo", "Santa Rosa", "San Jose", "Barinas", "Guamotey", "Guama"},
	scripts = Latn,
}

m["sai-gue"] = {
	"Güenoa",
	5626799,
	"sai-crn",
	aliases = {"Guenoa"},
	scripts = Latn,
}

m["sai-hau"] = {
	"Haush",
	3128376,
	"sai-cho",
	otherNames = {"Manek'enk"},
	scripts = Latn,
}

m["sai-hoc-pro"] = {
	"Proto-Huitoto-Ocaina",
	nil,
	"sai-hoc",
	type = "reconstructed",
	scripts = Latn,
}

m["sai-jee-pro"] = {
	"Proto-Jê",
	nil,
	"sai-jee",
	otherNames = {"Proto-Gê", "Proto-Jean", "Proto-Gean", "Proto-Jê-Kaingang", "Proto-Ye"},
	type = "reconstructed",
	scripts = Latn,
}

m["sai-jko"] = {
	"Jeikó",
	6176527,
	"sai-mje",
	aliases = {"Geicó", "Jeicó", "Jaikó", "Geikó", "Yeikó", "Jeiko", "Geico", "Jeico", "Jaiko", "Geiko", "Yeiko", "Eyco"},
	scripts = Latn,
}

m["sai-jrj"] = {
	"Jirajara",
	6202966,
	"sai-jir",
	scripts = Latn,
}

m["sai-kat"] = { -- contrast xoo, kzw, sai-xoc
	"Katembri",
	6375925,
	otherNames = {"Catrimbi", "Catembri", "Kariri de Mirandela", "Mirandela", "Kariri", "Kiriri"},
	scripts = Latn,
}

m["sai-mal"] = {
	"Malalí",
	6741212,
	aliases = {"Malali"},
	scripts = Latn,
}

m["sai-mar"] = {
	"Maratino",
	6755055,
	scripts = Latn,
}

m["sai-mat"] = {
	"Matanawi",
	6786047,
	otherNames = {"Matanauí", "Matanaui", "Matanawü", "Mitandua", "Moutoniway"},
	scripts = Latn,
}

m["sai-mcn"] = {
	"Mocana",
	3402048,
	aliases = {"Mokana"},
	scripts = Latn,
}

m["sai-men"] = {
	"Menien",
	16890110,
	"sai-mje",
	aliases = {"Menién"},
	scripts = Latn,
}

m["sai-mil"] = {
	"Millcayac",
	19573012,
	"sai-hrp",
	otherNames = {"Milykayak", "Huarpe", "Warpe"},
	scripts = Latn,
}

m["sai-mlb"] = {
	"Malibu",
	3402048,
	aliases = {"Malibú", "Malebú"},
	scripts = Latn,
}

m["sai-msk"] = {
	"Masakará",
	6782426,
	"sai-mje",
	aliases = {"Masakara", "Masacará", "Masacara"},
	scripts = Latn,
}

m["sai-muc"] = {
	"Mucuchí",
	nil,
	otherNames = {"Mucuchi", "Mokochi", "Mocochí", "Mirripú", "Maripú", "Mucuchí-Maripú"},
	scripts = Latn,
}

m["sai-mue"] = {
	"Muellama",
	16886936,
	"sai-bar",
	aliases = {"Muellamués"},
	scripts = Latn,
}

m["sai-muz"] = {
	"Muzo",
	6644203,
	scripts = Latn,
}

m["sai-mys"] = {
	"Maynas",
	16919393,
	otherNames = {"Mayna", "Maina", "Rimachu"},
	scripts = Latn,
}

m["sai-nat"] = {
	"Natú",
	9006749,
	otherNames = {"Natu", "Peagaxinan"},
	scripts = Latn,
}

m["sai-nje-pro"] = {
	"Proto-Northern Jê",
	nil,
	"sai-nje",
	otherNames = {"Proto-Core Jê"},
	type = "reconstructed",
	scripts = Latn,
}

m["sai-opo"] = {
	"Opón",
	7099152,
	"sai-car",
	otherNames = {"Opon", "Opón-Karare", "Opón-Carare", "Carare", "Carare-Opón"},
	scripts = Latn,
}

m["sai-oto"] = {
	"Otomaco",
	16879234,
	"sai-otm",
	aliases = {"Otomako", "Otomacan", "Otomac", "Otomak"},
	scripts = Latn,
}

m["sai-pal"] = {
	"Palta",
	3042978,
	scripts = Latn,
}

m["sai-pam"] = {
	"Pamigua",
	5908689,
	"sai-otm",
	aliases = {"Pamiwa"},
	scripts = Latn,
}

m["sai-par"] = {
	"Paratió",
	16890038,
	aliases = {"Paratio", "Prarto"},
	scripts = Latn,
}

m["sai-pnz"] = {
	"Panzaleo",
	3123275,
	aliases = {"Pansaleo"},
	scripts = Latn,
}

m["sai-prh"] = {
	"Puruhá",
	3410994,
	scripts = Latn,
}

m["sai-ptg"] = {
	"Patagón",
	nil,
	otherNames = {"Patagón de Perico"},
	scripts = Latn,
}

m["sai-pur"] = {
	"Purukotó",
	7261622,
	"sai-car",
	aliases = {"Purukoto", "Purucotó", "Purucoto"},
	scripts = Latn,
}

m["sai-pyg"] = {
	"Payaguá",
	7156643,
	"sai-guc",
	aliases = {"Payawá", "Payagua"},
	scripts = Latn,
}

m["sai-pyk"] = { 
	"Pykobjê",
	98113977,
	"sai-nje",
	aliases = {"Gavião-Pykobjê", "Pykobjê-Gavião", "Gavião", "Pyhcopji", "Gavião-Pyhcopji"},
	scripts = Latn,
}

m["sai-qmb"] = {
	"Quimbaya",
	7272043,
	otherNames = {"Kimbaya", "Quindío", "Quindio", "Quindo"},
	scripts = Latn,
}

m["sai-qtm"] = {
	"Quitemo",
	7272651,
	"sai-cpc",
	aliases = {"Quitemoca"},
	scripts = Latn,
}

m["sai-rab"] = {
	"Rabona",
	6644203,
	scripts = Latn,
}

m["sai-ram"] = {
	"Ramanos",
	16902824,
	scripts = Latn,
}

m["sai-sac"] = {
	"Sácata",
	5390321,
	otherNames = {"Sacata", "Zácata", "Chillao"},
	scripts = Latn,
}

m["sai-san"] = {
	"Sanaviron",
	16895999,
	aliases = {"Sanavirón", "Sanabirón", "Sanabiron", "Sanavirona", "Zanavirona"},
	scripts = Latn,
}

m["sai-sap"] = {
	"Sapará",
	7420922,
	"sai-car",
	aliases = {"Zapará", "Zapara"},
	scripts = Latn,
}

m["sai-sec"] = {
	"Sechura",
	7442912,
	otherNames = {"Sek", "Sec"},
	scripts = Latn,
}

m["sai-sin"] = {
	"Sinúfana",
	7525275,
	otherNames = {"Cenúfana", "Zenúfana", "Cinifaná", "Sinufana", "Sinú", "Cenú", "Zenú", "Finzenú", "Fincenú", "Pancenú", "Sutagao"},
	scripts = Latn,
}

m["sai-sje-pro"] = {
	"Proto-Southern Jê",
	nil,
	"sai-sje",
	type = "reconstructed",
	scripts = Latn,
}

m["sai-tab"] = {
	"Tabancale",
	5390321,
	otherNames = {"Aconipa"},
	scripts = Latn,
}

m["sai-tal"] = {
	"Tallán",
	16910468,
	otherNames = {"Atalán", "Tallan", "Tallanca", "Atalan", "Sek"},
	scripts = Latn,
}

m["sai-tap"] = {
	"Tapayuna",
	nil,
	"sai-nje",
	otherNames = {"Tapayúna", "Kajkwakhrattxi"},
	scripts = Latn,
}

m["sai-teu"] = {
	"Teushen",
	3519243,
	aliases = {"Tehues", "Teuéx"},
	scripts = Latn,
}

m["sai-tim"] = {
	"Timote",
	nil,
	otherNames = {"Cuica", "Timote-Cuica"},
	scripts = Latn,
}

m["sai-tpr"] = {
	"Taparita",
	7684460,
	"sai-otm",
	aliases = {"Taparito"},
	scripts = Latn,
}

m["sai-trr"] = {
	"Tarairiú",
	7685313,
	otherNames = {"Caratiú"},
	scripts = Latn,
}

m["sai-wai"] = {
	"Waitaká",
	16918610,
	aliases = {"Waitaka", "Waitacá", "Waitaca", "Goytacá", "Goitacá", "Guaitacá", "Guiatacá", "Guiatacás", "Goiatacá", "Goiatacás", "Guaiatacá", "Goytacaz", "Goitacaz", "Goyataca", "Aitacaz", "Uetacaz", "Uetacá", "Outacá", "Ouetacá", "Eutacá", "Itacaz", "Vaitacá"},
	scripts = Latn,
}

m["sai-way"] = {
	"Wayumará",
	nil,
	"sai-car",
	aliases = {"Wayumara", "Wajumará", "Wajumara", "Azumara", "Guimara"},
	scripts = Latn,
}

m["sai-wit-pro"] = {
	"Proto-Witotoan",
	nil,
	"sai-wit",
	type = "reconstructed",
	otherNames = {"Proto-Huitotoan", "Proto-Uitotoan"},
	scripts = Latn,
}

m["sai-wnm"] = {
	"Wanham",
	16879440,
	"sai-cpc",
	otherNames = {"Wañam", "Wanyam", "Huanyam", "Uanham", "Abitana"},
	scripts = Latn,
}

m["sai-xoc"] = { -- contrast xoo, kzw, sai-kat
	"Xocó",
	12953620,
	otherNames = {"Xoco", "Chocó", "Shokó", "Shoko", "Shocó", "Shoco", "Choco", "Chocaz", "Kariri-Xocó", "Kariri-Xoco", "Kariri-Shoko", "Cariri-Chocó", "Xukuru-Kariri", "Xucuru-Kariri", "Xucuru-Cariri", "Xukurú-Kirirí"},
	scripts = Latn,
}

m["sai-yao"] = {
	"Yao (South America)",
	nil,
	"sai-car",
	aliases = {"Yao", "Jaoi", "Yaoi", "Yaio"},
	scripts = Latn,
}

m["sai-yar"] = { -- not the same family as 'suy'
	"Yarumá",
	3505859,
	"sai-car",
	aliases = {"Yaruma"},
	scripts = Latn,
}

m["sai-yri"] = {
	"Yuri",
	nil,
	"sai-tyu",
	aliases = {"Jurí"},
	scripts = Latn,
}

m["sai-yup"] = {
	"Yupua",
	8061430,
	"sai-tuc",
	otherNames = {"Yupuá", "Yupúa", "Jupua", "Jupuá", "Jupúa", "Hiupiá", "Yupuá-Duriña", "Duriña"},
	scripts = Latn,
}

m["sai-yur"] = {
	"Yurumanguí",
	1281291,
	aliases = {"Yurumangui", "Yurimangí", "Yurimangi", "Yurimanguí", "Yurimangui"},
	scripts = Latn,
}

m["sal-pro"] = {
	"Proto-Salish",
	nil,
	"sal",
	aliases = {"Proto-Salishan"},
	type = "reconstructed",
	scripts = Latn,
}

m["sdv-daj-pro"] = {
	"Proto-Daju",
	nil,
	"sdv-daj",
	type = "reconstructed",
	scripts = Latn,
}

m["sdv-eje-pro"] = {
	"Proto-Eastern Jebel",
	nil,
	"sdv-eje",
	type = "reconstructed",
	scripts = Latn,
}

m["sdv-nil-pro"] = {
	"Proto-Nilotic",
	nil,
	"sdv-nil",
	type = "reconstructed",
	scripts = Latn,
}

m["sdv-nyi-pro"] = {
	"Proto-Nyima",
	nil,
	"sdv-nyi",
	type = "reconstructed",
	scripts = Latn,
}

m["sdv-tmn-pro"] = {
	"Proto-Taman",
	nil,
	"sdv-tmn",
	type = "reconstructed",
	scripts = Latn,
}

m["sem-amm"] = {
	"Ammonite",
	279181,
	"sem-can",
	scripts = {"Phnx"},
	translit_module = "Phnx-translit",
}

m["sem-amo"] = {
	"Amorite",
	35941,
	"sem-nwe",
	scripts = {"Xsux", "Latn"},
	aliases = {"Amoritic"},
}

m["sem-cha"] = {
	"Chaha",
	nil,
	"sem-eth",
	aliases = {"Cheha"},
	scripts = {"Ethi"},
	translit_module = "Ethi-translit",
	ancestors = {"sem-pro"},
}

m["sem-dad"] = {
	"Dadanitic",
	21838040,
	"sem-cen",
	otherNames = {"Dadanite", "Lihyanite", "Lihyanitic"},
	scripts = {"Narb"},
	translit_module = "Narb-translit",
}

m["sem-dum"] = {
	"Dumaitic",
	nil,
	"sem-cen",
	scripts = {"Narb"},
	translit_module = "Narb-translit",
}

m["sem-has"] = {
	"Hasaitic",
	3541433,
	"sem-cen",
	scripts = {"Narb"},
	translit_module = "Narb-translit",
}

m["sem-him"] = {
	"Himyaritic",
	35604,
	"sem",
	aliases = {"Himyarite", "Himyari", "Himyaric", "Himyar"},
	scripts = {"Arab", "Sarb"},
}

m["sem-his"] = {
	"Hismaic",
	22948260,
	"sem-cen",
	otherNames = {"Thamudic E"},
	scripts = {"Narb"},
	translit_module = "Narb-translit",
}

m["sem-mhr"] = {
	"Muher",
	33743,
	"sem-eth",
	otherNames = {"Muher Gurage", "Muxar"},
	scripts = Latn,
}

m["sem-pro"] = {
	"Proto-Semitic",
	1658554,
	"sem",
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["sem-saf"] = {
	"Safaitic",
	472586,
	"sem-cen",
	scripts = {"Narb"},
	translit_module = "Narb-translit",
}

m["sem-srb"] = {
	"Old South Arabian",
	35025,
	"sem-osa",
	scripts = {"Sarb"},
	translit_module = "Sarb-translit",
}

m["sem-tay"] = {
	"Taymanitic",
	24912301,
	"sem-cen",
	otherNames = {"Taymanite", "Thamudic A"},
	scripts = {"Narb"},
	translit_module = "Narb-translit",
}

m["sem-tha"] = {
	"Thamudic",
	843030,
	"sem-cen",
	scripts = {"Narb"},
	translit_module = "Narb-translit",
}

m["sem-wes-pro"] = {
	"Proto-West Semitic",
	98021726,
	"sem-wes",
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["sio-pro"] = { -- NB this is not Proto-Siouan-Catawban 'nai-sca-pro'
	"Proto-Siouan",
	34181,
	"sio",
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["sit-bok"] = {
	"Bokar",
	4938727,
	"sit-tan",
	otherNames = {"Ramo", "Pailibo"},
	scripts = Latn,
}

m["sit-cha"] = {
	"Chairel",
	5068066,
	"sit-luu",
	scripts = Latn,
}

m["sit-gkh"] = {
	"Gokhy",
	5578069,
	"tbq-lol",
	aliases = {"Gɔkhý", "Gɔkhy"},
	scripts = Latn,
}

m["sit-hrs-pro"] = {
	"Proto-Hrusish",
	nil,
	"sit-hrs",
	type = "reconstructed",
}

m["sit-jap"] = {
	"Japhug",
	3162245,
	"sit-rgy",
	otherNames = {"Chabao", "rGyalrong", "Rgyalrong", "Jiarong", "Gyarung", "Kuru"},
	scripts = Latn,
}

m["sit-kha-pro"] = {
	"Proto-Kham",
	nil,
	"sit-kha",
	type = "reconstructed",
}

m["sit-liz"] = {
	"Lizu",
	6660653,
	"sit-qia",
	scripts = Latn, -- and Ersu Shaba
}

m["sit-luu-pro"] = {
	"Proto-Luish",
	nil,
	"sit-luu",
	type = "reconstructed",
}

m["sit-mor"] = {
	"Moran",
	6909216,
	"tbq-bdg",
	aliases = {"Morān"},
	scripts = Latn,
}

m["sit-prn"] = {
	"Puiron",
	7259048,
	"sit-zem",
}

m["sit-pro"] = {
	"Proto-Sino-Tibetan",
	45961,
	"sit",
	type = "reconstructed",
	scripts = Latn,
}

m["sit-sit"] = {
	"Situ",
	19840830,
	"sit-rgy",
	otherNames = {"Eastern rGyalrong", "rGyalrong", "Rgyalrong", "rGyalrongic", "Gyalrong", "Gyarong", "rGyarong", "Gyarung", "Jiarong", "Jiarongyu", "Jyarong", "Jyarung", "Yelong", "Kuru"},
	scripts = Latn,
}

m["sit-tan-pro"] = {
	"Proto-Tani",
	nil,
	"sit-tan",
	type = "reconstructed",
	scripts = Latn,	-- needs verification
}

m["sit-tgm"] = {
	"Tangam",
	17041370,
	"sit-tan",
	scripts = Latn,
}

m["sit-tos"] = {
	"Tosu",
	7827899,
	"sit-qia",
	scripts = Latn, -- also Ersu Shaba
}

m["sit-tsh"] = {
	"Tshobdun",
	19840950,
	"sit-rgy",
	otherNames = {"Caodeng", "Sidaba", "rGyalrong", "Rgyalrong", "Jiarong", "Gyarung", "Kuru"},
	scripts = Latn,
}

m["sit-zbu"] = {
	"Zbu",
	19841106,
	"sit-rgy",
	otherNames = {"Ribu", "Rdzong'bur", "Rdzongmbur", "Showu", "rGyalrong", "Rgyalrong", "Jiarong", "Gyarung", "Kuru"},
	scripts = Latn,
}

m["sla-pro"] = {
	"Proto-Slavic",
	747537,
	"sla",
	aliases = {"Common Slavic"},
	type = "reconstructed",
	scripts = {"Latinx"},
	entry_name = {
		from = {"[ÀÁÃĀȀȂ]", "[àáãāȁȃ]", "[ÈÉẼĒȄȆ]", "[èéẽēȅȇ]", "[ÌÍĨĪȈȊ]", "[ìíĩīȉȋ]", "[ÒÓÕŌȌȎ]", "[òóõōȍȏ]", "[ÙÚŨŪȔȖ]", "[ùúũūȕȗ]", "[ỲÝỸȲ]", "[ỳýỹȳ]", "[Ǭ]", "[ǭ]", GRAVE, ACUTE, TILDE, MACRON, DGRAVE, INVBREVE},
		to   = {"A", "a", "E", "e", "I", "i", "O", "o", "U", "u", "Y", "y", "Ǫ", "ǫ"}
	},
	sort_key = {
		from = {"č" , "ď" , "ě" , "ę" , "ь" , "ľ" , "ň" , "ǫ" , "ř" , "š" , "ś" , "ť" , "ъ" , "ž" },
		to   = {"c²", "d²", "e²", "e³", "i²", "l²", "nj", "o²", "r²", "s²", "s³", "t²", "u²", "z²"},
	}
}

m["smi-pro"] = {
	"Proto-Samic",
	7251862,
	"smi",
	aliases = {"Proto-Sami"},
	type = "reconstructed",
	scripts = Latn,
	sort_key = {
		from = {"ā", "č" , "δ", "[ëē]", "ŋ" , "ń" , "ō", "š" , "θ" , "%([^()]+%)"},
		to   = {"a", "c²", "d", "e"   , "n²", "n³", "o", "s²", "t²"} },
}

m["son-pro"] = {
	"Proto-Songhay",
	nil,
	"son",
	aliases = {"Proto-Songhai"},
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["sqj-pro"] = {
	"Proto-Albanian",
	18210846,
	"sqj",
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["ssa-klk-pro"] = {
	"Proto-Kuliak",
	nil,
	"ssa-klk",
	aliases = {"Proto-Rub"},
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["ssa-kom-pro"] = {
	"Proto-Koman",
	nil,
	"ssa-kom",
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["ssa-pro"] = {
	"Proto-Nilo-Saharan",
	nil,
	"ssa",
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["syd-fne"] = {
	"Forest Nenets",
	1295107,
	"syd",
	scripts = {"Cyrl"},
	entry_name = {
		from = {"Ӑ", "ӑ", "[ӖЀ]", "[ӗѐ]", "[ӢЍ]", "[ӣѝ]", "Ӯ", "ӯ", BREVE, MACRON, GRAVE, ACUTE, DOTABOVE},
		to   = {"А", "а", "Е",    "е",    "И",    "и",    "У", "у"}},
}

m["syd-pro"] = {
	"Proto-Samoyedic",
	7251863,
	"syd",
	type = "reconstructed",
	scripts = Latn,
}

m["tai-pro"] = {
	"Proto-Tai",
	6583709,
	"tai",
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["tai-swe-pro"] = {
	"Proto-Southwestern Tai",
	nil,
	"tai-swe",
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["tbq-bdg-pro"] = {
	"Proto-Bodo-Garo",
	nil,
	"tbq-bdg",
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["tbq-kuk-pro"] = {
	"Proto-Kuki-Chin",
	nil,
	"tbq-kuk",
	otherNames = {"Proto-Kukish"},
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["tbq-lal-pro"] = {
	"Proto-Lalo",
	nil,
	"tbq-lol",
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["tbq-laz"] = {
	"Laze",
	17007626,
	"sit-nax",
	otherNames = {"Lare", "Shuitianhua"},
}

m["tbq-lob-pro"] = {
	"Proto-Lolo-Burmese",
	nil,
	"tbq-lob",
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["tbq-lol-pro"] = {
	"Proto-Loloish",
	7251855,
	"tbq-lol",
	otherNames = {"Proto-Nisoic"},
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["tbq-plg"] = {
	"Pai-lang",
	2879843,
	"tbq-lob",
	aliases = {"Bai-lang", "Pailang", "Bailang"},
	scripts = {"Hani", "Latinx"},
}

-- tbq-pro is now etymology-only

m["trk-dkh"] = {
	"Dukhan",
	nil,
	"trk-sib",
	aliases = {"Dukha"},
	scripts = {"Latn", "Cyrl", "Mong"},
}

m["trk-oat"] = {
	"Old Anatolian Turkish",
	7083390,
	"trk-ogz",
	scripts = {"ota-Arab"},
	ancestors = {"trk-ogz-pro"},
}

m["trk-pro"] = {
	"Proto-Turkic",
	3657773,
	"trk",
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["tup-gua-pro"] = {
	"Proto-Tupi-Guarani",
	nil,
	"tup-gua",
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["tup-kab"] = {
	"Kabishiana",
	15302988,
	"tup",
	aliases = {"Kabixiana", "Cabixiana", "Cabishiana", "Kapishana", "Capishana", "Kapišana", "Cabichiana", "Capichana", "Capixana"},
	scripts = Latn,
}

m["tup-pro"] = {
	"Proto-Tupian",
	10354700,
	"tup",
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["tuw-pro"] = {
	"Proto-Tungusic",
	nil,
	"tuw",
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["tuw-sol"] = {
	"Solon",
	30004,
	"tuw",
}

m["und-isa"] = {
	"Isaurian",
	16956868,
--	scripts = {"Xsux", "Hluw", "Latn"},
}

m["und-kas"] = {
	"Kassite",
	35612,
	aliases = {"Cassite", "Kassitic", "Kaššite"},
	scripts = {"Xsux"},
}

m["und-mil"] = {
	"Milang",
	6850761,
	scripts = {"Deva", "Latn"},
}

m["und-mmd"] = {
	"Mimi of Decorse",
	6862206,
	otherNames = {"Mimi of Gaudefroy-Demombynes", "Mimi-D"},
	scripts = Latn,
}

m["und-mmn"] = {
	"Mimi of Nachtigal",
	6862207,
	otherNames = {"Mimi-N"},
	scripts = Latn,
}

m["und-phi"] = {
	"Philistine",
	2230924,
	aliases = {"Philistian", "Philistinian"},
}

m["und-wji"] = {
	"Western Jicaque",
	3178610,
	"hok",
	otherNames = {"Jicaque of El Palmar", "Sula"},
	scripts = Latn,
}

m["urj-mdv-pro"] = {
	"Proto-Mordvinic",
	nil,
	"urj-mdv",
	type = "reconstructed",
	scripts = Latn,
}

m["urj-prm-pro"] = {
	"Proto-Permic",
	nil,
	"urj-prm",
	type = "reconstructed",
	scripts = Latn,
}

m["urj-pro"] = {
	"Proto-Uralic",
	288765,
	"urj",
	otherNames = {"Proto-Finno-Ugric", "Proto-Finno-Permic"}, -- PFU and PFP are subsumed into PU per [[Wiktionary:Beer parlour/2015/January#Merging Finno-Volgaic, Finno-Samic, Finno-Permic and Finno-Ugric into Uralic]]
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["urj-ugr-pro"] = {
	"Proto-Ugric",
	156631,
	"urj-ugr",
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["xnd-pro"] = {
	"Proto-Na-Dene",
	nil,
	"xnd",
	otherNames = {"Proto-Na-Dené", "Proto-Athabaskan-Eyak-Tlingit"},
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["xgn-kha"] = {
	"Khamnigan Mongol",
	3196052,
	"xgn",
	otherNames = {"Khamnigan", "Khamnigan Buryat"},
	scripts = {"Mong", "Latn", "Cyrl"},
}

m["xgn-mgr"] = {
	"Mangghuer",
	34214,
	"xgn",
	aliases = {"Monguor", "Mongour", "Mongor"},
	scripts = Latn, -- also "Mong", "Cyrl" ?
}

m["xgn-mgl"] = {
	"Mongghul",
	34214,
	"xgn",
	aliases = {"Monguor", "Mongour", "Mongor"},
	scripts = Latn, -- also "Mong", "Cyrl" ?
}

m["xgn-pro"] = {
	"Proto-Mongolic",
	2493677,
	"xgn",
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["ypk-pro"] = {
	"Proto-Yupik",
	nil,
	"ypk",
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["zhx-min-pro"] = {
	"Proto-Min",
	19646347,
	"zhx-min",
	type = "reconstructed",
	scripts = {"Latinx"},
}

m["zhx-sht"] = {
	"Shaozhou Tuhua",
	1920769,
	"zhx",
	otherNames = {"Xiangnan Tuhua", "Yuebei Tuhua", "Shipo", "Shina"},
	scripts = {"Nshu"},
}

m["zhx-tai"] = {
	"Taishanese",
	2208940,
	"zhx",
	aliases = {"Toishanese"},
	scripts = {"Hani"},
	ancestors = {"yue"},
}

m["zhx-teo"] = {
	"Teochew",
	36759,
	"zhx-min-hai",
	aliases = {"Chiuchow"},
	scripts = {"Hani"},
	ancestors = {"nan"},
}

m["zle-ono"] = {
	"Old Novgorodian",
	162013,
	"zle",
	scripts = {"Cyrs", "Glag"},
	translit_module = "Cyrs-Glag-translit",
	entry_name = {
		from = {u(0x0484)}, -- kamora
		to   = {}},
	sort_key = {
		from = {"оу"},
		to   = {"у" }},
}

m["zlw-ocs"] = {
	"Old Czech",
	593096,
	"zlw",
	scripts = Latn,
}

m["zlw-opl"] = {
	"Old Polish",
	149838,
	"zlw-lch",
	scripts = Latn,
}

m["zlw-pom"] = {
	"Pomeranian",
	149588,
	"zlw-lch",
	scripts = Latn,
}

m["zlw-slv"] = {
	"Slovincian",
	36822,
	"zlw-lch",
	scripts = Latn,
	ancestors = {"zlw-pom"},
}

return m