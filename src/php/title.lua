local php = {}

local text = "あい" --"User:Qnm"
local ns = 0 --828
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

-- see also https://github.com/axkr/info.bliki.wikipedia_parser/blob/master/bliki-core/src/main/java/info/bliki/extensions/scribunto/engine/lua/interfaces/MwTitle.java
-- or https://bitbucket.org/axelclk/info.bliki.wiki/src/master/bliki-core/src/main/java/info/bliki/extensions/scribunto/engine/lua/interfaces/MwTitle.java
local thisTitle = {
    isCurrentTitle = true,
    interwiki = "",
    namespace = ns, -- 829
    text = text,
    nsText = mw.site.namespaces[ns].name:gsub(' ', '_'), -- "Module_talk"
    thePartialUrl = wikiencode(text), --mw.uri.encode(text, "WIKI"), 避免循环引用
    fragment = ""
}

php.getUrl = function(fullText, method, query, proto)
    if method == 'localUrl' then
        return mw.uri.localUrl(fullText, query)
    elseif method == 'canonicalUrl' then
        return mw.uri.canonicalUrl(fullText, query)
    else  -- 'fullUrl'   proto: "http", "https", "relative" (the default), or "canonical"
        local t = { http='http:', https='https:', relative='', canonical='https:' }
        return t[proto] .. mw.uri.fullUrl(fullText, query)
    end
end

php.optszh = {
    ["NS_MEDIA"]=-2,
    ["thisTitle"]=thisTitle
}

php.optsen = {
    ["NS_MEDIA"]=-2,
    ["thisTitle"]=thisTitle
}

php.opts = php.optszh

php.getExpensiveData = function(titleFullText) return {} end
--php.getContent( self.fullText )
php.recordVaryFlag = function(titleFullText, flag)
    if flag ~= 'vary-page-id' then
        return nil
    end
    return nil
end
php.getFileInfo = function(titlePrefixedText) return nil end
php.protectionLevels = function(titlePrefixedText) return {} end
php.cascadingProtection = function(titlePrefixedText) return { restriction={} } end
php.redirectTarget = function(titlePrefixedText) return nil end


local isValidTitle = function(title, defaultNamespace) return true end
local title = function(ns, title, fragment, interwiki)
    ns = ns or ""
    title = title or ""
    fragment = fragment or ""
    interwiki = interwiki or ""
    local t = {}
    t.isLocal = ""
    t.isRedirect = ""
    t.subjectNsText = ""
    t.interwiki = interwiki
    t.namespace = 0 
    t.nsText = ns
    t.text = title
    t.id = title
    t.fragment = fragment
    t.contentModel = "wikitext" -- not bliki
    t.thePartialUrl = ""
    return t
end

php.makeTitle = function(ns, title, fragment, interwiki) 
    if isValidTitle(title, ns) then
        return title(ns, title, fragment, interwiki)
    else
        return nil
    end
end

php.newTitle = function(text_or_id, defaultNamespace)
    if type(text_or_id) == 'number' then
        return {} -- no database lookup
    elseif isValidTitle(text_or_id, defaultNamespace) then
        return title(defaultNamespace, text_or_id, nil, nil)
    else
        return nil
    end
end

php.getContent = function(titleFullText)
    local file = io.open('page/' .. titleFullText:gsub(' ', '_') .. '.wiki', "r")
    if not file then file = io.open('page/' .. titleFullText .. '.wiki', "r") end
    if not file then print(file .. " not found") return nil end
    local content = file:read "*a" -- *a or *all reads the whole file
    file:close()
    return content
end

return php
-- inspired by https://github.com/axkr/info.bliki.wikipedia_parser/bliki-core/src/main/java/info/bliki/extensions/scribunto/engine/lua/interfaces/MwTitle.java
