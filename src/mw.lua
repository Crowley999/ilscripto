unpack = unpack or table.unpack

package.searchers[#package.searchers + 1] = function(mod)
    mod, cnt = mod:gsub(' ', '_'):gsub('Module:', 'Module.') -- '_' is recognized by scribunto, so we use '_' as default
    return cnt > 0 and package.searchers[2](mod) or nil
end

function table.maxn( table ) -- [[mw:Extension:Scribunto/Lua_reference_manual#table.maxn]], for mw.message
    local maxn, k = 0, nil
    repeat
        k = next( table, k )
        if type( k ) == 'number' and k > maxn then
            maxn = k
        end
    until not k
    return maxn
end

mw = {["phpdata"] = require("php.data")}
require("mw.mwInit")
mw_interface = require("php.mw")
mw = require("mw.mw")
mw.setupInterface(mw_interface.opts)
mw.loadData = require
-- put mw.language before mw.ustring to avoid modifying mw.language
mw_interface = require("php.language")
require("mw.language").setupInterface(mw_interface.opts)
mw.ustring = require("ustring/ustring")
mw_interface = require("php.html")
require("mw.html").setupInterface(mw_interface.opts)
mw_interface = require("php.site")
require("mw.site").setupInterface(mw_interface.opts)
mw_interface = require("php.text")
require("mw.text").setupInterface(mw_interface.opts)
mw_interface = require("php.title")
require("mw.title").setupInterface(mw_interface.opts)
mw.title.setCurrent = function( text_or_id, defaultNamespace )
    local thisTitleObject = mw.title.new(text_or_id, defaultNamespace)
    if thisTitleObject then
        mw.title.getCurrentTitle = function() return thisTitleObject end
    else
        error("mw.title.setCurrent: invalid params")
    end
end
mw_interface = require("php.uri")
require("mw.uri").setupInterface(mw_interface.opts)
mw_interface = require("php.message")
require("mw.message").setupInterface(mw_interface.opts)
mw_interface = require("php.hash")
require("mw.hash").setupInterface(mw_interface.opts)

dmp = function(value, name) local dump = require("Module:dump"); print(dump._dump(value, name, nil, true)) end
