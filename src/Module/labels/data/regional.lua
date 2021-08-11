local labels = {}
local aliases = {}
local deprecated = {}

local m_data_functions = require("Module:labels/data/functions")

-- Generic

--not sure where to put this
labels["Classical"] = {
	special_display = "[[Classical <canonical_name>]]",
	regional_categories = {"Classical"},
}
aliases["classical"] = "Classical"

labels["Epigraphic"] = {
	special_display = "[[w:Epigraphy|Epigraphic <canonical_name>]]",
	regional_categories = {"Epigraphic"},
}

labels["regional"] = {
	regional_categories = {"Regional"},
}


-- Africa

-- Africa A
labels["Africa"] = {
	regional_categories = {"African"},
}
aliases["African"] = "Africa"

labels["Algeria"] = {
	display = "Algeria",
	regional_categories = {"Algerian"},
}
aliases["Algerian"] = "Algeria"

labels["Angola"] = {
	display = "[[w:Angola|Angola]]",
	regional_categories = {"Angolan"},
}
aliases["Angolan"] = "Angola"

-- Africa B
labels["Botswana"] = {
	regional_categories = {"Botswanan"},
}

labels["Burundi"] = {
	regional_categories = {"Burundian"},
}
aliases["Burundian"] = "Burundi"

-- Africa C
labels["Cape Verde"] = {
	regional_categories = {"Cape Verdean"},
}
aliases["Cape Verdean"] = "Cape Verde"

labels["Chad"] = {
	display = "Chad",
	regional_categories = {"Chadian"},
}
aliases["Chadian"] = "Chad"

labels["Congo"] = {
	display = "Congo",
	regional_categories = {"Congolese"},
} -- these could be split if need be
aliases["Democratic Republic of the Congo"] = "Congo"
aliases["Democratic Republic of Congo"] = "Congo"
aliases["DR Congo"] = "Congo"
aliases["Congo-Kinshasa"] = "Congo"
aliases["Republic of the Congo"] = "Congo"
aliases["Republic of Congo"] = "Congo"
aliases["Congo-Brazzaville"] = "Congo"
aliases["Congolese"] = "Congo"

-- Africa D
labels["Durban"] = {
	display = "[[Durban]]",
	regional_categories = {"Durban"},
}

-- Africa E
labels["East Africa"] = {
	display = "[[East Africa]]",
	regional_categories = {"East African"},
}
aliases["East African"] = "East Africa"

labels["Egypt"] = {
	regional_categories = {"Egyptian"},
}
aliases["Egyptian"] = "Egypt"

labels["Equatorial Guinea"] = {
    display = "[[w:Equatorial Guinea|Equatorial Guinea]]",
	regional_categories = {"Equatorial Guinean"},
}
aliases["Equatorial Guinean"] = "Equatorial Guinea"
aliases["Equatoguinean"] = "Equatorial Guinea"

-- Africa F

-- Africa G
labels["Ghana"] = {
	regional_categories = {"Ghanaian"},
}

-- Africa H
-- Africa I
-- Africa J

-- Africa K
labels["Kenya"] = {
    display = "[[Kenya]]",
	regional_categories = {"Kenyan"},
}
aliases["Kenyan"] = "Kenya"

-- Africa L
labels["Liberia"] = {
	regional_categories = {"Liberian"},
}
aliases["Liberian"] = "Liberia"

-- Africa M
labels["Mali"] = {
	display = "Mali",
	regional_categories = {"Malian"},
}
aliases["Malian"] = "Mali"

labels["Mauritania"] = {
	display = "Mauritania",
	regional_categories = {"Mauritanian"},
}
aliases["Mauritanian"] = "Mauritania"

labels["Morocco"] = {
	regional_categories = {"Moroccan"},
}
aliases["Moroccan"] = "Morocco"

labels["Mozambique"] = {
	display = "[[w:Mozambique|Mozambique]]",
	regional_categories = {"Mozambican"},
}
aliases["Mozambican"] = "Mozambique"

-- Africa N
labels["Namibia"] = {
	regional_categories = {"Namibian"},
}
aliases["Namibian"] = "Namibia"

labels["Natal"] = {
	display = "[[Natal]]",
	regional_categories = {"Natal"},
}

labels["Niger"] = {
	regional_categories = {"Nigerien"},
}
aliases["Nigerien"] = "Niger"

labels["Nigeria"] = {
	regional_categories = {"Nigerian"},
}
aliases["Nigerian"] = "Nigeria"

-- Africa O
-- Africa P
-- Africa Q

-- Africa R
labels["Rhodesia"] = {
	display = "[[w:Rhodesia|Rhodesia]]",
	regional_categories = {"Rhodesian"},
}
aliases["Rhodesian"] = "Rhodesia"

labels["Rwanda"] = {
	display = "Rwanda",
	regional_categories = {"Rwandan"},
}
aliases["Rwandan"] = "Rwanda"

labels["Réunion"] = {
	regional_categories = {"Réunion"},
}

-- Africa S
labels["São Tomé and Príncipe"] = {
	display = "[[w:São Tomé and Príncipe|São Tomé and Príncipe]]",
	regional_categories = {"Santomean"},
}
aliases["Santomean"] = "São Tomé and Príncipe"
aliases["São Tomé"] = "São Tomé and Príncipe"
aliases["São Toméan"] = "São Tomé and Príncipe"
aliases["Sao Tomean"] = "São Tomé and Príncipe"

labels["South Africa"] = {
	display = "[[w:South Africa|South Africa]]",
	regional_categories = {"South African"},
}
aliases["South African"] = "South Africa"

labels["Sudan"] = {
	display = "[[w:Sudan|Sudan]]",
	regional_categories = {"Sudanese"},
}
aliases["Sudanese"] = "Sudan"

-- Africa T
labels["Tanzania"] = {
	regional_categories = {"Tanzanian"},
}
aliases["Tanzanian"] = "Tanzania"

labels["Tunisia"] = {
	display = "[[Tunisia]]",
	regional_categories = {"Tunisian"},
}
aliases["Tunisian"] = "Tunisia"

-- Africa U
labels["Uganda"] = {
	display = "[[Uganda]]",
	regional_categories = {"Ugandan"},
}
aliases["Ugandan"] = "Uganda"

-- Africa V

-- Africa W
labels["West Africa"] = {
	regional_categories = {"West African"},
}
aliases["West African"] = "West Africa"

-- Africa X
-- Africa Y

-- Africa Z
labels["Zimbabwe"] = {
	display = "[[Zimbabwe]]",
	regional_categories = {"Zimbabwe"},
}

labels["Zululand"] = {
	display = "[[Zululand]]",
	regional_categories = {"Zululand"},
}


-- North America

-- NA A
labels["Acadia"] = {
	display = "Acadian",
	regional_categories = {"Acadian"},
}
aliases["Acadian"] = "Acadia"

labels["Alaska"] = {
	regional_categories = {"Alaskan"},
}
aliases["Alaskan"] = "Alaska"

labels["Alberta"] = {
	regional_categories = {"Canadian"},
}

labels["American spelling"] = {
	display = "American spelling",
	Wikipedia = "American and British English spelling differences",
	plain_categories = {"American English forms"},
	language = "en",
}

-- kludge, needed here for [[Template:standard spelling of]] et al
labels["American form"] = {
	display = "US",
	Wikipedia = "American and British English spelling differences",
	plain_categories = {"American English forms"},
	language = "en",
}
aliases["US form"] = "American form"

labels["Appalachia"] = {
	display = "[[Appalachia]]",
	regional_categories = {"Appalachian"},
}
aliases["Appalachian"] = "Appalachia"

labels["Atlantic Canada"] = {
	regional_categories = {"Atlantic Canadian"},
}
aliases["Atlantic Canadian"] = "Atlantic Canada"

-- NA B
labels["Baltimore"] = {
	regional_categories = {"Baltimore"},
}

labels["Bermuda"] = {
	regional_categories = {"Bermudan"},
}
aliases["Bermudan"] = "Bermuda"

labels["British Columbia"] = {
	regional_categories = {"Canadian"},
}
aliases["British Columbian"] = "British Columbia"

-- NA C
labels["Cajun"] = {
	display = "[[w:Cajun|Louisiana]]",
	regional_categories = {"Louisiana"},
}

labels["California"] = {
	regional_categories = {"California"},
}
aliases["Californian"] = "California"

labels["Canada"] = {
	display = "[[w:Canada|Canada]]",
	regional_categories = {"Canadian"},
}
aliases["Canadian"] = "Canada"

labels["Canadian Prairies"] = {
	regional_categories = {"Canadian"},
}

labels["Canadian spelling"] = {
	display = "Canadian spelling",
	Wikipedia = true,
	plain_categories = {"Canadian English forms"},
	language = "en",
}

-- kludge, needed here for [[Template:standard spelling of]] et al
labels["Canadian form"] = {
	display = "Canadian",
	Wikipedia = true,
	plain_categories = {"Canadian English forms"},
	language = "en",
}

labels["Chicago"] = {
	regional_categories = {"Chicago"},
}

labels["Chipilo"] = {
	display = "[[w:Chipilo|Chipilo]]",
	regional_categories = {"Chipilo"},
}

labels["Cincinnati"] = {
	display = "[[Cincinnati]]",
	regional_categories = {"Cincinnati"},
}

-- NA D
labels["DC"] = {
	display = "[[w:District of Columbia|District of Columbia]]",
	regional_categories = {"DC"},
}
aliases["District of Columbia"] = "DC"
aliases["Washington, D.C."] = "DC"
aliases["D.C."] = "DC"
aliases["Washington, DC"] = "DC"

-- NA E
-- NA F

-- NA G
labels["Georgia (US)"] = {
	display = "[[w:Georgia (U.S. state)|Georgia]]",
	regional_categories = {"Georgian (US)"},
}

-- NA H

-- NA I
labels["Indiana"] = {
	display = "[[w:Indiana|Indiana]]",
	regional_categories = {"Indiana"},
}
aliases["Indianan"] = "Indiana"
aliases["Indianian"] = "Indiana"

-- NA J
-- NA K

-- NA L
labels["Labrador"] = {
	display = "[[Labrador]]",
	regional_categories = {"Labrador"},
}

labels["Louisiana"] = {
	display = "[[w:Louisiana|Louisiana]]",
	regional_categories = {"Louisiana"},
}
aliases["New Orleans"] = "Louisiana"

-- NA M
labels["Manitoba"] = {
	display = "[[w:Manitoba|Manitoba]]",
	regional_categories = {"Canadian"},
}

labels["Maryland"] = {
	display = "[[w:Maryland|Maryland]]",
	regional_categories = {"Maryland"},
}

labels["Mexico"] = {
	display = "[[w:Mexico|Mexico]]",
	regional_categories = {"Mexican"},
}
aliases["Mexican"] = "Mexico"

labels["Michigan"] = {
	regional_categories = {"Michigan"},
}

labels["Midwest US"] = {
	display = "[[w:Midwestern United States|Midwestern US]]",
	regional_categories = {"Midwest US"},
}
aliases["Midwestern US"] = "Midwest US"

labels["Mississippi"] = {
	display = "[[w:Mississippi|Mississippi]]",
	regional_categories = {"Mississippi"},
}
aliases["Mississippian"] = "Mississippi"

labels["Missouri"] = {
	display = "[[w:Missouri|Missouri]]",
	regional_categories = {"Missourian"},
}
aliases["St Louis, Missouri"] = "Missouri"
aliases["St. Louis, Missouri"] = "Missouri"

labels["Morelos"] = {
	display = "[[w:Morelos|Morelos]]",
	regional_categories = {"Morelos"},
}

-- NA N
labels["New Brunswick"] = {
	regional_categories = {"Atlantic Canadian"},
}

labels["New England"] = {
	display = "[[w:New England|New England]]",
	regional_categories = {"New England"},
}

labels["New Jersey"] = {
	display = "[[w:New Jersey|New Jersey]]",
	regional_categories = {"New Jersey"},
}

labels["New Mexico"] = {
	display = "[[w:New Mexico|New Mexico]]",
	regional_categories = {"New Mexican"},
}
aliases["New Mexican"] = "New Mexico"

labels["New York"] = {
	display = "[[w:New York|New York]]",
	regional_categories = {"New York"},
}
aliases["NY"] = "New York"

labels["New York City"] = {
	display = "[[w:New York City|New York City]]",
	regional_categories = {"New York City"},
}
aliases["NYC"] = "New York City"
aliases["New York city"] = "New York City"

labels["Newfoundland"] = {
	display = "[[Newfoundland English|Newfoundland]]",
	regional_categories = {"Newfoundland"},
}

labels["North Carolina"] = {
	display = "[[w:North Carolina|North Carolina]]",
	regional_categories = {"North Carolinian"},
}
aliases["North Carolinian"] = "North Carolina"
aliases["NC"] = "North Carolina"

labels["Northwest Territories"] = {
	regional_categories = {"Canadian"},
}

labels["Northwestern US"] = {
	display = "[[w:Northwestern United States|Northwestern US]]",
	regional_categories = {"Northwestern US"},
}
aliases["northwestern US"] = "Northwestern US"

labels["Nova Scotia"] = {
	regional_categories = {"Atlantic Canadian"},
}
aliases["Nova Scotian"] = "Nova Scotia"

labels["Nunavut"] = {
	regional_categories = {"Canadian"},
}

-- NA O
labels["Oaxaca"] = {
	display = "[[w:Oaxaca|Oaxaca]]",
	regional_categories = {"Oaxacan"},
}
aliases["Oaxacan"] = "Oaxaca"

labels["Ohio"] = {
	display = "[[Ohio]]",
	regional_categories = {"Ohioan"},
}
aliases["Ohioan"] = "Ohio"
aliases["OH"] = "Ohio"

labels["Ontario"] = {
	regional_categories = {"Canadian"},
}

-- NA P
labels["Pennsylvania"] = {
	display = "[[w:Pennsylvania|Pennsylvania]]",
	regional_categories = {"Pennsylvanian"},
}
aliases["Pennsylvanian"] = "Pennsylvania"

labels["Philadelphia"] = {
	display = "[[w:Philadelphia|Philadelphia]]",
	regional_categories = {"Pennsylvanian"},
} -- can be split off if enough entries in it arise; group with PA for now

labels["Pittsburgh"] = {
	display = "[[w:Pittsburgh|Pittsburgh]]",
	regional_categories = {"Pennsylvanian"},
} -- can be split off if enough entries in it arise; group with PA for now

labels["Prince Edward Island"] = {
	regional_categories = {"Atlantic Canadian"},
}

-- NA Q
labels["Quebec"] = {
	regional_categories = {"Quebec"},
}
aliases["Québec"] = "Quebec"

-- NA R
labels["Rhode Island"] = {
	regional_categories = {"Rhode Island"},
}

-- NA S
labels["Saskatchewan"] = {
	regional_categories = {"Canadian"},
}

labels["Sinaloa"] = {
	regional_categories = {"Sinaloa"},
}

labels["Southern US"] = {
	display = "[[w:Southern United States|Southern US]]",
	regional_categories = {"Southern US"},
}
aliases["southern US"] = "Southern US"
aliases["US South"] = "Southern US"
aliases["US Southern"] = "Southern US"

labels["Southwestern US"] = {
	display = "[[w:Southwestern United States|Southwestern US]]",
	regional_categories = {"Southwestern US"},
}
aliases["Southwest US"] = "Southwestern US"
aliases["southwest US"] = "Southwestern US"
aliases["southwestern US"] = "Southwestern US"

-- NA T
labels["Texas"] = {
	display = "[[w:Texas|Texas]]",
	regional_categories = {"Texan"},
}
aliases["TX"] = "Texas"
aliases["Texan"] = "Texas"

-- NA U
labels["Upper Midwest US"] = {
	display = "[[w:Upper Midwest|Upper Midwestern US]]",
	regional_categories = {"Upper Midwest US"},
}
aliases["Upper Midwestern US"] = "Upper Midwest US"

labels["US"] = {
	display = "[[w:United States|US]]",
	regional_categories = {"American"},
}
aliases["U.S."] = "US"
aliases["United States"] = "US"
aliases["United States of America"] = "US"
aliases["USA"] = "US"
aliases["America"] = "US" -- or should these be aliases of 'North America'?
aliases["American"] = "US"

-- NA V
labels["Virginia"] = {
	display = "[[w:Virginia|Virginia]]",
	regional_categories = {"Virginian"},
}
aliases["Virginian"] = "Virginia"

-- NA W

labels["Western US"] = {
	display = "[[w:Western United States|Western US]]",
	regional_categories = {"Western US"},
}
aliases["western US"] = "Western US"

labels["Wisconsin"] = {
	regional_categories = {"Wisconsin"}
}

-- NA X

-- NA Y
labels["Yukon"] = {
	regional_categories = {"Canadian"},
}

-- NA Z

-- Central America and Caribbean
labels["Caribbean"] = {
	display = "[[Caribbean]]",
	regional_categories = {"Caribbean"},
}
aliases["West Indies"] = "Caribbean"

labels["Central America"] = {
	regional_categories = {"Central American"},
}
aliases["Central American"] = "Central America"

-- CAaC A
labels["Antilles"] = {
	regional_categories = {"Antilles"},
}

-- CAaC B
labels["Bahamas"] = {
	regional_categories = {"Bahaman"},
}
aliases["Bahaman"] = "Bahamas"

labels["Barbados"] = {
	display = "[[w:Barbados|Barbados]]",
	regional_categories = {"Barbadian"},
}
aliases["Barbadian"] = "Barbados"

labels["Belize"] = {
	display = "[[w:Belize|Belize]]",
	regional_categories = {"Belizean"},
}
aliases["Belizean"] = "Belize"

-- CAaC C

labels["Costa Rica"] = {
	regional_categories = {"Costa Rican"},
}
aliases["Costa Rican"] = "Costa Rica"

labels["Cuba"] = {
	regional_categories = {"Cuban"},
}
aliases["Cuban"] = "Cuba"

-- CAaC D

labels["Dominican Republic"] = {
	regional_categories = {"Dominican"},
}

-- CAaC E

labels["El Salvador"] = {
	regional_categories = {"Salvadorian"},
}
aliases["Salvadorian"] = "El Salvador"

-- CAaC F

-- CAaC G
labels["Guatemala"] = {
	regional_categories = {"Guatemalan"},
}
aliases["Guatemalan"] = "Guatemala"

-- CAaC H
labels["Haiti"] = {
	display = "[[w:Haiti|Haiti]]",
	regional_categories = {"Haitian"},
}

labels["Honduras"] = {
	regional_categories = {"Honduran"},
}
aliases["Honduran"] = "Honduras"

-- CAaC I

-- CAaC J
labels["Jamaica"] = {
	display = "[[w:Jamaica|Jamaica]]",
	regional_categories = {"Jamaican"},
}
aliases["Jamaican"] = "Jamaica"

-- CAaC K
-- CAaC L
-- CAaC M

-- CAaC N
labels["Nicaragua"] = {
	regional_categories = {"Nicaraguan"},
}
aliases["Nicaraguan"] = "Nicaragua"

-- CAaC O

-- CAaC P
labels["Panama"] = {
	regional_categories = {"Panamanian"},
}
aliases["Panamanian"] = "Panama"

labels["Puerto Rico"] = {
	regional_categories = {"Puerto Rican"},
}
aliases["Puerto Rican"] = "Puerto Rico"

-- CAaC Q
-- CAaC R
-- CAaC S
-- CAaC T
-- CAaC U
-- CAaC V
-- CAaC W
-- CAaC X
-- CAaC Y
-- CAaC Z

-- South America
labels["South America"] = {
	regional_categories = {"South American"},
}
aliases["South American"] = "South America"

-- SA A
labels["Andes"] = {
	regional_categories = {"Andean"}
}
aliases["Andean"] = "Andes"

labels["Argentina"] = {
	display = "[[w:Argentina|Argentina]]",
	regional_categories = {"Argentinian"},
}
aliases["Argentinian"] = "Argentina"

-- SA B
labels["Bahia"] = {
	display = "Bahia",
	regional_categories = {"Bahian"},
}
aliases["Baiano"] = "Bahia"
aliases["Bahian"] = "Bahia"

labels["Bolivia"] = {
	display = "[[w:Bolivia|Bolivia]]",
	regional_categories = {"Bolivian"},
}
aliases["Bolivian"] = "Bolivia"

labels["Brazil"] = {
	display = "[[w:Brazil|Brazil]]",
	regional_categories = {"Brazilian"},
}
aliases["Brazilian"] = "Brazil"

-- SA C
labels["Chile"] = {
	display = "[[w:Chile|Chile]]",
	regional_categories = {"Chilean"},
}
aliases["Chilean"] = "Chile"

labels["Colombia"] = {
	display = "[[w:Colombia|Colombia]]",
	regional_categories = {"Colombian"},
}
aliases["Colombian"] = "Colombia"

-- SA D

-- SA E
labels["Ecuador"] = {
	display = "[[w:Ecuador|Ecuador]]",
	regional_categories = {"Ecuadorian"},
}
aliases["Ecuadorian"] = "Ecuador"

-- SA F

-- SA G
labels["Guyana"] = {
	display = "[[w:Guyana|Guyana]]",
	regional_categories = {"Guyanese"},
}
aliases["Guyanese"] = "Guyana"

-- SA H
-- SA I
-- SA J
-- SA K
-- SA L
-- SA M

-- SA N
labels["Northeast Brazil"] = {
	regional_categories = {"Northeastern Brazilian"} 
}
aliases["Nordestino"] = "Northeast Brazil"
aliases["Nordeste"] = "Northeast Brazil"
aliases["Northeastern Brazilian"] = "Northeast Brazil"
aliases["Northeast Brazilian"] = "Northeast Brazil"

-- SA O

-- SA P
labels["Paraguay"] = {
	display = "[[w:Paraguay|Paraguay]]",
	regional_categories = {"Paraguayan"},
}
aliases["Paraguayan"] = "Paraguay"

labels["Paraná"] = {
	display = "[[w:Paraná (state)|Paraná]]",
	regional_categories = {"Paranaense"},
}
aliases["Paranaense"] = "Paraná"

labels["Peru"] = {
	display = "[[w:Peru|Peru]]",
	regional_categories = {"Peruvian"},
}
aliases["Peruvian"] = "Peru"

-- SA Q

-- SA R
labels["Rio de Janeiro"] = {
	display = "[[w:Rio de Janeiro|Rio de Janeiro]]",
	regional_categories = {"Carioca"},
}
aliases["Fluminense"] = "Rio de Janeiro"
aliases["Carioca"] = "Rio de Janeiro"

labels["Rio Grande do Sul"] = {
	regional_categories = {"Gaúcho"} 
}
aliases["Gaúcho"] = "Rio Grande do Sul"
aliases["Gaucho"] = "Rio Grande do Sul"

-- SA S
labels["São Paulo"] = {
	display = "[[w:São Paulo (state)|São Paulo]]",
	regional_categories = {"Paulista"},
}
aliases["Sao Paulo"] = "São Paulo"
aliases["Paulista"] = "São Paulo"

labels["South Brazil"] = {
	regional_categories = {"Southern Brazilian"} 
}
aliases["Southern Brazilian"] = "South Brazil"
aliases["South Brazilian"] = "South Brazil"

labels["Suriname"] = {
	display = "[[w:Suriname|Suriname]]",
	regional_categories = {"Surinamese"},
}
aliases["Surinamese"] = "Suriname"

-- SA T
labels["Trinidad and Tobago"] = {
	display = "[[Trinidad and Tobago]]",
	regional_categories = {"Trinidad and Tobago"},
}
aliases["Trinidad"] = "Trinidad and Tobago"
aliases["Tobago"] = "Trinidad and Tobago"
aliases["Trinidadian"] = "Trinidad and Tobago"
aliases["Tobagonian"] = "Trinidad and Tobago"
aliases["Trinidadian and Tobagonian"] = "Trinidad and Tobago"

-- SA U
labels["Uruguay"] = {
	display = "[[w:Uruguay|Uruguay]]",
	regional_categories = {"Uruguayan"},
}
aliases["Uruguayan"] = "Uruguay"

-- SA V
labels["Venezuela"] = {
	display = "[[w:Venezuela|Venezuela]]",
	regional_categories = {"Venezuelan"},
}
aliases["Venezuelan"] = "Venezuela"

-- SA W
-- SA X
-- SA Y
-- SA Z

-- Asia

-- Asia A
labels["Adana"] = {
	display = "[[w:Adana|Adana]]",
	regional_categories = {"Adana"},
}
aliases["Atana"] = "Adana"

labels["Afyonkarahisar"] = {
	display = "[[w:Afyonkarahisar|Afyonkarahisar]]",
	regional_categories = {"Afyonkarahisar"},
}
aliases["Afyon"] = "Afyonkarahisar"

labels["Ağın"] = {
	display = "[[w:Ağın|Ağın]]",	
	regional_categories = {"Ağın"},
}
aliases["Aghin"] = "Ağın"
aliases["Vaghaver"] = "Ağın"

labels["Aghjabadi"] = {
	display = "[[w:Aghjabadi District|Aghjabadi]]",
	regional_categories = {"Aghjabadi"},
}

labels["Ağrı"] = {
	display = "[[w:Ağrı|Ağrı]]",
	regional_categories = {"Ağrı"},
}
aliases["Aghri"] = "Ağrı"
aliases["Karaköse"] = "Ağrı"

labels["Ahlat"] = {
	display = "[[w:Ahlat|Ahlat]]",
	regional_categories = {"Ahlat"},
}
aliases["Khlat"] = "Ahlat"
aliases["Xlat"] = "Ahlat"

labels["Akhalkalaki"] = {
	display = "[[w:Akhalkalaki|Akhalkalaki]]",
	regional_categories = {"Akhalkalaki"},
}
aliases["Akhalkalak"] = "Akhalkalaki"
aliases["Akhlkalak"] = "Akhalkalaki"

labels["Akn"] = {
	display = "[[w:Kemaliye|Akn]]",
	regional_categories = {"Akn"},
}
aliases["Egin"] = "Akn"
aliases["Eğin"] = "Akn"

labels["Alashkert"] = {
	display = "[[w:Eleşkirt|Alashkert]]",
	regional_categories = {"Alashkert"},
}
aliases["Eleşkirt"] = "Alashkert"
aliases["Alaškert"] = "Alashkert"

labels["Şirvan"] = {
	display = "[[w:Şirvan, Azerbaijan|Shirvan]]",
	regional_categories = {"Shirvan"},
}
aliases["Şirvan"] = "Şirvan"
aliases["Əli Bayramlı"] = "Şirvan"
aliases["Ali Bayramli"] = "Şirvan"

labels["Amur"] = {
	display = "[[w:Amur|Amur]]",
	regional_categories = {"Amur"},
}

labels["Ankara"] = {
	display = "[[w:Ankara|Ankara]]",
	regional_categories = {"Ankara"},
}

labels["Antalya"] = {
	display = "[[w:Antalya|Antalya]]",
	regional_categories = {"Antalya"},
}

labels["Arapgir"] = {
	display = "[[w:Arapgir|Arapgir]]",
	regional_categories = {"Arapgir"},
}
aliases["Arapkir"] = "Arapgir"
aliases["Arabkir"] = "Arapgir"

labels["Ardabil"] = {
	display = "[[w:Ardabil|Ardebil]]",
	regional_categories = {"Ardabil"},
}
aliases["Ardebil"] = "Ardabil"
aliases["Ərdəbil"] = "Ardabil"
aliases["Ardabīl "] = "Ardabil"
aliases["Ardebīl"] = "Ardabil"

labels["Ardanuç"] = {
	display = "[[w:Ardanuç|Ardanuç]]",
	regional_categories = {"Ardanuç"},
}
aliases["Artanuj"] = "Ardanuç"
aliases["Ardanuji"] = "Ardanuç"

labels["Artvin"] = {
	display = "[[w:Artvin|Artvin]]",
	regional_categories = {"Artvin"},
}
aliases["Ardvin"] = "Artvin"
aliases["Ardvini"] = "Artvin"

labels["Aslanbeg"] = {
	display = "[[w:Arslanbey, Kartepe|Aslanbeg]]",
	regional_categories = {"Aslanbeg"},
}
aliases["Aslanbek"] = "Aslanbeg"

-- Asia B
labels["Baku"] = {
	display = "[[w:Baku|Baku]]",
	regional_categories = {"Baku"},
}
aliases["Bakı"] = "Baku"
aliases["Baki"] = "Baku"

labels["Balakan"] = {
	display = "[[w:Balakan District|Balakan]]",
	regional_categories = {"Balakan"},
}
aliases["Balakən"] = "Balakan"

labels["Banten"] = {
	display = "[[w:Bantenese|Banten]]",
	regional_categories = {"Banten"},
}
aliases["Bantenese"] = "Banten"

labels["Balıkesir"] = {
	display = "[[w:Balıkesir|Balıkesir]]",
	regional_categories = {"Balıkesir"},
}

labels["Bilasuvar"] = {
	display = "[[w:Bilasuvar District|Bilasuvar]]",
	regional_categories = {"Bilasuvar"},
}

labels["Bitlis"] = {
	display = "[[w:Bitlis|Bitlis]]",
	regional_categories = {"Bitlis"},
}
aliases["Baghesh"] = "Bitlis"

labels["Bogor"] = {
	regional_categories = {"Bogor"},
}

labels["Borchaly"] = {
	display = "[[w:Borchaly Uyezd|Borchaly]]",
	regional_categories = {"Borchaly"},
}
aliases["Borçalı"] = "Borchaly"
aliases["Borchali"] = "Borchaly"
aliases["Borchalu"] = "Borchaly"

labels["Bulanık"] = {
	display = "[[w:Bulanık|Bulanık]]",
	regional_categories = {"Bulanık"},
}
aliases["Bulanik"] = "Bulanık"
aliases["Bulanikh"] = "Bulanık"

labels["Dmanisi"] = {
	display = "[[w:Dmanisi|Dmanisi]]",
	regional_categories = {"Dmanisi"},
}
aliases["Başkeçid"] = "Dmanisi"

labels["Brebes"] = {
	regional_categories = {"Brebes"},
}
aliases["Brebian"] = "Brebes"

labels["Brunei"] = {
	display = "[[w:Brunei|Brunei]]",
	regional_categories = {"Bruneian"},
}

labels["Burdur"] = {
	display = "[[w:Burdur|Burdur]]",
	regional_categories = {"Burdur"},
}

labels["Bursa"] = {
	display = "[[w:Bursa|Bursa]]",
	regional_categories = {"Bursa"},
}

-- Asia C
labels["Çanakkale"] = {
	display = "[[w:Çanakkale|Çanakkale]]",
	regional_categories = {"Çanakkale"},
}

labels["Cebu"] = {
	regional_categories = {"Cebu"}
}

labels["Çemişgezek"] = {
	display = "[[w:Çemişgezek|Çemişgezek]]",
	regional_categories = {"Çemişgezek"},
}
aliases["Chmshkatsag"] = "Çemişgezek"
aliases["Çemişkezek"] = "Çemişgezek"
aliases["Čmškacag"] = "Çemişgezek"

labels["Chakhar"] = {
	display = "[[w:Chakhar|Chakhar]]",
	regional_categories = {"Chakhar"},
}

labels["China"] = {
	display = "[[w:China|China]]",
	regional_categories = {"Chinese"},
}

labels["Cirebon"] = {
	regional_categories = {"Cirebon"},
}
aliases["Cirebonese"] = "Cirebon"

labels["Cyprus"] = {
	display = "[[w:Cyprus|Cyprus]]",
	regional_categories = {"Cypriot"},
}
aliases["cypriot"] = "Cyprus"
aliases["Cypriot"] = "Cyprus"

-- Asia D

labels["Dashtestan"] = {
	display = "[[w:Dashtestan County|Dashtestan]]",
	regional_categories = {"Dashtestani"},
}

labels["Dandong"] = {
	display = "[[w:Dandong|Dandong]]",
	regional_categories = {"Dandong"},
}

labels["Delhi"] = {
	display = "[[w:Delhi|Delhi]]",
	regional_categories = {"Delhi"},
}

labels["Derbent"] = {
	display = "[[w:Derbent|Derbent]]",
	regional_categories = {"Derbent"},
}
aliases["Dərbənd"] = "Derbent"

labels["Divriği"] = {
	display = "[[w:Divriği|Divriği]]",
	regional_categories = {"Divriği"},
}
aliases["Tevrik"] = "Divriği"
aliases["Tewrik"] = "Divriği"
aliases["Dewrik"] = "Divriği"
aliases["Devrik"] = "Divriği"
aliases["Devrike"] = "Divriği"
aliases["Dewrike"] = "Divriği"

labels["Denizli"] = {
	display = "[[w:Denizli|Denizli]]",
	regional_categories = {"Denizli"},
}

labels["Diyarbakır"] = {
	display = "[[w:Diyarbakır|Diyarbakır]]",
	regional_categories = {"Diyarbakır"},
}
aliases["Diyarbakir"] = "Diyarbakır"
aliases["Diyarbekir"] = "Diyarbakır"
aliases["Tigranakert"] = "Diyarbakır"

labels["DIY"] = {
	display = "[[w:Special Region of Yogyakarta|DIY]]",
	regional_categories = {"DIY"},
}

-- Asia E
labels["East Sakhalin"] = {
	display = "East [[w:Sakhalin|Sakhalin]]", 
	regional_categories = {"East Sakhalin"},
}

labels["Elazığ"] = {
	display = "[[w:Elazığ|Elazığ]]",
	regional_categories = {"Elazığ"},
}
aliases["Elazig"] = "Elazığ"
aliases["Elazigh"] = "Elazığ"

labels["Erciş"] = {
	display = "[[w:Erciş|Erciş]]",
	regional_categories = {"Erciş"},
}
aliases["Ercis"] = "Erciş"
aliases["Archesh"] = "Erciş"
aliases["Artchesh"] = "Erciş"
aliases["Erdîş"] = "Erciş"

labels["Erzincan"] = {
	display = "[[w:Erzincan|Erzincan]]",
	regional_categories = {"Erzincan"},
}
aliases["Yerznka"] = "Erzincan"
aliases["Erznka"] = "Erzincan"
aliases["Erzinjan"] = "Erzincan"

labels["Erzurum"] = {
	display = "[[w:Erzurum|Erzurum]]",
	regional_categories = {"Erzurum"},
}
aliases["Karin"] = "Erzurum"
aliases["Erzrum"] = "Erzurum"

labels["Eskişehir"] = {
	display = "[[w:Eskişehir|Eskişehir]]",
	regional_categories = {"Eskişehir"},
}

-- Asia F
labels["Fengkai"] = {
	display = "[[w:Fengkai County|Fengkai]]",
	regional_categories = {"Fengkai"},
}

labels["Fuzuli"] = {
	display = "[[w:Fuzuli District|Fuzuli]]",
	regional_categories = {"Fuzuli"},
}
aliases["Füzuli"] = "Fuzuli"
aliases["Fizuli"] = "Fuzuli"

-- Asia G
labels["Gadabay"] = {
	display = "[[w:Gadabay District|Gadabay]]",
	regional_categories = {"Gadabay"},
}
aliases["Gədəbəy"] = "Gadabay"
aliases["Getabek"] = "Gadabay"

labels["Ganja"] = {
	display = "[[w:Ganja, Azerbaijan|Ganja]]",
	regional_categories = {"Ganja"},
}
aliases["Gandzak"] = "Ganja"
aliases["Gəncə"] = "Ganja"

labels["Gansu"] = {
	display = "[[w:Gansu, China|Gansu]]",
	regional_categories = {"Gansu"},
}

labels["Giresun"] = {
	display = "[[w:Giresun|Giresun]]",
	regional_categories = {"Giresun"},
}

labels["Goa"] = {
	display = "[[w:Goa|Goa]]",
	regional_categories = {"Goan"},
}
aliases["Goan"] = "Goa"

labels["Goranboy"] = {
	display = "[[w:Goranboy District|Goranboy]]",
	regional_categories = {"Goranboy"},
}

labels["Goris"] = {
	display = "[[w:Goris|Goris]]",
	regional_categories = {"Goris"},
}

labels["Goychay"] = {
	display = "[[w:Goychay District|Goychay]]",
	regional_categories = {"Goychay"},
}
aliases["Göyçay"] = "Goychay"

labels["Göygöl"] = {
	display = "[[w:Göygöl District|Göygöl]]",
	regional_categories = {"Göygöl"},
}
aliases["Goygol"] = "Göygöl"
aliases["Helenendorf"] = "Göygöl"
aliases["Yelenino"] = "Göygöl"
aliases["Khanlar"] = "Göygöl"
aliases["Xanlar"] = "Göygöl"

labels["Gürün"] = {
	display = "[[w:Gürün|Gürün]]",
	regional_categories = {"Gürün"},
}
aliases["Kyurin"] = "Gürün"
aliases["Gyurin"] = "Gürün"

-- Asia H
labels["Haçin"] = {
	display = "[[w:Saimbeyli|Haçin]]",
	regional_categories = {"Haçin"},
}
aliases["Hadjin"] = "Haçin"
aliases["Hajin"] = "Haçin"
aliases["Hachn"] = "Haçin"
aliases["Hajn"] = "Haçin"

labels["Hakkari"] = {
	display = "[[w:Hakkari|Hakkari]]",	
	regional_categories = {"Hakkari"},
}
aliases["Hakkiari"] = "Hakkari"
aliases["Hakari"] = "Hakkari"
aliases["Hakiari"] = "Hakkari"
aliases["Hakkâri"] = "Hakkari"

labels["Hemşin"] = {
	display = "[[w:Hemşin|Hemşin]]",
	regional_categories = {"Hemşin"},
}

labels["Hokkaido"] = {
	regional_categories = {"Hokkaido"},
}

labels["Hong Kong"] = {
	display = "[[w:Hong Kong|Hong Kong]]",
	regional_categories = {"Hong Kong"},
}

labels["Hyderabad"] = {
	display = "[[w:Hyderabad|Hyderabad]]",
	regional_categories = {"Hyderabadi"},
}

-- Asia I
labels["İçel"] = {
	display = "[[w:Mersin Province|İçel]]",
	regional_categories = {"İçel"},
}
aliases["Içel"] = "İçel"

labels["Imishli"] = {
	display = "[[w:Imishli District|Imishli]]",
	regional_categories = {"Imishli"},
}
aliases["İmişli"] = "Imishli"

labels["India"] = {
	display = "[[w:India|India]]",
	regional_categories = {"Indian"},
}
aliases["Indian"] = "India"

labels["Indore"] = {
	display = "[[Indore|Indore]]",
	regional_categories = {"Indore"},
}

labels["Indonesia"] = {
	display = "[[w:Indonesia|Indonesia]]",
	regional_categories = {"Indonesian"},
}
aliases["Indonesian"] = "Indonesia"

labels["Iran"] = {
	display = "[[w:Iran|Iran]]",
	regional_categories = {"Iranian"},
}
aliases["Iranian"] = "Iran"

labels["Iraq"] = {
	display = "Iraq",
	regional_categories = {"Iraqi"} }
aliases["Iraqi"] = "Iraq"

labels["Isparta"] = {
	display = "[[w:Isparta|Isparta]]",
	regional_categories = {"Isparta"},
}

labels["Israel"] = {
	display = "[[w:Israel|Israel]]",
	regional_categories = {"Israeli"},
}
aliases["Israeli"] = "Israel"

labels["Ivory Coast"] = {
	display = "[[w:Ivory Coast|Ivory Coast]]",
	regional_categories = {"Ivorian"},
}
aliases["Côte d’Ivoire"] = "Ivory Coast"
aliases["Côte d'Ivoire"] = "Ivory Coast"
aliases["Ivorian"] = "Ivory Coast"

labels["İzmir"] = {
	display = "[[w:İzmir|İzmir]]",
	regional_categories = {"İzmir"},
}
aliases["Izmir"] = "İzmir"

labels["İzmit"] = {
	display = "[[w:İzmit|İzmit]]",
	regional_categories = {"İzmit"},
}
aliases["Izmit"] = "İzmit"
aliases["Nicomedia"] = "İzmit"
aliases["Nikomedia"] = "İzmit"

-- Asia J
labels["Jabrayil"] = {
	display = "[[w:Jabrayil District|Jabrayil]]",
	regional_categories = {"Jabrayil"},
}
aliases["Cəbrayıl"] = "Jabrayil"

labels["Jakarta"] = {
	display = "[[w:Jakarta|Jakarta]]",
	regional_categories = {"Jakarta"},
}

labels["Jalilabad"] = {
	display = "[[w:Jalilabad District|Jalilabad]]",
	regional_categories = {"Jalilabad"},
}
aliases["Cəlilabad"] = "Jalilabad"

labels["Japan"] = {
	display = "[[w:Japan|Japan]]",
	regional_categories = {"Japanese"},
}

labels["Java"] = {
	display = "[[w:Java|Java]]",
	regional_categories = {"Javanese"},
}
aliases["Javanese"] = "Java"

labels["Javakheti"] = {
	display = "[[w:Javakheti|Javakheti]]",
	regional_categories = {"Javakheti"},
}
aliases["Javakhk"] = "Javakheti"

labels["Jeju"] = {
	display = "[[w:Jeju Province|Jeju]]",
	regional_categories = {"Jeju"},
}

labels["Jeju City"] = {
	display = "[[w:Jeju City|Jeju City]]",
	regional_categories = {"Jeju City"},
}

labels["Jeolla"] = {
	display = "[[w:Jeolla dialect|Jeolla dialect]]",
	regional_categories = {"Jeolla"},
}

labels["Jordan"] = {
	display = "Jordan",
	regional_categories = {"Jordanian"} }
aliases["Jordanian"] = "Jordan"

labels["Julfa"] = {
	display = "[[w:Julfa, Azerbaijan (city)|Julfa]]",
	regional_categories = {"Julfa"},
}
aliases["Old Julfa"] = "Julfa"
aliases["Culfa"] = "Julfa"
aliases["Jugha"] = "Julfa"
aliases["Hin Jugha"] = "Julfa"

-- Asia K
labels["Kakavaberd"] = {
	display = "[[w:Kakavaberd dialect|Kakavaberd]]",
	regional_categories = {"Kakavaberd"},
}
aliases["Kaqavaberd"] = "Kakavaberd"

labels["Kalbajar"] = {
	display = "[[w:Kalbajar District|Kalbajar]]",
	regional_categories = {"Kalbajar"},
}
aliases["Kelbajar"] = "Kalbajar"
aliases["Kəlbəcər"] = "Kalbajar"

labels["Karvansara"] = {
	display = "[[w:Karvansara, Gegharkunik]]",
	regional_categories = {"Karvansaray"},
}
aliases["Karvansaray"] = "Karvansara"

labels["Kalimantan"] = {
	display = "[[w:Kalimantan|Kalimantan]]",
	regional_categories = {"Kalimantanese"},
}

labels["Kaptanpaşa"] = {
	display = "[[w:tr:Kaptanpaşa, Çayeli|Kaptanpaşa]]",
	regional_categories = {"Rize"},
}

labels["Kars"] = {
	display = "[[w:Kars|Kars]]",
	regional_categories = {"Kars"},
}
aliases["Ghars"] = "Kars"

labels["Kathiyawadi"] = {
	display = "[[w:Kathiawar|Kathiyawadi]]",
	regional_categories = {"Kathiyawadi"},
}
aliases["Kathiawadi"] = "Kathiyawadi"
aliases["Sorathi"] = "Kathiyawadi"
aliases["Bhawnagari"] = "Kathiyawadi"
aliases["Gohilwadi"] = "Kathiyawadi"
aliases["Holadi"] = "Kathiyawadi"
aliases["Jhalawadi"] = "Kathiyawadi"

labels["Kayseri"] = {
	display = "[[w:Kayseri|Kayseri]]",
	regional_categories = {"Kayseri"},
}
aliases["Kesaria"] = "Kayseri"

labels["Kazakhstan"] = {
	display = "[[w:Kazakhstan|Kazakhstan]]",
	regional_categories = {"Kazakhstani"},
}
aliases["Kazakhstani"] = "Kazakhstan"
aliases["Kazakh"] = "Kazakhstani"

labels["Kazym"] = {
	regional_categories = {"Kazym"},
}

labels["Kemaliye"] = {
	display = "[[w:Kemaliye|Kemaliye]]",
	regional_categories = {"Kemaliye"},
}

labels["Khalkha"] = {
	display = "[[w:Khalkha|Khalkha]]",
	regional_categories = {"Khalkha"},
}

labels["Kharberd"] = {
	display = "[[w:Elazığ|Kharberd]]",
	regional_categories = {"Kharberd"},
}
aliases["Kharpert"] = "Kharberd"
aliases["Kharput"] = "Kharberd"
aliases["Harput"] = "Kharberd"

labels["Khevsureti"] = {
	display = "[[w:Khevsureti|Khevsureti]]",
	regional_categories = {"Khevsureti"},
}
aliases["Khevsuria"] = "Khevsureti"

labels["Khojavend"] = {
	display = "[[w:Khojavend District|Khojavend]]",
	regional_categories = {"Khojavend"},
}
aliases["Xocavənd"] = "Khojavend"

labels["Khotorjur"] = {
	display = "[[w:Khotorjur|Khotorjur]]",
	regional_categories = {"Khotorjur"},
}
aliases["Khodorchur"] = "Khotorjur"
aliases["Hodiçor"] = "Khotorjur"
aliases["Xodiçur"] = "Khotorjur"
aliases["Xodrçur"] = "Khotorjur"
aliases["Xodorçur"] = "Khotorjur"
aliases["Sırakonak"] = "Khotorjur"

labels["Konya"] = {
	display = "[[w:Konya|Konya]]",
	regional_categories = {"Konya"},
}

-- Asia L

labels["Lankaran"] = {
	display = "[[w:Lankaran|Lankaran]]",
	regional_categories = {"Lankaran"},
}
aliases["Lənkaran"] = "Lankaran"
aliases["Lənkəran"] = "Lankaran"
aliases["Lankon"] = "Lankaran"

labels["Lachin"] = {
	display = "[[w:Lachin District|Lachin]]",
	regional_categories = {"Lachin"},
}
aliases["Laçın"] = "Lachin"
aliases["Laçîn"] = "Lachin"

labels["Lebanon"] = {
	display = "Lebanon",
	regional_categories = {"Lebanese"},
}
aliases["Lebanese"] = "Lebanon"

labels["Levant"] = {
	display = "[[w:Levant|Levantine]]",
	regional_categories = {"Levantine"},
}
aliases["Levantine"] = "Levant"

labels["Libya"] = {
	display = "Libya",
	regional_categories = {"Libyan"},
}
aliases["Libyan"] = "Libya"

labels["Lori"] = {
	display = "[[w:Lori Province|Lori]]",
	regional_categories = {"Lori"},
}
aliases["Loṙi"] = "Lori"

labels["Lucknow"] = {
	regional_categories = {"Lucknow"},
}

-- Asia M
labels["Macau"] = {
	display = "[[w:Macau|Macau]]",
	regional_categories = {"Macanese"},
}
aliases["Macao"] = "Macau"
aliases["Macanese"] = "Macau"

labels["Mainland China"] = {
	display = "[[w:Mainland China|Mainland China]]",
	regional_categories = {"Mainland China"},
}
aliases["Mainland"] = "Mainland China"
aliases["mainland"] = "Mainland China"
aliases["mainland China"] = "Mainland China"

labels["Malatya"] = {
	display = "[[w:Malatya|Malatya]]",
	regional_categories = {"Malatya"},
}
aliases["Malatia"] = "Malatya"

labels["Malayeri"] = {
	display = "[[w:Malayer|Malayeri]]",
	regional_categories = {"Malayeri"},
}

labels["Malaysia"] = {
	display = "[[w:Malaysia|Malaysia]]",
	regional_categories = {"Malaysian"},
}
aliases["Malaysian"] = "Malaysia"

labels["Masally"] = {
	display = "[[w:Masally District|Masally]]",
	regional_categories = {"Masally"},
}
aliases["Masallı"] = "Masally"

labels["Medan"] = {
	display = "[[w:Medan|Medan]]",
	regional_categories = {"Medanese"},
}


labels["Meghri"] = {
	display = "[[w:Meghri|Meghri]]",
	regional_categories = {"Meghri"},
}
aliases["Meğri"] = "Meghri"

labels["Mehsani"] = {
	display = "[[w:Mehsana|Mehsani]]",
	regional_categories = {"Mehsani"},
}
aliases["Mahesani"] = "Mehsani"

labels["Mesudiye"] = {
	display = "[[w:Mesudiye, Ordu|Mesudiye]]",
	regional_categories = {"Mesudiye"},
}

labels["Mingachevir"] = {
	display = "[[w:Mingachevir|Mingachevir]]",
	regional_categories = {"Mingachevir"},
}
aliases["Mingəçevir"] = "Mingachevir"

labels["Moks"] = {
	display = "[[w:Bahçesaray (District), Van|Moks]]",
	regional_categories = {"Moks"},
}
aliases["Müküs"] = "Moks"
aliases["Miks"] = "Moks"

labels["Mongolia"] = {
	display = "[[w:Mongolia|Mongolia]]",
	regional_categories = {"Mongolian"},
}

labels["Muğla"] = {
	display = "[[w:Muğla|Muğla]]",
	regional_categories = {"Muğla"},
}

labels["Mumbai"] = {
	regional_categories = {"Mumbai"},
}

labels["Muş"] = {
	display = "[[w:Muş|Muş]]",
	regional_categories = {"Muş"},
}
aliases["Mush"] = "Muş"

labels["Myeik"] = {
    display = "[[w:Myeik dialect|Myeik]]",
    regional_categories = {"Myeik"},
}

-- Asia N
labels["Nakhchivan"] = {
	display = "[[w:Nakhchivan|Nakhchivan]]",
	regional_categories = {"Nakhchivan"},
}
aliases["Naxçıvan"] = "Nakhchivan"
aliases["Nakhichevan"] = "Nakhchivan"
aliases["Nakhijevan"] = "Nakhchivan"
aliases["Nahçıvan"] = "Nakhchivan"

labels["Negeri Sembilan"] = {
	display = "[[w:Negeri Sembilan|Negeri Sembilan]]",
	regional_categories = {"Negeri Sembilan"},
}

labels["Nepal"] = {
	display = "[[w:Nepal|Nepal]]",
	regional_categories = {"Nepali"},
}
aliases["Nepali"] = "Nepal"
aliases["Nepalese"] = "Nepal"

labels["New Julfa"] = {
	display = "[[w:New Julfa|New Julfa]]",
	regional_categories = { "New Julfa" },
}
aliases["Nor Jugha"] = "New Julfa"

labels["Niğde"] = {
	display = "[[w:Niğde|Niğde]]",
	regional_categories = {"Niğde"},
}
aliases["Nigde"] = "Niğde"

labels["Nij"] = {
	display = "[[w:Nij, Azerbaijan|Nij]]",
	regional_categories = {"Nij"},
}
aliases["Nidzh"] = "Nij"

labels["Nor Bayazet"] = {
	display = "[[w:Nor Bayazet|Nor Bayazet]]",
	regional_categories = {"Nor Bayazet"},
}
aliases["Novo-Bayazet"] = "Nor Bayazet"
aliases["Gavar"] = "Nor Bayazet"

labels["Nor Nakhichevan"] = {
	display = "[[w:Nakhichevan-on-Don|Nor Nakhichevan]]",
	regional_categories = {"Nor Nakhichevan"},
}
aliases["New Nakhichevan"] = "Nor Nakhichevan"
aliases["Nor Nakhijevan"] = "Nor Nakhichevan"
aliases["Nakhichevan-on-Don"] = "Nor Nakhichevan"

labels["North India"] = {
	display = "[[w:North India|North India]]",
	regional_categories = {"North Indian"},
}
aliases["North Indian"] = "North India"

labels["North Sakhalin"] = {
	display = "North [[w:Sakhalin|Sakhalin]]", 
	regional_categories = {"North Sakhalin"},
}

labels["North Sumatra"] = {
	display = "[[w: North Sumatra|North Sumatra]]",
	regional_categories = {"North Sumatranese"},
}
aliases["Sumut"] = "North Sumatra"

-- Asia O
labels["Oghuz"] = {
	display = "[[w:Oghuz District|Oghuz]]",
	regional_categories = {"Oghuz"},
}
aliases["Oğuz"] = "Oghuz"

labels["Oman"] = {
	display = "Oman",
	regional_categories = {"Omani"},
}
aliases["Omani"] = "Oman"

labels["Ordubad"] = {
	display = "[[w:Ordubad District (Azerbaijan)|Ordubad]]",
	regional_categories = {"Ordubad"},
}

-- Asia P
labels["Pahang"] = {
	display = "[[w:Pahang|Pahang]]",
	regional_categories = {"Pahang"},
}

labels["Pakistan"] = {
	display = "[[w:Pakistan|Pakistan]]",
	regional_categories = {"Pakistani"},
}
aliases["Pakistani"] = "Pakistan"

labels["Palestine"] = {
	display = "Palestine",
	regional_categories = {"Palestinian"},
}
aliases["Palestinian"] = "Palestine"

labels["Pasinler"] = {
	display = "[[w:Pasinler, Erzurum|Pasinler]]",
	regional_categories = {"Pasinler"},
}
aliases["Basen"] = "Pasinler"
aliases["Basean"] = "Pasinler"
aliases["Pasen"] = "Pasinler"

labels["Palu"] = {
	display = "[[w:Palu, Elazığ|Palu]]",
	regional_categories = {"Palu"},
}
aliases["Balu"] = "Palu"

labels["Partizak"] = {
	display = "[[w:hy:Պարտիզակ (Քոջաելի)|Partizak]]",
	regional_categories = {"Partizak"},
}
aliases["Bardizag"] = "Partizak"

labels["Perak"] = {
	display = "[[w:Perak|Perak]]",
	regional_categories = {"Perak"},
}

labels["Philippines"] = {
	display = "[[w:Philippines|Philippines]]",
	regional_categories = {"Philippine"},
}
aliases["Philippine"] = "Philippines"

labels["Priangan"] = {
	regional_categories = {"Priangan"},
}

labels["Pontianak"] = {
	display = "[[w: Pontianak|Pontianak]]",
	regional_categories = {"Pontianakese"},
}


labels["Pshavi"] = {
	display = "[[w:Pshavi|Pshavi]]",
	regional_categories = {"Pshavi"},
}

labels["Pulur"] = {
	display = "[[w:Ovacık, Dersim|Pulur]]",
	regional_categories = {"Pulur"},
}

labels["Punjab"] = {
	display = "[[w:Punjab|Punjab]]",
	regional_categories = {"Punjabi"},
}
aliases["Punjabi"] = "Punjab"

-- Asia Q
labels["Qakh"] = {
	display = "[[w:Qakh District|Qakh]]",
	regional_categories = {"Qakh"},
}
aliases["Kakhi"] = "Qakh"
aliases["Gakh"] = "Qakh"
aliases["Qax"] = "Qakh"

labels["Qazakh"] = {
	display = "[[w:Qazakh District|Qazakh]]",
	regional_categories = {"Qazakh"},
}
aliases["Qazax"] = "Qazakh"
aliases["Gazakh"] = "Qazakh"
aliases["Kazakh"] = "Qazakh"

labels["Qinghai"] = {
	display = "[[w:Qinghai, China|Qinghai]]",
	regional_categories = {"Qinghai"},
}

labels["Quba"] = {
	display = "[[w:Quba District (Azerbaijan)|Quba]]",
	regional_categories = {"Quba"},
}

labels["Agdam"] = {
	display = "[[w:Agdam District|Agdam]]",
	regional_categories = {"Agdam"},
}
aliases["Ağdam"] = "Agdam"

labels["Agjabedi"] = {
	display = "[[w:Aghjabadi District|Agjabedi]]",
	regional_categories = {"Agjabedi"},
}
aliases["Ağcabədi"] = "Agjabedi"
aliases["Aghjabedi"] = "Agjabedi"
aliases["Aghjabadi"] = "Agjabedi"

-- Asia R
labels["Rize"] = {
	display = "[[w:Rize|Rize]]",
	regional_categories = {"Rize"},
}

-- Asia S
labels["Saatly"] = {
	display = "[[w:Saatly District|Saatly]]",
	regional_categories = {"Saatly"},
}
aliases["Saatlı"] = "Saatly"

labels["Sakhalin"] = {
	display = "[[w:Sakhalin|Sakhalin]]",
	regional_categories = {"Sakhalin"},
}

labels["Salyan"] = {
	display = "[[w:Salyan District, Azerbaijan|Salyan]]",
	regional_categories = {"Salyan"},
}

labels["Sasun"] = {
	display = "[[w:Sason|Sasun]]",
	regional_categories = {"Sasun"},
}
aliases["Sason"] = "Sasun"
aliases["Sassoun"] = "Sasun"

labels["Seogwipo"] = {
	display = "[[w:Seogwipo|Seogwipo]]",
	regional_categories = {"Seogwipo"},
}

labels["Shahbuz"] = {
	display = "[[w:Shahbuz District|Shahbuz]]",
	regional_categories = {"Shahbuz"},
}

labels["Shamakhi"] = {
	display = "[[w:Shamakhi|Shamakhi]]",
	regional_categories = {"Shamakhi"},
}
aliases["Şamaxı"] = "Shamakhi"

labels["Shiraz"] = {
	display = "[[w:Shiraz|Shiraz]]",
	regional_categories = {"Shiraz"},
}

labels["Ujar"] = {
	display = "[[w:Ujar District|Ujar]]",
	regional_categories = {"Ujar"},
}
aliases["Ucar"] = "Ujar"

labels["Kurdamir"] = {
	display = "[[w:Kurdamir District|Kurdamir]]",
	regional_categories = {"Kurdamir"},
}
aliases["Kürdəmir"] = "Kurdamir"

labels["Barda"] = {
	display = "[[w:Barda District|Barda]]",
	regional_categories = {"Barda"},
}
aliases["Bərdə"] = "Barda"


labels["Shamkir"] = {
	display = "[[w:Shamkir District|Shamkir]]",
	regional_categories = {"Shamkir"},
}
aliases["Şəmkir"] = "Shamkir"
aliases["Shamkur"] = "Shamkir"
aliases["Shamkhor"] = "Shamkir"

labels["Shanghai"] = {
	display = "[[w:Shanghai|Shanghai]]",
	regional_categories = {"Shanghainese"},
}
aliases["Shanghainese"] = "Shanghai"

labels["Sheki"] = {
	display = "[[w:Sheki, Azerbaijan|Sheki]]",
	regional_categories = {"Sheki"},
}
aliases["Şəki"] = "Sheki"
aliases["Shaki"] = "Sheki"

labels["Shidong"] = {
	display = "[[w:Shidong|Shidong]]",
	regional_categories = {"Shidong"},
}

labels["Shirvan"] = {
	display = "[[w:Shirvan District|Shirvan]]",
	regional_categories = {"Shirvan"},
}

labels["Shuryshkar"] = {
	regional_categories = {"Shuryshkar"},
}
aliases["Shurishkar"] = "Shuryshkar"

labels["Shusha"] = {
	display = "[[w:Shusha|Shusha]]",
	regional_categories = {"Shusha"},
}
aliases["Şuşa"] = "Shusha"

labels["Singapore"] = {
	display = "[[w:Singapore|Singapore]]",
	regional_categories = {"Singapore"},
}
aliases["Singaporean"] = "Singapore"

labels["Sivas"] = {
	display = "[[w:Sivas|Sivas]]",
	regional_categories = {"Sivas"},
}
aliases["Sebastia"] = "Sivas"
aliases["Sebastea"] = "Sivas"

labels["South Asia"] = {
	display = "[[w:South Asia|South Asia]]",
	regional_categories = {"South Asian"},
}
aliases["South Asian"] = "South Asia"

labels["Southeast Asia"] = {
	display = "[[w:Southeast Asia|Southeast Asia]]",
	regional_categories = {"Southeast Asian"},
}
aliases["Southeast Asian"] = "Southeast Asia"
aliases["SEA"] = "Southeast Asia"

labels["South India"] = {
	display = "[[w:South India|South India]]",
	regional_categories = {"South Indian"},
}
aliases["South Indian"] = "South India"

labels["South Sakhalin"] = {
	display = "South [[w:Sakhalin|Sakhalin]]", 
	regional_categories = {"South Sakhalin"},
}

labels["Sri Lanka"] = {
	display = "[[Sri Lanka]]",
	regional_categories = {"Sri Lankan"},
}
aliases["Sri Lankan"] = "Sri Lanka"

labels["Sumatra"] = {
	display = "[[w: Sumatra|Sumatra]]",
	regional_categories = {"Sumatranese"},
}

labels["Surati"] = {
	display = "[[w:Surat district|Surati]]",
	regional_categories = {"Surati"},
}

labels["Surgut"] = {
	display = "[[w:Surgut|Surgut]]",
	regional_categories = {"Surgut"},
}

labels["Suzhou"] = {
	display = "[[w:Suzhou|Suzhou]]",
	regional_categories = {"Suzhounese"},
}
aliases["Suzhounese"] = "Suzhou"

labels["Syria"] = {
	display = "Syria",
	regional_categories = {"Syrian"},
}
aliases["Syrian"] = "Syria"

-- Asia T
labels["Tabriz"] = {
	display = "[[w:Tabriz|Tabriz]]",
	regional_categories = {"Tabrizi"},
}
aliases["Təbriz"] = "Tabriz"
aliases["Tebriz"] = "Tabriz"
aliases["Tabrizi"] = "Tabriz"

labels["Taiwan"] = {
	display = "[[w:Taiwan|Taiwan]]",
	regional_categories = {"Taiwanese"},
}
aliases["Taiwanese"] = "Taiwan"

labels["Tbilisi"] = {
	display = "[[w:Tbilisi|Tbilisi]]",
	regional_categories = {"Tbilisi"},
}
aliases["Tiflis"] = "Tbilisi"

labels["Tartar"] = {
	display = "[[w:Tartar District|Tartar]]",
	regional_categories = {"Tartar"},
}
aliases["Tərtər"] = "Tartar"

labels["Thailand"] = {
	display = "[[w:Thailand|Thailand]]",
	regional_categories = {"Thai"},
}
aliases["Thai"] = "Thailand"

labels["Tokat"] = {
	display = "[[w:Tokat|Tokat]]",
	regional_categories = {"Tokat"},
}
aliases["Evdokia"] = "Tokat"

labels["Tovuz"] = {
	display = "[[w:Tovuz District|Tovuz]]",
	regional_categories = {"Tovuz"},
}

labels["Trabzon"] = {
	display = "[[w:Trabzon|Trabzon]]",
	regional_categories = {"Trabzon"},
}
aliases["Trapizon"] = "Trabzon"

-- Asia U
labels["Urfa"] = {
	display = "[[w:Şanlıurfa|Urfa]]",
	regional_categories = {"Urfa"},
}
aliases["Urha"] = "Urfa"
aliases["Şanlıurfa"] = "Urfa"

labels["Uşak"] = {
	display = "[[w:Uşak|Uşak]]",
	regional_categories = {"Uşak"},
}

labels["Uttar Pradesh"] = {
	display = "[[w:Uttar Pradesh|Uttar Pradesh]]",
	regional_categories = {"Uttar Pradeshi"},
}

-- Asia V
labels["Van"] = {
	display = "[[w:Van, Turkey|Van]]",
	regional_categories = {"Van"},
}

labels["Vartashen"] = {
	display = "[[w:Oğuz (city)|Vartashen]]",
	regional_categories = {"Vartashen"},
}

labels["Vayots Dzor"] = {
	display = "[[w:hy:Վայոց_ձորի_միջբարբառ|Vayots Dzor]]",
	regional_categories = {"Vayots Dzor"},
}
aliases["Vayots dzor"] = "Vayots Dzor"

labels["Vietnam"] = {
	display = "[[w:Vietnam|Vietnam]]",
	regional_categories = {"Vietnamese"},
}
aliases["Vietnamese"] = "Vietnam"

labels["Vozm"] = {
	display = "[[w:Gümüşören, Pervari|Vozm]]",
	regional_categories = {"Vozm"},
}
aliases["Vozim"] = "Vozm"
aliases["Özim"] = "Vozm"
aliases["Üzim"] = "Vozm"

-- Asia W
labels["West Kalimantan"] = {
	display = "[[w:West Kalimantan|West Kalimantan]]",
	regional_categories = {"West Kalimantanese"},
}
aliases["Kalbar"] = "West Kalimantan"

-- Asia X

-- Asia Y
labels["Yardymli"] = {
	display = "[[w:Yardymli District|Yardymli]]",
	regional_categories = {"Yardymli"},
}

labels["Yemen"] = {
	display = "Yemen",
	regional_categories = {"Yemeni"},
}
aliases["Yemeni"] = "Yemen"
aliases["Yemenite"] = "Yemen"

labels["Yerevan"] = {
	display = "[[w:Yerevan|Yerevan]]",
	regional_categories = {"Yerevan"},
}
aliases["İrəvan"] = "Yerevan"

labels["Yevlakh"] = {
	display = "[[w:Yevlakh District|Yevlakh]]",
	regional_categories = {"Yevlakh"},
}
aliases["Yevlax"] = "Yevlakh"


labels["Yogyakarta"] = {
	display = "[[w:Yogyakarta|Yogyakarta]]",
	regional_categories = {"Yogyakarta"},
}

labels["Yonggu"] = {
	display = "[[w:Yonggu, Guangdong|Yonggu]]",
	regional_categories = {"Yonggu"},
}

-- Asia Z
labels["Zangilan"] = {
	display = "[[w:Zəngilan|Zangilan]]",
	regional_categories = {"Zangilan"},
}
aliases["Zəngilan"] = "Zangilan"
aliases["Zangelan"] = "Zangilan"

labels["Zanjan"] = {
	display = "[[w:Zanjan, Iran|Zanjan]]",
	regional_categories = {"Zanjan"},
}
aliases["Zәncan"] = "Zanjan"
aliases["Zәngan"] = "Zanjan"

labels["Zaqatala"] = {
	display = "[[w:Zaqatala District|Zaqatala]]",
	regional_categories = {"Zaqatala"},
}
aliases["Zakatala"] = "Zaqatala"
aliases["Zagatala"] = "Zaqatala"

labels["Zardab"] = {
	display = "[[w:Zardab District|Zardab]]",
	regional_categories = {"Zardab"},
}
aliases["Zərdab"] = "Zardab"

-- Europe
labels["Europe"] = {
	display = "[[w:Europe|Europe]]",
	regional_categories = {"European"},
}

-- Europe A
labels["Alemannia"] = {
	display = "[[w:Alemannia|Alemannia]]",
	regional_categories = {"Alemannic"},
}
aliases["Alemannic"] = "Alemannia"

labels["Alghero"] = {
	display = "[[w:Alghero|Alghero]]",
	regional_categories = {"Algherese"},
}
aliases["Algherese"] = "Alghero"

labels["Al-Andalus"] = {
	display = "[[w:al-Andalus|al-Andalus]]",
	regional_categories = {"Andalusian"},
}
aliases["al-Andalus"] = "Al-Andalus"

labels["Amsterdam"] = {
	display = "[[w:Amsterdam|Amsterdam]]",
	regional_categories = {"Amsterdam"},
}

labels["Andalusia"] = {
	display = "[[w:Andalusia|Andalusia]]",
	regional_categories = {"Andalusian"},
}

labels["Antrim"] = {
	display = "[[w:County Antrim|Antrim]]",
	regional_categories = {"Ulster"},
}

labels["Aragón"] = {
	regional_categories = {"Aragonese"},
}
aliases["Aragonese"] = "Aragón"
aliases["Aragon"] = "Aragón"

labels["Aran"] = {
	display = "[[w:Aran Islands|Aran]]",
	regional_categories = {"Connacht"},
}

labels["Argyll"] = {
	display = "[[w:Argyll|Argyll]]",
	regional_categories = {"Argyll"},
}

labels["Arran"] = {
	display = "[[w:Isle of Arran|Arran]]",
	regional_categories = {"Arran"},
}

labels["Arvanitika"] = {
	display = "[[w:Arvanitika|Arvanitika]]",
	regional_categories = {"Arvanitika"},
}

labels["Asturias"] = {
	regional_categories = {"Asturian"},
}
aliases["Asturian"] = "Asturias"

labels["Austria"] = {
	display = "[[w:Austria|Austria]]",
	regional_categories = {"Austrian"},
}
aliases["Austrian"] = "Austria"

labels["Azores"] = {
	display = "[[w:Azores|Azores]]",
	regional_categories = {"Azorean"},
}
aliases["Azorean"] = "Azores"
aliases["Azorian"] = "Azores"

-- Europe B
labels["Badenoch"] = {
	display = "[[w:Badenoch|Badenoch]]",
	regional_categories = {"Badenoch"},
}

labels["Balearics"] = {
	display = "[[w:Balearic Islands|Balearics]]",
	regional_categories = {"Balearic"},
}
aliases["Balearic"] = "Balearics"
aliases["Balearic Islands"] = "Balearics"
aliases["Baleares"] = "Balearics"
aliases["Balears"] = "Balearics"

labels["Banat"] = {
	display = "[[w:Banat|Banat]]",
	regional_categories = {"Banat"},
}

labels["Basque Country"] = {
	display = "[[w:Basque Country (autonomous community)|Basque Country]]",
	regional_categories = {"Basque Country"},
}

labels["Bavaria"] = {
	display = "[[w:Bavaria|Bavaria]]",
	regional_categories = {"Bavarian"},
}
aliases["Bavarian"] = "Bavaria"

labels["Bedfordshire"] = {
	display = "[[w:Bedfordshire|Bedfordshire]]",
	regional_categories = {"Bedfordshire"},
}
aliases["Bedfordshire dialect"] = "Bedfordshire"

labels["Berkshire"] = {
	display = "[[w:Berkshire|Berkshire]]",
	regional_categories = {"Berkshire"},
}
aliases["Berkshire dialect"] = "Berkshire"

labels["Belgium"] = {
	display = "[[w:Belgium|Belgium]]",
	regional_categories = {"Belgian"},
}
aliases["Belgian"] = "Belgium"

labels["Bern"] = {
	display = "[[w:Bern|Bern]]",
	regional_categories = {"Bernese"},
}
aliases["Bernese"] = "Bern"

labels["Black Isle"] = {
	display = "[[w:Black Isle|Black Isle]]",
	regional_categories = {"Black Isle"},
}

labels["Bohuslän"] = {
	display = "[[w:Bohuslän|Bohuslän]]",
	regional_categories = {"Bohuslän"},
}
aliases["Bohuslan"] = "Bohuslän"

labels["Bologna"] = {
	display = "[[Bologna]]",
	regional_categories = {"Bolognese"},
}
aliases["Bolognese"] = "Bologna"

labels["Bosnia"] = {
	display = "[[w:Bosnia|Bosnia]]",
	regional_categories = {"Bosnian"},
}
aliases["Bosnian"] = "Bosnia"

labels["Brabant"] = {
	display = "[[w:Brabant|Brabant]]",
	regional_categories = {"Brabantian"},
}
aliases["Brabantian"] = "Brabant"

labels["Bristol"] = {
	display = "[[w:Bristol|Bristol]]",
	regional_categories = {"Bristolian"},
}
aliases["Bristolian"] = "Bristol"

labels["Britain"] = {
	display = "[[w:Great Britain|Britain]]",
	regional_categories = {"British"},
}
aliases["Brit"] = "Britain"
aliases["British"] = "Britain"
aliases["Great Britain"] = "Britain"
aliases["UK"] = "Britain"
aliases["United Kingdom"] = "Britain"

labels["British spelling"] = {
	display = "British spelling",
	Wikipedia = "American and British English spelling differences",
	plain_categories = {"British English forms"},
	language = "en",
}
aliases["Commonwealth spelling"] = "British spelling"

-- kludge, needed here for [[Template:standard spelling of]] et al
labels["British form"] = {
	display = "British",
	Wikipedia = "American and British English spelling differences",
	plain_categories = {"British English forms"},
	language = "en",
}
aliases["Commonwealth form"] = "British form"
aliases["UK form"] = "British form"

labels["Bukovina"] = {
	display = "[[w:Bukovina|Bukovina]]",
	regional_categories = {"Bukovinian"},
}
aliases["Bucovina"] = "Bukovina"
aliases["Bukovinian"] = "Bukovina"
aliases["Bukowina"] = "Bukovina"

labels["Burgos"] = {
	regional_categories = {"Burgos"},
}

-- Europe C
labels["Caithness"] = {
	display = "[[w:Caithness|Caithness]]",
	regional_categories = {"Caithness"},
}

labels["Cambridge University"] = {
	display = "[[w:University of Cambridge|Cambridge University]]",
	regional_categories = {"Cambridge University"},
}
aliases["University of Cambridge"] = "Cambridge University"

labels["Canaries"] = {
	display = "[[w:Canary Islands|Canary Islands]]",
	regional_categories = {"Canarian"},
}
aliases["Canary Islands"] = "Canaries"
aliases["Canarias"] = "Canaries"

labels["Carinthia"] = {
	display = "[[w:Carinthia|Carinthia]]",
	regional_categories = {"Carinthian"},
}
aliases["Carinthian"] = "Carinthia"
aliases["Kärnten"] = "Carinthia"

labels["Carpi"] = {
	display = "[[w:Carpi, Emilia-Romagna|Carpi]]",
	regional_categories = {"Carpigiano"},
}
aliases["Carpigiano"] = "Carpi"

labels["Channel Islands"] = {
	display = "[[w:Channel Islands|Channel Islands]]",
	regional_categories = {"Channel Islands"},
}

labels["Connacht"] = {
	display = "[[w:Connacht|Connacht]]",
	regional_categories = {"Connacht"},
}

labels["Connemara"] = {
	display = "[[w:Connemara|Connemara]]",
	regional_categories = {"Connacht"},
}

labels["Cork"] = {
	display = "[[w:Cork (city)|Cork]]",
	regional_categories = {"Munster"},
}

labels["Cornwall"] = {
	display = "[[w:Cornwall|Cornwall]]",
	regional_categories = {"Cornish"},
}
aliases["Cornish"] = "Cornwall"
aliases["Cornish dialect"] = "Cornwall"

labels["Crimea"] = {
	display = "[[w:Crimea|Crimea]]",
	regional_categories = {"Crimean"},
}
aliases["Crimean"] = "Crimea"

labels["Croatia"] = {
	display = "[[w:Croatia|Croatia]]",
	regional_categories = {"Croatian"},
}
aliases["Croatian"] = "Croatia"

labels["Cumbria"] = {
	display = "[[w:Cumbria|Cumbria]]",
	regional_categories = {"Cumbrian"},
}
aliases["Cumbrian"] = "Cumbria"

labels["West Cumbria"] = {
	display = "[[w:Cumbria|West Cumbria]]",
	regional_categories = {"Cumbrian"},
} -- can be split off if enough entries in it arise; group with Cumbria for now
aliases["West Cumbrian"] = "West Cumbria"


-- Europe D
labels["DDR"] = {
	display = "[[w:GDR|East Germany]]",
	regional_categories = {"DDR"},
}
aliases["GDR"] = "DDR"
aliases["East German"] = "DDR"
aliases["East Germany"] = "DDR"

labels["Dalmatia"] = {
	display = "[[w:Dalmatia|Dalmatia]]",
	regional_categories = {"Dalmatian"},
}
aliases["Dalmatian"] = "Dalmatia"

labels["Derbyshire"] = {
	display = "[[w:Derbyshire|Derbyshire]]",
	regional_categories = {"Derbyshire"},
}
aliases["Derbyshire dialect"] = "Derbyshire"

labels["Devon"] = {
	display = "[[w:Devon|Devon]]",
	regional_categories = {"Devonian"},
}
aliases["Devonian"] = "Devon"
aliases["Devonian dialect"] = "Devon"
aliases["Devonshire"] = "Devon"
aliases["Devonshire dialect"] = "Devon"

labels["Dobruja"] = {
	display = "[[w:Dobruja|Dobruja]]",
	regional_categories = {"Dobrujan"},
}
aliases["Dobrogea"] = "Dobruja"
aliases["Dobrujan"] = "Dobruja"

labels["Dorset"] = {
	display = "[[w:Dorset|Dorset]]",
	regional_categories = {"Dorset"},
}
aliases["Dorset dialect"] = "Dorset"

labels["Dublin"] = {
	display = "[[w:Dublin|Dublin]]",
	regional_categories = {"Dublin"},
}

labels["Dundee"] = {
	display = "[[w:Dundee|Dundee]]",
	regional_categories = {"Dundee"},
}

labels["Durham"] = {
	display = "[[w:County Durham|Durham]]",
	regional_categories = {"Durham"},
}

-- Europe E
labels["East Anglia"] = {
	display = "[[w:East Anglia|East Anglia]]",
	regional_categories = {"East Anglian"},
}
aliases["East Anglian"] = "East Anglia"
aliases["East Anglian dialect"] = "East Anglia"

labels["East Midlands"] = {
	display = "[[w:East Midlands|East Midlands]]",
	regional_categories = {"East Midlands"},
}
aliases["East Midlands dialect"] = "East Midlands"

labels["Edirne"] = {
	display = "[[w:Edirne|Edirne]]",
	regional_categories = {"Edirne"},
}
aliases["Adrianople"] = "Edirne"
aliases["Odrin"] = "Edirne"

labels["Egerland"] = {
	display = "[[w:Egerland|Egerland]]",
	regional_categories = {"Egerland"},
}
aliases["Egerländisch"] = "Egerland"
aliases["Chebsko"] = "Egerland"

labels["England"] = {
	display = "[[w:England|England]]",
	regional_categories = {"English"},
}
aliases["English"] = "England"

labels["Essex"] = {
	display = "[[w:Essex|Essex]]",
	regional_categories = {"Essex"},
}
aliases["Essex dialect"] = "Essex"

labels["Estonia"] = {
	display = "[[w:Estonia|Estonia]]",
	regional_categories = {"Estonian"},
}
aliases["Estonian"] = "Estonia"

labels["Exmoor"] = {
	display = "[[w:Exmoor|Exmoor]]",
	regional_categories = {"Devonian", "Somerset"},
}

labels["Extremadura"] = {
	display = "[[w:Extremadura|Extremadura]]",
	regional_categories = {"Extremaduran"},
}
aliases["Extremaduran"] = "Extremadura"

-- Europe F
labels["Finland"] = {
	display = "[[w:Finland|Finland]]",
	regional_categories = {"Finland"},
}
aliases["Finnish"] = "Finland"

labels["Fjolde"] = {
	display = "[[w:Fjolde|Fjolde]]",
	regional_categories = {"Fjolde"},
}
aliases["Viöl"] = "Fjolde"

labels["France"] = {
	display = "[[w:France|France]]",
	regional_categories = {"French"},
}
aliases["French"] = "France"

labels["Föhr-Amrum"] = {
	display = "[[w:Föhr-Amrum|Föhr-Amrum]]",
	regional_categories = {"Föhr-Amrum"},
}
aliases["Föhr-Amrum dialect"] = "Föhr-Amrum"
aliases["Feer"] = "Föhr-Amrum"
aliases["Fering"] = "Föhr-Amrum"
aliases["Oomram"] = "Föhr-Amrum"
aliases["Öömrang"] = "Föhr-Amrum"

-- Europe G
labels["Galicia"] = {
	regional_categories = {"Galician"},
}
aliases["Galician"] = "Galicia"

labels["Galway"] = {
	display = "[[w:County Galway|Galway]]",
	regional_categories = {"Galway"},
}

labels["Germany"] = {
	display = "[[w:Germany|Germany]]",
	regional_categories = {"German"},
}
aliases["German"] = "Germany" -- comment this alias out if it causes problems

labels["Gloucestershire"] = {
	display = "[[w:Gloucestershire|Gloucestershire]]",
	regional_categories = {"Gloucestershire"},
}
aliases["Gloucestershire dialect"] = "Gloucestershire"
aliases["Glos"] = "Gloucestershire"

labels["Gotland"] = {
	display = "[[w:Gotland|Gotland]]",
	regional_categories = {"Gotlandic"},
}
aliases["Gotlandic"] = "Gotland"

labels["Granada"] = {
	regional_categories = {"Granada"},
}

labels["Guernsey"] = {
	display = "[[w:Guernsey|Guernsey]]",
	regional_categories = {"Guernsey"},
}

-- Europe H
labels["The Hague"] = {
	display = "[[w:The Hague|The Hague]]",
	regional_categories = {"Hague"},
}
aliases["Hague"] = "The Hague"
aliases["Den Haag"] = "The Hague"

labels["Hartlepool"] = {
	display = "[[w:Hartlepool|Hartlepool]]",
	regional_categories = {"Teesside"},
}

labels["Heligoland"] = {
	display = "[[w:Heligoland|Heligoland]]",
	regional_categories = {"Heligolandic"},
}
aliases["Heligoland dialect"] = "Heligoland"
aliases["Halunder"] = "Heligoland"
aliases["Heligolandic"] = "Heligoland"
aliases["Helgoland"] = "Heligoland"
aliases["Helgoland dialect"] = "Heligoland"

labels["Herefordshire"] = {
	display = "[[w:Herefordshire|Herefordshire]]",
	regional_categories = {"Herefordshire"},
}
aliases["Herefordshire dialect"] = "Herefordshire"

labels["Holland"] = {
	display = "[[w:Holland|Holland]]",
	regional_categories = {"Hollandic"},
}
aliases["Hollandic"] = "Holland"

labels["Huelva"] = {
	display = "[[w:Province of Huelva|Huelva]]",
	regional_categories = {"Huelvan"},
}
aliases["Huelvan"] = "Extremadura"


-- Europe I
labels["Ireland"] = {
	display = "[[w:Ireland|Ireland]]",
	regional_categories = {"Irish"},
}
aliases["Irish"] = "Ireland"

labels["Islay"] = {
	display = "[[w:Islay|Islay]]",
	regional_categories = {"Islay"},
}

labels["Isle of Man"] = {
	display = "[[w:Isle of Man|Isle of Man]]",
	regional_categories = {"Manx"},
}
aliases["Manx"] = "Isle of Man"
aliases["Isle of Mann"] = "Isle of Man"

labels["Isle of Wight"] = {
	display = "[[w:Isle of Wight|Isle of Wight]]",
	regional_categories = {"Isle of Wight"},
}

labels["Istanbul"] = {
	display = "[[w:Istanbul|Istanbul]]",
	regional_categories = {"Istanbul"},
}
aliases["İstanbul"] = "Istanbul"
aliases["Polis"] = "Istanbul"

-- Europe J
labels["Jersey"] = {
	display = "[[w:Jersey|Jersey]]",
	regional_categories = {"Jersey"},
}

labels["Jutland"] = {
	display = "[[w:Jutland|Jutland]]",
	regional_categories = {"Jutlandic"},
}
aliases["Jutlandic"] = "Jutland"

-- Europe K
labels["Kalix"] = {
	display = "[[w:Kalix|Kalix]]",
	regional_categories = {"Kalix"},
}

labels["Kazan"] = {
	display = "[[w:Kazan|Kazan]]",
	regional_categories = {"Kazan"},
}

labels["Kent"] = {
	display = "[[w:Kent|Kent]]",
	regional_categories = {"Kentish"},
}
aliases["Kentish"] = "Kent"
aliases["Kentish dialect"] = "Kent"
aliases["Kent dialect"] = "Kent"

labels["Kırklareli"] = {
	display = "[[w:Kırklareli|Kırklareli]]",
	regional_categories = {"Kırklareli"},
}
aliases["Kirklareli"] = "Kırklareli"

labels["Kukkuzi"] = {
	display = "[[w:Kukkuzi|Kukkuzi]]",
	regional_categories = {"Kukkuzi"},
}

-- Europe L
labels["Lancashire"] = {
	display = "[[w:Lancashire|Lancashire]]",
	regional_categories = {"Lancashire"},
}

labels["Latvia"] = {
	display = "[[w:Latvia|Latvia]]",
	regional_categories = {"Latvian"},
}
aliases["Latvian"] = "Latvia"

labels["Lewis"] = {
	display = "[[w:Isle of Lewis|Lewis]]",
	regional_categories = {"Lewis"},
}
aliases["Isle of Lewis"] = "Lewis"

labels["Liechtenstein"] = {
	display = "[[w:Liechenstein|Liechtenstein]]",
	regional_categories = {"Liechtenstein"},
}

labels["Lincolnshire"] = {
	display = "[[w:Lincolnshire|Lincolnshire]]",
	regional_categories = {"Lincolnshire"},
}

labels["Lithuania"] = {
	display = "[[w:Lithuania|Lithuania]]",
	regional_categories = {"Lithuanian"},
}
aliases["Lithuanian"] = "Lithuania"

labels["Liverpool"] = {
	display = "[[w:Liverpool|Liverpudlian]]",
	regional_categories = {"Liverpudlian"},
}
aliases["Scouse"] = "Liverpool"

labels["London"] = {
	display = "[[w:London|London]]",
	regional_categories = {"London"},
}

labels["Lorraine"] = {
	display = "[[w:Lorraine|Lorraine]]",
	regional_categories = {"Lorraine"},
}

labels["Lower Austria"] = {
	display = "[[w:Lower Austria|Lower Austria]]",
	regional_categories = {"Lower Austrian"},
}
aliases["Niederösterreich"] = "Lower Austria"
aliases["Niederösterreichisch"] = "Lower Austria"
aliases["Lower Austrian"] = "Lower Austria"

labels["Lucerne"] = {
	display = "[[w:Lucerne|Lucerne]]",
	regional_categories = {"Lucerne"},
}
aliases["Luzern"] = "Lucerne"

labels["Luleå"] = {
	display = "[[w:Luleå|Luleå]]",
	regional_categories = {"Luleå"},
}
aliases["Lulea"] = "Luleå"

labels["Luserna"] = {
	display = "[[w:Luserna|Luserna]]",
	regional_categories = {"Luserna"},
}

labels["Luxembourg"] = {
	display = "[[w:Luxembourg|Luxembourg]]",
	regional_categories = {"Luxembourgish"},
}
aliases["Luxembourgish"] = "Luxembourg"
aliases["Luxemburg"] = "Luxembourg"
aliases["Luxemburgish"] = "Luxembourg"

labels["Lviv"] = {
	display = "[[w:Lviv|Lviv]]",
	regional_categories = {"Lviv"},
}
aliases["Lvov"] = "Lviv"
aliases["Lwow"] = "Lviv"
aliases["Lwów"] = "Lviv"

-- Europe M

labels["Madeira"] = {
	display = "[[w:Madeira|Madeira]]",
	regional_categories = {"Madeiran"},
}
aliases["Madeiran"] = "Madeira"

labels["Mallorca"] = {
	display = "[[w:Mallorca|Mallorca]]",
	regional_categories = {"Mallorcan"},
}
aliases["Mallorcan"] = "Mallorca"
aliases["Majorca"] = "Mallorca"

labels["Malta"] = {
	display = "[[w:Malta|Malta]]",
	regional_categories = {"Maltese"},
}
aliases["Maltese"] = "Malta"

labels["Manchester"] = {
	display = "[[w:Manchester|Manchester]]",
	regional_categories = {"Mancunian"},
}
aliases["Mancunian"] = "Manchester"
aliases["Manc"] = "Manchester"

labels["Mantua"] = {
	display = "[[w:Mantua|Mantua]]",
	regional_categories = {"Mantovano"},
}
aliases["Mantovano"] = "Mantua"

labels["Maramureș"] = {
	display = "[[w:Maramureș|Maramureș]]",
	regional_categories = {"Maramureș"},
}
aliases["Maramures"] = "Maramureș"

labels["Marseille"] = {
	display = "[[w:Marseille|Marseille]]",
	regional_categories = {"Marseille"},
}

labels["Midlands"] = {
	display = "[[w:The Midlands|Midlands]]",
	regional_categories = {"Midlands"},
}
aliases["Midlands dialect"] = "Midlands"
aliases["South Midlands"] = "Midlands" -- OK as alias? or a subvariety worth distinguishing?

labels["Mirandola"] = {
	display = "[[w:Mirandola|Mirandola]]",
	regional_categories = {"Mirandolese"},
}
aliases["Mirandolese"] = "Mirandola"

labels["Modena"] = {
	display = "[[w:Modena|Modena]]",
	regional_categories = {"Modenese"},
}
aliases["Modenese"] = "Modena"

labels["Moldova"] = {
	display = "[[w:Moldavia|Moldavia]]",
	regional_categories = {"Moldovan"},
}
aliases["Moldavian"] = "Moldova"
aliases["Moldovan"] = "Moldova"
aliases["Moldavia"] = "Moldova"

labels["Republic of Moldova"] = {
	display = "[[w:Moldova|Moldova]]",
	regional_categories = {"Republic of Moldova"},
}

labels["Montenegro"] = {
	display = "[[w:Montenegro|Montenegro]]",
	regional_categories = {"Montenegrin"},
}
aliases["Montenegrin"] = "Montenegro"

labels["Moravia"] = {
	display = "[[w:Moravia|Moravia]]",
	regional_categories = {"Moravian"},
}
aliases["Moravian"] = "Moravia"

labels["Moscow"] = {
	display = "[[w:Moscow|Moscow]]",
	regional_categories = {"Moscow"},
}

labels["Munster"] = {
	display = "[[w:Munster|Munster]]",
	regional_categories = {"Munster"},
}

labels["Muntenia"] = {
	display = "[[w:Muntenia|Muntenia]]",
	regional_categories = {"Muntenian"},
}
aliases["Muntenian"] = "Muntenia"

labels["Murcia"] = {
	regional_categories = {"Murcian"},
}
aliases["Murcian"] = "Murcia"

labels["Myanmar"] = {
	display = "[[w:Myanmar|Myanmar]]",
	regional_categories = {"Myanmarese"},
}
aliases["Myanmarese"] = "Myanmar"
aliases["Burma"] = "Myanmar"
aliases["Burmese"] = "Myanmar"

-- Europe N
labels["Naples"] = {
	display = "[[w:Naples|Naples]]",
	regional_categories = {"Neapolitan"},
}
aliases["Neapolitan"] = "Naples"
aliases["Napoli"] = "Naples"

labels["Navarre"] = {
	regional_categories = {"Navarrese"},
}
aliases["Navarrese"] = "Navarre"

labels["Netherlands"] = {
	display = "[[w:Netherlands|Netherlands]]",
	regional_categories = {"Netherlands"},
}

labels["Norfolk"] = {
	display = "[[w:Norfolk|Norfolk]]",
	regional_categories = {"Norfolk"},
}

labels["North Wales"] = {
	display = "[[w:North Wales|North Wales]]",
	regional_categories = {"North Wales"},
}

labels["Northern Crimea"] = {
	display = "Northern [[w:Crimea|Crimea]]",
	regional_categories = {"Northern"},
}

labels["Northern England"] = {
	display = "[[w:Northern England|Northern England]]",
	regional_categories = {"Northern England"},
}
aliases["northern England"] = "Northern England"
aliases["North England"] = "Northern England"
aliases["north England"] = "Northern England"

labels["Northern Ireland"] = {
	display = "[[w:Northern Ireland|Northern Ireland]]",
	regional_categories = {"Ulster"},
}
aliases["Northern Irish"] = "Northern Ireland"

labels["Northern Isles"] = {
	display = "[[w:Orkney|Orkney]], [[w:Shetland|Shetland]]",
	regional_categories = {"Orkney", "Shetland"},
}
aliases["Insular Scots"] = "Northern Isles"

labels["Northumbria"] = {
	display = "[[w:Northumbria|Northumbria]]",
	regional_categories = {"Northumbrian"},
}
aliases["Northumbrian"] = "Northumbria"
aliases["Northumberland"] = "Northumbria"
aliases["Northeast England"] = "Northumbria"
aliases["North-East England"] = "Northumbria"
aliases["North East England"] = "Northumbria"

labels["Nottinghamshire"] = {
	display = "[[w:Nottinghamshire|Nottinghamshire]]",
	regional_categories = {"Nottinghamshire"},
}
aliases["Nottinghamshire dialect"] = "Nottinghamshire"

-- Europe O
labels["Oltenia"] = {
	display = "[[w:Oltenia|Oltenia]]",
	regional_categories = {"Oltenian"},
}
aliases["Oltenian"] = "Oltenia"

labels["Orenburg"] = {
	display = "[[w:Orenburg|Orenburg]]",
	regional_categories = {"Orenburg"},
}

labels["Orkney"] = {
	display = "[[w:Orkney|Orkney]]",
	regional_categories = {"Orkney"},
}
aliases["Orcadian"] = "Orkney"

labels["Ostrobothnia"] = {
	display = "[[w:Ostrobothnia|Ostrobothnia]]",
	regional_categories = {"Ostrobothnian"},
}
aliases["Ostrobothnian"] = "Ostrobothnia"
aliases["Österbotten"] = "Ostrobothnia"

labels["Oxfordshire"] = {
	display = "[[w:Oxfordshire|Oxfordshire]]",
	regional_categories = {"Oxfordshire"},
}
aliases["Oxfordshire dialect"] = "Oxfordshire"

labels["Oxford University"] = {
	display = "[[w:University of Oxford|Oxford University]]",
	regional_categories = {"Oxford University"},
}
aliases["University of Oxford"] = "Oxford University"

-- Europe P
labels["Parma"] = {
	display = "[[w:Parma|Parma]]",
	regional_categories = {"Parmigiano"},
}
aliases["Parmigiano"] = "Parma"

labels["Perthshire"] = {
	display = "[[w:Perthshire|Perthshire]]",
	regional_categories = {"Perthshire"},
}

labels["Piacenza"] = {
	display = "[[w:Piacenza|Piacenza]]",
	regional_categories = {"Piacentino"},
}
aliases["Piacentino"] = "Piacenza"

labels["Picardy"] = {
	display = "[[w:Picardy|Picardy]]",
	regional_categories = {"Picard"},
}
aliases["Picard"] = "Picardy"

labels["Portugal"] = {
	display = "[[w:Portugal|Portugal]]",
	regional_categories = {"Portuguese"},
}
aliases["Portuguese"] = "Portugal"

labels["Prešov"] = {
	display = "[[w:Prešov|Prešov]]",
	regional_categories = {"Prešov"},
}
aliases["Presov"] = "Prešov"

labels["Provence"] = {
	display = "[[w:Provence|Provence]]",
	regional_categories = {"Provence"},
}
--don't add Provençal as an alias

labels["Prussia"] = {
	display = "[[w:Prussia (region)|Prussia]]",
	regional_categories = {"Prussian"},
}
aliases["Prussian"] = "Prussia"
aliases["East Prussia"] = "Prussia" --aliased for now; if many entries use it, it can be separated
aliases["East Prussian"] = "Prussia"
aliases["West Prussia"] = "Prussia"
aliases["West Prussian"] = "Prussia"

labels["Pskov"] = {
	display = "[[w:Pskov|Pskov]]",
	regional_categories = {"Pskov"},
}
-- Europe Q

-- Europe R
labels["Reggio Emilia"] = {
	display = "[[w:Reggio Emilia|Reggio Emilia]]",
	regional_categories = {"Reggiano"},
}
aliases["Reggiano"] = "Reggio Emilia"

labels["Roman Empire"] = {
	display = "[[w:Roman Empire|Roman Empire]]",
	regional_categories = {"Roman"},
}

labels["Ross-shire"] = {
	display = "[[w:Ross-shire|Ross-shire]]",
	regional_categories = {"Ross-shire"},
}
aliases["Ross"] = "Ross-shire"

labels["Rotterdam"] = {
	display = "[[w:Rotterdam|Rotterdam]]",
	regional_categories = {"Rotterdam"},
}
aliases["Rotterdams"] = "Rotterdam"

-- Europe S
labels["Saarland"] = {
	display = "[[w:Saarland|Saarland]]",
	regional_categories = {"Saarland"},
}
aliases["Saarländisch"] = "Saarland"
aliases["Saarlandic"] = "Saarland"
aliases["Saarlandish"] = "Saarland"

labels["Saint Ouen"] = {
	display = "[[w:Saint Ouen, Jersey|Saint Ouën]]",
	regional_categories = {"Saint Ouënnais"},
}
aliases["Saint Ouënnais"] = "Saint Ouen"

labels["Saint Petersburg"] = {
	display = "[[w:Saint Petersburg|Saint Petersburg]]",
	regional_categories = {"Saint Petersburg"},
}
aliases["St Petersburg"] = "Saint Petersburg"
aliases["St. Petersburg"] = "Saint Petersburg"

labels["Sandoy"] = {
	display = "[[w:Sandoy|Sandoy]]",
	regional_categories = {"Sandoy"},
}
aliases["Sandø"] = "Sandoy"

labels["Sappada"] = {
	display = "[[w:Sappada|Sappada]]",
	regional_categories = {"Sappada"},
}

labels["Sauris"] = {
	display = "[[w:Sauris|Sauris]]",
	regional_categories = {"Sauris"},
}

labels["Scania"] = {
	display = "[[w:Scania|Scania]]",
	regional_categories = {"Scanian"},
}
aliases["Scanian"] = "Scania"
aliases["Skanian"] = "Scania"
aliases["Skåne"] = "Scania"

labels["Scotland"] = {
	display = "[[w:Scotland|Scotland]]",
	regional_categories = {"Scottish"},
}
aliases["Scottish"] = "Scotland"

labels["Sense"] = {
	display = "[[w:Sense District|Sense]]",
	regional_categories = {"Sensler"},
}
aliases["Sensler"] = "Sense"
aliases["Sense District"] = "Sense"
aliases["Senslerdeutsch"] = "Sense"

labels["Serbia"] = {
	display = "[[w:Serbia|Serbia]]",
	regional_categories = {"Serbian"},
}
aliases["Serbian"] = "Serbia"

labels["Shetland"] = {
	display = "[[w:Shetland|Shetland]]",
	regional_categories = {"Shetland"},
}
aliases["Shetland islands"] = "Shetland"
aliases["Shetland Islands"] = "Shetland"
aliases["Shetlandic"] = "Shetland"
aliases["Shetlands"] = "Shetland"

labels["Silesia"] = {
	display = "[[w:Silesia|Silesia]]",
	regional_categories = {"Silesia"},
} --Silesia German, Silesia Polish; for differentiation between sli "Silesian German"
-- don't add Silesian as alias

labels["Skye"] = {
	display = "[[w:Isle of Skye|Skye]]",
	regional_categories = {"Skye"},
}
aliases["Isle of Skye"] = "Skye"

labels["Somerset"] = {
	display = "[[w:Somerset|Somerset]]",
	regional_categories = {"Somerset"},
}
aliases["Somerset dialect"] = "Somerset"

labels["South Wales"] = {
	display = "[[w:South Wales|South Wales]]",
	regional_categories = {"South Wales"},
}

labels["Southern England"] = {
	display = "[[w:Southern England|Southern England]]",
	regional_categories = {"Southern England"},
}
aliases["southern England"] = "Southern England"
aliases["South England"] = "Southern England"
aliases["south England"] = "Southern England"

labels["South Tyrol"] = {
	display = "[[w:South Tyrol|South Tyrol]]",
	regional_categories = {"South Tyrolean"},
}
aliases["Alto Adige"] = "South Tyrol"
aliases["South Tirol"] = "South Tyrol"
aliases["South Tirolean"] = "South Tyrol"
aliases["South Tirolese"] = "South Tyrol"
aliases["South Tyrolean"] = "South Tyrol"
aliases["South Tyrolese"] = "South Tyrol"

labels["Spain"] = {
	display = "[[w:Spain|Spain]]",
	regional_categories = {"Spanish"},
}
aliases["Spanish"] = "Spain"

labels["Spilamberto"] = {
	display = "[[w:Spilamberto|Spilamberto]]",
	regional_categories = {"Spilambertese"},
}
aliases["Spilambertese"] = "Spilamberto"

labels["St. Gallen"] = {
	display = "[[w:St. Gallen|St. Gallen]]",
	regional_categories = {"St. Gallen"},
}
aliases["St Gallen"] = "St. Gallen"
aliases["Saint Gallen"] = "St. Gallen"

labels["Styria"] = {
	display = "[[w:Styria|Styria]]",
	regional_categories = {"Styrian"},
}
aliases["Styrian"] = "Styria"
aliases["Steiermark"] = "Styria"
aliases["Steiermärkisch"] = "Styria"
aliases["Steirisch"] = "Styria"

labels["Suffolk"] = {
	display = "[[w:Suffolk|Suffolk]]",
	regional_categories = {"Suffolk"},
}
aliases["Suffolk dialect"] = "Suffolk"

labels["Sutherland"] = {
	display = "[[w:Sutherland|Sutherland]]",
	regional_categories = {"Sutherland"},
}

labels["Suðuroy"] = {
	display = "[[w:Suðuroy|Suðuroy]]",
	regional_categories = {"Suðuroy"},
}
aliases["Suduroy"] = "Suðuroy"

labels["Sweden"] = {
	display = "[[w:Sweden|Sweden]]",
	regional_categories = {"Sweden"},
}
aliases["Swedish"] = "Sweden"

labels["Switzerland"] = {
	display = "[[w:Switzerland|Switzerland]]",
	regional_categories = {"Switzerland"},
}
aliases["Swiss"] = "Switzerland"
aliases["Swiss German"] = "Switzerland" -- some German entries use this alias; let -sche know if it causes problems

labels["Sylt"] = {
	display = "[[w:Sylt|Sylt]]",
	regional_categories = {"Sylt"},
}
aliases["Söl"] = "Sylt"
aliases["Sölring"] = "Sylt"
aliases["Söl'"] = "Sylt"
aliases["Söl'ring"] = "Sylt"

-- Europe T
labels["Teesside"] = {
	display = "[[w:Teesside|Teesside]]",
	regional_categories = {"Teesside"},
}

labels["Timau"] = {
	display = "[[w:Paluzza|Timau]]",
	regional_categories = {"Timau"},
}

labels["Transylvania"] = {
	display = "[[w:Transylvania|Transylvania]]",
	regional_categories = {"Transylvanian"},
}
aliases["Transilvania"] = "Transylvania"
aliases["Transylvanian"] = "Transylvania"

-- Europe U
labels["Uist"] = {
	display = "[[w:Uist|Uist]]",
	regional_categories = {"Uist"},
}

labels["Ulster"] = {
	display = "[[w:Ulster|Ulster]]",
	regional_categories = {"Ulster"},
}

labels["Uri"] = {
	display = "[[w:Canton of Uri|Uri]]",
	regional_categories = {"Urner"},
}
aliases["Urseren"] = "Uri"
aliases["Urner"] = "Uri"
aliases["Urnerdeutsch"] = "Uri"

-- Europe V
labels["Venice"] = {
	display = "[[w:Venice|Venice]]",
	regional_categories = {"Venetian"},
}
aliases["Venetian"] = "Venice"

labels["Vienna"] = {
	display = "[[w:Vienna|Vienna]]",
	regional_categories = {"Viennese"},
}
aliases["Viennese"] = "Vienna"

labels["Vilhelmina"] = {
	display = "[[w:Vilhelmina|Vilhelmina]]",
	regional_categories = {"Vilhelmina"},
}

labels["Vojvodina"] = {
	display = "[[w:Vojvodina|Vojvodina]]",
	regional_categories = {"Vojvodina"},
}

-- Europe W
labels["Wales"] = {
	display = "[[w:Wales|Wales]]",
	regional_categories = {"Welsh"},
}
aliases["Welsh"] = "Wales"

labels["Wallonia"] = {
	display = "[[w:Wallonia|Wallonia]]",
	regional_categories = {"Wallonian"},
}
aliases["Wallonian"] = "Wallonia"

labels["Wearside"] = {
	display = "[[w:Wearside|Wearside]]",
	regional_categories = {"Wearside"},
}

labels["West Country"] = {
	display = "[[w:West Country|West Country]]",
	regional_categories = {"West Country"},
}
aliases["West England"] = "West Country"
aliases["west England"] = "West Country"
aliases["Western England"] = "West Country"
aliases["western England"] = "West Country"
aliases["West of England"] = "West Country"

labels["West Midlands"] = {
	display = "[[w:West Midlands|West Midlands]]",
	regional_categories = {"West Midlands"},
}

labels["Western Ukraine"] = {
	display = "[[w:Western Ukraine|Western Ukraine]]",
	regional_categories = {"Western"},
}

labels["Wiltshire"] = {
	display = "[[w:Wiltshire|Wiltshire]]",
	regional_categories = {"Wiltshire"},
}
aliases["Wiltshire dialect"] = "Wiltshire"
aliases["Wilts"] = "Wiltshire"
aliases["Wilts dialect"] = "Wiltshire"

-- Europe X

-- Europe Y
labels["Yorkshire"] = {
	display = "[[w:Yorkshire|Yorkshire]]",
	regional_categories = {"Yorkshire"},
}

-- Europe Z
labels["Zürich"] = {
	display = "[[w:Zürich|Zürich]]",
	regional_categories = {"Zürich"},
}
aliases["Zurich"] = "Zürich"

-- Australia and Oceania

-- AO A 
labels["Australia"] = {
	display = "[[w:Australia|Australia]]",
	regional_categories = {"Australian"},
}
aliases["AU"] = "Australia"
aliases["Australian"] = "Australia"

labels["Australian spelling"] = {
	display = "Australian spelling",
	Wikipedia = "Australian English#Spelling and style",
	plain_categories = {"Australian English forms"},
	language = "en",
}

-- kludge, needed here for [[Template:standard spelling of]] et al
labels["Australian form"] = {
	display = "Australian",
	Wikipedia = "Australian English#Spelling and style",
	plain_categories = {"Australian English forms"},
	language = "en",
}

-- AO B
-- AO C
-- AO D
-- AO E
-- AO F
-- AO G

-- AO H
labels["Hawaii"] = {
	display = "[[w:Hawaii|Hawaii]]",
	regional_categories = {"Hawaiian"},
}
aliases["Hawaiian"] = "Hawaii"

-- AO I
-- AO J

-- AO K
labels["Kauaʻi"] = {
	display = "[[w:Kauai|Kauaʻi]]",
	regional_categories = {"Kauaʻi"},
}
aliases["Kauai"] = "Kauaʻi"
aliases["Kaua'i"] = "Kauaʻi"

-- AO L
labels["Lānaʻi"] = {
	display = "[[w:Lanai|Lānaʻi]]",
	regional_categories = {"Lānaʻi"},
}
aliases["Lanaʻi"] = "Lānaʻi"
aliases["Lanai"] = "Lānaʻi"
aliases["Lāna'i"] = "Lānaʻi"
aliases["Lana'i"] = "Lānaʻi"

-- AO M
labels["Maui"] = {
	display = "[[w:Maui|Maui]]",
	regional_categories = {"Maui"},
}

labels["Molokaʻi"] = {
	display = "[[w:Molokai|Molokaʻi]]",
	regional_categories = {"Molokaʻi"},
}
aliases["Molokai"] = "Molokaʻi"
aliases["Moloka'i"] = "Molokaʻi"

-- AO N
labels["New Zealand"] = {
	display = "[[w:New Zealand|New Zealand]]",
	regional_categories = {"New Zealand"},
}
aliases["NZ"] = "New Zealand"

labels["Niʻihau"] = {
	display = "[[w:Niihau dialect|Niʻihau]]",
	regional_categories = {"Niʻihau"},
}
aliases["Ni'ihau"] = "Niʻihau"
aliases["Niihau"] = "Niʻihau"

-- AO O
-- AO P
-- AO Q
-- AO R
-- AO S
-- AO T
-- AO U
-- AO V
-- AO W
-- AO X
-- AO Y
-- AO Z

-- Other/unclear

labels["Antarctica"] = {
	display = "[[w:Antarctica|Antarctica]]",
	regional_categories = {"Antarctic"},
}
aliases["Antarctic"] = "Antarctica"
aliases["South Pole"] = "Antarctica"

labels["Commonwealth"] = {
	display = "[[Commonwealth of Nations]]",
	regional_categories = {"Commonwealth"},
}

labels["Kitti"] = {
	regional_categories = {"Kitti"},
}

-- Adds labels[label]["languages"][language_code] = true for members of "languages" field.
m_data_functions.handle_languages(labels)

return {labels = labels, aliases = aliases, deprecated = deprecated}