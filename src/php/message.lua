local php = {}

php.optszh = {
    ["lang"]="zh",
}

php.optsen = {
    ["lang"]="en",
}

php.opts = php.optszh

php.check = function(what, data) return false end -- bliki
php.plain = function(data) -- bliki
    local t = {}
    t.useDB = data['useDB'] or false
    t.lang = data['lang'] or php.opts.lang
    t.keys = data['keys'] or {}
    t.params = data['params'] or {}
    t.rawMessage = data['rawMessage'] or ""
    local m = t.rawMessage
    local p = t.params
    for i = #p, 1, -1 do
        local from = '$' .. i
        local to = p[i]
        if type(to) == 'table' then
            to = p['raw'] or p['num'] or 'unknown'
        end
        m = string.gsub(m, from, to)
    end
    return m
end

return php

-- inspired by https://github.com/axkr/info.bliki.wikipedia_parser/bliki-core/src/main/java/info/bliki/extensions/scribunto/engine/lua/interfaces/MwMessage.java
