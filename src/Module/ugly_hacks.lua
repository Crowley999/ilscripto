local export = {}

function export.explode(frame)
	local wanted_index = tonumber(frame.args[3])
 
	local count = 1
	for item in mw.text.gsplit(frame.args[1], frame.args[2], true) do
		if count == wanted_index then
			return item
		end
		count = count + 1	
	end
	
	return ""
end

function export.substr(frame)
	return mw.ustring.sub(frame.args[1] or "", tonumber(frame.args[2]) or 1, tonumber(frame.args[3]) or -1)
end

function export.find(frame)
	return mw.ustring.find(frame.args[1] or "", frame.args[2] or "", 1, true) or ""
end

function export.find_pattern(frame)
	return mw.ustring.find(frame.args[1] or "", frame.args[2] or "", 1, false) or ""
end

function export.replace(frame)
	return (mw.ustring.gsub(frame.args[1] or "", frame.args[2] or "", frame.args[3] or ""))
end

function export.match(frame)
	return (mw.ustring.match(frame.args[1] or "", frame.args[2] or ""))
end

function export.escape_wiki(frame)
	return mw.text.nowiki(frame.args[1] or "")
end

function export.escape_html(frame)
	return mw.text.encode(frame.args[1] or "")
end

function export.zeropad(frame)
	if #frame.args[1] >= tonumber(frame.args[2]) then
		return frame.args[1]	
	else
		return mw.ustring.sub(string.rep("0", frame.args[2]) .. (frame.args[1] or ""), -frame.args[2])
	end
end

function export.is_valid_page_name(frame)
	local res = mw.title.new(frame.args[1])
	if res then
		return "valid"
	else
		return ""
	end
end

return setmetatable({ }, {
	__index = function(self, key)
		local m_debug = require('Module:debug')
		local frame = mw.getCurrentFrame()
		local pframe = frame:getParent()
		local tname = pframe and pframe:getTitle()

		m_debug.track('ugly hacks/' .. key)
		if pframe then
			m_debug.track('ugly hacks/' .. key .. '/from ' .. tname)
		else
			mw.log(debug.traceback('ugly hacks: parent frame not available'))
		end
		return export[key]	
	end
})