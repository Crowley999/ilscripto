
--[[--------------------------< P A R A M E T E R S   N O T   S U P P O R T E D >------------------------------

This is a list of parameters that once were but now are no longer supported:

	['albumlink'] = nil,			-- unique alias of titlelink used by old cite AV media notes
	['albumtype'] = nil,			-- controled inappropriate functionality in the old cite AV media notes
	['artist'] = nil,				-- unique alias of others used by old cite AV media notes
	['Author'] = nil,				-- non-standard capitalization
	['authorformat'] = nil,			-- primarily used to support Vancouver format which functionality now part of name-list-format
	['author-format'] = nil,		-- primarily used to support Vancouver format which functionality now part of name-list-format
	['author-name-separator'] = nil,-- primarily used to support Vancouver format which functionality now part of name-list-format
	['author-separator'] = nil,		-- primarily used to support Vancouver format which functionality now part of name-list-format
	['began'] = nil,				-- module handles date ranges; cite episode and cite series
	['chapterlink'] = nil,			-- if ever necessary to link to a chapter article, |chapter= can be wikilinked 
	['chapter-link'] = nil,			-- 
	['cointerviewers'] = nil,		-- unique alias of others used by old cite interview
	['day'] = nil,					-- deprecated in {{citation/core}} and somehow undeprecated in Module:Citation/CS1 and now finally removed
	['director'] = nil,				-- unique alias of author used by old cite DVD-notes
	['DoiBroken'] = nil,			-- not used, non-standard captialization
	['Editor'] = nil,				-- non-standard capitalization
	['editorformat'] = nil,			-- primarily used to support Vancouver format which functionality now part of name-list-format
	['EditorSurname'] = nil,		-- non-standard capitalization
	['editor-format'] = nil,		-- primarily used to support Vancouver format which functionality now part of name-list-format
	['EditorGiven'] = nil,			-- non-standard capitalization
	['editor-name-separator'] = nil,-- primarily used to support Vancouver format which functionality now part of name-list-format
	['editor-separator'] = nil,		-- primarily used to support Vancouver format which functionality now part of name-list-format
	['Embargo'] = nil,				-- not used, non-standard capitalization
	['ended'] = nil,				-- module handles date ranges; cite episode and cite series
	['month'] = nil,				-- functionality supported by |date=
	['name-separator'] = nil,		-- primarily used to support Vancouver format which functionality now part of name-list-format
	['notestitle'] = nil,			-- unique alias of chapter used by old cite AV media notes
	['PPrefix'] = nil,				-- non-standard capitalization
	['PPPrefix'] = nil,				-- not used, non-standard capitalization
	['pp-prefix'] = nil,			-- not used, not documented
	['p-prefix'] = nil,				-- not used, not documented
	['publisherid'] = nil,			-- unique alias of id used by old cite AV media notes and old cite DVD-notes
	['Ref'] = nil,					-- non-statndard capitalization
	['separator'] = nil,			-- this functionality now provided by |mode=
	['titleyear'] = nil,			-- unique alias of origyear used by old cite DVD-notes

	['Author#'] = nil,				-- non-standard capitalization
	['authors#'] = nil,				-- no need for multiple lists of author names
	['Editor#'] = nil,				-- non-standard capitalization
	['editors#'] = nil,				-- no need for multiple lists of editor names
	['EditorGiven#'] = nil,			-- non-standard capitalization
	['EditorSurname#'] = nil,		-- non-standard capitalization

]]

--[[--------------------------< S U P P O R T E D   P A R A M E T E R S >--------------------------------------

Because a steady-state signal conveys no useful information, whitelist.basic_arguments[] list items can have three values:
	true - these parameters are valid and supported parameters
	false - these parameters are deprecated but still supported
	nil - these parameters are no longer supported (when setting a parameter to nil, leave a comment stating the reasons for invalidating the parameter)
	
]]

local whitelist = {}

local basic_arguments = {
	['accessdate'] = true,
	['access-date'] = true,
	['agency'] = true,
	['airdate'] = true,
	['air-date'] = true,
	['archivedate'] = true,
	['archive-date'] = true,
	['archive-format'] = true,
	['archiveurl'] = true,
	['archive-url'] = true,
	['article'] = true,
	['arxiv'] = true,
	['ARXIV'] = true,
	['asin'] = true,
	['ASIN'] = true,
	['asin-tld'] = true,
	['ASIN-TLD'] = true,
	['at'] = true,
	['author'] = true,
	['author-first'] = true,
	['author-last'] = true,
	['authorlink'] = true,
	['author-link'] = true,
	['authormask'] = true,
	['author-mask'] = true,
	['authors'] = true,
	['bibcode'] = true,
	['BIBCODE'] = true,
	['bibcode-access'] = true,
	['biorxiv'] = true,
	['booktitle'] = true,
	['book-title'] = true,
	['callsign'] = true,			-- cite interview
	['call-sign'] = true,			-- cite interview
	['cartography'] = true,
	['chapter'] = true,
	['chapter-format'] = true,
	['chapterurl'] = true,
	['chapter-url'] = true,
	['citeseerx'] = true,
	['city'] = true,				-- cite interview, cite episode, cite serial
	['class'] = true,				-- cite arxiv and arxiv identifiers
	['cn'] = true,
	['CN'] = true,
	['coauthor'] = false,			-- deprecated
	['coauthors'] = false,			-- deprecated
	['conference'] = true,
	['conference-format'] = true,
	['conferenceurl'] = true,
	['conference-url'] = true,
	['contribution'] = true,
	['contribution-format'] = true,
	['contributionurl'] = true,
	['contribution-url'] = true,
	['contributor'] = true,
	['contributor-first'] = true,
	['contributor-last'] = true,
	['contributor-link'] = true,
	['contributor-mask'] = true,
	['credits'] = true,				-- cite episode, cite serial
	['date'] = true,
	['deadurl'] = true,
	['dead-url'] = true,
	['degree'] = true,
	['department'] = true,
	['dictionary'] = true,
	['displayauthors'] = true,
	['display-authors'] = true,
	['displayeditors'] = true,
	['display-editors'] = true,
	['docket'] = true,
	['doi'] = true,
	['DOI'] = true,
	['doi-access'] = true,
	['doi-broken'] = true,
	['doi_brokendate'] = true,
	['doi-broken-date'] = true,
	['doi_inactivedate'] = true,
	['doi-inactive-date'] = true,
	['edition'] = true,
	['editor'] = true,
	['editor-first'] = true,
	['editor-given'] = true,
	['editor-last'] = true,
	['editorlink'] = true,
	['editor-link'] = true,
	['editormask'] = true,
	['editor-mask'] = true,
	['editors'] = true,
	['editor-surname'] = true,
	['eissn'] = true,
	['EISSN'] = true,
	['embargo'] = true,
	['encyclopaedia'] = true,
	['encyclopedia'] = true,
	['entry'] = true,
	['episode'] = true,															-- cite serial only TODO: make available to cite episode?
	['episodelink'] = true,														-- cite episode and cite serial
	['episode-link'] = true,													-- cite episode and cite serial
	['eprint'] = true,															-- cite arxiv and arxiv identifiers
	['event'] = true,
	['event-format'] = true,
	['eventurl'] = true,
	['event-url'] = true,
	['first'] = true,
	['format'] = true,
	['given'] = true,
	['hdl'] = true,
	['HDL'] = true,
	['hdl-access'] = true,
	['host'] = true,
	['id'] = true,
	['ID'] = true,
	['ignoreisbnerror'] = true,
	['ignore-isbn-error'] = true,
	['in'] = true,
	['inset'] = true,
	['institution'] = true,
	['interviewer'] = true,				--cite interview
	['interviewers'] = true,			--cite interview
	['isbn'] = true,
	['ISBN'] = true,
	['isbn13'] = true,
	['ISBN13'] = true,
	['ismn'] = true,
	['ISMN'] = true,
	['issn'] = true,
	['ISSN'] = true,
	['issue'] = true,
	['jfm'] = true,
	['JFM'] = true,
	['journal'] = true,
	['jstor'] = true,
	['JSTOR'] = true,
	['jstor-access'] = true,
	['language'] = true,
	['last'] = true,
	['lastauthoramp'] = true,
	['last-author-amp'] = true,
	['laydate'] = true,
	['lay-date'] = true,
	['laysource'] = true,
	['lay-source'] = true,
	['laysummary'] = true,
	['lay-summary'] = true,
	['lay-format'] = true,
	['layurl'] = true,
	['lay-url'] = true,
	['lccn'] = true,
	['LCCN'] = true,
	['location'] = true,
	['magazine'] = true,
	['mailinglist'] = true,				-- cite mailing list only
	['mailing-list'] = true,			-- cite mailing list only
	['map'] = true,						-- cite map only
	['map-format'] = true,				-- cite map only
	['mapurl'] = true,					-- cite map only
	['map-url'] = true,					-- cite map only
	['medium'] = true,
	['message-id'] = true,			-- cite newsgroup
	['minutes'] = true,
	['mode'] = true,
	['mr'] = true,
	['MR'] = true,
	['name-list-format'] = true,
	['network'] = true,
	['newsgroup'] = true,
	['newspaper'] = true,
	['nocat'] = true,
	['no-cat'] = true,
	['nopp'] = true,
	['no-pp'] = true,
	['notracking'] = true,
	['no-tracking'] = true,
	['number'] = true,
	['oclc'] = true,
	['OCLC'] = true,
	['ol'] = true,
	['OL'] = true,
	['ol-access'] = true,
	['origyear'] = true,
	['orig-year'] = true,
	['osti'] = true,
	['OSTI'] = true,
	['osti-access'] = true,
	['others'] = true,
	['p'] = true,
	['page'] = true,
	['pages'] = true,
	['people'] = true,
	['periodical'] = true,
	['place'] = true,
	['pmc'] = true,
	['PMC'] = true,
	['pmid'] = true,
	['PMID'] = true,
	['postscript'] = true,
	['pp'] = true,
	['program'] = true,				-- cite interview
	['publicationdate'] = true,
	['publication-date'] = true,
	['publicationplace'] = true,
	['publication-place'] = true,
	['publisher'] = true,
	['quotation'] = true,
	['quote'] = true,
	['ref'] = true,
	['registration'] = true,
	['rfc'] = true,
	['RFC'] = true,
	['s2cid'] = true,
	['s2cid-access'] = true,
	['scale'] = true,
	['script-chapter'] = true,
	['script-title'] = true,
	['season'] = true,
	['section'] = true,
	['section-format'] = true,
	['sections'] = true,					-- cite map only
	['sectionurl'] = true,
	['section-url'] = true,
	['series'] = true,
	['serieslink'] = true,
	['series-link'] = true,
	['seriesno'] = true,
	['series-no'] = true,
	['seriesnumber'] = true,
	['series-number'] = true,
	['series-separator'] = true,
	['sheet'] = true,															-- cite map only
	['sheets'] = true,															-- cite map only
	['ssrn'] = true,
	['SSRN'] = true,
	['station'] = true,
	['subject'] = true,
	['subjectlink'] = true,
	['subject-link'] = true,
	['subscription'] = true,
	['surname'] = true,
	['template doc demo'] = true,
	['template-doc-demo'] = true,
	['time'] = true,
	['timecaption'] = true,
	['time-caption'] = true,
	['title'] = true,
	['titlelink'] = true,
	['title-link'] = true,
	['title_zh'] = true,
	['trans_chapter'] = true,
	['trans-chapter'] = true,
	['trans-map'] = true,
	['transcript'] = true,
	['transcript-format'] = true,
	['transcripturl'] = true,
	['transcript-url'] = true,
	['trans_title'] = true,
	['trans-title'] = true,
	['translator'] = true,
	['translator-first'] = true,
	['translator-last'] = true,
	['translator-link'] = true,
	['translator-mask'] = true,
	['type'] = true,
	['url'] = true,
	['URL'] = true,
	['urlstatus'] = true,
	['url-status'] = true,
	['vauthors'] = true,
	['veditors'] = true,
	['version'] = true,
	['via'] = true,
	['volume'] = true,
	['website'] = true,
	['work'] = true,
	['year'] = true,
	['zbl'] = true,
	['ZBL'] = true,
	['unified'] = true,
	['csbn'] = true,
	['CSBN'] = true,
}

local numbered_arguments = {
	['author#'] = true,
	['author-first#'] = true,
	['author#-first'] = true,
	['author-last#'] = true,
	['author#-last'] = true,
	['author-link#'] = true,
	['author#link'] = true,
	['author#-link'] = true,
	['authorlink#'] = true,
	['author-mask#'] = true,
	['author#mask'] = true,
	['author#-mask'] = true,
	['authormask#'] = true,
	['contributor#'] = true,
	['contributor-first#'] = true,
	['contributor#-first'] = true,
	['contributor-last#'] = true,
	['contributor#-last'] = true,
	['contributor-link#'] = true,
	['contributor#-link'] = true,
	['contributor-mask#'] = true,
	['contributor#-mask'] = true,
	['editor#'] = true,
	['editor-first#'] = true,
	['editor#-first'] = true,
	['editor#-given'] = true,
	['editor-given#'] = true,
	['editor-last#'] = true,
	['editor#-last'] = true,
	['editor-link#'] = true,
	['editor#link'] = true,
	['editor#-link'] = true,
	['editorlink#'] = true,
	['editor-mask#'] = true,
	['editor#mask'] = true,
	['editor#-mask'] = true,
	['editormask#'] = true,
	['editor#-surname'] = true,
	['editor-surname#'] = true,
	['first#'] = true,
	['given#'] = true,
	['last#'] = true,
	['subject#'] = true,
	['subject-link#'] = true,
	['subject#link'] = true,
	['subject#-link'] = true,
	['subjectlink#'] = true,
	['surname#'] = true,
	['translator#'] = true,
	['translator-first#'] = true,
	['translator#-first'] = true,
	['translator-last#'] = true,
	['translator#-last'] = true,
	['translator-link#'] = true,
	['translator#-link'] = true,
	['translator-mask#'] = true,
	['translator#-mask'] = true,
}

return {basic_arguments = basic_arguments, numbered_arguments = numbered_arguments};