local php = {}

local function wikiencode( s )
	local ret = string.gsub( s, '([^a-zA-Z0-9!$()*,./:;@~_-])', function ( c )
		if c == ' ' then
			return '_'
		else
			return string.format( '%%%02X', string.byte( c, 1, 1 ) )
		end
	end );
	return ret
end
php.opts = {
    server = mw.site.server,
    canonical = mw.site.server:gsub('^//', 'https://'),
    defaultUrl = string.format("https:%s/wiki/%s", mw.site.server, wikiencode(mw.title.getCurrentTitle().prefixedText)),  --mw.title.getCurrentTitle():canonicalText会循环引用
    --defaultUrl=string.format("https:%s/wiki/%s", mw.site.server, 'Module:User:Qnm'),  --此workaround没有urlencode
}

-- see also https://doc.wikimedia.org/mediawiki-core/master/php/classCoreParserFunctions.html
-- see also https://stackoverflow.com/questions/15128485/mediawiki-api-section-names-encoding
-- 准确实现为CoreParserFunctions.php的anchorencode及Parser.php的guessSectionNameFromWikiText
php.anchorEncode = function(s)
    return mw.uri.encode(s, 'QUERY'):gsub('+', '_'):gsub('%', '.')
end

--[=[
    由于并没有用/w/，当query为'&'时，formatquery(query)为'?&'，php.localUrl为/wiki/User:Qnm?&，mw.uri.localUrl为/wiki/User:Qnm?，但mediawiki实际输出为/w/index.php?title=User%3AQnm&，两者是兼容的。
]=]
local formatquery = function(query)
    if query == nil or query == '' or type(query) == 'table' and next(query) == nil then
        return ''
    elseif type(query) == 'table' then
        local t = {}
        for k, v in pairs(query) do
            if v then -- exclude nil
                table.insert(t, string.format("%s=%s", mw.uri.encode(tostring(k), 'QUERY'), mw.uri.encode(tostring(v), 'QUERY')))
            end
        end
        if next(t) == nil then return '' end
        return '?' .. table.concat(t, '&')
    elseif type(query) == 'string' then
        query = query:gsub('%%(%x%x)', function (hex) return string.char(tonumber(hex, 16)) end)
        local t = {}
        local e = false
        for s, sym in query:gmatch('([^=&]*)([=&]?)') do
            table.insert(t, mw.uri.encode(s, 'QUERY'))
            if sym == '&' then 
                e = false
            elseif sym == '=' then
                sym = e and '%3D' or sym
                e = true
            end
            table.insert(t, sym)
        end
        return '?' .. table.concat(t)
    else
        return ''
    end
end

php.localUrl = function(page, query)
    return '/wiki/' .. page .. formatquery(query)
end

php.fullUrl = function(page, query)
    return php.opts.server .. '/wiki/' .. page .. formatquery(query)
end

php.canonicalUrl = function(page, query)
    return php.opts.canonical .. '/wiki/' .. page .. formatquery(query)
end

return php
