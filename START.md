# Getting started
Run the following code to put code and pages together:
```bash
git clone --branch master https://github.com/Crowley999/ilscripto ilscripto
git clone --branch sup https://github.com/Crowley999/ilscripto ilscripto-sup
cp -r ilscripto-sup/src/page ilscripto/src/page
cp -r ilscripto-sup/src/Module ilscripto/src/Module
cd ilscripto/src
ln -s Module module # this is not needed
lua # run lua
```
Some examples involving `getContent` are shown below.
## [装13](https://en.wiktionary.org/wiki/装13)
```lua
require("mw")
show=require("Module:zh-see").show
f1=mw.getCurrentFrame()
f2=f1:newChild({title="装13",args={"裝13"}})
f3=f2:newChild({title="Template:zh-see"})
mw.title.setCurrent("装13")
print(show(f3))
```
will produce:
```moin
{| class="wikitable mw-collapsible mw-collapsed" style="border:1px solid #797979; margin-left: 1px; text-align:left; min-width:70%"
|-
| style="background-color: #eeeeee; padding-left: 0.5em" | '''For pronunciation and definitions of '''<span lang="zh" class="Hani">[[装#Chinese|装]][[1#Chinese|1]][[3#Chinese|3]]</span>''' – see <span lang="zh" class="Hani">[[裝13#Chinese|裝13]]</span>.'''<br>(This term, <span lang="zh" class="Hani">装13</span>, is  ''the simplified'' form of <span lang="zh" class="Hani">裝13</span>.)
|-
| class="mw-collapsible-content" style="background-color: #F5DEB3; font-size: smaller" | <b>Notes:</b>
* [[w:Simplified Chinese|Simplified Chinese]] is mainly used in Mainland China, Malaysia and Singapore.
* [[w:Traditional Chinese|Traditional Chinese]] is mainly used in Hong Kong, Macau<span class="serial-comma">,</span> and Taiwan.
|}[[Category:Chinese simplified forms|衣0613]]{{Template:zh-pron|cat=v|dg=|m=zhuāngshísān,zhuāngbī|w=|mb=|mn=|j=|g=|x=|md=|c=|only_cat=yes|mn-t=|h=|c-t=}}
```
## [Reconstruction:Proto-Germanic/fuhsaz](https://en.wiktionary.org/wiki/Reconstruction:Proto-Germanic/fuhsaz)
```lua
require("mw")
descendants_tree=require("Module:etymology/templates").descendants_tree
f1=mw.getCurrentFrame()
f2=f1:newChild({title="Reconstruction:Proto-Germanic/fuhsaz",args={"gmw-pro","*fuhs"}})
f3=f2:newChild({title="Template:descendants_tree"})
mw.title.setCurrent("Proto-Germanic/fuhsaz","Reconstruction")
print(descendants_tree(f3))
```
will produce:
```moin
Proto-West Germanic: <span class="Latinx" lang="gmw-pro">[[Reconstruction&#x3a;Proto-West Germanic/fuhs|*fuhs]]</span><ul><li>{{#invoke:etymology/templates|descendants_tree|ang|fox}}</li><li>{{desc|ofs|*foks}}<ul><li>{{desc|frr|foos}}</li><li>{{desc|stq|Foaks}}</li><li>{{desc|fy|foks}}</li></ul><li>{{desc|osx|fohs}}, {{l|osx|fuhs}}<ul><li>{{desc|gml|vos}}, {{l|gml|vōs}}<ul><li>{{desc|nds|-}}<ul><li>{{desc|nds-nl|vos}}</li><li>{{desc|nds-de|Voss}}, {{l|nds|Voß}}</li><li>Westphalian:<dl><dd>Ravensbergisch-Lippisch: {{l|nds|Fos}}</dd><dd>Suerländer-Märkisch: {{l|nds|Foss}}</dd><dd>Westmünsterländisch: {{l|nds|Foss}}</dd></dl></li></ul><li>{{desc|pdt|Foss}}</li><li>{{desc|bor=1|is|fox}}</li><li>{{desc|bor=1|da|fos}}</li></ul></li></ul><li>{{#invoke:etymology/templates|descendants_tree|odt|fus}}</li><li>{{desc|goh|fuhs}}<ul><li>{{desc|gmh|vuhs}}<ul><li>{{desc|gsw|Fuchs}}, {{l|gsw|Fugs}}<dl><dd>{{desc|swg|}}</dd><dd>Walser: {{l|gsw|fuks}}, {{l|gsw|fuksch}}, {{l|gsw|fòcks}}, {{l|gsw|vucks}}</dd></dl><li>{{desc|bar|}}<dl><dd>{{desc|cim|buks|alts=1}}</dd><dd>{{desc|mhn|}}</dd></dl><li>{{desc|gmw-cfr|}}<dl><dd>{{desc|hrx|Fuchs}}</dd><dd>{{desc|lb|Fuuss}}</dd></dl><li>{{desc|gmw-ecg|}}<dl><dd>{{desc|wym|füks}}</dd></dl><li>{{desc|vmf|}}</li><li>{{#invoke:etymology/templates|descendants_tree|de|Fuchs}}</li><li>{{desc|gmw-rfr|}}<dl><dd>{{desc|pdc|Fux}}</dd></dl><li>{{desc|yi|פֿוקס}}</li></ul></li></ul></li></ul>
```
## [あい](https://en.wiktionary.org/wiki/あい)
```lua
require("mw")
show_kango=require("Module:ja-see").show_kango
f1=mw.getCurrentFrame()
f2=f1:newChild({title="あい",args={"哀","愛","隘","埃","娃","靄",}})
f3=f2:newChild({title="Template:ja-see-kango"})
mw.title.setCurrent("あい")
print(show_kango(f3))
```
will produce:
```moin
{| class="wikitable" style="min-width:70%"
|-
| <b>For pronunciation and definitions of <span lang="ja" class="Jpan">あい</span> – see the following entries.</b>
|-
| style="background-color: white" |
{| style="width: 100%"
|-
| style="white-space:nowrap;width:15%;vertical-align:top;" | <span style="font-size:x-large"><span lang="ja" class="Jpan">【[[哀#Japanese|哀]]】</span></span><span class="explain" title="Jōyō kanji" style="vertical-align: top;">S</span>
| style="" |

: <span style="padding-right:.6em;color:#5A5C5A;font-size:80%">[noun]</span> [[grief]]; [[sorrow]]; [[sadness]]; [[lamentation]]
: <span style="padding-right:.6em;color:#5A5C5A;font-size:80%">[noun]</span> [[pity]]; [[sympathy]]
|-
| style="white-space:nowrap;width:15%;vertical-align:top;border-top:1px solid lightgray;" | <span style="font-size:x-large"><span lang="ja" class="Jpan">【[[愛#Japanese|愛]]】</span></span><span class="explain" title="Grade 4 kanji" style="vertical-align: top;">4</span>
| style="border-top:1px solid lightgray;" |

: <span style="padding-right:.6em;color:#5A5C5A;font-size:80%">[noun]</span> [[love]]
: <span style="padding-right:.6em;color:#5A5C5A;font-size:80%">[noun]</span> [[affection]]
: <span style="padding-right:.6em;color:#5A5C5A;font-size:80%">[noun]</span> [[tenderness]]
: <span style="padding-right:.6em;color:#5A5C5A;font-size:80%">[noun]</span> ''This term needs a translation to English.''
: <span style="padding-right:.6em;color:#5A5C5A;font-size:80%">[noun]</span> ''This term needs a translation to English.''
: <span style="padding-right:.6em;color:#5A5C5A;font-size:80%">[noun]</span> {{lb|ja|sort=あい|Christianity}} [[agape#Noun|agape]]
: <span style="padding-right:.6em;color:#5A5C5A;font-size:80%">[proper noun]</span> {{given name|ja|female|A=a|sort=あい}}
: <span style="padding-right:.6em;color:#5A5C5A;font-size:80%">[proper noun]</span> {{surname|ja|A=a|nodot=1|sort=あい}}
|-
| style="white-space:nowrap;width:15%;vertical-align:top;border-top:1px solid lightgray;" | <span style="font-size:x-large"><span lang="ja" class="Jpan">【[[隘#Japanese|隘]]】</span></span><span class="explain" title="Hyōgaiji kanji" style="vertical-align: top;">H</span>
| style="border-top:1px solid lightgray;" |

: <span style="padding-right:.6em;color:#5A5C5A;font-size:80%">[affix]</span> [[narrow]]; [[confined]]
|-
| style="white-space:nowrap;width:15%;vertical-align:top;border-top:1px solid lightgray;" | <span style="font-size:x-large"><span lang="ja" class="Jpan">【[[埃#Japanese|埃]]】</span></span><span class="explain" title="Hyōgaiji kanji" style="vertical-align: top;">H</span>
| style="border-top:1px solid lightgray;" |

: <span style="padding-right:.6em;color:#5A5C5A;font-size:80%">[noun]</span> one ten-[[billionth]]
|-
| style="white-space:nowrap;width:15%;vertical-align:top;border-top:1px solid lightgray;" | <span style="font-size:x-large"><span lang="ja" class="Jpan">【[[娃#Japanese|娃]]】</span></span><span class="explain" title="Jinmeiyō kanji" style="vertical-align: top;">J</span>
| style="border-top:1px solid lightgray;" |

: <span style="padding-right:.6em;color:#5A5C5A;font-size:80%">[affix]</span> [[beauty]], [[beautiful]] girl {{qualifier|generally only used in names}}
|-
| style="white-space:nowrap;width:15%;vertical-align:top;border-top:1px solid lightgray;" | <span style="font-size:x-large"><span lang="ja" class="Jpan">【[[靄#Japanese|靄]]】</span></span><span class="explain" title="Hyōgaiji kanji" style="vertical-align: top;">H</span>
| style="border-top:1px solid lightgray;" |

: <span style="padding-right:.6em;color:#5A5C5A;font-size:80%">[affix]</span> [[mist]], [[haze]]
: <span style="padding-right:.6em;color:#5A5C5A;font-size:80%">[affix]</span> [[mistiness]], [[haziness]]
: <span style="padding-right:.6em;color:#5A5C5A;font-size:80%">[proper noun]</span> {{given name|ja|female|A=a|sort=あい}}
|}
|-
| (This term, <span lang="ja" class="Jpan">あい</span>, is an alternative spelling of the above Sino-Japanese terms.)
|}
```
## [华莱士 (快餐)](https://zh.wikipedia.org/wiki/华莱士_(快餐))
```lua
require("mw")
citation=require('Module:citation/CS1').citation
f1=mw.getCurrentFrame()
f2=f1:newChild({title="华莱士 (快餐)",args={["title"]="市场监管总局：杨国福、华莱士、蜜雪冰城等被罚款",["url"]="http://www.chinanews.com/gn/2021/08-23/9549417.shtml",["accessdate"]="2021-09-10",["work"]="央视新闻客户端",["date"]="2021-08-23",}})
f3=f2:newChild({title="Template:Cite news",args={["CitationClass"]="news"}})
mw.title.setCurrent("华莱士 (快餐)")
print(citation(f3))
```
will produce:
```moin
<cite class="citation news">[http://www.chinanews.com/gn/2021/08-23/9549417.shtml -{市场监管总局：杨国福、华莱士、蜜雪冰城等被罚款}-]. 央视新闻客户端. 2021-08-23 <span class="reference-accessdate"> &#91;<span class="nowrap">2021-09-10</span>&#93;</span>.</cite><span title="ctx_ver=Z39.88-2004&rfr_id=info%3Asid%2Fzh.wiktionary.org%3A%E5%8E%E8%8E%B1%E5%A3%AB+%28%E5%BF%AB%E9%A4%90%29&rft.atitle=%E5%B8%82%E5%9C%BA%E7%9B%91%E7%AE%A1%E6%BB%E5%B1%EF%BC%9A%E6%9D%A8%E5%9B%BD%E7%A6%8F%E3%81%E5%8E%E8%8E%B1%E5%A3%AB%E3%81%E8%9C%9C%E9%9B%AA%E5%86%B0%E5%9F%8E%E7+%89%E8%A2%AB%E7%BD%9A%E6%AC%BE&rft.date=2021-08-23&rft.genre=article&rft.jtitle=%E5%A4%AE%E8%A7%86%E6%96%B0%E9%97%BB%E5%AE%A2%E6%88%B7%E7%AB%AF&rft_id=http%3A%2F%2Fwww.chinanews.com%2Fgn%2F2021%2F08-23%2F9549417.shtml&rft_val_fmt=info%3Aofi%2Ffmt%3Akev%3Amtx%3Ajournal" class="Z3988"><span style="display:none;">&nbsp;</span></span> <span style="display:none;font-size:100%" class="error citation-comment">请检查<code style="color:inherit; border:inherit; padding:inherit;">&#124;access-date=</code>中的日期值 ([[Help:引文格式1错误#bad_date|帮助]])</span>[[Category:引文格式1错误：日期]]
```
I didn't fully implement ```lang.formatDate``` which is used by ```Module:Citation/CS1/Date_validation.lua```, so 引文格式1错误 appeared.
