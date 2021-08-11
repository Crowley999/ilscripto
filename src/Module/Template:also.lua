local export = {}

local yesno = require('Module:yesno')

local get_script

-- If there are characters in both scripts (the key and value), the second
-- should be used.
local overridden_by = {
	Latn = "Latinx",
	Grek = "polytonic",
	Cyrl = "Cyrs",
}

-- Join with serial "and" and serial comma
local function serial_comma_join(seq, conjunction)
	conjunction = conjunction or ","
	if #seq == 0 then
		return ""
	elseif #seq == 1 then
		return seq[1] -- nothing to join
	elseif #seq == 2 then
		return seq[1] .. " ''and'' " .. seq[2]
	else
		return table.concat(seq, conjunction .. " ", 1, #seq - 1)
			.. "<span class='serial-comma'>" .. conjunction .. "</span>" ..
			"''<span class='serial-and'> and</span>'' " ..
			seq[#seq]
	end
end

function export.main(frame)
	local args			= frame:getParent().args
	
	local sc_default	= args["sc"]
	local nosc			= yesno(args["nosc"])
	if nosc then
		require("Module:debug").track("also/nosc param")
		if sc_default then
			error("|nosc= and |sc= are mutually contradictory. Specify one or the other.")
		else
			-- Turn off script by setting default script to None.
			sc_default = "None"
		end
	end
	
	if sc_default then
		-- [[Special:WhatLinksHere/Template:tracking/also/sc param]]
		require("Module:debug").track("also/sc param")
	end
	
	local uni_default = yesno((args["uni"] == "auto") or args["uni"]) and "auto" or nil
	
	local title = mw.title.getCurrentTitle()
	local full_pagename = title.fullText
	-- Disables tagging outside of mainspace, where {{also}} more often links to
	-- pages that are not entries and don't need tagging. Tagging in Reconstruction
	-- would be more complicated and is often unnecessary, and there are very few
	-- entries in Appendix.
	local detect_sc = title.nsText == ""
		or args["detectsc"] -- to test the script detection capabilities
	
	local items = {}
	local use_semicolon = false
	
	for i, arg in ipairs(args) do
		local uni = args["uni" .. i] or uni_default
		local sc = args["sc" .. i] or sc_default
		
		if arg:find(",", 1, true) then
			use_semicolon = true
		end
		
		if not yesno(uni, uni) then
			uni = nil
		end
		
		local s
		local link_text = arg:match("%[%[[^%[%]|]+|(.+)]]") or arg:match("%[%[([^%[%]|]+)]]")
		
		if link_text then
			s = arg
			arg = mw.text.decode(link_text)
		else
			s = "[[" .. arg .. "]]"
			arg = mw.text.decode(arg)
		end
		
		local codepoint
		
		if uni then
			require("Module:debug").track("also/uni")
			
			if uni == 'auto' then
				codepoint = (mw.ustring.len(arg) == 1) and mw.ustring.codepoint(arg, 1, 1)
			else
				codepoint = tonumber(uni)
				
				if mw.ustring.len(arg) ~= 1 or codepoint ~= mw.ustring.codepoint(arg, 1, 1) then
					require("Module:debug").track("also/uni/noauto")
				else
					require("Module:debug").track("also/uni/auto")
				end
			end
		end
		
		-- If all characters are in one script, tag the link with it.
		-- Ignore all "None"-script characters.
		local rtl
		if detect_sc and not sc then
			-- leading bytes for non-Latin scripts (that is, codepoints between U+340 and U+10FFFF)
			if arg:find("[\200-\244]") then
				get_script = get_script or require("Module:scripts").charToScript
				local curr_sc
				for codepoint in mw.ustring.gcodepoint(arg) do
					curr_sc = get_script(codepoint)
					if curr_sc ~= "None" then
						if sc == nil then
							sc = curr_sc
						elseif curr_sc ~= sc then
							-- For instance, Grek -> polytonic.
							if overridden_by[sc] == curr_sc then
								sc = curr_sc
							
							-- For instance, Grek and Latn.
							elseif overridden_by[curr_sc] ~= sc then
								require("Module:debug").track("also/no sc detected")
								mw.log("Module:Template:also found two scripts in " .. arg .. ": "
									.. sc .. " and " .. curr_sc .. ".")
								sc = nil
								break
							end
						end
					end
				end
				rtl = mw.loadData("Module:scripts/data")[sc]
				rtl = rtl and rtl.direction == "rtl"
			else
				sc = "Latn"
			end
		end
		
		if sc then
			s = '<b class="' .. sc .. '">' .. s .. "</b>"
			if rtl then
				s = s .. "&lrm;"
			end
		else
			s = "'''" .. s .. "'''"
		end
		
		if codepoint then
			local m_unidata = require('Module:Unicode data')
			
			s = s .. (" <small>[U+%04X %s]</small>"):format(
				codepoint,
				m_unidata.lookup_name(codepoint):gsub("<", "&lt;")
			)
		end
		
		if arg ~= full_pagename then
			table.insert(items, s)
		else
			require("Module:debug").track("also/pagename")
		end
	end
	
	if #items == 0 then
		table.insert(items, "{{{1}}}")
	end
	
	return ("<div class=\"disambig-see-also%s\">''See also:'' %s</div>"):format(
		(#items == 2) and "-2" or "",
		serial_comma_join(items, use_semicolon and ";" or ",")
	)
end

return export