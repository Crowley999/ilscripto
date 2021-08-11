local php = {}

php.optszh = {
    ["lang"]="zh",
}

php.optsen = {
    ["lang"]="en",
}

php.opts = php.optszh
php.opts["allowEnvFuncs"] = true

php.currentFrames = {{title='',args={},argstr={}}}
php.fc = 1

php.setTTL = function(ttl) return nil end -- comp
php.addWarning = function(text) return nil end -- comp, ok
php.incrementExpensiveFunctionCount = function() return nil end -- comp, ok
php.isSubsting = function() return false end -- comp
php.frameExists = function(frameId)
    if frameId == 'current' then frameId = 'frame' .. php.fc end
    local i = tonumber(frameId:sub(6))
    if math.floor(i) == i and frameId == 'frame' .. i then
        return i > 0 and i <= php.fc
    end
end
php.getExpandedArgument = function(frameId, name)
    if frameId == 'current' then frameId = 'frame' .. php.fc end
    local i = tonumber(frameId:sub(6))
    if math.floor(i) == i and frameId == 'frame' .. i and i > 0 and i <= php.fc then
        return php.currentFrames[i].argstr[name]
    end
end
php.getAllExpandedArguments = function(frameId, name)
    if frameId == 'current' then frameId = 'frame' .. php.fc end
    local i = tonumber(frameId:sub(6))
    if math.floor(i) == i and frameId == 'frame' .. i and i > 0 and i <= php.fc then
        return php.currentFrames[i].args
    end
end
php.newChildFrame = function(frameId, title, args)
    -- if php.fc > 100 then error('newChild: too many frames') end
    local frame = php.currentFrames[php.fc]
    php.fc = php.fc + 1
    if not title then
        title = frame.title
    end
    local argstr = {}
    for k, v in pairs(args) do
        argstr[tostring(k)] = v
    end
    local newFrameId = 'frame' .. php.fc
    php.currentFrames[php.fc] = { title=title, args=args, argstr=argstr }
    return newFrameId
end
php.expandTemplate = function(frameId, title, args) -- comp
    local t = {}
    local n = #args
    local f = function(s)
        s = s:gsub('=', '&#61;')
        s = s:gsub('{', '&#123;')
        s = s:gsub('|', '&#124;')
        s = s:gsub('}', '&#125;')
        return s
    end
    for i = 1, n do
        table.insert(t, '|' .. f(args[i]))
    end
    for k, v in pairs(args) do
        if not (type(k) == 'number' and math.floor(k) == k and k > 0 and k <= n) then
            table.insert(t, '|' .. f(k) .. '=' .. f(v))
        end
    end
    return string.format("{{%s%s}}", title, table.concat(t))
end
php.callParserFunction = function(frameId, name, args) -- comp
    local colonPos = name:find(':')
    if colonPos then
        args = { name:sub(colonPos + 1), unpack(args) }
        name = name:sub(1, colonPos - 1)
    end
    if args[1] == nil then
        error('callParserFunction: At least one unnamed parameter (the parameter that comes after the colon in wikitext) must be provided')
    end
    local arg1 = args[1]
    local t = {}
    local n = #args
    for i = 2, n do
        table.insert(t, '|' .. args[i])
    end
    for k, v in pairs(args) do
        if not (type(k) == 'number' and math.floor(k) == k and k > 0 and k <= n) then
            table.insert(t, '|' .. k .. '=' .. v)
        end
    end
    return string.format("{{%s:%s%s}}", name, arg1, table.concat(t))
end
php.preprocess = function(frameId, text) return text end -- comp
php.getFrameTitle = function(frameId) return mw.title.getCurrentTitle().text end -- comp
-- frameId 为 'empty' 或 'current' 或 'frame' .. 自然数。
-- 不过目前把mw.loadData = require，所以frameId不可能为'empty'

return php

-- inspired by https://github.com/axkr/info.bliki.wikipedia_parser/bliki-core/src/main/java/info/bliki/extensions/scribunto/engine/lua/ScributoLuaEngine.java
