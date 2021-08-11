local php = {}

-- php -r 'var_dump(array_flip(get_html_translation_table(HTML_ENTITIES, ENT_QUOTES | ENT_HTML5, "UTF-8")));'
php.getEntityTable = function() return entitytable end

-- see [https://github.com/wikimedia/mediawiki/blob/master/includes/parser/StripState.php], but we don't have Parser.php, no need to unstrip
php.unstrip = function(s) return s end
php.unstripNoWiki = function(s) return s end
php.killMarkers = function(s) return s end

local jsonlib = require("php.lib.json") -- [http://regex.info/blog/lua/json]
--[=[
mwtext.JSON_PRESERVE_KEYS = 1  -- ignored
mwtext.JSON_TRY_FIXING = 2  -- decode
mwtext.JSON_PRETTY = 4  -- encode
]=]
php.jsonEncode = function(value, flags)
    local t = {}
    if type(flags) ~= 'number' or flags ~= flags then flags = 0 else flags = math.max(0, math.min(7, flags)) end
    if flags >= 4 then flags = flags - 4; t.pretty = true end
    if flags >= 2 then flags = flags - 2 end
    if flags >= 1 then flags = flags - 1; t.JSON_PRESERVE_KEYS = true end
    return jsonlib:encode(value, nil, t)
end

php.jsonDecode = function(json, flags)
    local t = {}
    if type(flags) ~= 'number' or flags ~= flags then flags = 0 else flags = math.max(0, math.min(7, flags)) end
    if flags >= 4 then flags = flags - 4 end
    if flags >= 2 then flags = flags - 2; t.JSON_TRY_FIXING = true end
    if flags >= 1 then flags = flags - 1; t.JSON_PRESERVE_KEYS = true end
    return jsonlib:decode(json, nil, t)
end


php.optszh = {
    ["comma"]="、",  -- MediaWiki:comma-separator
    ["and"]="和",  -- MediaWiki:and + MediaWiki:word-separator
    ["ellipsis"]="…",  -- MediaWiki:ellipsis
    ["nowiki_protocols"]={ ['[Bb][Ii][Tt][Cc][Oo][Ii][Nn]:']='%1&#58;', ['[Gg][Ee][Oo]:']='%1&#58;', ['[Mm][Aa][Gg][Nn][Ee][Tt]:']='%1&#58;', ['[Mm][Aa][Ii][Ll][Tt][Oo]:']='%1&#58;', ['[Nn][Ee][Ww][Ss]:']='%1&#58;', ['[Ss][Ii][Pp]:']='%1&#58;', ['[Ss][Ii][Pp][Ss]:']='%1&#58;', ['[Ss][Mm][Ss]:']='%1&#58;', ['[Tt][Ee][Ll]:']='%1&#58;', ['[Uu][Rr][Nn]:']='%1&#58;', ['[Xx][Mm][Pp][Pp]:']='%1&#58;', },  -- mw:Manual:$wgUrlProtocols
}

php.optsen = {
    ["comma"]=", ",  -- MediaWiki:comma-separator
    ["and"]=" and ",  -- MediaWiki:and + MediaWiki:word-separator
    ["ellipsis"]="...",  -- MediaWiki:ellipsis
    ["nowiki_protocols"]={ ['[Bb][Ii][Tt][Cc][Oo][Ii][Nn]:']='%1&#58;', ['[Gg][Ee][Oo]:']='%1&#58;', ['[Mm][Aa][Gg][Nn][Ee][Tt]:']='%1&#58;', ['[Mm][Aa][Ii][Ll][Tt][Oo]:']='%1&#58;', ['[Nn][Ee][Ww][Ss]:']='%1&#58;', ['[Ss][Ii][Pp]:']='%1&#58;', ['[Ss][Ii][Pp][Ss]:']='%1&#58;', ['[Ss][Mm][Ss]:']='%1&#58;', ['[Tt][Ee][Ll]:']='%1&#58;', ['[Uu][Rr][Nn]:']='%1&#58;', ['[Xx][Mm][Pp][Pp]:']='%1&#58;', },  -- mw:Manual:$wgUrlProtocols
}

local entitytable = mw.phpdata.entitytable

php.opts = php.optszh

return php
