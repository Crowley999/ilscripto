
local citation_config = {};

-- override <code>...</code> styling to remove color, border, and padding.  <code> css is specified here:
-- https://git.wikimedia.org/blob/mediawiki%2Fcore.git/69cd73811f7aadd093050dbf20ed70ef0b42a713/skins%2Fcommon%2FcommonElements.css#L199
local code_style="color:inherit; border:inherit; padding:inherit;";

--[[--------------------------< U N C A T E G O R I Z E D _ N A M E S P A C E S >------------------------------

List of namespaces that should not be included in citation error categories.  Same as setting notracking = true by default

Note: Namespace names should use underscores instead of spaces.

]]
local uncategorized_namespaces = { 'User', 'Talk', 'User_talk', 'Wikipedia_talk', 'File_talk', 'Template_talk',
	'Help_talk', 'Category_talk', 'Portal_talk', 'Book_talk', 'Draft', 'Draft_talk', 'Education_Program_talk', 
	'Module_talk', 'MediaWiki_talk' };

local uncategorized_subpages = {'/[Ss]andbox', '/[Tt]estcases'};		-- list of Lua patterns found in page names of pages we should not categorize

--[[--------------------------< M E S S A G E S >--------------------------------------------------------------

Translation table

The following contains fixed text that may be output as part of a citation.
This is separated from the main body to aid in future translations of this
module.

]]

local messages = {
	['archived-dead'] = '（$1存档于$2）',
	['archived-not-dead'] = '（原始内容$1于$2）',
	['archived-missing'] = '（原始内容$1存档于$2）',
	['archived'] = '存档',
	['by'] = 'By',																-- contributions to authored works: introduction, foreword, afterword
	['cartography'] = 'Cartography by $1',
	['editor'] = '编',
	['editors'] = '编', 
	['edition'] = '$1', 
	['episode'] = '第$1集',
	['et al'] = '等', 
	['in'] = '(编)',																-- edited works
	['inactive'] = '不活跃',
	['inset'] = '$1 inset',
	['lay summary'] = '简明摘要',
	['newsgroup'] = '[[Usenet newsgroup|Newsgroup]]:&nbsp;$1',
	['original'] = '原始内容',
	['published'] = '$1',
	['retrieved'] = '&#91;$1&#93;',
	['season'] = '第$1季', 
	['section'] = '§ $1',
	['sections'] = '§§ $1',
	['series'] = '第$1系列',
	['type'] = ' ($1)',															-- for titletype
	['written'] = '写于$1',

	['vol'] = '$1 Vol.&nbsp;$2',												-- $1 is sepc; bold journal style volume is in presentation{}
	['vol-no'] = '$1 Vol.&nbsp;$2 no.&nbsp;$3',									-- sepc, volume, issue
	['issue'] = '$1 No.&nbsp;$2',												-- $1 is sepc

	['j-vol'] = '$1 $2',														-- sepc, volume; bold journal volume is in presentation{}
	['j-issue'] = ' ($1)',

	['nopp'] = '$1 $2';															-- page(s) without prefix; $1 is sepc

	['p-prefix'] = ": $2",												-- $1 is sepc
	['pp-prefix'] = ": $2",											-- $1 is sepc
	['j-page(s)'] = ': $1',														-- same for page and pages

	['sheet'] = '$1 Sheet&nbsp;$2',												-- $1 is sepc
	['sheets'] = '$1 Sheets&nbsp;$2',											-- $1 is sepc
	['j-sheet'] = ': Sheet&nbsp;$1',
	['j-sheets'] = ': Sheets&nbsp;$1',
	
	['subscription'] = '[[File:Lock-red-alt.svg|9px|link=|alt=需要付费订阅|需要付费订阅]]' ..
		'[[Category:含有連結內容需訂閱查看的頁面]]', 
	
	['registration']='[[File:Lock-blue-alt-2.svg|9px|link=|alt=需要免费注册|需要免费注册]]' ..
		'[[Category:含有內容需登入查看的頁面]]',
	
	['language'] = '<span style="font-family: sans-serif; cursor: default; color:#555; font-size: 0.8em; bottom: 0.1em; font-weight: bold;" title="连接到$1网页">（$1）</span>', 
	['via'] = " &ndash;-{zh-hans:通过;zh-hant:透過;}-$1",
	['event'] = '事件发生在',
	['minutes'] = '记录于', 
	
	['parameter-separator'] = '、',
	['parameter-final-separator'] = '和',
	['parameter-pair-separator'] = '和',
	
	-- Determines the location of the help page
	['help page link'] = 'Help:引文格式1错误',
	['help page label'] = '帮助',
	
	-- Internal errors (should only occur if configuration is bad)
	['undefined_error'] = '调用了一个未定义的错误条件',
	['unknown_manual_ID'] = '无法识别的手动ID模式',
	['unknown_ID_mode'] = '无法识别的ID模式',
	['unknown_argument_map'] = 'Argument map not defined for this variable',
	['bare_url_no_origin'] = 'Bare url found but origin indicator is nil or empty',
}

--[[--------------------------< P R E S E N T A T I O N >------------------------------------------------------

Fixed presentation markup.  Originally part of citation_config.messages it has been moved into its own, more semantically
correct place.

]]
local presentation = 
	{
	-- Error output
	-- .error class is specified at https://git.wikimedia.org/blob/mediawiki%2Fcore.git/9553bd02a5595da05c184f7521721fb1b79b3935/skins%2Fcommon%2Fshared.css#L538
	-- .citation-comment class is specified at Help:CS1_errors#Controlling_error_message_display
	['hidden-error'] = '<span style="display:none;font-size:100%" class="error citation-comment">$1</span>',
	['visible-error'] = '<span style="font-size:100%" class="error citation-comment">$1</span>',

	['accessdate'] = '<span class="reference-accessdate">$2</span>',			-- to allow editors to hide accessdate using personal css

	['bdi'] = '<bdi$1>$2</bdi>',												-- bidirectional isolation used with |script-title= and the like

	['format'] = ' <span style="font-size:85%;">($1)</span>',					-- for |format=, |chapter-format=, etc

	['access-signal'] = '<span class="plainlinks">$1&#8239;$2</span>',			-- external link with appropriate lock icon
		['free'] = '[[File:Lock-green.svg|9px|link=|alt=可免费查阅|可免费查阅]]',
		['registration'] = '[[File:Lock-blue-alt-2.svg|9px|link=|alt=需要免费注册|需要免费注册]]',
		['limited'] = '[[File:Lock-blue-alt-2.svg|9px|link=|alt=有限度免费查阅，超限则需付费订阅|有限度免费查阅，超限则需付费订阅]]',
		['subscription'] = '[[File:Lock-red-alt.svg|9px|link=|alt=需要付费订阅|需要付费订阅]]',

	['italic-title'] = "$1",

	['kern-left'] = '<span style="padding-left:0.2em;">$1</span>$2',			-- spacing to use when title contains leading single or double quote mark
	['kern-right'] = '$1<span style="padding-right:0.2em;">$2</span>',			-- spacing to use when title contains trailing single or double quote mark

	['nowrap1'] = '<span class="nowrap">$1</span>',								-- for nowrapping an item: <span ...>yyyy-mm-dd</span>
	['nowrap2'] = '<span class="nowrap">$1</span> $2',							-- for nowrapping portions of an item: <span ...>dd mmmm</span> yyyy (note white space)
	
	['parameter'] = '<code style="'..code_style..'">&#124;$1=</code>',

	['quoted-text'] = '<q>$1</q>',												-- for wrapping |quote= content
	['quoted-title'] = '$1',

	['trans-italic-title'] = "&#91;$1&#93;",
	['trans-quoted-title'] = "&#91;$1&#93;",
	['vol-bold'] = ' <b>$1</b>',													-- for journal cites; for other cites ['vol'] in messages{}
	}

--[[--------------------------< A L I A S E S >----------------------------------------------------------------

Aliases table for commonly passed parameters

]]

local aliases = {
	['AccessDate'] = {'access-date', 'accessdate'},
	['Agency'] = 'agency',
	['AirDate'] = {'air-date', 'airdate'},
	['ArchiveDate'] = {'archive-date', 'archivedate'},
	['ArchiveFormat'] = 'archive-format',
	['ArchiveURL'] = {'archive-url', 'archiveurl'},
	['ASINTLD'] = {'ASIN-TLD', 'asin-tld'},
	['At'] = 'at',
	['Authors'] = {'authors', 'people', 'host', 'credits'},
	['BookTitle'] = {'book-title', 'booktitle'},
	['Callsign'] = {'call-sign', 'callsign'},									-- cite interview
	['Cartography'] = 'cartography',
	['Chapter'] = {'chapter', 'contribution', 'entry', 'article', 'section'},
	['ChapterFormat'] = {'chapter-format', 'contribution-format', 'section-format'};
	['ChapterURL'] = {'chapter-url', 'chapterurl', 'contribution-url', 'contributionurl', 'section-url', 'sectionurl'},
	['City'] = 'city',															-- cite interview
	['Class'] = 'class',														-- cite arxiv and arxiv identifiers
	['Coauthors'] = {'coauthors', 'coauthor'},									-- coauthor and coauthors are deprecated; remove after 1 January 2015?
	['Conference'] = {'conference', 'event'},
	['ConferenceFormat'] = {'conference-format', 'event-format'},
	['ConferenceURL'] = {'conference-url', 'conferenceurl', 'event-url', 'eventurl'},
	['Contribution'] = 'contribution',											-- introduction, foreword, afterword, etc; required when |contributor= set
	['Date'] = {'date', 'air-date', 'airdate'},
	['DeadURL'] = {'dead-url', 'deadurl','url-status','urlstatus'},
	['Degree'] = 'degree',
	['DF'] = 'df',
	['DisplayAuthors'] = {'display-authors', 'displayauthors'},
	['DisplayEditors'] = {'display-editors', 'displayeditors'},
	['Docket'] = 'docket',
	['DoiBroken'] = {'doi-broken', 'doi-broken-date', 'doi-inactive-date', 'doi_brokendate', 'doi_inactivedate'},
	['Edition'] = 'edition',
	['Editors'] = 'editors',
	['Embargo'] = 'embargo',
	['Encyclopedia'] = {'encyclopedia', 'encyclopaedia'},						-- this one only used by citation
	['Episode'] = 'episode',													-- cite serial only TODO: make available to cite episode?
	['Format'] = 'format',
	['ID'] = {'id', 'ID'},
	['IgnoreISBN'] = {'ignore-isbn-error', 'ignoreisbnerror'},
	['Inset'] = 'inset',
	['Issue'] = {'issue', 'number'},
	['Language'] = {'language', 'in'},
	['LastAuthorAmp'] = {'last-author-amp', 'lastauthoramp'},
	['LayDate'] = {'lay-date', 'laydate'},
	['LayFormat'] = 'lay-format',
	['LaySource'] = {'lay-source', 'laysource'},
	['LayURL'] = {'lay-url', 'lay-summary', 'layurl', 'laysummary'},
	['MailingList'] = {'mailinglist', 'mailing-list'},							-- cite mailing list only
	['Map'] = 'map',															-- cite map only
	['MapFormat'] = 'map-format',												-- cite map only
	['MapURL'] = {'mapurl', 'map-url'},											-- cite map only
	['MessageID'] = 'message-id',
	['Minutes'] = 'minutes',
	['Mode'] = 'mode',
	['NameListFormat'] = 'name-list-format',
	['Network'] = 'network',
	['NoPP'] = {'no-pp', 'nopp'},
	['NoTracking'] = {'template-doc-demo', 'template doc demo', 'no-cat', 'nocat', 
		'no-tracking', 'notracking'},
	['Number'] = 'number',														-- this case only for cite techreport
	['OrigYear'] = {'orig-year', 'origyear'},
	['Others'] = {'others', 'interviewer', 'interviewers'},
	['Page'] = {'p', 'page'},
	['Pages'] = {'pp', 'pages'},
	['Periodical'] = {'journal', 'newspaper', 'magazine', 'work',
		'website',  'periodical', 'encyclopedia', 'encyclopaedia', 'dictionary', 'mailinglist'},
	['Place'] = {'place', 'location'},
	['Program'] = 'program',													-- cite interview
	['PostScript'] = 'postscript',
	['PublicationDate'] = {'publicationdate', 'publication-date'},
	['PublicationPlace'] = {'publication-place', 'publicationplace'},
	['PublisherName'] = {'publisher', 'distributor', 'institution', 'newsgroup'},
	['Quote'] = {'quote', 'quotation'},
	['Ref'] = 'ref',
	['RegistrationRequired'] = 'registration',
	['Scale'] = 'scale',
	['ScriptChapter'] = 'script-chapter',
	['ScriptTitle'] = 'script-title',
	['Section'] = 'section',
	['Season'] = 'season',
	['Sections'] = 'sections',													-- cite map only
	['Series'] = {'series', 'version'},
	['SeriesSeparator'] = 'series-separator',
	['SeriesLink'] = {'series-link', 'serieslink'},
	['SeriesNumber'] = {'series-number', 'series-no', 'seriesnumber', 'seriesno'},
	['Sheet'] = 'sheet',														-- cite map only
	['Sheets'] = 'sheets',														-- cite map only
	['Station'] = 'station',
	['SubscriptionRequired'] = 'subscription',
	['Time'] = 'time',
	['TimeCaption'] = {'time-caption', 'timecaption'},
	['Title'] = 'title',
	['TitleLink'] = {'title-link', 'episode-link', 'titlelink', 'episodelink'},
	['TitleNote'] = 'department',
	['TitleType'] = {'type', 'medium'},
	['TransChapter'] = {'trans-chapter', 'trans_chapter'},
	['TransMap'] = 'trans-map',													-- cite map only
	['Transcript'] = 'transcript',
	['TranscriptFormat'] = 'transcript-format',
	['TranscriptURL'] = {'transcript-url', 'transcripturl'},
	['TransTitle'] = {'trans-title', 'trans_title', 'title_zh'},
	['URL'] = {'url', 'URL'},
	['UrlAccess']={'url-access','urlaccess'},
	['Vauthors'] = 'vauthors',
	['Veditors'] = 'veditors',
	['Via'] = 'via',
	['Volume'] = 'volume',
	['Year'] = 'year',

	['AuthorList-First'] = {"first#", "given#", "author-first#", "author#-first"},
	['AuthorList-Last'] = {"last#", "author#", "surname#", "author-last#", "author#-last", "subject#"},
	['AuthorList-Link'] = {"authorlink#", "author-link#", "author#-link", "subjectlink#", "author#link", "subject-link#", "subject#-link", "subject#link"},
	['AuthorList-Mask'] = {"author-mask#", "authormask#", "author#mask", "author#-mask"},
	
	['ContributorList-First'] = {'contributor-first#','contributor#-first'},
	['ContributorList-Last'] = {'contributor#', 'contributor-last#', 'contributor#-last'},
	['ContributorList-Link'] = {'contributor-link#', 'contributor#-link'},
	['ContributorList-Mask'] = {'contributor-mask#', 'contributor#-mask'},

	['EditorList-First'] = {"editor-first#", "editor#-first", "editor-given#", "editor#-given"},
	['EditorList-Last'] = {"editor#", "editor-last#", "editor#-last", "editor-surname#", "editor#-surname"},
	['EditorList-Link'] = {"editor-link#", "editor#-link", "editorlink#", "editor#link"},
	['EditorList-Mask'] = {"editor-mask#", "editor#-mask", "editormask#", "editor#mask"},
	
	['TranslatorList-First'] = {'translator-first#','translator#-first'},
	['TranslatorList-Last'] = {'translator#', 'translator-last#', 'translator#-last'},
	['TranslatorList-Link'] = {'translator-link#', 'translator#-link'},
	['TranslatorList-Mask'] = {'translator-mask#', 'translator#-mask'},
}

--[[--------------------------< D E F A U L T S >--------------------------------------------------------------

Default parameter values

TODO: keep this?  Only one default?
]]

local defaults = {
	['DeadURL'] = 'yes',
}


--[[--------------------------< V O L U M E ,  I S S U E ,  P A G E S >----------------------------------------

These tables hold cite class values (from the template invocation) and identify those templates that support
|volume=, |issue=, and |page(s)= parameters.  Cite conference and cite map require further qualification which
is handled in the main module.

]]

local templates_using_volume = {'citation', 'audio-visual', 'book', 'conference', 'encyclopaedia', 'interview', 'journal', 'magazine', 'map', 'news', 'report', 'techreport'}
local templates_using_issue = {'citation', 'conference', 'episode', 'interview', 'journal', 'magazine', 'map', 'news'}
local templates_not_using_page = {'audio-visual', 'episode', 'mailinglist', 'newsgroup', 'podcast', 'serial', 'sign', 'speech'}



--[[--------------------------< K E Y W O R D S >--------------------------------------------------------------

This table holds keywords for those parameters that have defined sets of acceptible keywords.

]]

local keywords = {
	['yes_true_y'] = {'yes', 'true', 'y'},										-- ignore-isbn-error, last-author-amp, no-tracking, nopp, registration, subscription
	['deadurl'] = {'yes', 'true', 'y', 'dead', 'no', 'live', 'unfit', 'usurped'},
	['mode'] = {'cs1', 'cs2'},
	['name-list-format'] = {'vanc'},
	['contribution'] = {'afterword', 'foreword', 'introduction', 'preface'},	-- generic contribution titles that are rendered unquoted in the 'chapter' position
	['date-format'] = {'dmy', 'dmy-all', 'mdy', 'mdy-all', 'ymd', 'ymd-all'},
	['id-access'] = {'free'},
}


--[[--------------------------< I N V I S I B L E _ C H A R A C T E R S >--------------------------------------

This table holds non-printing or invisible characters indexed either by name or by Unicode group. Values are decimal
representations of UTF-8 codes.  The table is organized as a table of tables because the lua pairs keyword returns
table data in an arbitrary order.  Here, we want to process the table from top to bottom because the entries at
the top of the table are also found in the ranges specified by the entries at the bottom of the table.

This list contains patterns for templates like {{'}} which isn't an error but transcludes characters that are
invisible.  These kinds of patterns must be recognized by the functions that use this list.

Also here is a pattern that recognizes stripmarkers that begin and end with the delete characters.  The nowiki
stripmarker is not an error but some others are because the parameter values that include them become part of the
template's metadata before stripmarker replacement.

]]

local invisible_chars = {
	{'replacement', '\239\191\189', '替换字符'},								-- U+FFFD, EF BF BD
	{'apostrophe', '&zwj;\226\128\138\039\226\128\139', '撇号'},				-- apostrophe template: &zwj; hair space ' zero-width space; not an error
	{'apostrophe', '\226\128\138\039\226\128\139', '撇号'},						-- apostrophe template: hair space ' zero-width space; (as of 2015-12-11) not an error
	{'zero width joiner', '\226\128\141', '零宽连字'},							-- U+200D, E2 80 8D
	{'zero width space', '\226\128\139', '零宽空格'},							-- U+200B, E2 80 8B
	{'hair space', '\226\128\138', '字间最小间隔'},								-- U+200A, E2 80 8A
	{'soft hyphen', '\194\173', '软连字符'},									-- U+00AD, C2 AD
	{'horizontal tab', '\009', '水平制表'},										-- U+0009 (HT), 09
	{'line feed', '\010', '換行符'},											-- U+0010 (LF), 0A
	{'carriage return', '\013', '回车符'},										-- U+0013 (CR), 0D
--	{'nowiki stripmarker', '\127UNIQ%-%-nowiki%-[%a%d]+%-QINU\127'},			-- nowiki stripmarker; not an error
	{'stripmarker', '\127[^\127]*UNIQ%-%-(%a+)%-[%a%d]+%-QINU[^\127]*\127', 'mediawiki占位符'},	
																				-- stripmarker; may or may not be an error; capture returns the stripmaker type
	{'delete', '\127', '删除符'},												-- U+007F (DEL), 7F; must be done after stripmarker test
	{'C0 control', '[\000-\008\011\012\014-\031]', 'C0控制符'},					-- U+0000–U+001F (NULL–US), 00–1F (except HT, LF, CR (09, 0A, 0D))
	{'C1 control', '[\194\128-\194\159]', 'C1控制符'},							-- U+0080–U+009F (XXX–APC), C2 80 – C2 9F
	{'Specials', '[\239\191\185-\239\191\191]', '特殊字符'},					-- U+FFF9-U+FFFF, EF BF B9 – EF BF BF
	{'Private use area', '[\238\128\128-\239\163\191]', '私用空间'},			-- U+E000–U+F8FF, EE 80 80 – EF A3 BF
	{'Supplementary Private Use Area-A', '[\243\176\128\128-\243\191\191\189]',
		'补充私用空间A'},														-- U+F0000–U+FFFFD, F3 B0 80 80 – F3 BF BF BD
	{'Supplementary Private Use Area-B', '[\244\128\128\128-\244\143\191\189]',
		'补充私用空间B'},														-- U+100000–U+10FFFD, F4 80 80 80 – F4 8F BF BD
}


--[[--------------------------< M A I N T E N A N C E _ C A T E G O R I E S >----------------------------------

Here we name maintenance categories to be used in maintenance messages.

]]

local maint_cats = {
	['ASIN'] = '引文格式1维护：ASIN使用ISBN',
	['date_year'] = '引文格式1维护：日期与年',
	['disp_auth_ed'] = '引文格式1维护：显示－作者',									-- $1 is authors or editors
	['embargo'] = '引文格式1维护：PMC封锁过期',
	['english'] = 'CS1 maint: English language specified',
	['etal'] = '引文格式1维护：显式使用等标签',
	['extra_text'] = '引文格式1维护：冗余文本',
	['ignore_isbn_err'] = '引文格式1维护：ISBN错误被忽略',
	['jfm_format'] = '引文格式1维护：jfm格式',
	['mr_format'] = '引文格式1维护：MR格式',
	['pmc_format'] = '引文格式1维护：PMC格式',
	['unknown_lang'] = '引文格式1维护：未识别语文类型',
	['untitled'] = '引文格式1维护：无标题期刊',
	['zbl_format'] = '引文格式1维护：zbl格式',
	}

--[[--------------------------< P R O P E R T I E S _ C A T E G O R I E S >------------------------------------

Here we name properties categories

]]

local prop_cats = {
	['foreign_lang_source'] = 'CS1$1来源 ($2)',					-- |language= categories; $1 is language name, $2 is ISO639-1 code
	['script'] = 'CS1含有外文文本',							-- when language specified by |script-title=xx: doesn't have its own category
	['script_with_name'] = 'CS1含有$1文本 ($2)',					-- |script-title=xx: has matching category; $1 is language name, $2 is ISO639-1 code
	}



--[[--------------------------< T I T L E _ T Y P E S >--------------------------------------------------------

Here we map a template's CitationClass to TitleType (default values for |type= parameter)

]]

local title_types = {
	['AV-media-notes'] = 'Media notes',
	['DVD-notes'] = 'Media notes',
	['mailinglist'] = '邮件列表',
	['map'] = 'Map',
	['podcast'] = 'Podcast',
	['pressrelease'] = '新闻稿',
	['report'] = 'Report',
	['techreport'] = 'Technical report',
	['thesis'] = 'Thesis',
	}

--[[--------------------------< E R R O R _ C O N D I T I O N S >----------------------------------------------

Error condition table

The following contains a list of IDs for various error conditions defined in the code.  For each ID, we specify a
text message to display, an error category to include, and whether the error message should be wrapped as a hidden comment.

Anchor changes require identical changes to matching anchor in Help:CS1 errors

]]

local error_conditions = {
	accessdate_missing_url = {
		message = '使用<code style="'..code_style..'">&#124;accessdate=</code>需要含有<code style="'..code_style..'">&#124;url=</code>',
		anchor = 'accessdate_missing_url',
		category = '含有访问日期但无网址的引用的页面',
		hidden = true },
	archive_missing_date = {
		message = '使用<code style="'..code_style..'">&#124;archiveurl=</code>需要含有<code style="'..code_style..'">&#124;archivedate=</code>',
		anchor = 'archive_missing_date',
		category = '含有存档网址错误的引用的页面',
		hidden = false },
	archive_missing_url = {
		message = '使用<code style="'..code_style..'">&#124;archiveurl=</code>需要含有<code style="'..code_style..'">&#124;url=</code>',
		anchor = 'archive_missing_url',
		category = '含有存档网址错误的引用的页面',
		hidden = false },
	arxiv_missing = {
		message = '需要使用<code style="'..code_style..'">&#124;arxiv=</code>',
		anchor = 'arxiv_missing',
		category = '引文格式1错误：arXiv',											-- same as bad arxiv
		hidden = false },
	arxiv_params_not_supported = {
		message = '不支持的参数使用了arXiv',
		anchor = 'arxiv_params_not_supported',
		category = '引文格式1错误：arXiv',											-- same as bad arxiv
		hidden = false },
	bad_arxiv = {
		message = '请检查<code style="'..code_style..'">&#124;arxiv=</code>值',
		anchor = 'bad_arxiv',
		category = '引文格式1错误：arXiv',
		hidden = false },
	bad_asin = {
		message = '请检查<code style="'..code_style..'">&#124;asin=</code>值',
		anchor = 'bad_asin',
		category ='引文格式1错误：ASIN',
		hidden = false },
	bad_bibcode = {
		message = '请检查<code style="'..code_style..'">&#124;bibcode=</code>值',
		anchor = 'bad_bibcode',
		category = '引文格式1错误：bibcode',
		hidden = false },
	bad_biorxiv = {
		message = '请检查<code style="'..code_style..'">&#124;biorxiv=</code>值',
		anchor = 'bad_biorxiv',
		category = '引文格式1错误：bioRxiv',
		hidden = false },
	bad_citeseerx = {
		message = '请检查<code style="'..code_style..'">&#124;citeseerx=</code>的值',
		anchor = 'bad_citeseerx',
		category = '引文格式1错误：citeseerx',
		hidden = false },
	bad_cnid = {
		message = '请检查<code style="'..code_style..'">&#124;cn=</code>的值',
		anchor = 'bad_cnid',
		category = '引文格式1错误：CN',
		hidden = false },
	bad_date = {
		message = '请检查<code style="'..code_style..'">$1</code>中的日期值',
		anchor = 'bad_date',
		category = '引文格式1错误：日期',
		hidden = true },
	bad_doi = {
		message = '请检查<code style="'..code_style..'">&#124;doi=</code>值',
		anchor = 'bad_doi',
		category = '引文格式1错误：DOI',
		hidden = false },
	bad_hdl = {
		message = '请检查<code style="'..code_style..'">&#124;hdl=</code>值',
		anchor = 'bad_hdl',
		category = '引文格式1错误：HDL',
		hidden = false },
	bad_isbn = {
		message = '请检查<code style="'..code_style..'">&#124;isbn=</code>值',
		anchor = 'bad_isbn',
		category = '含有ISBN错误的引用的页面',
		hidden = false },
	bad_ismn = {
		message = '请检查<code style="'..code_style..'">&#124;ismn=</code>值',
		anchor = 'bad_ismn',
		category = '引文格式1错误：ISMN',
		hidden = false },
	bad_issn = {
		message = '请检查<code style="'..code_style..'">&#124;issn=</code>值',
		anchor = 'bad_issn',
		category = '引文格式1错误：ISSN',
		hidden = false },
	bad_jfm = {
		message = '请检查<code style="'..code_style..'">&#124;jfm=</code>值',
		anchor = 'bad_jfm',
		category = '引文格式1错误：JFM',
		hidden = false },
	bad_lccn = {
		message = '请检查<code style="'..code_style..'">&#124;lccn=</code>值',
		anchor = 'bad_lccn',
		category = '引文格式1错误：LCCN',
		hidden = false },
	bad_message_id = {
		message = '请检查<code style="'..code_style..'">&#124;message-id=</code>值',
		anchor = 'bad_message_id',
		category = '引文格式1错误：message-id',
		hidden = false },
	bad_mr = {
		message = '请检查<code style="'..code_style..'">&#124;mr=</code>值',
		anchor = 'bad_mr',
		category = '引文格式1错误：MR',
		hidden = false },
	bad_oclc = {
		message = '请检查<code style="'..code_style..'">&#124;oclc=</code>值',
		anchor = 'bad_oclc',
		category = '引文格式1错误：OCLC',
		hidden = false },
	bad_ol = {
		message = '请检查<code style="'..code_style..'">&#124;ol=</code>值',
		anchor = 'bad_ol',
		category = '引文格式1错误：OL',
		hidden = false },
	bad_paramlink = {															-- for |title-link=, |author/editor/translator-link=, |series-link=, |episode-link=
		message = '请检查<code style="'..code_style..'">&#124;$1=</code>值',
		anchor = 'bad_paramlink',
		category = '引文格式1错误：参数链接',
		hidden = false },
	bad_pmc = {
		message = '请检查<code style="'..code_style..'">&#124;pmc=</code>值',
		anchor = 'bad_pmc',
		category = '引文格式1错误：PMC',
		hidden = false },
	bad_pmid = {
		message = '请检查<code style="'..code_style..'">&#124;pmid=</code>值',
		anchor = 'bad_pmid',
		category = '引文格式1错误：PMID',
		hidden = false },
	bad_s2cid = {
		message = '请检查<code style="'..code_style..'">&#124;s2cid=</code>的值',
		anchor = 'bad_s2cid',
		category = '引文格式1错误：S2CID',
		hidden = false },
	bad_ssrn = {
		message = '请检查<code style="'..code_style..'">&#124;ssrn=</code>的值',
		anchor = 'bad_ssrn',
		category = '引文格式1错误：SSRN',
		hidden = false },
	bad_url = {
		message = '请检查<code style="'..code_style..'">&#124;url=</code>值',
		anchor = 'bad_url',
		category = '含有网址格式错误的引用的页面',
		hidden = false },
	bare_url_missing_title = {
		message = '$1缺少标题',
		anchor = 'bare_url_missing_title',
		category = '含有裸露网址的引用的页面',
		hidden = false },
	bad_zbl = {
		message = '请检查<code style="'..code_style..'">&#124;zbl=</code>的值',
		anchor = 'bad_zbl',
		category = '引文格式1错误：ZBL',
		hidden = false },
	bad_csbn = {
		message = '请检查<code style="'..code_style..'">&#124;csbn=</code>或<code style="'..code_style..'">&#124;unified=</code>的值',
		anchor = 'bad_csbn',
		category = '引文格式1错误：CSBN',
		hidden = false },
	class_ignored = {
		message = '<code style="'..code_style..'">&#124;class=</code>被忽略',
		anchor = 'class_ignored',
		category = '引文格式1错误：class参数被忽略',
		hidden = false },
	chapter_ignored = {
		message = '<code style="'..code_style..'">&#124;$1=</code>被忽略',
		anchor = 'chapter_ignored',
		category = '引文格式1错误：章节参数被忽略',
		hidden = false },
	citation_missing_title = {
		message = '缺少或<code style="'..code_style..'">&#124;title=</code>为空',
		anchor = 'citation_missing_title',
		category = '含有缺少标题的引用的页面',
		hidden = false },
	cite_web_url = {
-- this error applies to cite web and to cite podcast
		message = '缺少或<code style="'..code_style..'">&#124;url=</code>为空',
		anchor = 'cite_web_url',
		category = '含有缺少网址的网站引用的页面',
		hidden = true },
	coauthors_missing_author = {
		message = '使用<code style="'..code_style..'">&#124;coauthors=</code>需要含有<code style="'..code_style..'">&#124;author=</code>',
		anchor = 'coauthors_missing_author',
		category = '引文格式1错误：无主作者的合作者',
		hidden = false },
	contributor_ignored = {
		message = '<code style="'..code_style..'">&#124;contributor=</code>被忽略</code>',
		anchor = 'contributor_ignored',
		category = '引文格式1错误：合作者',
		hidden = false },
	contributor_missing_required_param = {
		message = '使用<code style="'..code_style..'">&#124;contributor=</code>需要含有<code style="'..code_style..'">&#124;$1=</code>',
		anchor = 'contributor_missing_required_param',
		category = '引文格式1错误：合作者',
		hidden = false },
	deprecated_params = {
		message = '引文使用过时参数$1',
		anchor = 'deprecated_params',
		category = '含有过时参数的引用的页面',
		hidden = true },
	empty_citation = {
		message = '空引用',
		anchor = 'empty_citation',
		category = '含有空引用的页面',
		hidden = false },
	first_missing_last = {
		message = '$1列表中的<code style="'..code_style..'">&#124;first$2=</code>缺少<code style="'..code_style..'">&#124;last$2=</code>',
		anchor = 'first_missing_last',
		category = '引文格式1错误：缺少作者或编者',
		hidden = false },
	format_missing_url = {
		message = '使用<code style="'..code_style..'">&#124;format=</code>需要含有<code style="'..code_style..'">&#124;url=</code>',
		anchor = 'format_missing_url',
		category = '含有格式却不含网址的引用的页面',
		hidden = true },
	implict_etal_editor = {
		message = '建议使用<code style="'..code_style..'">&#124;displayeditors=</code>',
		anchor = 'displayeditors',
		category = '含有旧式缩略标签的引用的页面 in editors',
		hidden = true },
	invalid_param_val = {
		message = '无效<code style="'..code_style..'">&#124;$1=$2</code>',
		anchor = 'invalid_param_val',
		category = '引文格式1错误：无效参数值',
		hidden = false },
	invisible_char = {
		message = '参数$2值左起第$3位存在$1',
		anchor = 'invisible_char',
		category = '引文格式1错误：不可见字符',
		hidden = false },
	missing_name = {
		message = '$1列表缺少<code style="'..code_style..'">&#124;last$2=</code>',
		anchor = 'missing_name',
		category = '引文格式1错误：缺少作者或编者',
		hidden = false },
	param_access_requires_param = {
		message =  '使用<code style="'..code_style..'">&#124;$1-access=</code>需要含有<code style="'..code_style..'">&#124;$1=</code>',
		anchor = 'param_access_requires_param',
		category = '含有-access参数但无主参数的引用的页面',
		hidden = true },
	param_has_ext_link = {
		message = '外部链接存在于<code style="'..code_style..'">$1</code>',
		anchor = 'param_has_ext_link',
		category = '引文格式1错误：外部链接',
		hidden = false },
	parameter_ignored = {
		message = '已忽略未知参数<code style="'..code_style..'">&#124;$1=</code>',
		anchor = 'parameter_ignored',
		category = '含有未知参数的引用的页面',
		hidden = false },
	parameter_ignored_suggest = {
		message = '已忽略未知参数<code style="'..code_style..'">&#124;$1=</code>（建议使用<code style="'..code_style..'">&#124;$2=</code>）',
		anchor = 'parameter_ignored_suggest',
		category = '含有未知参数的引用的页面',
		hidden = false },
	redundant_parameters = {
		message = '$1只需其一',
		anchor = 'redundant_parameters',
		category = '含有冗余参数的引用的页面',
		hidden = false },
	text_ignored = {
		message = '已忽略文本“$1”',
		anchor = 'text_ignored',
		category = '含有未命名参数的引用的页面',
		hidden = false },
	trans_missing_title = {
		message = '使用<code style="'..code_style..'">&#124;trans-title=</code>需要含有<code style="'..code_style..'">&#124;title=</code>',
		anchor = 'trans_missing_title',
		category = '引文格式1错误：翻译标题',
		hidden = false },
	vancouver = {
		message = '温哥华格式错误',
		anchor = 'vancouver',
		category = '引文格式1错误：温哥华格式',
		hidden = false },
	wikilink_in_url = {
		message = '网址－维基内链冲突',
		anchor = 'wikilink_in_url',
		category = '引文格式1错误：网址－维基内链冲突',
		hidden = false },
}

--[[--------------------------< I D _ H A N D L E R S >--------------------------------------------------------

The following contains a list of values for various defined identifiers.  For each identifier we specify a
variety of information necessary to properly render the identifier in the citation.

	parameters: a list of parameter aliases for this identifier
	link: Wikipedia article name
	label: the alternate name to apply to link
	mode: 	'manual' when there is a specific function in the code to handle the identifier;
			'external' for identifiers that link outside of Wikipedia;
	prefix: the first part of a url that will be concatenated with a second part which usually contains the identifier
	encode: true if uri should be percent encoded; otherwise false
	COinS: identifier link or keyword for use in COinS:
		for identifiers registered at info-uri.info use: info:....
		for identifiers that have COinS keywords, use the keyword: rft.isbn, rft.issn, rft.eissn
		for others make a url using the value in prefix, use the keyword: pre (not checked; any text other than 'info' or 'rft' works here)
		set to nil to leave the identifier out of the COinS
	separator: character or text between label and the identifier in the rendered citation
]]

local id_handlers = {
	['ARXIV'] = {
		parameters = {'arxiv', 'ARXIV', 'eprint'}, 
		link = 'arXiv',
		label = 'arXiv',
		mode = 'manual',
		prefix = '//arxiv.org/abs/', 											-- protocol relative tested 2013-09-04
		encode = false,
		COinS = 'info:arxiv',
		separator = ':',
		access = 'free',
	},
	['ASIN'] = {
		parameters = { 'asin', 'ASIN' },	   
		link = '亚马逊标准识别码',
		label = 'ASIN',
		mode = 'manual',
		prefix = '//www.amazon.',
		COinS = nil,															-- no COinS for this id (needs thinking on implementation because |asin-tld=)
		separator = '&nbsp;',
		encode = false;
	},
	['BIBCODE'] = {
		parameters = {'bibcode', 'BIBCODE'}, 
		link = 'Bibcode',
		label = 'Bibcode',
		mode = 'manual',
		prefix = 'https://ui.adsabs.harvard.edu/abs/',
		encode = false,
		COinS = 'info:bibcode',
		custom_access = 'bibcode-access',
		separator = ':',
	},
	['BIORXIV'] = {
		parameters = {'biorxiv'}, 
		link = 'bioRxiv',
		label = 'bioRxiv',
		mode = 'manual',
		prefix = '//doi.org/',
		encode = true,
		COinS = 'pre',
		separator = '&nbsp;',
		access = 'free',
	},
	['CITESEERX'] = {
		parameters = {'citeseerx'},
		link = 'CiteSeerX',
		q = 'Q2715061',
		label = 'CiteSeerX',
		mode = 'manual',
		prefix = '//citeseerx.ist.psu.edu/viewdoc/summary?doi=',
		COinS =  'pre',															-- use prefix value
		access = 'free',														-- free to read
		encode = true,
		separator = '&nbsp;',
	},
	['CNID'] = {
		parameters = {'cn', 'CN'},
		link = '国内统一刊号',
		label = "CN",
		mode = 'manual',
		prefix = 'http://www.nppa.gov.cn/nppa/publishing/view.shtml?&pubCode=',
		encode = true,
		separator = ' ',
	},
	['DOI'] = {
		parameters = { 'doi', 'DOI' },
		link = '數位物件識別號',
		q = 'Q25670',
		label = 'doi',
		mode = 'manual',
		prefix = '//dx.doi.org/',
		COinS = 'info:doi',
		custom_access = 'doi-access',
		separator = ':',
		encode = true,
	},
	['EISSN'] = {
		parameters = {'eissn', 'EISSN'},
		link = 'International_Standard_Serial_Number#Electronic_ISSN',
		label = 'eISSN',
		mode = 'manual',
		prefix = '//www.worldcat.org/issn/',
		COinS = 'rft.eissn',
		encode = false,
		separator = '&nbsp;',
	},
	['HDL'] = {
		parameters = { 'hdl', 'HDL' },
		link = 'Handle System',
		q = 'Q3126718',
		label = 'hdl',
		mode = 'manual',
		prefix = '//hdl.handle.net/',
		COinS = 'info:hdl',
		custom_access = 'hdl-access',
		separator = ':',
		encode = true,
	},
	['ISBN'] = {
		parameters = {'isbn', 'ISBN', 'isbn13', 'ISBN13'}, 
		link = '国际标准书号',
		label = 'ISBN',
		mode = 'manual',
		prefix = 'Special:BookSources/',
		COinS = 'rft.isbn',
		separator = '&nbsp;',
	},
	['ISMN'] = {
		parameters = {'ismn', 'ISMN'}, 
		link = 'International Standard Music Number',
		label = 'ISMN',
		mode = 'manual',
		prefix = '',															-- not currently used; 
		COinS = 'nil',															-- nil because we can't use pre or rft or info:
		separator = '&nbsp;',
	},
	['ISSN'] = {
		parameters = {'issn', 'ISSN'}, 
		link = '国际标准连续出版物号',
		label = 'ISSN',
		mode = 'manual',
		prefix = '//www.worldcat.org/issn/',
		COinS = 'rft.issn',
		encode = false,
		separator = '&nbsp;',
	},
	['JFM'] = {
		parameters = {'jfm', 'JFM'}, 
		link = 'Jahrbuch über die Fortschritte der Mathematik',
		label = 'JFM',
		mode = 'manual',
		prefix = '//zbmath.org/?format=complete&q=an:',
		COinS = 'pre',															-- use prefix value
		encode = true,
		separator = '&nbsp;',
	},
	['JSTOR'] = {
		parameters = {'jstor', 'JSTOR'}, 
		link = 'JSTOR',
		label = 'JSTOR',
		mode = 'external',
		prefix = '//www.jstor.org/stable/', 									-- protocol relative tested 2013-09-04
		COinS = 'pre',	-- use prefix value
		custom_access = 'jstor-access',
		encode = false,
		separator = '&nbsp;',
	},
	['LCCN'] = {
		parameters = {'LCCN', 'lccn'}, 
		link = '美国国会图书馆控制码',
		label = 'LCCN',
		mode = 'manual',
		prefix = 'http://lccn.loc.gov/',
		COinS = 'info:lccn',													-- use prefix value
		encode = false,
		separator = '&nbsp;',
	},
	['MR'] = {
		parameters = {'MR', 'mr'}, 
		link = '數學評論',
		label = 'MR',
		mode = 'manual',
		prefix = '//www.ams.org/mathscinet-getitem?mr=', 						-- protocol relative tested 2013-09-04
		COinS = 'pre',															-- use prefix value
		encode = true,
		separator = '&nbsp;',
	},
	['OCLC'] = {
		parameters = {'OCLC', 'oclc'}, 
		link = 'OCLC',
		label = 'OCLC',
		mode = 'manual',
		prefix = '//www.worldcat.org/oclc/',
		COinS = 'info:oclcnum',
		encode = true,
		separator = '&nbsp;',
	},
	['OL'] = {
		parameters = { 'ol', 'OL' },
		link = '开放图书馆',
		label = 'OL',
		mode = 'manual',
		prefix = '//openlibrary.org/',
		COinS = nil,															-- no COinS for this id (needs thinking on implementation because /authors/books/works/OL)
		custom_access = 'ol-access',
		separator = '&nbsp;',
		endode = true,
	},
	['OSTI'] = {
		parameters = {'OSTI', 'osti'}, 
		link = '科学和技术信息办公室',
		label = 'OSTI',
		mode = 'external',
		prefix = '//www.osti.gov/energycitations/product.biblio.jsp?osti_id=',	-- protocol relative tested 2013-09-04
		COinS = 'pre',															-- use prefix value
		custom_access = 'osti-access',
		encode = true,
		separator = '&nbsp;',
	},
	['PMC'] = {
		parameters = {'PMC', 'pmc'}, 
		link = '公共医学中心',
		label = 'PMC',
		mode = 'manual',
		prefix = '//www.ncbi.nlm.nih.gov/pmc/articles/PMC', 
		suffix = " ",
		COinS = 'pre',															-- use prefix value
		encode = true,
		separator = '&nbsp;',
		access = 'free',
	},
	['PMID'] = {
		parameters = {'PMID', 'pmid'}, 
		link = '公共医学识别码',
		label = 'PMID',
		mode = 'manual',
		prefix = '//www.ncbi.nlm.nih.gov/pubmed/',
		COinS = 'info:pmid',
		encode = false,
		separator = '&nbsp;',
	},
	['RFC'] = {
		parameters = {'RFC', 'rfc'}, 
		link = '徵求修正意見書',
		label = 'RFC',
		mode = 'external',
		prefix = '//tools.ietf.org/html/rfc',
		COinS = 'pre',															-- use prefix value
		encode = false,
		separator = '&nbsp;',
		access = 'free',
	},
	['S2CID'] = {
		parameters = {'s2cid', 'S2CID'},
		link = 'Semantic Scholar',  -- l10n: Not created yet
		label = 'S2CID',
		mode = 'manual',
		prefix = 'https://api.semanticscholar.org/CorpusID:',
		COinS = 'pre',															-- use prefix value
		custom_access = 's2cid-access',
		encode = false,
		separator = '&nbsp;',
		},
	['SSRN'] = {
		parameters = {'SSRN', 'ssrn'}, 
		link = '社会科学研究网络',
		label = 'SSRN',
		mode = 'manual',
		prefix = '//ssrn.com/abstract=', 										-- protocol relative tested 2013-09-04
		COinS = 'pre',															-- use prefix value
		encode = true,
		separator = '&nbsp;',
		access = 'free',
	},
	['USENETID'] = {
		parameters = {'message-id'},
		link = 'Usenet',
		label = 'Usenet:',
		mode = 'manual',
		prefix = 'news:',
		encode = false,
		COinS = 'pre',															-- use prefix value
		separator = '&nbsp;',
	},
	['ZBL'] = {
		parameters = {'ZBL', 'zbl'}, 
		link = 'Zentralblatt MATH',
		label = 'Zbl',
		mode = 'manual',
		prefix = '//zbmath.org/?format=complete&q=an:',
		COinS = 'pre',															-- use prefix value
		encode = true,
		separator = '&nbsp;',
	},
-- LOCAL
	['CSBN'] = {
		parameters = {'unified', 'csbn', 'CSBN'}, 
		link = '统一书号',
		label = 'CSBN',
		mode = 'manual',
		prefix = 'http://book.douban.com/subject_search?search_text=SH',
		COinS = 'rft.csbn',
		encode = true,
		separator = '&nbsp;',
	},
-- END LOCAL
}

return 	{
	aliases = aliases,
	defaults = defaults,
	error_conditions = error_conditions,
	id_handlers = id_handlers,
	keywords = keywords,
	invisible_chars = invisible_chars,
	maint_cats = maint_cats,
	messages = messages,
	presentation = presentation,
	prop_cats = prop_cats,
	title_types = title_types,
	uncategorized_namespaces = uncategorized_namespaces,
	uncategorized_subpages = uncategorized_subpages,
	templates_using_volume = templates_using_volume,
	templates_using_issue = templates_using_issue,
	templates_not_using_page = templates_not_using_page,
	}