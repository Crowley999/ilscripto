local export = {}
export.entitytable = {
  ["&Tab;"]="\t",
  ["&NewLine;"]="\n",
  ["&excl;"]="!",
  ["&quot;"]="\"",
  ["&num;"]="#",
  ["&dollar;"]="$",
  ["&percnt;"]="%",
  ["&amp;"]="&",
  ["&apos;"]="'",
  ["&lpar;"]="(",
  ["&rpar;"]=")",
  ["&ast;"]="*",
  ["&plus;"]="+",
  ["&comma;"]=",",
  ["&period;"]=".",
  ["&sol;"]="/",
  ["&colon;"]=":",
  ["&semi;"]=";",
  ["&lt;"]="<",
  ["&nvlt;"]="<⃒",
  ["&equals;"]="=",
  ["&bne;"]="=⃥",
  ["&gt;"]=">",
  ["&nvgt;"]=">⃒",
  ["&quest;"]="?",
  ["&commat;"]="@",
  ["&lbrack;"]="[",
  ["&bsol;"]="\\",
  ["&rsqb;"]="]",
  ["&Hat;"]="^",
  ["&lowbar;"]="_",
  ["&grave;"]="`",
  ["&fjlig;"]="fj",
  ["&lbrace;"]="{",
  ["&vert;"]="|",
  ["&rcub;"]="}",
  ["&nbsp;"]=" ",
  ["&iexcl;"]="¡",
  ["&cent;"]="¢",
  ["&pound;"]="£",
  ["&curren;"]="¤",
  ["&yen;"]="¥",
  ["&brvbar;"]="¦",
  ["&sect;"]="§",
  ["&DoubleDot;"]="¨",
  ["&copy;"]="©",
  ["&ordf;"]="ª",
  ["&laquo;"]="«",
  ["&not;"]="¬",
  ["&shy;"]="­",
  ["&reg;"]="®",
  ["&macr;"]="¯",
  ["&deg;"]="°",
  ["&plusmn;"]="±",
  ["&sup2;"]="²",
  ["&sup3;"]="³",
  ["&DiacriticalAcute;"]="´",
  ["&micro;"]="µ",
  ["&para;"]="¶",
  ["&CenterDot;"]="·",
  ["&Cedilla;"]="¸",
  ["&sup1;"]="¹",
  ["&ordm;"]="º",
  ["&raquo;"]="»",
  ["&frac14;"]="¼",
  ["&half;"]="½",
  ["&frac34;"]="¾",
  ["&iquest;"]="¿",
  ["&Agrave;"]="À",
  ["&Aacute;"]="Á",
  ["&Acirc;"]="Â",
  ["&Atilde;"]="Ã",
  ["&Auml;"]="Ä",
  ["&Aring;"]="Å",
  ["&AElig;"]="Æ",
  ["&Ccedil;"]="Ç",
  ["&Egrave;"]="È",
  ["&Eacute;"]="É",
  ["&Ecirc;"]="Ê",
  ["&Euml;"]="Ë",
  ["&Igrave;"]="Ì",
  ["&Iacute;"]="Í",
  ["&Icirc;"]="Î",
  ["&Iuml;"]="Ï",
  ["&ETH;"]="Ð",
  ["&Ntilde;"]="Ñ",
  ["&Ograve;"]="Ò",
  ["&Oacute;"]="Ó",
  ["&Ocirc;"]="Ô",
  ["&Otilde;"]="Õ",
  ["&Ouml;"]="Ö",
  ["&times;"]="×",
  ["&Oslash;"]="Ø",
  ["&Ugrave;"]="Ù",
  ["&Uacute;"]="Ú",
  ["&Ucirc;"]="Û",
  ["&Uuml;"]="Ü",
  ["&Yacute;"]="Ý",
  ["&THORN;"]="Þ",
  ["&szlig;"]="ß",
  ["&agrave;"]="à",
  ["&aacute;"]="á",
  ["&acirc;"]="â",
  ["&atilde;"]="ã",
  ["&auml;"]="ä",
  ["&aring;"]="å",
  ["&aelig;"]="æ",
  ["&ccedil;"]="ç",
  ["&egrave;"]="è",
  ["&eacute;"]="é",
  ["&ecirc;"]="ê",
  ["&euml;"]="ë",
  ["&igrave;"]="ì",
  ["&iacute;"]="í",
  ["&icirc;"]="î",
  ["&iuml;"]="ï",
  ["&eth;"]="ð",
  ["&ntilde;"]="ñ",
  ["&ograve;"]="ò",
  ["&oacute;"]="ó",
  ["&ocirc;"]="ô",
  ["&otilde;"]="õ",
  ["&ouml;"]="ö",
  ["&divide;"]="÷",
  ["&oslash;"]="ø",
  ["&ugrave;"]="ù",
  ["&uacute;"]="ú",
  ["&ucirc;"]="û",
  ["&uuml;"]="ü",
  ["&yacute;"]="ý",
  ["&thorn;"]="þ",
  ["&yuml;"]="ÿ",
  ["&Amacr;"]="Ā",
  ["&amacr;"]="ā",
  ["&Abreve;"]="Ă",
  ["&abreve;"]="ă",
  ["&Aogon;"]="Ą",
  ["&aogon;"]="ą",
  ["&Cacute;"]="Ć",
  ["&cacute;"]="ć",
  ["&Ccirc;"]="Ĉ",
  ["&ccirc;"]="ĉ",
  ["&Cdot;"]="Ċ",
  ["&cdot;"]="ċ",
  ["&Ccaron;"]="Č",
  ["&ccaron;"]="č",
  ["&Dcaron;"]="Ď",
  ["&dcaron;"]="ď",
  ["&Dstrok;"]="Đ",
  ["&dstrok;"]="đ",
  ["&Emacr;"]="Ē",
  ["&emacr;"]="ē",
  ["&Edot;"]="Ė",
  ["&edot;"]="ė",
  ["&Eogon;"]="Ę",
  ["&eogon;"]="ę",
  ["&Ecaron;"]="Ě",
  ["&ecaron;"]="ě",
  ["&Gcirc;"]="Ĝ",
  ["&gcirc;"]="ĝ",
  ["&Gbreve;"]="Ğ",
  ["&gbreve;"]="ğ",
  ["&Gdot;"]="Ġ",
  ["&gdot;"]="ġ",
  ["&Gcedil;"]="Ģ",
  ["&Hcirc;"]="Ĥ",
  ["&hcirc;"]="ĥ",
  ["&Hstrok;"]="Ħ",
  ["&hstrok;"]="ħ",
  ["&Itilde;"]="Ĩ",
  ["&itilde;"]="ĩ",
  ["&Imacr;"]="Ī",
  ["&imacr;"]="ī",
  ["&Iogon;"]="Į",
  ["&iogon;"]="į",
  ["&Idot;"]="İ",
  ["&inodot;"]="ı",
  ["&IJlig;"]="Ĳ",
  ["&ijlig;"]="ĳ",
  ["&Jcirc;"]="Ĵ",
  ["&jcirc;"]="ĵ",
  ["&Kcedil;"]="Ķ",
  ["&kcedil;"]="ķ",
  ["&kgreen;"]="ĸ",
  ["&Lacute;"]="Ĺ",
  ["&lacute;"]="ĺ",
  ["&Lcedil;"]="Ļ",
  ["&lcedil;"]="ļ",
  ["&Lcaron;"]="Ľ",
  ["&lcaron;"]="ľ",
  ["&Lmidot;"]="Ŀ",
  ["&lmidot;"]="ŀ",
  ["&Lstrok;"]="Ł",
  ["&lstrok;"]="ł",
  ["&Nacute;"]="Ń",
  ["&nacute;"]="ń",
  ["&Ncedil;"]="Ņ",
  ["&ncedil;"]="ņ",
  ["&Ncaron;"]="Ň",
  ["&ncaron;"]="ň",
  ["&napos;"]="ŉ",
  ["&ENG;"]="Ŋ",
  ["&eng;"]="ŋ",
  ["&Omacr;"]="Ō",
  ["&omacr;"]="ō",
  ["&Odblac;"]="Ő",
  ["&odblac;"]="ő",
  ["&OElig;"]="Œ",
  ["&oelig;"]="œ",
  ["&Racute;"]="Ŕ",
  ["&racute;"]="ŕ",
  ["&Rcedil;"]="Ŗ",
  ["&rcedil;"]="ŗ",
  ["&Rcaron;"]="Ř",
  ["&rcaron;"]="ř",
  ["&Sacute;"]="Ś",
  ["&sacute;"]="ś",
  ["&Scirc;"]="Ŝ",
  ["&scirc;"]="ŝ",
  ["&Scedil;"]="Ş",
  ["&scedil;"]="ş",
  ["&Scaron;"]="Š",
  ["&scaron;"]="š",
  ["&Tcedil;"]="Ţ",
  ["&tcedil;"]="ţ",
  ["&Tcaron;"]="Ť",
  ["&tcaron;"]="ť",
  ["&Tstrok;"]="Ŧ",
  ["&tstrok;"]="ŧ",
  ["&Utilde;"]="Ũ",
  ["&utilde;"]="ũ",
  ["&Umacr;"]="Ū",
  ["&umacr;"]="ū",
  ["&Ubreve;"]="Ŭ",
  ["&ubreve;"]="ŭ",
  ["&Uring;"]="Ů",
  ["&uring;"]="ů",
  ["&Udblac;"]="Ű",
  ["&udblac;"]="ű",
  ["&Uogon;"]="Ų",
  ["&uogon;"]="ų",
  ["&Wcirc;"]="Ŵ",
  ["&wcirc;"]="ŵ",
  ["&Ycirc;"]="Ŷ",
  ["&ycirc;"]="ŷ",
  ["&Yuml;"]="Ÿ",
  ["&Zacute;"]="Ź",
  ["&zacute;"]="ź",
  ["&Zdot;"]="Ż",
  ["&zdot;"]="ż",
  ["&Zcaron;"]="Ž",
  ["&zcaron;"]="ž",
  ["&fnof;"]="ƒ",
  ["&imped;"]="Ƶ",
  ["&gacute;"]="ǵ",
  ["&jmath;"]="ȷ",
  ["&circ;"]="ˆ",
  ["&Hacek;"]="ˇ",
  ["&Breve;"]="˘",
  ["&dot;"]="˙",
  ["&ring;"]="˚",
  ["&ogon;"]="˛",
  ["&DiacriticalTilde;"]="˜",
  ["&DiacriticalDoubleAcute;"]="˝",
  ["&DownBreve;"]="̑",
  ["&Alpha;"]="Α",
  ["&Beta;"]="Β",
  ["&Gamma;"]="Γ",
  ["&Delta;"]="Δ",
  ["&Epsilon;"]="Ε",
  ["&Zeta;"]="Ζ",
  ["&Eta;"]="Η",
  ["&Theta;"]="Θ",
  ["&Iota;"]="Ι",
  ["&Kappa;"]="Κ",
  ["&Lambda;"]="Λ",
  ["&Mu;"]="Μ",
  ["&Nu;"]="Ν",
  ["&Xi;"]="Ξ",
  ["&Omicron;"]="Ο",
  ["&Pi;"]="Π",
  ["&Rho;"]="Ρ",
  ["&Sigma;"]="Σ",
  ["&Tau;"]="Τ",
  ["&Upsilon;"]="Υ",
  ["&Phi;"]="Φ",
  ["&Chi;"]="Χ",
  ["&Psi;"]="Ψ",
  ["&Omega;"]="Ω",
  ["&alpha;"]="α",
  ["&beta;"]="β",
  ["&gamma;"]="γ",
  ["&delta;"]="δ",
  ["&epsi;"]="ε",
  ["&zeta;"]="ζ",
  ["&eta;"]="η",
  ["&theta;"]="θ",
  ["&iota;"]="ι",
  ["&kappa;"]="κ",
  ["&lambda;"]="λ",
  ["&mu;"]="μ",
  ["&nu;"]="ν",
  ["&xi;"]="ξ",
  ["&omicron;"]="ο",
  ["&pi;"]="π",
  ["&rho;"]="ρ",
  ["&sigmav;"]="ς",
  ["&sigma;"]="σ",
  ["&tau;"]="τ",
  ["&upsi;"]="υ",
  ["&phi;"]="φ",
  ["&chi;"]="χ",
  ["&psi;"]="ψ",
  ["&omega;"]="ω",
  ["&thetasym;"]="ϑ",
  ["&upsih;"]="ϒ",
  ["&straightphi;"]="ϕ",
  ["&piv;"]="ϖ",
  ["&Gammad;"]="Ϝ",
  ["&gammad;"]="ϝ",
  ["&varkappa;"]="ϰ",
  ["&rhov;"]="ϱ",
  ["&straightepsilon;"]="ϵ",
  ["&backepsilon;"]="϶",
  ["&IOcy;"]="Ё",
  ["&DJcy;"]="Ђ",
  ["&GJcy;"]="Ѓ",
  ["&Jukcy;"]="Є",
  ["&DScy;"]="Ѕ",
  ["&Iukcy;"]="І",
  ["&YIcy;"]="Ї",
  ["&Jsercy;"]="Ј",
  ["&LJcy;"]="Љ",
  ["&NJcy;"]="Њ",
  ["&TSHcy;"]="Ћ",
  ["&KJcy;"]="Ќ",
  ["&Ubrcy;"]="Ў",
  ["&DZcy;"]="Џ",
  ["&Acy;"]="А",
  ["&Bcy;"]="Б",
  ["&Vcy;"]="В",
  ["&Gcy;"]="Г",
  ["&Dcy;"]="Д",
  ["&IEcy;"]="Е",
  ["&ZHcy;"]="Ж",
  ["&Zcy;"]="З",
  ["&Icy;"]="И",
  ["&Jcy;"]="Й",
  ["&Kcy;"]="К",
  ["&Lcy;"]="Л",
  ["&Mcy;"]="М",
  ["&Ncy;"]="Н",
  ["&Ocy;"]="О",
  ["&Pcy;"]="П",
  ["&Rcy;"]="Р",
  ["&Scy;"]="С",
  ["&Tcy;"]="Т",
  ["&Ucy;"]="У",
  ["&Fcy;"]="Ф",
  ["&KHcy;"]="Х",
  ["&TScy;"]="Ц",
  ["&CHcy;"]="Ч",
  ["&SHcy;"]="Ш",
  ["&SHCHcy;"]="Щ",
  ["&HARDcy;"]="Ъ",
  ["&Ycy;"]="Ы",
  ["&SOFTcy;"]="Ь",
  ["&Ecy;"]="Э",
  ["&YUcy;"]="Ю",
  ["&YAcy;"]="Я",
  ["&acy;"]="а",
  ["&bcy;"]="б",
  ["&vcy;"]="в",
  ["&gcy;"]="г",
  ["&dcy;"]="д",
  ["&iecy;"]="е",
  ["&zhcy;"]="ж",
  ["&zcy;"]="з",
  ["&icy;"]="и",
  ["&jcy;"]="й",
  ["&kcy;"]="к",
  ["&lcy;"]="л",
  ["&mcy;"]="м",
  ["&ncy;"]="н",
  ["&ocy;"]="о",
  ["&pcy;"]="п",
  ["&rcy;"]="р",
  ["&scy;"]="с",
  ["&tcy;"]="т",
  ["&ucy;"]="у",
  ["&fcy;"]="ф",
  ["&khcy;"]="х",
  ["&tscy;"]="ц",
  ["&chcy;"]="ч",
  ["&shcy;"]="ш",
  ["&shchcy;"]="щ",
  ["&hardcy;"]="ъ",
  ["&ycy;"]="ы",
  ["&softcy;"]="ь",
  ["&ecy;"]="э",
  ["&yucy;"]="ю",
  ["&yacy;"]="я",
  ["&iocy;"]="ё",
  ["&djcy;"]="ђ",
  ["&gjcy;"]="ѓ",
  ["&jukcy;"]="є",
  ["&dscy;"]="ѕ",
  ["&iukcy;"]="і",
  ["&yicy;"]="ї",
  ["&jsercy;"]="ј",
  ["&ljcy;"]="љ",
  ["&njcy;"]="њ",
  ["&tshcy;"]="ћ",
  ["&kjcy;"]="ќ",
  ["&ubrcy;"]="ў",
  ["&dzcy;"]="џ",
  ["&ensp;"]=" ",
  ["&emsp;"]=" ",
  ["&emsp13;"]=" ",
  ["&emsp14;"]=" ",
  ["&numsp;"]=" ",
  ["&puncsp;"]=" ",
  ["&ThinSpace;"]=" ",
  ["&hairsp;"]=" ",
  ["&ZeroWidthSpace;"]="​",
  ["&zwnj;"]="‌",
  ["&zwj;"]="‍",
  ["&lrm;"]="‎",
  ["&rlm;"]="‏",
  ["&hyphen;"]="‐",
  ["&ndash;"]="–",
  ["&mdash;"]="—",
  ["&horbar;"]="―",
  ["&Verbar;"]="‖",
  ["&OpenCurlyQuote;"]="‘",
  ["&rsquo;"]="’",
  ["&sbquo;"]="‚",
  ["&OpenCurlyDoubleQuote;"]="“",
  ["&rdquo;"]="”",
  ["&bdquo;"]="„",
  ["&dagger;"]="†",
  ["&Dagger;"]="‡",
  ["&bull;"]="•",
  ["&nldr;"]="‥",
  ["&hellip;"]="…",
  ["&permil;"]="‰",
  ["&pertenk;"]="‱",
  ["&prime;"]="′",
  ["&Prime;"]="″",
  ["&tprime;"]="‴",
  ["&backprime;"]="‵",
  ["&lsaquo;"]="‹",
  ["&rsaquo;"]="›",
  ["&oline;"]="‾",
  ["&caret;"]="⁁",
  ["&hybull;"]="⁃",
  ["&frasl;"]="⁄",
  ["&bsemi;"]="⁏",
  ["&qprime;"]="⁗",
  ["&MediumSpace;"]=" ",
  ["&ThickSpace;"]="  ",
  ["&NoBreak;"]="⁠",
  ["&af;"]="⁡",
  ["&InvisibleTimes;"]="⁢",
  ["&ic;"]="⁣",
  ["&euro;"]="€",
  ["&TripleDot;"]="⃛",
  ["&DotDot;"]="⃜",
  ["&complexes;"]="ℂ",
  ["&incare;"]="℅",
  ["&gscr;"]="ℊ",
  ["&HilbertSpace;"]="ℋ",
  ["&Hfr;"]="ℌ",
  ["&Hopf;"]="ℍ",
  ["&planckh;"]="ℎ",
  ["&planck;"]="ℏ",
  ["&imagline;"]="ℐ",
  ["&Ifr;"]="ℑ",
  ["&lagran;"]="ℒ",
  ["&ell;"]="ℓ",
  ["&naturals;"]="ℕ",
  ["&numero;"]="№",
  ["&copysr;"]="℗",
  ["&wp;"]="℘",
  ["&primes;"]="ℙ",
  ["&rationals;"]="ℚ",
  ["&realine;"]="ℛ",
  ["&Rfr;"]="ℜ",
  ["&Ropf;"]="ℝ",
  ["&rx;"]="℞",
  ["&trade;"]="™",
  ["&Zopf;"]="ℤ",
  ["&mho;"]="℧",
  ["&Zfr;"]="ℨ",
  ["&iiota;"]="℩",
  ["&Bscr;"]="ℬ",
  ["&Cfr;"]="ℭ",
  ["&escr;"]="ℯ",
  ["&expectation;"]="ℰ",
  ["&Fouriertrf;"]="ℱ",
  ["&Mellintrf;"]="ℳ",
  ["&orderof;"]="ℴ",
  ["&aleph;"]="ℵ",
  ["&beth;"]="ℶ",
  ["&gimel;"]="ℷ",
  ["&daleth;"]="ℸ",
  ["&CapitalDifferentialD;"]="ⅅ",
  ["&DifferentialD;"]="ⅆ",
  ["&exponentiale;"]="ⅇ",
  ["&ImaginaryI;"]="ⅈ",
  ["&frac13;"]="⅓",
  ["&frac23;"]="⅔",
  ["&frac15;"]="⅕",
  ["&frac25;"]="⅖",
  ["&frac35;"]="⅗",
  ["&frac45;"]="⅘",
  ["&frac16;"]="⅙",
  ["&frac56;"]="⅚",
  ["&frac18;"]="⅛",
  ["&frac38;"]="⅜",
  ["&frac58;"]="⅝",
  ["&frac78;"]="⅞",
  ["&larr;"]="←",
  ["&uarr;"]="↑",
  ["&srarr;"]="→",
  ["&darr;"]="↓",
  ["&harr;"]="↔",
  ["&UpDownArrow;"]="↕",
  ["&nwarrow;"]="↖",
  ["&UpperRightArrow;"]="↗",
  ["&LowerRightArrow;"]="↘",
  ["&swarr;"]="↙",
  ["&nleftarrow;"]="↚",
  ["&nrarr;"]="↛",
  ["&rarrw;"]="↝",
  ["&nrarrw;"]="↝̸",
  ["&Larr;"]="↞",
  ["&Uarr;"]="↟",
  ["&twoheadrightarrow;"]="↠",
  ["&Darr;"]="↡",
  ["&larrtl;"]="↢",
  ["&rarrtl;"]="↣",
  ["&LeftTeeArrow;"]="↤",
  ["&UpTeeArrow;"]="↥",
  ["&map;"]="↦",
  ["&DownTeeArrow;"]="↧",
  ["&larrhk;"]="↩",
  ["&rarrhk;"]="↪",
  ["&larrlp;"]="↫",
  ["&looparrowright;"]="↬",
  ["&harrw;"]="↭",
  ["&nleftrightarrow;"]="↮",
  ["&Lsh;"]="↰",
  ["&rsh;"]="↱",
  ["&ldsh;"]="↲",
  ["&rdsh;"]="↳",
  ["&crarr;"]="↵",
  ["&curvearrowleft;"]="↶",
  ["&curarr;"]="↷",
  ["&olarr;"]="↺",
  ["&orarr;"]="↻",
  ["&leftharpoonup;"]="↼",
  ["&leftharpoondown;"]="↽",
  ["&RightUpVector;"]="↾",
  ["&uharl;"]="↿",
  ["&rharu;"]="⇀",
  ["&rhard;"]="⇁",
  ["&RightDownVector;"]="⇂",
  ["&dharl;"]="⇃",
  ["&rightleftarrows;"]="⇄",
  ["&udarr;"]="⇅",
  ["&lrarr;"]="⇆",
  ["&llarr;"]="⇇",
  ["&upuparrows;"]="⇈",
  ["&rrarr;"]="⇉",
  ["&downdownarrows;"]="⇊",
  ["&leftrightharpoons;"]="⇋",
  ["&rightleftharpoons;"]="⇌",
  ["&nLeftarrow;"]="⇍",
  ["&nhArr;"]="⇎",
  ["&nrArr;"]="⇏",
  ["&DoubleLeftArrow;"]="⇐",
  ["&DoubleUpArrow;"]="⇑",
  ["&Implies;"]="⇒",
  ["&Downarrow;"]="⇓",
  ["&hArr;"]="⇔",
  ["&Updownarrow;"]="⇕",
  ["&nwArr;"]="⇖",
  ["&neArr;"]="⇗",
  ["&seArr;"]="⇘",
  ["&swArr;"]="⇙",
  ["&lAarr;"]="⇚",
  ["&rAarr;"]="⇛",
  ["&zigrarr;"]="⇝",
  ["&LeftArrowBar;"]="⇤",
  ["&RightArrowBar;"]="⇥",
  ["&DownArrowUpArrow;"]="⇵",
  ["&loarr;"]="⇽",
  ["&roarr;"]="⇾",
  ["&hoarr;"]="⇿",
  ["&forall;"]="∀",
  ["&comp;"]="∁",
  ["&part;"]="∂",
  ["&npart;"]="∂̸",
  ["&Exists;"]="∃",
  ["&nexist;"]="∄",
  ["&empty;"]="∅",
  ["&nabla;"]="∇",
  ["&isinv;"]="∈",
  ["&notin;"]="∉",
  ["&ReverseElement;"]="∋",
  ["&notniva;"]="∌",
  ["&prod;"]="∏",
  ["&Coproduct;"]="∐",
  ["&sum;"]="∑",
  ["&minus;"]="−",
  ["&MinusPlus;"]="∓",
  ["&plusdo;"]="∔",
  ["&ssetmn;"]="∖",
  ["&lowast;"]="∗",
  ["&compfn;"]="∘",
  ["&Sqrt;"]="√",
  ["&prop;"]="∝",
  ["&infin;"]="∞",
  ["&angrt;"]="∟",
  ["&angle;"]="∠",
  ["&nang;"]="∠⃒",
  ["&angmsd;"]="∡",
  ["&angsph;"]="∢",
  ["&mid;"]="∣",
  ["&nshortmid;"]="∤",
  ["&shortparallel;"]="∥",
  ["&nparallel;"]="∦",
  ["&and;"]="∧",
  ["&or;"]="∨",
  ["&cap;"]="∩",
  ["&caps;"]="∩︀",
  ["&cup;"]="∪",
  ["&cups;"]="∪︀",
  ["&Integral;"]="∫",
  ["&Int;"]="∬",
  ["&tint;"]="∭",
  ["&ContourIntegral;"]="∮",
  ["&DoubleContourIntegral;"]="∯",
  ["&Cconint;"]="∰",
  ["&cwint;"]="∱",
  ["&cwconint;"]="∲",
  ["&awconint;"]="∳",
  ["&there4;"]="∴",
  ["&Because;"]="∵",
  ["&ratio;"]="∶",
  ["&Colon;"]="∷",
  ["&minusd;"]="∸",
  ["&mDDot;"]="∺",
  ["&homtht;"]="∻",
  ["&sim;"]="∼",
  ["&nvsim;"]="∼⃒",
  ["&bsim;"]="∽",
  ["&race;"]="∽̱",
  ["&ac;"]="∾",
  ["&acE;"]="∾̳",
  ["&acd;"]="∿",
  ["&wr;"]="≀",
  ["&NotTilde;"]="≁",
  ["&esim;"]="≂",
  ["&nesim;"]="≂̸",
  ["&simeq;"]="≃",
  ["&nsime;"]="≄",
  ["&TildeFullEqual;"]="≅",
  ["&simne;"]="≆",
  ["&ncong;"]="≇",
  ["&approx;"]="≈",
  ["&napprox;"]="≉",
  ["&ape;"]="≊",
  ["&apid;"]="≋",
  ["&napid;"]="≋̸",
  ["&bcong;"]="≌",
  ["&CupCap;"]="≍",
  ["&nvap;"]="≍⃒",
  ["&bump;"]="≎",
  ["&nbump;"]="≎̸",
  ["&HumpEqual;"]="≏",
  ["&nbumpe;"]="≏̸",
  ["&esdot;"]="≐",
  ["&nedot;"]="≐̸",
  ["&doteqdot;"]="≑",
  ["&fallingdotseq;"]="≒",
  ["&risingdotseq;"]="≓",
  ["&coloneq;"]="≔",
  ["&eqcolon;"]="≕",
  ["&ecir;"]="≖",
  ["&circeq;"]="≗",
  ["&wedgeq;"]="≙",
  ["&veeeq;"]="≚",
  ["&triangleq;"]="≜",
  ["&equest;"]="≟",
  ["&NotEqual;"]="≠",
  ["&Congruent;"]="≡",
  ["&bnequiv;"]="≡⃥",
  ["&NotCongruent;"]="≢",
  ["&leq;"]="≤",
  ["&nvle;"]="≤⃒",
  ["&ge;"]="≥",
  ["&nvge;"]="≥⃒",
  ["&lE;"]="≦",
  ["&nlE;"]="≦̸",
  ["&geqq;"]="≧",
  ["&NotGreaterFullEqual;"]="≧̸",
  ["&lneqq;"]="≨",
  ["&lvertneqq;"]="≨︀",
  ["&gneqq;"]="≩",
  ["&gvertneqq;"]="≩︀",
  ["&ll;"]="≪",
  ["&nLtv;"]="≪̸",
  ["&nLt;"]="≪⃒",
  ["&gg;"]="≫",
  ["&NotGreaterGreater;"]="≫̸",
  ["&nGt;"]="≫⃒",
  ["&between;"]="≬",
  ["&NotCupCap;"]="≭",
  ["&NotLess;"]="≮",
  ["&ngtr;"]="≯",
  ["&NotLessEqual;"]="≰",
  ["&ngeq;"]="≱",
  ["&LessTilde;"]="≲",
  ["&GreaterTilde;"]="≳",
  ["&nlsim;"]="≴",
  ["&ngsim;"]="≵",
  ["&lessgtr;"]="≶",
  ["&gl;"]="≷",
  ["&ntlg;"]="≸",
  ["&NotGreaterLess;"]="≹",
  ["&prec;"]="≺",
  ["&succ;"]="≻",
  ["&PrecedesSlantEqual;"]="≼",
  ["&succcurlyeq;"]="≽",
  ["&precsim;"]="≾",
  ["&SucceedsTilde;"]="≿",
  ["&NotSucceedsTilde;"]="≿̸",
  ["&npr;"]="⊀",
  ["&NotSucceeds;"]="⊁",
  ["&sub;"]="⊂",
  ["&vnsub;"]="⊂⃒",
  ["&sup;"]="⊃",
  ["&nsupset;"]="⊃⃒",
  ["&nsub;"]="⊄",
  ["&nsup;"]="⊅",
  ["&SubsetEqual;"]="⊆",
  ["&supe;"]="⊇",
  ["&NotSubsetEqual;"]="⊈",
  ["&NotSupersetEqual;"]="⊉",
  ["&subsetneq;"]="⊊",
  ["&vsubne;"]="⊊︀",
  ["&supsetneq;"]="⊋",
  ["&vsupne;"]="⊋︀",
  ["&cupdot;"]="⊍",
  ["&UnionPlus;"]="⊎",
  ["&sqsub;"]="⊏",
  ["&NotSquareSubset;"]="⊏̸",
  ["&sqsupset;"]="⊐",
  ["&NotSquareSuperset;"]="⊐̸",
  ["&SquareSubsetEqual;"]="⊑",
  ["&SquareSupersetEqual;"]="⊒",
  ["&sqcap;"]="⊓",
  ["&sqcaps;"]="⊓︀",
  ["&sqcup;"]="⊔",
  ["&sqcups;"]="⊔︀",
  ["&CirclePlus;"]="⊕",
  ["&ominus;"]="⊖",
  ["&CircleTimes;"]="⊗",
  ["&osol;"]="⊘",
  ["&CircleDot;"]="⊙",
  ["&ocir;"]="⊚",
  ["&oast;"]="⊛",
  ["&odash;"]="⊝",
  ["&boxplus;"]="⊞",
  ["&boxminus;"]="⊟",
  ["&timesb;"]="⊠",
  ["&sdotb;"]="⊡",
  ["&vdash;"]="⊢",
  ["&dashv;"]="⊣",
  ["&DownTee;"]="⊤",
  ["&perp;"]="⊥",
  ["&models;"]="⊧",
  ["&DoubleRightTee;"]="⊨",
  ["&Vdash;"]="⊩",
  ["&Vvdash;"]="⊪",
  ["&VDash;"]="⊫",
  ["&nvdash;"]="⊬",
  ["&nvDash;"]="⊭",
  ["&nVdash;"]="⊮",
  ["&nVDash;"]="⊯",
  ["&prurel;"]="⊰",
  ["&vartriangleleft;"]="⊲",
  ["&vrtri;"]="⊳",
  ["&LeftTriangleEqual;"]="⊴",
  ["&nvltrie;"]="⊴⃒",
  ["&RightTriangleEqual;"]="⊵",
  ["&nvrtrie;"]="⊵⃒",
  ["&origof;"]="⊶",
  ["&imof;"]="⊷",
  ["&mumap;"]="⊸",
  ["&hercon;"]="⊹",
  ["&intcal;"]="⊺",
  ["&veebar;"]="⊻",
  ["&barvee;"]="⊽",
  ["&angrtvb;"]="⊾",
  ["&lrtri;"]="⊿",
  ["&xwedge;"]="⋀",
  ["&xvee;"]="⋁",
  ["&bigcap;"]="⋂",
  ["&bigcup;"]="⋃",
  ["&diamond;"]="⋄",
  ["&sdot;"]="⋅",
  ["&Star;"]="⋆",
  ["&divonx;"]="⋇",
  ["&bowtie;"]="⋈",
  ["&ltimes;"]="⋉",
  ["&rtimes;"]="⋊",
  ["&lthree;"]="⋋",
  ["&rthree;"]="⋌",
  ["&backsimeq;"]="⋍",
  ["&curlyvee;"]="⋎",
  ["&curlywedge;"]="⋏",
  ["&Sub;"]="⋐",
  ["&Supset;"]="⋑",
  ["&Cap;"]="⋒",
  ["&Cup;"]="⋓",
  ["&pitchfork;"]="⋔",
  ["&epar;"]="⋕",
  ["&lessdot;"]="⋖",
  ["&gtrdot;"]="⋗",
  ["&Ll;"]="⋘",
  ["&nLl;"]="⋘̸",
  ["&Gg;"]="⋙",
  ["&nGg;"]="⋙̸",
  ["&lesseqgtr;"]="⋚",
  ["&lesg;"]="⋚︀",
  ["&gtreqless;"]="⋛",
  ["&gesl;"]="⋛︀",
  ["&curlyeqprec;"]="⋞",
  ["&cuesc;"]="⋟",
  ["&NotPrecedesSlantEqual;"]="⋠",
  ["&NotSucceedsSlantEqual;"]="⋡",
  ["&NotSquareSubsetEqual;"]="⋢",
  ["&NotSquareSupersetEqual;"]="⋣",
  ["&lnsim;"]="⋦",
  ["&gnsim;"]="⋧",
  ["&precnsim;"]="⋨",
  ["&scnsim;"]="⋩",
  ["&nltri;"]="⋪",
  ["&ntriangleright;"]="⋫",
  ["&nltrie;"]="⋬",
  ["&NotRightTriangleEqual;"]="⋭",
  ["&vellip;"]="⋮",
  ["&ctdot;"]="⋯",
  ["&utdot;"]="⋰",
  ["&dtdot;"]="⋱",
  ["&disin;"]="⋲",
  ["&isinsv;"]="⋳",
  ["&isins;"]="⋴",
  ["&isindot;"]="⋵",
  ["&notindot;"]="⋵̸",
  ["&notinvc;"]="⋶",
  ["&notinvb;"]="⋷",
  ["&isinE;"]="⋹",
  ["&notinE;"]="⋹̸",
  ["&nisd;"]="⋺",
  ["&xnis;"]="⋻",
  ["&nis;"]="⋼",
  ["&notnivc;"]="⋽",
  ["&notnivb;"]="⋾",
  ["&barwed;"]="⌅",
  ["&doublebarwedge;"]="⌆",
  ["&lceil;"]="⌈",
  ["&RightCeiling;"]="⌉",
  ["&LeftFloor;"]="⌊",
  ["&RightFloor;"]="⌋",
  ["&drcrop;"]="⌌",
  ["&dlcrop;"]="⌍",
  ["&urcrop;"]="⌎",
  ["&ulcrop;"]="⌏",
  ["&bnot;"]="⌐",
  ["&profline;"]="⌒",
  ["&profsurf;"]="⌓",
  ["&telrec;"]="⌕",
  ["&target;"]="⌖",
  ["&ulcorner;"]="⌜",
  ["&urcorner;"]="⌝",
  ["&llcorner;"]="⌞",
  ["&drcorn;"]="⌟",
  ["&frown;"]="⌢",
  ["&smile;"]="⌣",
  ["&cylcty;"]="⌭",
  ["&profalar;"]="⌮",
  ["&topbot;"]="⌶",
  ["&ovbar;"]="⌽",
  ["&solbar;"]="⌿",
  ["&angzarr;"]="⍼",
  ["&lmoust;"]="⎰",
  ["&rmoust;"]="⎱",
  ["&OverBracket;"]="⎴",
  ["&bbrk;"]="⎵",
  ["&bbrktbrk;"]="⎶",
  ["&OverParenthesis;"]="⏜",
  ["&UnderParenthesis;"]="⏝",
  ["&OverBrace;"]="⏞",
  ["&UnderBrace;"]="⏟",
  ["&trpezium;"]="⏢",
  ["&elinters;"]="⏧",
  ["&blank;"]="␣",
  ["&oS;"]="Ⓢ",
  ["&HorizontalLine;"]="─",
  ["&boxv;"]="│",
  ["&boxdr;"]="┌",
  ["&boxdl;"]="┐",
  ["&boxur;"]="└",
  ["&boxul;"]="┘",
  ["&boxvr;"]="├",
  ["&boxvl;"]="┤",
  ["&boxhd;"]="┬",
  ["&boxhu;"]="┴",
  ["&boxvh;"]="┼",
  ["&boxH;"]="═",
  ["&boxV;"]="║",
  ["&boxdR;"]="╒",
  ["&boxDr;"]="╓",
  ["&boxDR;"]="╔",
  ["&boxdL;"]="╕",
  ["&boxDl;"]="╖",
  ["&boxDL;"]="╗",
  ["&boxuR;"]="╘",
  ["&boxUr;"]="╙",
  ["&boxUR;"]="╚",
  ["&boxuL;"]="╛",
  ["&boxUl;"]="╜",
  ["&boxUL;"]="╝",
  ["&boxvR;"]="╞",
  ["&boxVr;"]="╟",
  ["&boxVR;"]="╠",
  ["&boxvL;"]="╡",
  ["&boxVl;"]="╢",
  ["&boxVL;"]="╣",
  ["&boxHd;"]="╤",
  ["&boxhD;"]="╥",
  ["&boxHD;"]="╦",
  ["&boxHu;"]="╧",
  ["&boxhU;"]="╨",
  ["&boxHU;"]="╩",
  ["&boxvH;"]="╪",
  ["&boxVh;"]="╫",
  ["&boxVH;"]="╬",
  ["&uhblk;"]="▀",
  ["&lhblk;"]="▄",
  ["&block;"]="█",
  ["&blk14;"]="░",
  ["&blk12;"]="▒",
  ["&blk34;"]="▓",
  ["&Square;"]="□",
  ["&squarf;"]="▪",
  ["&EmptyVerySmallSquare;"]="▫",
  ["&rect;"]="▭",
  ["&marker;"]="▮",
  ["&fltns;"]="▱",
  ["&bigtriangleup;"]="△",
  ["&blacktriangle;"]="▴",
  ["&triangle;"]="▵",
  ["&blacktriangleright;"]="▸",
  ["&rtri;"]="▹",
  ["&bigtriangledown;"]="▽",
  ["&blacktriangledown;"]="▾",
  ["&triangledown;"]="▿",
  ["&blacktriangleleft;"]="◂",
  ["&ltri;"]="◃",
  ["&lozenge;"]="◊",
  ["&cir;"]="○",
  ["&tridot;"]="◬",
  ["&bigcirc;"]="◯",
  ["&ultri;"]="◸",
  ["&urtri;"]="◹",
  ["&lltri;"]="◺",
  ["&EmptySmallSquare;"]="◻",
  ["&FilledSmallSquare;"]="◼",
  ["&starf;"]="★",
  ["&star;"]="☆",
  ["&phone;"]="☎",
  ["&female;"]="♀",
  ["&male;"]="♂",
  ["&spadesuit;"]="♠",
  ["&clubs;"]="♣",
  ["&hearts;"]="♥",
  ["&diamondsuit;"]="♦",
  ["&sung;"]="♪",
  ["&flat;"]="♭",
  ["&natur;"]="♮",
  ["&sharp;"]="♯",
  ["&check;"]="✓",
  ["&cross;"]="✗",
  ["&maltese;"]="✠",
  ["&sext;"]="✶",
  ["&VerticalSeparator;"]="❘",
  ["&lbbrk;"]="❲",
  ["&rbbrk;"]="❳",
  ["&bsolhsub;"]="⟈",
  ["&suphsol;"]="⟉",
  ["&LeftDoubleBracket;"]="⟦",
  ["&RightDoubleBracket;"]="⟧",
  ["&langle;"]="⟨",
  ["&RightAngleBracket;"]="⟩",
  ["&Lang;"]="⟪",
  ["&Rang;"]="⟫",
  ["&loang;"]="⟬",
  ["&roang;"]="⟭",
  ["&longleftarrow;"]="⟵",
  ["&LongRightArrow;"]="⟶",
  ["&LongLeftRightArrow;"]="⟷",
  ["&xlArr;"]="⟸",
  ["&DoubleLongRightArrow;"]="⟹",
  ["&xhArr;"]="⟺",
  ["&xmap;"]="⟼",
  ["&dzigrarr;"]="⟿",
  ["&nvlArr;"]="⤂",
  ["&nvrArr;"]="⤃",
  ["&nvHarr;"]="⤄",
  ["&Map;"]="⤅",
  ["&lbarr;"]="⤌",
  ["&bkarow;"]="⤍",
  ["&lBarr;"]="⤎",
  ["&dbkarow;"]="⤏",
  ["&drbkarow;"]="⤐",
  ["&DDotrahd;"]="⤑",
  ["&UpArrowBar;"]="⤒",
  ["&DownArrowBar;"]="⤓",
  ["&Rarrtl;"]="⤖",
  ["&latail;"]="⤙",
  ["&ratail;"]="⤚",
  ["&lAtail;"]="⤛",
  ["&rAtail;"]="⤜",
  ["&larrfs;"]="⤝",
  ["&rarrfs;"]="⤞",
  ["&larrbfs;"]="⤟",
  ["&rarrbfs;"]="⤠",
  ["&nwarhk;"]="⤣",
  ["&nearhk;"]="⤤",
  ["&searhk;"]="⤥",
  ["&swarhk;"]="⤦",
  ["&nwnear;"]="⤧",
  ["&toea;"]="⤨",
  ["&seswar;"]="⤩",
  ["&swnwar;"]="⤪",
  ["&rarrc;"]="⤳",
  ["&nrarrc;"]="⤳̸",
  ["&cudarrr;"]="⤵",
  ["&ldca;"]="⤶",
  ["&rdca;"]="⤷",
  ["&cudarrl;"]="⤸",
  ["&larrpl;"]="⤹",
  ["&curarrm;"]="⤼",
  ["&cularrp;"]="⤽",
  ["&rarrpl;"]="⥅",
  ["&harrcir;"]="⥈",
  ["&Uarrocir;"]="⥉",
  ["&lurdshar;"]="⥊",
  ["&ldrushar;"]="⥋",
  ["&LeftRightVector;"]="⥎",
  ["&RightUpDownVector;"]="⥏",
  ["&DownLeftRightVector;"]="⥐",
  ["&LeftUpDownVector;"]="⥑",
  ["&LeftVectorBar;"]="⥒",
  ["&RightVectorBar;"]="⥓",
  ["&RightUpVectorBar;"]="⥔",
  ["&RightDownVectorBar;"]="⥕",
  ["&DownLeftVectorBar;"]="⥖",
  ["&DownRightVectorBar;"]="⥗",
  ["&LeftUpVectorBar;"]="⥘",
  ["&LeftDownVectorBar;"]="⥙",
  ["&LeftTeeVector;"]="⥚",
  ["&RightTeeVector;"]="⥛",
  ["&RightUpTeeVector;"]="⥜",
  ["&RightDownTeeVector;"]="⥝",
  ["&DownLeftTeeVector;"]="⥞",
  ["&DownRightTeeVector;"]="⥟",
  ["&LeftUpTeeVector;"]="⥠",
  ["&LeftDownTeeVector;"]="⥡",
  ["&lHar;"]="⥢",
  ["&uHar;"]="⥣",
  ["&rHar;"]="⥤",
  ["&dHar;"]="⥥",
  ["&luruhar;"]="⥦",
  ["&ldrdhar;"]="⥧",
  ["&ruluhar;"]="⥨",
  ["&rdldhar;"]="⥩",
  ["&lharul;"]="⥪",
  ["&llhard;"]="⥫",
  ["&rharul;"]="⥬",
  ["&lrhard;"]="⥭",
  ["&udhar;"]="⥮",
  ["&ReverseUpEquilibrium;"]="⥯",
  ["&RoundImplies;"]="⥰",
  ["&erarr;"]="⥱",
  ["&simrarr;"]="⥲",
  ["&larrsim;"]="⥳",
  ["&rarrsim;"]="⥴",
  ["&rarrap;"]="⥵",
  ["&ltlarr;"]="⥶",
  ["&gtrarr;"]="⥸",
  ["&subrarr;"]="⥹",
  ["&suplarr;"]="⥻",
  ["&lfisht;"]="⥼",
  ["&rfisht;"]="⥽",
  ["&ufisht;"]="⥾",
  ["&dfisht;"]="⥿",
  ["&lopar;"]="⦅",
  ["&ropar;"]="⦆",
  ["&lbrke;"]="⦋",
  ["&rbrke;"]="⦌",
  ["&lbrkslu;"]="⦍",
  ["&rbrksld;"]="⦎",
  ["&lbrksld;"]="⦏",
  ["&rbrkslu;"]="⦐",
  ["&langd;"]="⦑",
  ["&rangd;"]="⦒",
  ["&lparlt;"]="⦓",
  ["&rpargt;"]="⦔",
  ["&gtlPar;"]="⦕",
  ["&ltrPar;"]="⦖",
  ["&vzigzag;"]="⦚",
  ["&vangrt;"]="⦜",
  ["&angrtvbd;"]="⦝",
  ["&ange;"]="⦤",
  ["&range;"]="⦥",
  ["&dwangle;"]="⦦",
  ["&uwangle;"]="⦧",
  ["&angmsdaa;"]="⦨",
  ["&angmsdab;"]="⦩",
  ["&angmsdac;"]="⦪",
  ["&angmsdad;"]="⦫",
  ["&angmsdae;"]="⦬",
  ["&angmsdaf;"]="⦭",
  ["&angmsdag;"]="⦮",
  ["&angmsdah;"]="⦯",
  ["&bemptyv;"]="⦰",
  ["&demptyv;"]="⦱",
  ["&cemptyv;"]="⦲",
  ["&raemptyv;"]="⦳",
  ["&laemptyv;"]="⦴",
  ["&ohbar;"]="⦵",
  ["&omid;"]="⦶",
  ["&opar;"]="⦷",
  ["&operp;"]="⦹",
  ["&olcross;"]="⦻",
  ["&odsold;"]="⦼",
  ["&olcir;"]="⦾",
  ["&ofcir;"]="⦿",
  ["&olt;"]="⧀",
  ["&ogt;"]="⧁",
  ["&cirscir;"]="⧂",
  ["&cirE;"]="⧃",
  ["&solb;"]="⧄",
  ["&bsolb;"]="⧅",
  ["&boxbox;"]="⧉",
  ["&trisb;"]="⧍",
  ["&rtriltri;"]="⧎",
  ["&LeftTriangleBar;"]="⧏",
  ["&NotLeftTriangleBar;"]="⧏̸",
  ["&RightTriangleBar;"]="⧐",
  ["&NotRightTriangleBar;"]="⧐̸",
  ["&iinfin;"]="⧜",
  ["&infintie;"]="⧝",
  ["&nvinfin;"]="⧞",
  ["&eparsl;"]="⧣",
  ["&smeparsl;"]="⧤",
  ["&eqvparsl;"]="⧥",
  ["&lozf;"]="⧫",
  ["&RuleDelayed;"]="⧴",
  ["&dsol;"]="⧶",
  ["&xodot;"]="⨀",
  ["&bigoplus;"]="⨁",
  ["&bigotimes;"]="⨂",
  ["&biguplus;"]="⨄",
  ["&bigsqcup;"]="⨆",
  ["&iiiint;"]="⨌",
  ["&fpartint;"]="⨍",
  ["&cirfnint;"]="⨐",
  ["&awint;"]="⨑",
  ["&rppolint;"]="⨒",
  ["&scpolint;"]="⨓",
  ["&npolint;"]="⨔",
  ["&pointint;"]="⨕",
  ["&quatint;"]="⨖",
  ["&intlarhk;"]="⨗",
  ["&pluscir;"]="⨢",
  ["&plusacir;"]="⨣",
  ["&simplus;"]="⨤",
  ["&plusdu;"]="⨥",
  ["&plussim;"]="⨦",
  ["&plustwo;"]="⨧",
  ["&mcomma;"]="⨩",
  ["&minusdu;"]="⨪",
  ["&loplus;"]="⨭",
  ["&roplus;"]="⨮",
  ["&Cross;"]="⨯",
  ["&timesd;"]="⨰",
  ["&timesbar;"]="⨱",
  ["&smashp;"]="⨳",
  ["&lotimes;"]="⨴",
  ["&rotimes;"]="⨵",
  ["&otimesas;"]="⨶",
  ["&Otimes;"]="⨷",
  ["&odiv;"]="⨸",
  ["&triplus;"]="⨹",
  ["&triminus;"]="⨺",
  ["&tritime;"]="⨻",
  ["&iprod;"]="⨼",
  ["&amalg;"]="⨿",
  ["&capdot;"]="⩀",
  ["&ncup;"]="⩂",
  ["&ncap;"]="⩃",
  ["&capand;"]="⩄",
  ["&cupor;"]="⩅",
  ["&cupcap;"]="⩆",
  ["&capcup;"]="⩇",
  ["&cupbrcap;"]="⩈",
  ["&capbrcup;"]="⩉",
  ["&cupcup;"]="⩊",
  ["&capcap;"]="⩋",
  ["&ccups;"]="⩌",
  ["&ccaps;"]="⩍",
  ["&ccupssm;"]="⩐",
  ["&And;"]="⩓",
  ["&Or;"]="⩔",
  ["&andand;"]="⩕",
  ["&oror;"]="⩖",
  ["&orslope;"]="⩗",
  ["&andslope;"]="⩘",
  ["&andv;"]="⩚",
  ["&orv;"]="⩛",
  ["&andd;"]="⩜",
  ["&ord;"]="⩝",
  ["&wedbar;"]="⩟",
  ["&sdote;"]="⩦",
  ["&simdot;"]="⩪",
  ["&congdot;"]="⩭",
  ["&ncongdot;"]="⩭̸",
  ["&easter;"]="⩮",
  ["&apacir;"]="⩯",
  ["&apE;"]="⩰",
  ["&napE;"]="⩰̸",
  ["&eplus;"]="⩱",
  ["&pluse;"]="⩲",
  ["&Esim;"]="⩳",
  ["&Colone;"]="⩴",
  ["&Equal;"]="⩵",
  ["&ddotseq;"]="⩷",
  ["&equivDD;"]="⩸",
  ["&ltcir;"]="⩹",
  ["&gtcir;"]="⩺",
  ["&ltquest;"]="⩻",
  ["&gtquest;"]="⩼",
  ["&les;"]="⩽",
  ["&nles;"]="⩽̸",
  ["&ges;"]="⩾",
  ["&nges;"]="⩾̸",
  ["&lesdot;"]="⩿",
  ["&gesdot;"]="⪀",
  ["&lesdoto;"]="⪁",
  ["&gesdoto;"]="⪂",
  ["&lesdotor;"]="⪃",
  ["&gesdotol;"]="⪄",
  ["&lap;"]="⪅",
  ["&gap;"]="⪆",
  ["&lne;"]="⪇",
  ["&gne;"]="⪈",
  ["&lnap;"]="⪉",
  ["&gnap;"]="⪊",
  ["&lesseqqgtr;"]="⪋",
  ["&gEl;"]="⪌",
  ["&lsime;"]="⪍",
  ["&gsime;"]="⪎",
  ["&lsimg;"]="⪏",
  ["&gsiml;"]="⪐",
  ["&lgE;"]="⪑",
  ["&glE;"]="⪒",
  ["&lesges;"]="⪓",
  ["&gesles;"]="⪔",
  ["&els;"]="⪕",
  ["&egs;"]="⪖",
  ["&elsdot;"]="⪗",
  ["&egsdot;"]="⪘",
  ["&el;"]="⪙",
  ["&eg;"]="⪚",
  ["&siml;"]="⪝",
  ["&simg;"]="⪞",
  ["&simlE;"]="⪟",
  ["&simgE;"]="⪠",
  ["&LessLess;"]="⪡",
  ["&NotNestedLessLess;"]="⪡̸",
  ["&GreaterGreater;"]="⪢",
  ["&NotNestedGreaterGreater;"]="⪢̸",
  ["&glj;"]="⪤",
  ["&gla;"]="⪥",
  ["&ltcc;"]="⪦",
  ["&gtcc;"]="⪧",
  ["&lescc;"]="⪨",
  ["&gescc;"]="⪩",
  ["&smt;"]="⪪",
  ["&lat;"]="⪫",
  ["&smte;"]="⪬",
  ["&smtes;"]="⪬︀",
  ["&late;"]="⪭",
  ["&lates;"]="⪭︀",
  ["&bumpE;"]="⪮",
  ["&preceq;"]="⪯",
  ["&NotPrecedesEqual;"]="⪯̸",
  ["&SucceedsEqual;"]="⪰",
  ["&NotSucceedsEqual;"]="⪰̸",
  ["&prE;"]="⪳",
  ["&scE;"]="⪴",
  ["&precneqq;"]="⪵",
  ["&scnE;"]="⪶",
  ["&precapprox;"]="⪷",
  ["&succapprox;"]="⪸",
  ["&precnapprox;"]="⪹",
  ["&succnapprox;"]="⪺",
  ["&Pr;"]="⪻",
  ["&Sc;"]="⪼",
  ["&subdot;"]="⪽",
  ["&supdot;"]="⪾",
  ["&subplus;"]="⪿",
  ["&supplus;"]="⫀",
  ["&submult;"]="⫁",
  ["&supmult;"]="⫂",
  ["&subedot;"]="⫃",
  ["&supedot;"]="⫄",
  ["&subE;"]="⫅",
  ["&nsubE;"]="⫅̸",
  ["&supseteqq;"]="⫆",
  ["&nsupseteqq;"]="⫆̸",
  ["&subsim;"]="⫇",
  ["&supsim;"]="⫈",
  ["&subsetneqq;"]="⫋",
  ["&vsubnE;"]="⫋︀",
  ["&supnE;"]="⫌",
  ["&varsupsetneqq;"]="⫌︀",
  ["&csub;"]="⫏",
  ["&csup;"]="⫐",
  ["&csube;"]="⫑",
  ["&csupe;"]="⫒",
  ["&subsup;"]="⫓",
  ["&supsub;"]="⫔",
  ["&subsub;"]="⫕",
  ["&supsup;"]="⫖",
  ["&suphsub;"]="⫗",
  ["&supdsub;"]="⫘",
  ["&forkv;"]="⫙",
  ["&topfork;"]="⫚",
  ["&mlcp;"]="⫛",
  ["&Dashv;"]="⫤",
  ["&Vdashl;"]="⫦",
  ["&Barv;"]="⫧",
  ["&vBar;"]="⫨",
  ["&vBarv;"]="⫩",
  ["&Vbar;"]="⫫",
  ["&Not;"]="⫬",
  ["&bNot;"]="⫭",
  ["&rnmid;"]="⫮",
  ["&cirmid;"]="⫯",
  ["&midcir;"]="⫰",
  ["&topcir;"]="⫱",
  ["&nhpar;"]="⫲",
  ["&parsim;"]="⫳",
  ["&parsl;"]="⫽",
  ["&nparsl;"]="⫽⃥",
  ["&fflig;"]="ﬀ",
  ["&filig;"]="ﬁ",
  ["&fllig;"]="ﬂ",
  ["&ffilig;"]="ﬃ",
  ["&ffllig;"]="ﬄ",
  ["&Ascr;"]="𝒜",
  ["&Cscr;"]="𝒞",
  ["&Dscr;"]="𝒟",
  ["&Gscr;"]="𝒢",
  ["&Jscr;"]="𝒥",
  ["&Kscr;"]="𝒦",
  ["&Nscr;"]="𝒩",
  ["&Oscr;"]="𝒪",
  ["&Pscr;"]="𝒫",
  ["&Qscr;"]="𝒬",
  ["&Sscr;"]="𝒮",
  ["&Tscr;"]="𝒯",
  ["&Uscr;"]="𝒰",
  ["&Vscr;"]="𝒱",
  ["&Wscr;"]="𝒲",
  ["&Xscr;"]="𝒳",
  ["&Yscr;"]="𝒴",
  ["&Zscr;"]="𝒵",
  ["&ascr;"]="𝒶",
  ["&bscr;"]="𝒷",
  ["&cscr;"]="𝒸",
  ["&dscr;"]="𝒹",
  ["&fscr;"]="𝒻",
  ["&hscr;"]="𝒽",
  ["&iscr;"]="𝒾",
  ["&jscr;"]="𝒿",
  ["&kscr;"]="𝓀",
  ["&lscr;"]="𝓁",
  ["&mscr;"]="𝓂",
  ["&nscr;"]="𝓃",
  ["&pscr;"]="𝓅",
  ["&qscr;"]="𝓆",
  ["&rscr;"]="𝓇",
  ["&sscr;"]="𝓈",
  ["&tscr;"]="𝓉",
  ["&uscr;"]="𝓊",
  ["&vscr;"]="𝓋",
  ["&wscr;"]="𝓌",
  ["&xscr;"]="𝓍",
  ["&yscr;"]="𝓎",
  ["&zscr;"]="𝓏",
  ["&Afr;"]="𝔄",
  ["&Bfr;"]="𝔅",
  ["&Dfr;"]="𝔇",
  ["&Efr;"]="𝔈",
  ["&Ffr;"]="𝔉",
  ["&Gfr;"]="𝔊",
  ["&Jfr;"]="𝔍",
  ["&Kfr;"]="𝔎",
  ["&Lfr;"]="𝔏",
  ["&Mfr;"]="𝔐",
  ["&Nfr;"]="𝔑",
  ["&Ofr;"]="𝔒",
  ["&Pfr;"]="𝔓",
  ["&Qfr;"]="𝔔",
  ["&Sfr;"]="𝔖",
  ["&Tfr;"]="𝔗",
  ["&Ufr;"]="𝔘",
  ["&Vfr;"]="𝔙",
  ["&Wfr;"]="𝔚",
  ["&Xfr;"]="𝔛",
  ["&Yfr;"]="𝔜",
  ["&afr;"]="𝔞",
  ["&bfr;"]="𝔟",
  ["&cfr;"]="𝔠",
  ["&dfr;"]="𝔡",
  ["&efr;"]="𝔢",
  ["&ffr;"]="𝔣",
  ["&gfr;"]="𝔤",
  ["&hfr;"]="𝔥",
  ["&ifr;"]="𝔦",
  ["&jfr;"]="𝔧",
  ["&kfr;"]="𝔨",
  ["&lfr;"]="𝔩",
  ["&mfr;"]="𝔪",
  ["&nfr;"]="𝔫",
  ["&ofr;"]="𝔬",
  ["&pfr;"]="𝔭",
  ["&qfr;"]="𝔮",
  ["&rfr;"]="𝔯",
  ["&sfr;"]="𝔰",
  ["&tfr;"]="𝔱",
  ["&ufr;"]="𝔲",
  ["&vfr;"]="𝔳",
  ["&wfr;"]="𝔴",
  ["&xfr;"]="𝔵",
  ["&yfr;"]="𝔶",
  ["&zfr;"]="𝔷",
  ["&Aopf;"]="𝔸",
  ["&Bopf;"]="𝔹",
  ["&Dopf;"]="𝔻",
  ["&Eopf;"]="𝔼",
  ["&Fopf;"]="𝔽",
  ["&Gopf;"]="𝔾",
  ["&Iopf;"]="𝕀",
  ["&Jopf;"]="𝕁",
  ["&Kopf;"]="𝕂",
  ["&Lopf;"]="𝕃",
  ["&Mopf;"]="𝕄",
  ["&Oopf;"]="𝕆",
  ["&Sopf;"]="𝕊",
  ["&Topf;"]="𝕋",
  ["&Uopf;"]="𝕌",
  ["&Vopf;"]="𝕍",
  ["&Wopf;"]="𝕎",
  ["&Xopf;"]="𝕏",
  ["&Yopf;"]="𝕐",
  ["&aopf;"]="𝕒",
  ["&bopf;"]="𝕓",
  ["&copf;"]="𝕔",
  ["&dopf;"]="𝕕",
  ["&eopf;"]="𝕖",
  ["&fopf;"]="𝕗",
  ["&gopf;"]="𝕘",
  ["&hopf;"]="𝕙",
  ["&iopf;"]="𝕚",
  ["&jopf;"]="𝕛",
  ["&kopf;"]="𝕜",
  ["&lopf;"]="𝕝",
  ["&mopf;"]="𝕞",
  ["&nopf;"]="𝕟",
  ["&oopf;"]="𝕠",
  ["&popf;"]="𝕡",
  ["&qopf;"]="𝕢",
  ["&ropf;"]="𝕣",
  ["&sopf;"]="𝕤",
  ["&topf;"]="𝕥",
  ["&uopf;"]="𝕦",
  ["&vopf;"]="𝕧",
  ["&wopf;"]="𝕨",
  ["&xopf;"]="𝕩",
  ["&yopf;"]="𝕪",
  ["&zopf;"]="𝕫",
}
return export
