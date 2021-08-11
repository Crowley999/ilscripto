local export = {}
-- [[Module:ja-ruby]]

function export.show(frame)
	local args = frame:getParent().args
	local first_param = args[1] or error("Example has not been specified. Please pass parameter 1 to the module invocation.")
	local kana = args[2] ~= '' and args[2] or first_param
	-- if user only specified one param, assume first param is only kana (no kanji)
	return ('<span lang="ja" class="Jpan">%s</span>'):format(require('Module:ja-ruby').ruby_auto{
		term = first_param,
		kana = kana,
	})
end

return export