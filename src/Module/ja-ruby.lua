local export = {}

local function str_hira_to_kata(s)
    return (mw.ustring.gsub(s, '[ぁ-ゖ]', function(m1) return mw.ustring.char(mw.ustring.codepoint(m1) + 96) end))
end
local function str_kata_to_hira(s)
    return (mw.ustring.gsub(s, '[ァ-ヶ]', function(m1) return mw.ustring.char(mw.ustring.codepoint(m1) - 96) end))
end

local function str_ucompare(s1, s2, limit) -- using Wagner–Fischer algorithm
    s1, s2 = mw.text.split(s1, ''), mw.text.split(s2, '')
    local len1, len2 = #s1, #s2
    if limit and len1 * len2 * 20 > limit then return {{s1}, {s2}} end

    local m_cost, m_step = {{0}}, {{}}
    for i = 1, len1 do
        m_cost[i + 1] = {i}
        m_step[i + 1] = {3}
    end
    for j = 1, len2 do
        m_cost[1][j + 1] = j
        m_step[1][j + 1] = 4
    end

    for i = 1, len1 do
        for j = 1, len2 do
            local b_same = s1[i] == s2[j]
            local c_sub = m_cost[i][j] + (b_same and 0 or 1)
            local c_del = m_cost[i][j + 1] + 1
            local c_ins = m_cost[i + 1][j] + 1
            if c_sub <= c_del and c_sub <= c_ins then
                m_cost[i + 1][j + 1] = c_sub
                m_step[i + 1][j + 1] = b_same and 1 or 2
            elseif c_del <= c_ins then
                m_cost[i + 1][j + 1] = c_del
                m_step[i + 1][j + 1] = 3
            else
                m_cost[i + 1][j + 1] = c_ins
                m_step[i + 1][j + 1] = 4
            end
        end
    end

    local i1, i2 = len1 + 1, len2 + 1
    local m_offset = {{-1, -1}, {-1, -1}, {-1, 0}, {0, -1}}
    local r_step_rev = {}
    local r_step_rev_pos1 = {}
    local r_step_rev_pos2 = {}
    local step = m_step[i1][i2]
    while step do
        table.insert(r_step_rev, step)
        i1 = i1 + m_offset[step][1]
        i2 = i2 + m_offset[step][2]
        table.insert(r_step_rev_pos1, i1)
        table.insert(r_step_rev_pos2, i2)
        step = m_step[i1][i2]
    end

    local r1, r2 = {}, {}
    local i = #r_step_rev
    local step = r_step_rev[i]
    while i > 0 do
        local r1_f, r2_f = {}, {}
        if step == 1 then
            repeat
                table.insert(r1_f, s1[r_step_rev_pos1[i]])
                table.insert(r2_f, s2[r_step_rev_pos2[i]])
                i = i - 1
                step = r_step_rev[i]
            until step ~= 1
        else
            while true do
                if step == 2 then
                    table.insert(r1_f, s1[r_step_rev_pos1[i]])
                    table.insert(r2_f, s2[r_step_rev_pos2[i]])
                elseif step == 3 then
                    table.insert(r1_f, s1[r_step_rev_pos1[i]])
                elseif step == 4 then
                    table.insert(r2_f, s2[r_step_rev_pos2[i]])
                else
                    break
                end
                i = i - 1
                step = r_step_rev[i]
            end
        end
        table.insert(r1, table.concat(r1_f))
        table.insert(r2, table.concat(r2_f))
    end
    return {r1, r2}
end

local function str_parse_link(s)
    local t = {}
    local lt
    local i1, i2
    local i_o = 1
    local i_n = s:find('%[%[', i_o)
    while i_n do
        i1, i2 = s:find('%[%[', i_n + 1), s:find('%]%]', i_n + 2)
        if not i2 then break end
        while i1 and i1 < i2 do
            i_n = i1
            i1 = s:find('%[%[', i_n + 1)
        end
        if i_o < i_n then table.insert(t, {
            text = s:sub(i_o, i_n - 1),
        }) end
        if i_n + 2 < i2 then
            lt = s:sub(i_n + 2, i2 - 1)
            i1 = lt:find('|')
            if i1 and i1 > 1 and i1 < lt:len() then
                table.insert(t, {
                    text = lt:sub(i1 + 1),
                    linkto = lt:sub(1, i1 - 1),
                })
            else
                table.insert(t, {
                    text = lt,
                    linkto = lt,
                })
            end
        end
        i_o = i2 + 2
        i_n = s:find('%[%[', i_o)
    end
    if i_o <= #s then table.insert(t, {
        text = s:sub(i_o),
    }) end
    return t
end

local function table_merge(link_table, ruby_table)
    local r = {}
    local r_sub, r_insert
    local len_cut
    local id_l, id_r = 1, 1
    local nn = false
    while id_l <= #link_table and id_r <= #ruby_table do
        len_cut = link_table[id_l].text:len() - ruby_table[id_r].text:len()
        if ruby_table[id_r].ruby and (ruby_table[id_r].ruby:find'%[%[..-%]%]' or len_cut < 0) then
            if ruby_table[id_r].ruby then
                r_sub = {
                    text = {},
                    ruby = str_parse_link(ruby_table[id_r].ruby),
                }
                r_insert = r_sub.text
                table.insert(r, r_sub)
            else
                r_insert = r
            end
            while len_cut < 0 do
                table.insert(r_insert, {
                    text = link_table[id_l].text,
                    linkto = link_table[id_l].linkto
                })
                id_l = id_l + 1
                len_cut = len_cut + link_table[id_l].text:len()
            end
            table.insert(r_insert, {
                text = link_table[id_l].text:sub(1, -1 - len_cut),
                linkto = link_table[id_l].linkto
            })
            if len_cut == 0 then
                id_l = id_l + 1
                id_r = id_r + 1
            else
                link_table[id_l].text = link_table[id_l].text:sub(-len_cut)
                id_r = id_r + 1
            end
        else
            if link_table[id_l].linkto then
                r_sub = {
                    text = {},
                    linkto = link_table[id_l].linkto,
                }
                r_insert = r_sub.text
                table.insert(r, r_sub)
            else
                r_insert = r
            end
            while len_cut > 0 and not (ruby_table[id_r].ruby and ruby_table[id_r].ruby:find'%[%[..-%]%]') do
                table.insert(r_insert, {
                    text = ruby_table[id_r].text,
                    ruby = ruby_table[id_r].ruby,
                })
                id_r = id_r + 1
                len_cut = len_cut - ruby_table[id_r].text:len()
            end
            if len_cut == 0 then
                table.insert(r_insert, {
                    text = ruby_table[id_r].text,
                    ruby = ruby_table[id_r].ruby,
                })
                id_l = id_l + 1
                id_r = id_r + 1
            else
                if ruby_table[id_r].ruby then
                    link_table[id_l].text = link_table[id_l].text:sub(-(len_cut + ruby_table[id_r].text:len()))
                else
                    table.insert(r_insert, {
                        text = ruby_table[id_r].text:sub(1, -1 + len_cut),
                    })
                    ruby_table[id_r].text = ruby_table[id_r].text:sub(len_cut)
                    id_l = id_l + 1
                end
            end
        end
    end
    return r
end

function export.len_text(ruby_table)
    local r = 0
    for _, v in ipairs(ruby_table) do
        v = v.text
        r = r + (type(v) == 'string' and mw.ustring.len(v) or export.len_text(v))
    end
    return r
end

function export.len_ruby(ruby_table)
    local r = 0
    for _, v in ipairs(ruby_table) do
        v = v.ruby or v.text
        r = r + (type(v) == 'string' and mw.ustring.len(v) or export.len_ruby(v))
    end
    return r
end

function export.to_text(ruby_table)
    local r = {}
    local v_text
    for _, v in ipairs(ruby_table) do
        v_text = v.text
        if type(v_text) == 'string' then
            table.insert(r, v_text)
        else
            table.insert(r, export.to_text(v_text))
        end
    end
    return table.concat(r)
end

function export.to_ruby(ruby_table)
    local r = {}
    local v_text
    for _, v in ipairs(ruby_table) do
        v_text = v.ruby or v.text
        if type(v_text) == 'string' then
            table.insert(r, v_text)
        else
            table.insert(r, export.to_ruby(v_text))
        end
    end
    return table.concat(r)
end

local function table_to_markup(ruby_table, break_link, lb, lm, lf, rb, rm, rf)
    local text = {}
    local v_text, v_ruby, v_linkto
    for _, v in ipairs(ruby_table) do
        v_linkto, v_ruby = v.linkto, v.ruby
        if type(v.text) ~= 'string' then
            if break_link and v_linkto then
                v_text = {}
                for _, vv in ipairs(v.text) do
                    if vv.text ~= '' or vv.ruby and vv.ruby ~= '' then
                        table.insert(v_text, {
                            text = {{
                                text = vv.text,
                                linkto = v_linkto,
                            }},
                            ruby = vv.ruby,
                        })
                    end
                end
                v_linkto, v_ruby = nil, nil
                v_text = table_to_markup(v_text, break_link, lb, lm, lf, rb, rm, rf)
            else
                v_text = table_to_markup(v.text, break_link, lb, lm, lf, rb, rm, rf)
            end
        else
            v_text = v.text
        end
        if v_linkto then
            if v_linkto ~= '' then table.insert(text, lb .. v_linkto .. lm .. (v_text ~= '' and v_text or '_') .. lf)
            else table.insert(text, v_text) end
        elseif v_ruby then
            if type(v_ruby) ~= 'string' then v_ruby = table_to_markup(v_ruby, break_link, lb, lm, lf, rb, rm, rf) end
            if v_ruby ~= '' then table.insert(text, rb .. v_text .. rm .. v_ruby .. rf)
            else table.insert(text, v_text) end
        else
            table.insert(text, v_text)
        end
    end
    return table.concat(text)
end

-- "options.markup": Use custom markups. See below.
-- "options.break_link = true": Change [[...|<ruby>...<ruby>]] to <ruby>[[...]]<ruby>.
function export.to_markup(ruby_table, options)
    options = options or {}
    omarkup = options.markup or {}

    return table_to_markup(
        ruby_table,
        options.break_link,
        omarkup.link_border_left or '[[',
        omarkup.link_border_middle or '|',
        omarkup.link_border_right or ']]',
        omarkup.ruby_border_left or '[',
        omarkup.ruby_border_middle or '](',
        omarkup.ruby_border_right or ')')
end

-- The options are the same as "function export.to_markup"
function export.to_wiki(ruby_table, options)
    options = options or {}
    omarkup = options.markup or {}

    return table_to_markup(
        ruby_table,
        options.break_link,
        omarkup.link_border_left or '[[',
        omarkup.link_border_middle or '|',
        omarkup.link_border_right or ']]',
        omarkup.ruby_border_left or '<ruby>',
        omarkup.ruby_border_middle or '<rp>(</rp><rt>',
        omarkup.ruby_border_right or '</rt><rp>)</rp></ruby>')
end

function export.parse_markup(markup)
    local ruby = {}
    local link_table = str_parse_link(markup:gsub('(%b[])(%b())', function(m1, m2)
        table.insert(ruby, m2:sub(2, -2))
        return m1:sub(2, -2)
    end))

    local plain_text = export.to_text(str_parse_link(markup))
    local ruby_table = {}
    local p0 = 1
    local ruby_n = 1
    local s_text, s_ruby
    plain_text:gsub('()(%b[])(%b())()', function(p1, m1, m2, p2)
        if p0 < p1 then
            s_text = plain_text:sub(p0, p1 - 1)
            table.insert(ruby_table, {text = s_text})
        end
        if #m1 > 2 then
            s_text = m1:sub(2, -2)
            s_ruby = ruby[ruby_n]
            table.insert(ruby_table, {
                text = s_text,
                ruby = s_ruby ~= '' and s_ruby or nil,
            })
        end
        p0 = p2
        ruby_n = ruby_n + 1
    end)
    if p0 <= #plain_text then
        s_text = plain_text:sub(p0)
        table.insert(ruby_table, {text = s_text})
    end

    return table_merge(link_table, ruby_table)
end

-- "options.try == nil": Lauch an error when the initial match failed.
-- "options.try == 'return'": Return "nil, (error information)" when the initial match failed.
-- "options.try == 'force'": Try every possible pattern when the initial match failed.
-- "options.try_force_limit": Limit the time used by "options.try == 'force'".
-- "options.space == nil": Remove spaces between kana or kanji but preserve elsewhere.
-- "options.space == 'all'": Preserve all spaces.
-- "options.space == 'none'": Remove all spaces.
-- "options.allow_ruby_link == true": Try to match the links in the rubies.
function export.parse_text(term, kana, options)
	options = options or {}

	local pat_kana = 'ぁ-ゖァ-ヶー' -- signs subject to hira-kata matching
	local pat_kanji_probable = '々一-鿿㐀-䶿𠀀-𮯯𰀀-𱍏﨎﨏﨑﨓﨔﨟﨡﨣﨤﨧﨨﨩０-９Ａ-Ｚａ-ｚ〆〇' -- signs that can have ruby, but not spaces
	local pat_rubiable_probable = '0-9a-zA-Zα-ωΑ-Ω' -- signs that can have both ruby and spaces
	local pat_mute_probable = '%^%-%.゠・' -- signs that may appear in term, but not kana

    local _remove_space
    if options.space == 'none' then
        _remove_space = function(_r)
            local function _next(p1, p2)
                if p2 and p2 < #_r[p1].text then
                    return p1, p2 + 1
                end
                p1 = p1 + 1
                if p1 > #_r then
                    p2 = nil
                else
                    p2 = type(_r[p1].text) ~= 'string' and 1 or nil
                end
                return p1, p2
            end
            local pos1, pos2 = _next(0, nil)
            while pos1 <= #_r do
                _t = pos2 and _r[pos1].text[pos2] or _r[pos1]
                _t.text = _t.text:gsub(' ', '')
                if _t.linkto then _t.linkto = _remove_space({{text = _t.linkto}})[1].text end
                if _t.ruby then _t.ruby = _remove_space({{text = _t.ruby}})[1].text end
                if pos2 then
                    if _r[pos1].linkto then _r[pos1].linkto = _remove_space({{text = _r[pos1].linkto}})[1].text end
                    if _r[pos1].ruby then _r[pos1].ruby = _remove_space({{text = _r[pos1].ruby}})[1].text end
                end
                pos1, pos2 = _next(pos1, pos2)
            end
            return _r
        end
    elseif options.space == 'all' then
        _remove_space = function(_r)
            return _r
        end
    else
        _remove_space = function(_r, context_ak, context_bk)
            local function _next(p1, p2)
                if p2 and p2 < #_r[p1].text then
                    return p1, p2 + 1
                end
                p1 = p1 + 1
                if p1 > #_r then
                    p2 = nil
                else
                    p2 = type(_r[p1].text) ~= 'string' and 1 or nil
                end
                return p1, p2
            end
            local pos1, pos2 = _next(0, nil)
            local pos3, pos4 = pos1, pos2
            local after_k = context_ak
            local before_k
            local _t, char
            while pos1 <= #_r do
                if pos3 == pos1 and (pos4 == pos2 or pos4 < pos2) or pos3 < pos1 then
                    before_k = context_bk
                    pos3, pos4 = _next(pos1, pos2)
                    while pos3 <= #_r do
                        _t = pos4 and _r[pos3].text[pos4] or _r[pos3]
                        char = mw.ustring.find(_t.text, '[^ \']')
                        if char then
                            char = mw.ustring.sub(_t.text, char, char)
                            before_k = mw.ustring.find(char, '^['..pat_kanji_probable..pat_kana..']$')
                            break
                        end
                        pos3, pos4 = _next(pos3, pos4)
                    end
                end

                _t = pos2 and _r[pos1].text[pos2] or _r[pos1]
                if _t.linkto then _t.linkto = _remove_space({{text = _t.linkto}}, after_k, before_k)[1].text end
                if _t.ruby then _t.ruby = _remove_space({{text = _t.ruby}}, after_k, before_k)[1].text end
                if pos2 then
                    if _r[pos1].linkto then _r[pos1].linkto = _remove_space({{text = _r[pos1].linkto}}, after_k, before_k)[1].text end
                    if _r[pos1].ruby then _r[pos1].ruby = _remove_space({{text = _r[pos1].ruby}}, after_k, before_k)[1].text end
                end

                local seg = {}
                local i0 = 1
                for i1, m1, i2 in mw.ustring.gmatch(_t.text, '()(['..pat_kanji_probable..pat_kana..']+)()') do
                    if after_k and not mw.ustring.sub(_t.text, i0, i1 - 1):find'[^ \']' then
                        table.insert(seg, (mw.ustring.sub(_t.text, i0, i1 - 1):gsub(' ', '')))
                    else
                        table.insert(seg, mw.ustring.sub(_t.text, i0, i1 - 1))
                    end
                    table.insert(seg, m1)
                    after_k = true
                    i0 = i2
                end
                after_k = after_k and not mw.ustring.sub(_t.text, i0):find'[^ \']'
                if after_k and before_k then
                    table.insert(seg, (mw.ustring.sub(_t.text, i0):gsub(' ', '')))
                else
                    table.insert(seg, mw.ustring.sub(_t.text, i0))
                end
                _t.text = table.concat(seg)

                pos1, pos2 = _next(pos1, pos2)
            end
            return _r
        end
    end

	-- Create the link table
	-- e.g. "[[エドガー・アラン・ポー|アラン・ポー]]の[[推理 小説]]"
	local link_table = str_parse_link(term:gsub('%%', '')) -- remove '%'
	--[[link_table = {
        {text = 'アラン・ポー', linkto = 'エドガー・アラン・ポー'},
        {text = 'の'},
        {text = '推理 小説', linkto = '推理 小説'},
    }]]

	-- Remove romaji markup
	kana = kana:gsub('[%^%-%.]', '') -- remove '^', '-', '.', preserve '%', ' '

    -- Create the ruby table
	-- e.g. 'アラン・ポーの推理 小説', 'あらん ぽー の すいり しょうせつ'
	-- ("ぽお" is not allowed)
	local ruby_table = {}
    local plain_term_raw = export.to_text(str_parse_link(term)) -- Remove links: [[A|B]] -> B, [[C]] -> C
    local plain_kana_raw = options.allow_ruby_link and kana or export.to_text(str_parse_link(kana))
	local plain_term = mw.text.split(plain_term_raw, '%%')
	local plain_kana = mw.text.split(plain_kana_raw, '%%')
    if #plain_term ~= #plain_kana then
        mw.logObject(plain_term)
        mw.logObject(plain_kana)
        error('Separator "%" in the kanji and kana strings do not match.')
    end
    for i, plain_term_i in ipairs(plain_term) do
        if plain_term ~= '' or plain_kana[i] ~= '' then
            local pattern_ruby, pattern_ruby_is_ruby = {}, {}
            local function _func_pat(s_sub)
                local in_xml_tag = false
                table.insert(pattern_ruby, '(' .. mw.ustring.gsub(s_sub, '.', function(m0)
                    if in_xml_tag then
                        if m0 == '>' then in_xml_tag = false end
                        return ''
                    else
                        if m0 == '<' then
                            in_xml_tag = true
                            return ' ?<.->'
                        else
                            local m0_m = m0
                            if m0:find'^[%(%)%.%%%+%-%*%?%[%]%^%$]$' then m0_m = '%' .. m0_m end
                            if mw.ustring.find(m0, '^['..pat_mute_probable..']$') then m0_m = '[' .. m0_m .. ' -]?'
                            elseif mw.ustring.find(m0, '^[ヶゖケ]$') then
                                m0_m = "[" .. str_kata_to_hira(m0_m) .. str_hira_to_kata(m0_m) .. "かがこカガコ]"
                            elseif mw.ustring.find(m0, '^['..pat_kana..']$') then
                                m0_m = "[" .. str_kata_to_hira(m0_m) .. str_hira_to_kata(m0_m) .. "]"
                            end
                            return ' ?' .. m0_m
                        end
                    end
                end) .. ' ?)')
            end
            local plain_term_noxml = plain_term_i:gsub('%b<>', '<>')
            local pos0 = 1
            for pos1, pos2 in mw.ustring.gmatch(plain_term_noxml, '()['..pat_kanji_probable..pat_rubiable_probable..']+()') do
                if pos0 < pos1 then _func_pat(mw.ustring.sub(plain_term_noxml, pos0, pos1 - 1)) end
                if not pattern_ruby_is_ruby[#pattern_ruby] then
                    table.insert(pattern_ruby, '(..-)')
                    pattern_ruby_is_ruby[#pattern_ruby] = true
                end
                pos0 = pos2
            end
            plain_term_noxml = mw.ustring.sub(plain_term_noxml, pos0)
            if #pattern_ruby == 0 and not mw.ustring.find(plain_term_noxml, '['..pat_kana..']') then
                -- if a "non-rubiable" and "non-kana" string is isolated by %, it matches anything.
                table.insert(pattern_ruby, '(.-)')
                pattern_ruby_is_ruby[#pattern_ruby] = true
            else
                if #plain_term_noxml > 0 then _func_pat(plain_term_noxml) end
            end
            local pat_ruby_s = table.concat(pattern_ruby)
            -- 'アラン・ポーの推理 小説' to '( ?[あア] ?[らラ] ?[んン] ?[・ -]? ?[ぽポ] ?ー ?[のノ] ?)(..-)( )(..-)'
            -- Excute matching
            local ruby_table_i_ruby = {mw.ustring.match(plain_kana[i], '^'..pat_ruby_s..'$')}
            if #ruby_table_i_ruby > 0 then
                local ruby_table_i_text = {mw.ustring.match(plain_term_i, '^'..pat_ruby_s..'$')}
                for n_match = 1, #pattern_ruby do
                    if pattern_ruby_is_ruby[n_match] and ruby_table_i_text[n_match] ~= ruby_table_i_ruby[n_match] then
                        table.insert(ruby_table, {
                            text = ruby_table_i_text[n_match],
                            ruby = ruby_table_i_ruby[n_match],
                        })
                    else
                        if #ruby_table > 0 and ruby_table[#ruby_table].ruby == nil then
                            ruby_table[#ruby_table].text = ruby_table[#ruby_table].text .. ruby_table_i_text[n_match]
                        else
                            table.insert(ruby_table, {text = ruby_table_i_text[n_match]})
                        end
                    end
                end
            elseif options.try == 'force' then
                require('Module:debug').track('ja-ruby/forced match')
                local forced_result = str_ucompare(plain_term_i, plain_kana[i], options.try_force_limit)
                for ii, vv in ipairs(forced_result[1]) do
                    table.insert(ruby_table, {
                        text = vv,
                        ruby = forced_result[2][ii] ~= vv and forced_result[2][ii] or nil,
                    })
                end
            elseif options.try == 'return' then
                return nil, 'Can not match "' .. plain_term_i .. '" and "' .. plain_kana[i] .. '".'
            else
                mw.log(pat_ruby_s)
                error('Can not match "' .. plain_term_i .. '" and "' .. plain_kana[i] .. '"')
            end
        end
    end
	--[[ruby_table = {
        {text = 'アラン・ポーの'},
        {text = '推理', ruby = 'すいり'},
        {text = ' '}
        {text = '小説', ruby = 'しょうせつ'},
    }]]

    return _remove_space(table_merge(link_table, ruby_table))
	-- Merge the ruby and link table
    --[[return {
        {text = 'アラン・ポー', linkto = 'エドガー・アラン・ポー'},
        {text = 'の'},
        {text = {
            {text = '推理', ruby = 'すいり'},
            {text = ''}
            {text = '小説', ruby = 'しょうせつ'},
        }, linkto = '推理小説'},
    }]]
end

-- shortcut
function export.ruby_auto(args)
    local to_target
    if args.target == 'text' then
        to_target = export.to_text
    elseif args.target == 'ruby' then
        to_target = export.to_ruby
    elseif args.target == 'markup' then
        to_target = export.to_markup
    else
        to_target = export.to_wiki
    end

    if args.term and args.kana then
        local result, err = export.parse_text(args.term, args.kana, args.options)
        if result then
            return to_target(result, args.options)
        else
            return result, err
        end
    elseif args.markup then
        return to_target(export.parse_markup(args.markup, args.options), args.options)
    else
        error('Cannot find "term" and "kana" or "markup"')
    end
end

return export