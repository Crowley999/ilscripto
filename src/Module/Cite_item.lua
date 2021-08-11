-- Creates a timeline for an item based on various properties

local p = {}
local wikidata = require('Module:Wikidata')
local linguistic = require('Module:Linguistic')
local fb = require('Module:Fallback')


local i18n = {
	articletitle = {
		de = '„$1“',
		en = '"$1"',
		fr = '«$1»',
		nb = '«$1»',
		nn = '«$1»',
		},
	booktitle = {
		en = '<i>$1</i>',
		},
	editor = {
		de = '$1 (Hrsg.)',
		en = '$1 (ed.)',
		nb = '$1 (red.)',
		nn = '$1 (red.)',
	},
	editors = {
		de = '$1 (Hrsg.)',
		en = '$1 (eds.)',
		nb = '$1 (red.)',
		nn = '$1 (red.)',	
	},
	num = {
		af = 'nr. $1',
		ca = 'núm. $1',
		cs = 'č. $1',
		da = 'nr. $1',
		de = 'Nr. $1',
		el = 'αρ. $1',
		en = 'no. $1',
		es = ' nº$1',
		fa = 'ش. 1$',
		fr = 'n°1$1',
		gd = 'àir. $1',
		ja = '$1番',
		['io'] = 'nº$1',
		ka = 'არა$1',
		lt = 'nr. $1',
		lv = 'nr. $1',
		mk = 'бр. $1',
		nl = 'nr $1',
		no = 'nr $1',
		pl = 'nr $1',
		pt = 'nº$1',
		ru = '№$1',
		sk = 'č. $1',
		sl = 'št. $1',
		st = 'no. $1',
		sv = 'nr $1',
		nl = '$1號',
	},	
	page = {
		de = 'S. $1',
		en = 'p. $1',
		fr = 'p. $1',
		nb = 's. $1',
		nn = 's. $1',
	},
	['read online'] = {
		de = '[$1 online]',
		en = '[$1 read online]',
		fr = '[$1 lire en ligne]',
		nb = '[$1 les online]',
		nn = '[$1 les online]',		
	},
	['volume'] = {
		de = 'Band $1',
		en = 'vol. $1',	
	},
	['citation_comma'] = {
		zh = '，',  -- in Chinese the commas used in citation aren't '、'
		["zh-cn"] = '，',
		["zh-hans"] = '，',
		["zh-hant"] = '，',
		["zh-hk"] = '，',
		["zh-mo"] = '，',
		["zh-sg"] = '，',
		["zh-tw"] = '，',
		en = ', ',
		message = 'comma-separator',
	},
}

local function translate(msg, lg, sub1, sub2)
	local str = fb._langSwitch(i18n[msg], lg)
	if not str then
		return "nil"
	end
	if sub1 then
		str = str:gsub("$1", sub1)
	end
	if sub2 then
		str = str:gsub("$2", sub2)
	end
	return str
end

local function getTitle(item, lang)
	local title = wikidata.formatStatements({entity=item, property = 'P1476'})
	if not title then
		title = wikidata._getLabel(item, {lang= lang}) .. " (title not provided in Wikidata)"
	end
	return title
end
local function formatpage(page, lang)
-- same text for singular and plural, most of the time, they can be distinguished by the presence of a "-" but that does not always work, see Q11927173
	if not page then 
		return nil
	end
	return translate("page", lang, page)
end

local function formatnum(num, lang)
	if not num then 
		return nil
	end
	return translate("num", lang, num)
end

local function getauthor(item, lang)
	return wikidata.formatStatements{entity=item, property = 'P50', lang=lang}
end

local function getISBN(item, lang)
	local ISBN = wikidata.formatStatements{entity = item, property = 'P212', lang=lang, numval = 1}
	if ISBN then 
		return 'ISBN ' ..ISBN
	end
end

local function getLink(item, lang)
	local links = wikidata.formatStatements{entity = item, property = 'P854', numval = 1, lang=lang}
	if links then
		return translate('read online', lang, links)
	end
end

local function getVolume(item, lang)
	local volume = wikidata.formatStatements{item = item, property = 'P478', numval = 1, lang=lang}
	if volume then
		return translate("volume", lang, volume)
	end
end

local function getDoi(item, lang)
	local doi = wikidata.formatStatements({entity=item, property = 'P356', numval = 1, lang=lang}) -- what to do if several value
	if not doi then
		return nil
	end
	return '<small>' .. 'doi: [http://dx.doi.org/' .. doi .. ' ' .. doi .. ']' .. '</small>' -- needs i18n ?
end

local function getPmid(item, lang)
	local pmid = wikidata.formatStatements({entity=item, property = 'P698', numval = 1, lang=lang}) -- what to do if several values
	if not pmid then
		return nil
	end
	return '<small> PubMed ID: [https://www.ncbi.nlm.nih.gov/pubmed/?term=' .. pmid .. ' ' .. pmid .. '] </small>' -- needs i18n ?
end

local function getPmcid(item, lang)
	local pmcid = wikidata.formatStatements({entity=item, property = 'P932', numval = 1, lang=lang}) -- what to do if several values
	if not pmcid then
		return nil
	end
	return '<small> PubMed Central ID: [https://www.ncbi.nlm.nih.gov/pmc/articles/PMC?term=' .. pmcid .. ' ' .. pmcid .. '] </small>' -- needs i18n ?
end

local function getEditor(item, lang)
	local editortable = wikidata.getClaims({entity=item, property='P98'})
	if not editortable then 
		return nil
	end
	local editor = wikidata.formatStatements({entity=item, property='P98', lang=lang}) -- should have a "formatClaims" function to avoid double work
	if #editortable > 1 then
		 return translate('editor', lang, editor)
	else
		return translate('editors', lang, editor)
	end
		
end

local function getedition(item, lang)
	local ednumber = wikidata.formatStatements({entity=item, property = 'P393', lang=lang, numval = 1}) 
	if not ednumber then 
		return nil
	end
	local ord = require('Module:Ordinal')._Ordinal
	return fb._langSwitch({ 
		de = ednumber .. '. Auflage', 
		en = ord(ednumber, 'en') .. ' edition',
		fr = ord(ednumber, 'fr') .. ' édition',
		nb = ord(ednumber, 'nb') .. ' utgave',
		nn = ord(ednumber, 'nn') .. ' utgave',
		}, lang)
end

local function getarticletitle(item, lang)
	local title = getTitle(item, lang)
	title = translate("articletitle", lang, title)
	return title
end

local function getbooktitle(item, lang)-- needs i18n some languages do not use this format
	local title = getTitle(item, lang)
	title = translate("booktitle", lang, title)
	return title
end

local function getissue(item, lang)
	return  wikidata.formatStatements({entity=item, property = 'P433', lang=lang})
end

local function getpublisher(item, lang)
	return wikidata.formatStatements({entity=item, property = 'P123', lang=lang})
end

local function getpublishdate(item, lang)
	return  wikidata.formatStatements({entity=item, property = 'P577', lang=lang})
end

local function getpublishplace(item, lang)
	return  wikidata.formatStatements({entity=item, property = 'P291', lang=lang})
end

local function geturl(item, lang)
	return wikidata.formatStatements({entity=item, property = 'P854', lang=lang})
end

local function getlicense(item, lang)
	return wikidata.formatStatements{entity=item, property = 'P275', lang=lang}
end

local function getjournal(item, lang) -- get the title property rather than the label
	local journal = wikidata.formatStatements({entity = item, property = 'P1433', exlcudespecial = true})
	if journal then return '<i>' .. journal .. '</i>' end -- would need i18n 
end

local function citebook(item, lang, page, num)
	local publishdate = getpublishdate(item, lang)
	local author = getauthor(item, lang)
	local editor = getEditor(item, lang)
	local title = getbooktitle(item, lang)
	local publishplace = getpublishplace(item, lang)
	local publisher = getpublisher(item, lang)
	if publishplace and publisher then -- needs cleanup
		publisher = publishplace .. mw.getCurrentFrame():expandTemplate{title = "colon", args = {lang}} .. publisher
	end
	local edition = getedition(item, lang)
	local isbn = getISBN(item, lang)
	local doi = getDoi(item, lang)
	local pmid = getPmid(item, lang)
	local pmid = getPmcid(item, lang)
	local link = getLink(item, lang)
	local volume = getVolume(item, lang)
	local pagenumber = formatpage(page, lang)
	local refnum = formatpage(num, lang)
	local license = getlicense(item, lang)

	local fields = {}
	table.insert(fields, author)
	table.insert(fields, editor)
	table.insert(fields, title)
	table.insert(fields, edition)
	table.insert(fields, volume)
	table.insert(fields, publisher)
	table.insert(fields, publishdate)
	table.insert(fields, pagenumber)
	table.insert(fields, refnum)
	table.insert(fields, isbn)
	table.insert(fields, doi)
	table.insert(fields, pmid)
	table.insert(fields, pmcid)
	table.insert(fields, link)
	table.insert(fields, license)
	return linguistic.conj(fields, lang, translate("citation_comma", lang))
end

local function citearticle(item, lang, page, num)
	local author = getauthor(item, lang)
	local title = getarticletitle(item, lang)
	local publisher = getpublisher(item, lang)
	local publishdate = getpublishdate(item, lang)
	local pagenumber = formatpage(page, lang)
	local journal = getjournal(item, lang)
	local issue = getissue(item, lang)
	local publishdate = getpublishdate(item, lang)
	local doi = getDoi(item, lang)
	local pmid = getPmid(item, lang)
	local pmid = getPmcid(item, lang)
	local link = getLink(item, lang)
	local volume = getVolume(item, lang)
	local pagenumber = formatpage(page, lang)
	local refnum = formatpage(num, lang)
	local license = getlicense(item, lang)
	
	local fields = {}
	table.insert(fields, author)
	table.insert(fields, title)
	table.insert(fields, publisher)
	table.insert(fields, journal)
	table.insert(fields, volume)
	table.insert(fields, issue)
	table.insert(fields, publishdate)
	table.insert(fields, pagenumber)
	table.insert(fields, refnum)
	table.insert(fields, doi)
	table.insert(fields, pmid)
	table.insert(fields, pmcid)
	table.insert(fields, link)
	table.insert(fields, license)
	return linguistic.conj(fields, lang, "comma")
end

function p.citeitem(item, lang, page)
	if not item then return nil end
	if type(item) == 'string' then
		item = mw.wikibase.getEntityObject(item)
	end
	if not item then
		return "invalid item id"
	end
	if wikidata.getClaims({entity = item, property = 'P1433'}) then -- if item has "edition of" is a book, else an article, needs a better solution
		return citearticle(item, lang, page)
	else
		mw.log('Citing as book')
		return citebook(item, lang, page)
	end
end

function p.cite(frame)
	local lang = frame.args.lang
	if not lang or lang == '' then
		lang = frame:preprocess('{{int:lang}}')
	end
	local page = frame.args.page
	if page == '' then
		page = nil
	end
	return p.citeitem(frame.args.item, lang, page)
end

function p.reflist(frame)
	local list = mw.text.split( frame.args[1], ' ')
	local lang = frame.args.lang
	if not lang or lang == '' then
		lang = frame:preprocess('{{int:lang}}')
	end
	local str = ''
	for i, j in pairs(list) do
		str = str ..  '<li> ' .. p.citeitem(mw.text.trim(j),lang) .. '</li>'
	end
	return str
end

return p
-- author: https://en.wiktionary.org/wiki/Special:Contributions/Zolo
