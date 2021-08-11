local data = {}

-- romaji with diacritics to romaji without
data.rd={
	['ā']='aa',['ē']='ee',['ī']='ii',['ō']='ou',['ū']='uu'
};

-- equivalent katakana = romaji pairs, k=r or kr
-- clever trick: replaces ン with n¤
-- x=sh, q=ch, c=ts
data.kr={
	["ア"] =  "a", ["イ"] =  "i", ["ウ"] =  "u", ["エ"] =  "e", ["オ"] =  "o",
	["カ"] = "ka", ["キ"] = "ki", ["ク"] = "ku", ["ケ"] = "ke", ["コ"] = "ko",
	["サ"] = "sa", ["シ"] = "xi", ["ス"] = "su", ["セ"] = "se", ["ソ"] = "so",
	["タ"] = "ta", ["チ"] = "qi", ["ツ"] = "cu", ["テ"] = "te", ["ト"] = "to",
	["ナ"] = "na", ["ニ"] = "ni", ["ヌ"] = "nu", ["ネ"] = "ne", ["ノ"] = "no",
	["ハ"] = "ha", ["ヒ"] = "hi", ["フ"] = "fu", ["ヘ"] = "he", ["ホ"] = "ho",
	["マ"] = "ma", ["ミ"] = "mi", ["ム"] = "mu", ["メ"] = "me", ["モ"] = "mo",
	["ヤ"] = "ya",                ["ユ"] = "yu",                ["ヨ"] = "yo",
	["ラ"] = "ra", ["リ"] = "ri", ["ル"] = "ru", ["レ"] = "re", ["ロ"] = "ro",
	["ワ"] = "wa", ["ヰ"] = "wi",                ["ヱ"] = "we", ["ヲ"] =  "o",

	["ン"] = "n¤",

	["ガ"] = "ga", ["ギ"] = "gi", ["グ"] = "gu", ["ゲ"] = "ge", ["ゴ"] = "go",
	["カ゜"] = "nga", ["キ゜"] = "ngi", ["ク゜"] = "ngu", ["ケ゜"] = "nge", ["コ゜"] = "ngo",
	["ザ"] = "za", ["ジ"] = "ji", ["ズ"] = "zu", ["ゼ"] = "ze", ["ゾ"] = "zo",
	["ダ"] = "da", ["ヂ"] = "ji", ["ヅ"] = "zu", ["デ"] = "de", ["ド"] = "do",
	["バ"] = "ba", ["ビ"] = "bi", ["ブ"] = "bu", ["ベ"] = "be", ["ボ"] = "bo",
	["パ"] = "pa", ["ピ"] = "pi", ["プ"] = "pu", ["ペ"] = "pe", ["ポ"] = "po",
	["ヷ"] = "va", ["ヸ"] = "vi", ["ヴ"] = "vu", ["ヹ"] = "ve", ["ヺ"] = "vo",

	["・"] = " ",
	["！"] = "◆!◇", ["？"] = "◆?◇",
	["（"] = "◇(◆", ["）"] = "◆)◇",
	["「"] = '◇“◆', ["」"] = '◆”◇', ["『"] = '◇“◆', ["』"] = '◆”◇', ["“"] = '◇“◆', ["”"] = '◆”◇',
	["："] = "◆:◇",
	["～"] = "~", ["〜"] = "~", ["〰"] = "~", -- fullwidth tilde vs. wave dash vs. fancy chouonpu
	["、"] = "◆,◇", ["，"] = "◆,◇",           -- ideographic comma vs. fullwidth comma
	["＝"] = "-", ["゠"] = "-",               -- fullwidth equals sign vs. official unicode character
	["※"] = "◆†◇",
	-- ["。"] = "◆.◇", -- fullwidth period is handled by the module code itself
};

-- equivalent romaji = katakana pairs, r=k or rk
data.rk={
	['wyu']='ウュ',['vyu']='ヴュ',['vyo']='ヴョ',['vye']='ヴィェ',['vya']='ヴャ',['tyu']='テュ',['ryu']='リュ',['ryo']='リョ',['rye']='リェ',['rya']='リャ',['pyu']='ピュ',['pyo']='ピョ',['pye']='ピェ',['pya']='ピャ',['nyu']='ニュ',['nyo']='ニョ',['nye']='ニェ',['nya']='ニャ',['myu']='ミュ',['myo']='ミョ',['mye']='ミェ',['mya']='ミャ',['kyu']='キュ',['kyo']='キョ',['kye']='キェ',['kya']='キャ',['kwo']='クォ',['kwi']='クィ',['kwe']='クェ',['kwa']='クァ',['kwa']='クヮ',['hyu']='ヒュ',['hyo']='ヒョ',['hye']='ヒェ',['hya']='ヒャ',['gyu']='ギュ',['gyo']='ギョ',['gye']='ギェ',['gya']='ギャ',['gwo']='グォ',['gwi']='グィ',['gwe']='グェ',['gwa']='グァ',['gwa']='グヮ',['fyu']='フュ',['fyo']='フョ',['fye']='フィェ',['fya']='フャ',['dyu']='デュ',['byu']='ビュ',['byo']='ビョ',['bye']='ビェ',['bya']='ビャ',['zu']='ズ',['zo']='ゾ',['zi']='ズィ',['ze']='ゼ',['za']='ザ',['yu']='ユ',['yo']='ヨ',['yi']='イィ',['ye']='イェ',['ya']='ヤ',['wu']='ウゥ',['wo']='ウォ',['wi']='ウィ',['we']='ウェ',['wa']='ワ',['vu']='ヴ',['vo']='ヴォ',['vi']='ヴィ',['ve']='ヴェ',['va']='ヴァ',['tu']='トゥ',['to']='ト',['ti']='ティ',['te']='テ',['ta']='タ',['su']='ス',['so']='ソ',['si']='スィ',['se']='セ',['sa']='サ',['ru']='ル',['ro']='ロ',['ri']='リ',['re']='レ',['ra']='ラ',['pu']='プ',['po']='ポ',['pi']='ピ',['pe']='ペ',['pa']='パ',['mu']='ム',['mo']='モ',['mi']='ミ',['me']='メ',['ma']='マ',['lu']='ル゜',['lo']='ロ゜',['li']='リ゜',['le']='レ゜',['la']='ラ゜',['ku']='ク',['ko']='コ',['ki']='キ',['ke']='ケ',['ka']='カ',['ju']='ジュ',['jo']='ジョ',['ji']='ジ',['je']='ジェ',['ja']='ジャ',['hu']='ホゥ',['ho']='ホ',['hi']='ヒ',['he']='ヘ',['ha']='ハ',['gu']='グ',['go']='ゴ',['gi']='ギ',['ge']='ゲ',['ga']='ガ',['fu']='フ',['fo']='フォ',['fi']='フィ',['fe']='フェ',['fa']='ファ',['du']='ドゥ',['do']='ド',['di']='ディ',['de']='デ',['da']='ダ',['bu']='ブ',['bo']='ボ',['bi']='ビ',['be']='ベ',['ba']='バ'
};

-- hiragana with dakuten to empty
data.dakuten={
	['が']='',['ぎ']='',['ぐ']='',['げ']='',['ご']='',['ざ']='',['じ']='',['ず']='',['ぜ']='',['ぞ']='',['だ']='',['ぢ']='',['づ']='',['で']='',['ど']='',['ば']='',['び']='',['ぶ']='',['べ']='',['ぼ']='',['ゔ']=''
}

-- hiragana with dakuten or handakuten to those without
data.tenconv={
	['が']='か',['ぎ']='き',['ぐ']='く',['げ']='け',['ご']='こ',['ざ']='さ',['じ']='し',['ず']='す',['ぜ']='せ',['ぞ']='そ',['だ']='た',['ぢ']='ち',['づ']='つ',['で']='て',['ど']='と',['ば']='は',['び']='ひ',['ぶ']='ふ',['べ']='へ',['ぼ']='ほ',['ぱ']='は',['ぴ']='ひ',['ぷ']='ふ',['ぺ']='へ',['ぽ']='ほ',['ゔ']='う',['か゜']='か',['き゜']='き',['く゜']='く',['け゜']='け',['こ゜']='こ'
}

-- hiragana with handakuten to empty
data.handakuten={
	['ぱ']='',['ぴ']='',['ぷ']='',['ぺ']='',['ぽ']='',['か゜']='',['き゜']='',['く゜']='',['け゜']='',['こ゜']=''
}

-- all small hiragana except small tsu (useful when counting morae)
data.nonmora_to_empty={
	['ぁ']='',['ぅ']='',['ぃ']='',['ぇ']='',['ぉ']='',['ゃ']='',['ゅ']='',['ょ']=''
}

data.longvowels={
	['あー']='ああ',['いー']='いい',['うー']='うう',['えー']='ええ',['おー']='おお',['ぁー']='ぁあ',['ぃー']='ぃい',['ぅー']='ぅう',['ぇー']='ぇえ',['ぉー']='ぉお', ['かー']='かあ',['きー']='きい',['くー']='くう',['けー']='けえ',['こー']='こお',['さー']='さあ',['しー']='しい',['すー']='すう',['せー']='せえ',['そー']='そお',['たー']='たあ',['ちー']='ちい',['つー']='つう',['てー']='てえ',['とー']='とお',['なー']='なあ',['にー']='にい',['ぬー']='ぬう',['ねー']='ねえ',['のー']='のお',['はー']='はあ',['ひー']='ひい',['ふー']='ふう',['へー']='へえ',['ほー']='ほお',['まー']='まあ',['みー']='みい',['むー']='むう',['めー']='めえ',['もー']='もお',['やー']='やあ',['ゆー']='ゆう',['よー']='よお',['ゃー']='ゃあ',['ゅー']='ゅう',['ょー']='ょお',['らー']='らあ',['りー']='りい',['るー']='るう',['れー']='れえ',['ろー']='ろお',['わー']='わあ'
}

data.joyo_kanji = ([[
亜哀挨愛曖悪握圧扱宛嵐安案暗以衣位囲医依委威為畏胃尉異移萎偉椅彙意違維慰遺緯域育一
壱逸茨芋引印因咽姻員院淫陰飲隠韻右宇羽雨唄鬱畝浦運雲永泳英映栄営詠影鋭衛易疫益液駅悦越謁閲円延沿炎
宴怨媛援園煙猿遠鉛塩演縁艶汚王凹央応往押旺欧殴桜翁奥横岡屋億憶臆虞乙俺卸音恩温穏下化火加可仮何花佳
価果河苛科架夏家荷華菓貨渦過嫁暇禍靴寡歌箇稼課蚊牙瓦我画芽賀雅餓介回灰会快戒改怪拐悔海界皆械絵開階
塊楷解潰壊懐諧貝外劾害崖涯街慨蓋該概骸垣柿各角拡革格核殻郭覚較隔閣確獲嚇穫学岳楽額顎掛潟括活喝渇割
葛滑褐轄且株釜鎌刈干刊甘汗缶完肝官冠巻看陥乾勘患貫寒喚堪換敢棺款間閑勧寛幹感漢慣管関歓監緩憾還館環
簡観韓艦鑑丸含岸岩玩眼頑顔願企伎危机気岐希忌汽奇祈季紀軌既記起飢鬼帰基寄規亀喜幾揮期棋貴棄毀旗器畿
輝機騎技宜偽欺義疑儀戯擬犠議菊吉喫詰却客脚逆虐九久及弓丘旧休吸朽臼求究泣急級糾宮救球給嗅窮牛去巨居
拒拠挙虚許距魚御漁凶共叫狂京享供協況峡挟狭恐恭胸脅強教郷境橋矯鏡競響驚仰暁業凝曲局極玉巾斤均近金菌
勤琴筋僅禁緊錦謹襟吟銀区句苦駆具惧愚空偶遇隅串屈掘窟熊繰君訓勲薫軍郡群兄刑形系径茎係型契計恵啓掲渓
経蛍敬景軽傾携継詣慶憬稽憩警鶏芸迎鯨隙劇撃激桁欠穴血決結傑潔月犬件見券肩建研県倹兼剣拳軒健険圏堅検
嫌献絹遣権憲賢謙鍵繭顕験懸元幻玄言弦限原現舷減源厳己戸古呼固孤弧股虎故枯個庫湖雇誇鼓錮顧五互午呉後
娯悟碁語誤護口工公勾孔功巧広甲交光向后好江考行坑孝抗攻更効幸拘肯侯厚恒洪皇紅荒郊香候校耕航貢降高康
控梗黄喉慌港硬絞項溝鉱構綱酵稿興衡鋼講購乞号合拷剛傲豪克告谷刻国黒穀酷獄骨駒込頃今困昆恨根婚混痕紺
魂墾懇左佐沙査砂唆差詐鎖座挫才再災妻采砕宰栽彩採済祭斎細菜最裁債催塞歳載際埼在材剤財罪崎作削昨柵索
策酢搾錯咲冊札刷刹拶殺察撮擦雑皿三山参桟蚕惨産傘散算酸賛残斬暫士子支止氏仕史司四市矢旨死糸至伺志私
使刺始姉枝祉肢姿思指施師恣紙脂視紫詞歯嗣試詩資飼誌雌摯賜諮示字寺次耳自似児事侍治持時滋慈辞磁餌璽鹿
式識軸七叱失室疾執湿嫉漆質実芝写社車舎者射捨赦斜煮遮謝邪蛇尺借酌釈爵若弱寂手主守朱取狩首殊珠酒腫種
趣寿受呪授需儒樹収囚州舟秀周宗拾秋臭修袖終羞習週就衆集愁酬醜蹴襲十汁充住柔重従渋銃獣縦叔祝宿淑粛縮
塾熟出述術俊春瞬旬巡盾准殉純循順準潤遵処初所書庶暑署緒諸女如助序叙徐除小升少召匠床抄肖尚招承昇松沼
昭宵将消症祥称笑唱商渉章紹訟勝掌晶焼焦硝粧詔証象傷奨照詳彰障憧衝賞償礁鐘上丈冗条状乗城浄剰常情場畳
蒸縄壌嬢錠譲醸色拭食植殖飾触嘱織職辱尻心申伸臣芯身辛侵信津神唇娠振浸真針深紳進森診寝慎新審震薪親人
刃仁尽迅甚陣尋腎須図水吹垂炊帥粋衰推酔遂睡穂随髄枢崇数据杉裾寸瀬是井世正生成西声制姓征性青斉政星牲
省凄逝清盛婿晴勢聖誠精製誓静請整醒税夕斥石赤昔析席脊隻惜戚責跡積績籍切折拙窃接設雪摂節説舌絶千川仙
占先宣専泉浅洗染扇栓旋船戦煎羨腺詮践箋銭潜線遷選薦繊鮮全前善然禅漸膳繕狙阻祖租素措粗組疎訴塑遡礎双
壮早争走奏相荘草送倉捜挿桑巣掃曹曽爽窓創喪痩葬装僧想層総遭槽踪操燥霜騒藻造像増憎蔵贈臓即束足促則息
捉速側測俗族属賊続卒率存村孫尊損遜他多汰打妥唾堕惰駄太対体耐待怠胎退帯泰堆袋逮替貸隊滞態戴大代台第
題滝宅択沢卓拓託濯諾濁但達脱奪棚誰丹旦担単炭胆探淡短嘆端綻誕鍛団男段断弾暖談壇地池知値恥致遅痴稚置
緻竹畜逐蓄築秩窒茶着嫡中仲虫沖宙忠抽注昼柱衷酎鋳駐著貯丁弔庁兆町長挑帳張彫眺釣頂鳥朝貼超腸跳徴嘲潮
澄調聴懲直勅捗沈珍朕陳賃鎮追椎墜通痛塚漬坪爪鶴低呈廷弟定底抵邸亭貞帝訂庭逓停偵堤提程艇締諦泥的笛摘
滴適敵溺迭哲鉄徹撤天典店点展添転塡田伝殿電斗吐妬徒途都渡塗賭土奴努度怒刀冬灯当投豆東到逃倒凍唐島桃
討透党悼盗陶塔搭棟湯痘登答等筒統稲踏糖頭謄藤闘騰同洞胴動堂童道働銅導瞳峠匿特得督徳篤毒独読栃凸突届
屯豚頓貪鈍曇丼那奈内梨謎鍋南軟難二尼弐匂肉虹日入乳尿任妊忍認寧熱年念捻粘燃悩納能脳農濃把波派破覇馬
婆罵拝杯背肺俳配排敗廃輩売倍梅培陪媒買賠白伯拍泊迫剥舶博薄麦漠縛爆箱箸畑肌八鉢発髪伐抜罰閥反半氾犯
帆汎伴判坂阪板版班畔般販斑飯搬煩頒範繁藩晩番蛮盤比皮妃否批彼披肥非卑飛疲秘被悲扉費碑罷避尾眉美備微
鼻膝肘匹必泌筆姫百氷表俵票評漂標苗秒病描猫品浜貧賓頻敏瓶不夫父付布扶府怖阜附訃負赴浮婦符富普腐敷膚
賦譜侮武部舞封風伏服副幅復福腹複覆払沸仏物粉紛雰噴墳憤奮分文聞丙平兵併並柄陛閉塀幣弊蔽餅米壁璧癖別
蔑片辺返変偏遍編弁便勉歩保哺捕補舗母募墓慕暮簿方包芳邦奉宝抱放法泡胞俸倣峰砲崩訪報蜂豊飽褒縫亡乏忙
坊妨忘防房肪某冒剖紡望傍帽棒貿貌暴膨謀頰北木朴牧睦僕墨撲没勃堀本奔翻凡盆麻摩磨魔毎妹枚昧埋幕膜枕又
末抹万満慢漫未味魅岬密蜜脈妙民眠矛務無夢霧娘名命明迷冥盟銘鳴滅免面綿麺茂模毛妄盲耗猛網目黙門紋問冶
夜野弥厄役約訳薬躍闇由油喩愉諭輸癒唯友有勇幽悠郵湧猶裕遊雄誘憂融優与予余誉預幼用羊妖洋要容庸揚揺葉
陽溶腰様瘍踊窯養擁謡曜抑沃浴欲翌翼拉裸羅来雷頼絡落酪辣乱卵覧濫藍欄吏利里理痢裏履璃離陸立律慄略柳流
留竜粒隆硫侶旅虜慮了両良料涼猟陵量僚領寮療瞭糧力緑林厘倫輪隣臨瑠涙累塁類令礼冷励戻例鈴零霊隷齢麗暦
歴列劣烈裂恋連廉練錬呂炉賂路露老労弄郎朗浪廊楼漏籠六録麓論和話賄脇惑枠湾腕]]):gsub("%s", "")

data.grade1 = ([[一右雨円王音下火花貝学気九休玉金空月犬見五口校左三山子四糸字耳七車手十出女小上森
人水正生青夕石赤千川先早草足村大男竹中虫町天田土二日入年白八百文木本名目立力林六
]]):gsub("%s", "")

data.grade2 = ([[引羽雲園遠何科夏家歌画回会海絵外角楽活間丸岩顔汽記帰弓牛魚京強教近兄形計元言原戸
古午後語工公広交光考行高黄合谷国黒今才細作算止市矢姉思紙寺自時室社弱首秋週春書少場色食心新親図数西
声星晴切雪船線前組走多太体台地池知茶昼長鳥朝直通弟店点電刀冬当東答頭同道読内南肉馬売買麦半番父風分
聞米歩母方北毎妹万明鳴毛門夜野友用曜来里理話
]]):gsub("%s", "")

data.grade3 = ([[悪安暗医委意育員院飲運泳駅央横屋温化荷界開階寒感漢館岸起期客究急級宮球去橋業曲局
銀区苦具君係軽血決研県庫湖向幸港号根祭皿仕死使始指歯詩次事持式実写者主守取酒受州拾終習集住重宿所暑
助昭消商章勝乗植申身神真深進世整昔全相送想息速族他打対待代第題炭短談着注柱丁帳調追定庭笛鉄転都度投
豆島湯登等動童農波配倍箱畑発反坂板皮悲美鼻筆氷表秒病品負部服福物平返勉放味命面問役薬由油有遊予羊洋
葉陽様落流旅両緑礼列練路和
]]):gsub("%s", "")

data.grade4 = ([[愛案以衣位茨印英栄媛塩岡億加果貨課芽賀改械害街各覚潟完官管関観願岐希季旗器機議求
泣給挙漁共協鏡競極熊訓軍郡群径景芸欠結建健験固功好香候康佐差菜最埼材崎昨札刷察参産散残氏司試児治滋
辞鹿失借種周祝順初松笑唱焼照城縄臣信井成省清静席積折節説浅戦選然争倉巣束側続卒孫帯隊達単置仲沖兆低
底的典伝徒努灯働特徳栃奈梨熱念敗梅博阪飯飛必票標不夫付府阜富副兵別辺変便包法望牧末満未民無約勇要養
浴利陸良料量輪類令冷例連老労録
]]):gsub("%s", "")

data.grade5 = ([[圧囲移因永営衛易益液演応往桜可仮価河過快解格確額刊幹慣眼紀基寄規喜技義逆久旧救居
許境均禁句型経潔件険検限現減故個護効厚耕航鉱構興講告混査再災妻採際在財罪殺雑酸賛士支史志枝師資飼示
似識質舎謝授修述術準序招証象賞条状常情織職制性政勢精製税責績接設絶祖素総造像増則測属率損貸態団断築
貯張停提程適統堂銅導得毒独任燃能破犯判版比肥非費備評貧布婦武復複仏粉編弁保墓報豊防貿暴脈務夢迷綿輸
余容略留領歴
]]):gsub("%s", "")

data.grade6 = ([[胃異遺域宇映延沿恩我灰拡革閣割株干巻看簡危机揮貴疑吸供胸郷勤筋系敬警劇激穴券絹権
憲源厳己呼誤后孝皇紅降鋼刻穀骨困砂座済裁策冊蚕至私姿視詞誌磁射捨尺若樹収宗就衆従縦縮熟純処署諸除承
将傷障蒸針仁垂推寸盛聖誠舌宣専泉洗染銭善奏窓創装層操蔵臓存尊退宅担探誕段暖値宙忠著庁頂腸潮賃痛敵展
討党糖届難乳認納脳派拝背肺俳班晩否批秘俵腹奮並陛閉片補暮宝訪亡忘棒枚幕密盟模訳郵優預幼欲翌乱卵覧裏
律臨朗論
]]):gsub("%s", "")

data.secondary = ([[堀撃茂羅匂誇斉袋弊沃随逐漂枕且抗揺涙鐘鮮沢洞怠嬢嚇焦喩淡被般捜頰岳疲侵廷眺
稼唾塀霊迅附醜屈棋坊珍恐賓筒苗摘椎寝軟絞凡斑悦勧耐緩蔽坪沼衰譲柵蹴拷慶替愁繁皆覆雅沈踏疎継扶朕隔舗
妖粘喫炊抜賄悠弥腰崩倫循是脱掲舷冶紹沸頻押疾寂雄扇臆恋俊嫌乏契傾迎竜盤触硫括惰併滴凶墨俺巾碁儀
訂袖弄箇堆贈踊萎碑褐騒弔怖沙甘慨芝剛准玄股趣控販妬餅錬枯搾稲伴添抽鬼尾壁床滅轄拠繊拍幣掌惑腐
漏核奥棺虚譜嗣鉢潤寧姫陪鋭濯壱慰跳該靴症偶浸姻穫響澄尉蚊鈍鎌圏頑既又窒屯肖宜貞冠帥蛇欧仰宛煮伯撮伺
紳徴呈吹麺稽桁秀吉狂湿柄栓胆呉克廊双郊塑駐啓拒繕柔捗闘酎剥遡陥霧摩巨腫邦召杯購媒畳荒陵膨裾糾脂超
升丈芋禍伎麓儒錯梗丘甚膝猫娠隣閥罵符披洪瀬剰騰如琴猶徹錮紺頼弾巡廃隻嗅壇籠請凍詐励痕醸忙苛凝遜
寡詠監酢諧僧伐爽浪臭硬賠叱痩襲践匿矯培詣墾槽謁塁憂載越戴吏挑渓醒柿耗殖勘幅喚墜吟羞謡犠津撤輩喪催侮
鬱誰獲喉庸戻悼尿噴璃蓄遇錠杉雇緊免壌菌卑拐駒隆塗彙鉛胎惜江桑陣嫉顧懐彩鈴腎摯陳懲措遷軸旺辣彰突謀
怪唄覇爆漠箋傍餌鶏与抑頒采冗痘隙掛尚肝貢旨匠垣囚昇憧涯抱瞳砲舶漸殻携藻祈嫁塡濃遂浄懇婆廉酌虎韓恒畔
剖仙換豚慕乞嫡占泥艦咽叫呪郭逓緯普柳排赴酔艶曹飽兼幾威較薄脇渉促刑鼓呂傘丙斎猛逝膜肢斤慌称羨挫貪憬
唯宰勲舟丹栽毀裂奇鍋賊遍畏斥枢懸乙鍛衝釜滞珠督飢履藤諦薦恭蛮扱佳痴酷拶虹裕捻哺偽臼畿盾蜂暇唆須粋
融窃礎閑吐娯麗崖妙粛依寛窟伏那汚環憩怨貫瞭芯畜綱墳露宵訴隷逸虞丼曇蓋憶忍煎淑詔盗謎虜牲簿跡瑠
齢剤浦秩恨迭端慮汰泡褒房雷凹濫豪抄渇愉尋殊酬蔑頓溺娘倒肘輝亜訟紡倣愚艇昧罰含駆婚戯祉邸尻窯
朽稿憾哀桃及魅髄奉烈菊雌穏軌捕煙妥葛揚韻絡峠遣璧湧旦煩磨錦楼泰鍵裸湾衷享婿妃謄擦炉躍狙唐俸項戚溝蜜
唇到悩侶薫爪亭漬逮膳串抵綻刺殿擁療勅獄累慈旋削蛍恣描顎嵐姓癒霜孔俗驚滝潜塞峡即釣孤析奨淫華遮却執
惨砕緻款曽彼寿塾封翁厄震紋把瘍伸炎餓互紛帝遵挟挨魂患弧峰妨紫瞬振黙厘爵殴閲倹拭攻帽込猿更汁肪範賦
偉釈礁忌郎鑑乾払叔託胞締離篤瓦衡宴髪繭壮甲盲援罷瓶凸幽翼飾征銃肩禅漆殉刈脊茎誓途粗怒隅脚喝悟欄御劣
索冥堤粧弦玩暫維搬肯献辱芳傲缶狭麻施尼鶴濁握勃但介溶藍猟虐拓慢塔晶叙浮距棟傑敢燥惧糧睦審奪葬軒据繰
拳戒聴腺企亀訃酪脅還渋妊貌透悔謙誘縛膚駄隠稚詰縫盆鋳鎮朱網欺架匹骸阻赦楷貼没泊充棄捉泌偏坑緒腕敏汗
拘畝賜桟睡剣痢祥逃募擬寮影雰詳酵胴諭幻疫避暁需掃踪昆誉挿刃騎弐概侯斗椅辛舞眠僚頃渦硝汎堪眉嘲債薪抹
璽朴岬摂僅慄闇拉埋塊侍肌滑菓賢僕奔癖拙荘矛塚違浜租診巧狩迫賭詮潰冒奴陶卸翻氾彫縁況堅妄崇了遭鎖帆
徐粒堕銘掘斜償択渡枠歓憤謹暦漫邪搭斬窮嘱撲偵庶刹箸為尽涼劾魔賂遅凄憎扉穂壊籍嘆某卓顕曖牙棚襟微獣陰
恥鯨慎旬諮歳哲恵致敷零藩諾咲勾
]]):gsub("%s", "")

data.jinmeiyo_kanji = ([[
丑丞乃之乎也云亘亙些亦亥亨亮仔伊伍伽佃佑伶侃侑俄俠俣俐倭俱倦倖偲傭儲允兎兜其冴凌凜凛凧凪凰凱函劉劫
勁勺勿匁匡廿卜卯卿厨厩叉叡叢叶只吾吞吻哉哨啄哩喬喧喰喋嘩嘉嘗噌噂圃圭坐尭堯坦埴堰堺堵塙壕壬夷奄奎套
娃姪姥娩嬉孟宏宋宕宥寅寓寵尖尤屑峨峻崚嵯嵩嶺巌巖已巳巴巫巷巽帖幌幡庄庇庚庵廟廻弘弛彗彦彪彬徠忽怜恢恰
恕悌惟惚悉惇惹惺惣慧憐戊或戟托按挺挽掬捲捷捺捧掠揃摑摺撒撰撞播撫擢孜敦斐斡斧斯於旭昂昊昏昌昴晏晃晄
晒晋晟晦晨智暉暢曙曝曳朋朔杏杖杜李杭杵杷枇柑柴柘柊柏柾柚桧檜栞桔桂栖桐栗梧梓梢梛梯桶梶椛梁棲椋椀楯
楚楕椿楠楓椰楢楊榎樺榊榛槙槇槍槌樫槻樟樋橘樽橙檎檀櫂櫛櫓欣欽歎此殆毅毘毬汀汝汐汲沌沓沫洸洲洵洛浩浬
淵淳渚渚淀淋渥湘湊湛溢滉溜漱漕漣澪濡瀕灘灸灼烏焰焚煌煤煉熙燕燎燦燭燿爾牒牟牡牽犀狼猪猪獅玖珂珈珊珀
玲琢琢琉瑛琥琶琵琳瑚瑞瑶瑳瓜瓢甥甫畠畢疋疏皐皓眸瞥矩砦砥砧硯碓碗碩碧磐磯祇祢禰祐祐祷禱禄祿禎禎禽禾
秦秤稀稔稟稜穣穰穹穿窄窪窺竣竪竺竿笈笹笙笠筈筑箕箔篇篠簞簾籾粥粟糊紘紗紐絃紬絆絢綺綜綴緋綾綸縞徽繫
繡纂纏羚翔翠耀而耶耽聡肇肋肴胤胡脩腔脹膏臥舜舵芥芹芭芙芦苑茄苔苺茅茉茸茜莞荻莫莉菅菫菖萄菩萌萠萊菱
葦葵萱葺萩董葡蓑蒔蒐蒼蒲蒙蓉蓮蔭蔣蔦蓬蔓蕎蕨蕉蕃蕪薙蕾蕗藁薩蘇蘭蝦蝶螺蟬蟹蠟衿袈袴裡裟裳襖訊訣註詢
詫誼諏諄諒謂諺讃豹貰賑赳跨蹄蹟輔輯輿轟辰辻迂迄辿迪迦這逞逗逢遥遙遁遼邑祁郁鄭酉醇醐醍醬釉釘釧銑鋒鋸
錘錐錆錫鍬鎧閃閏閤阿陀隈隼雀雁雛雫霞靖鞄鞍鞘鞠鞭頁頌頗顚颯饗馨馴馳駕駿驍魁魯鮎鯉鯛鰯鱒鱗鳩鳶鳳鴨鴻
鵜鵬鷗鷲鷺鷹麒麟麿黎黛鼎
亞惡爲榮衞圓緣薗應櫻奧橫溫價壞懷樂渴卷陷寬氣僞戲虛峽狹曉
駈勳薰惠揭鷄藝擊縣儉劍險圈檢顯驗嚴廣恆黃國黑碎雜兒濕實壽收從澁獸縱緖敍
將涉燒奬條狀乘淨剩疊孃讓釀眞寢愼盡粹醉穗瀨齊靜攝專戰纖禪壯爭莊搜巢曾裝瘦騷增藏臟卽帶
滯瀧單團彈晝鑄廳徵聽鎭轉傳嶋燈盜稻德拜盃賣髮拔晚祕冨拂佛步峯飜
每萬默埜彌藥與搖樣謠來賴覽龍凉綠淚壘禮曆歷鍊郞錄]]):gsub("%s", "")

return data