local export = {}
local m_zh = require("Module:zh")
local sub = mw.ustring.sub
local gsub = mw.ustring.gsub
local match = mw.ustring.match

local function link(text, make_link)
	return '<span lang="zh" class="Hani">' .. (make_link and ('[[' .. text .. '#Chinese|' .. text .. ']]') or text) .. '</span>'
end

local function get_occurrence(content)
	local _, occurrence = content:gsub("zh%-pron", "zh-see"):gsub("zh%-see", "")
	return occurrence
end

function export.show(frame)
	local non_lemma_type = {
		['s'] = 'the simplified', ['simp'] = 'the simplified', ['simplified'] = 'the simplified',
		['fs'] = 'the former (1964-1986) first-round simplified',
		['fsv'] = 'the former (1964-1986) first-round simplified and varient',
		['ss'] = 'the second-round simplified',
		['ssv'] = 'the second-round simplified and variant',
		['sgs'] = 'the former (1969–1976) Singaporean simplified',
		['sgsv'] = 'the former (1969–1976) Singaporean simplified and variant',
		['sgss'] = 'the former (1969–1976) Singaporean simplified and second-round simplified',
		['sgssv'] = 'the former (1969–1976) Singaporean simplified, second-round simplified<span class="serial-comma">,</span> and variant',
		['rocs'] = 'the former (1935–1936) ROC simplified', -- 第一批簡體字表
		['rocsv'] = 'the former (1935–1936) ROC simplified and variant',
		['rocss'] = 'the former (1935–1936) ROC simplified and second-round simplified',
		['rocssv'] = 'the former (1935–1936) ROC simplified, second-round simplified<span class="serial-comma">,</span> and variant',
		['rocsgs'] = 'the former (1935–1936) ROC simplified and former (1969–1976) Singaporean simplified',
		['rocsgsv'] = 'the former (1935–1936) ROC simplified, former (1969–1976) Singaporean simplified<span class="serial-comma">,</span> and variant',
		['rocsgssv'] = 'the former (1935–1936) ROC simplified, former (1969–1976) Singaporean simplified, second-round simplified<span class="serial-comma">,</span> and variant',
		['rocfs'] = 'the former (1935–1936) ROC simplified and former (1964-1986) first-round simplified',
		['rocfsv'] = 'the former (1935–1936) ROC simplified, former (1964-1986) first-round simplified<span class="serial-comma">,</span> and variant',
		['rocfsgs'] = 'the former (1935–1936) ROC simplified, former (1964-1986) first-round simplified<span class="serial-comma">,</span> and former (1969–1976) Singaporean simplified',
		['rocfsgsv'] = 'the former (1935–1936) ROC simplified, former (1964-1986) first-round simplified, former (1969–1976) Singaporean simplified<span class="serial-comma">,</span> and variant',
		['rocfsgssv'] = 'the former (1935–1936) ROC simplified, former (1964-1986) first-round simplified, former (1969–1976) Singaporean simplified, second-round simplified<span class="serial-comma">,</span> and variant',
		['ds'] = 'the draft (1955) first-round simplified', -- 漢字簡化方案草案
		['dsv'] = 'the draft (1955) first-round simplified and variant',
		['dss'] = 'the draft (1955) first-round simplified and second-round simplified',
		['dssv'] = 'the draft (1955) first-round simplified, second-round simplified<span class="serial-comma">,</span> and variant',
		['dsgs'] = 'the draft (1955) first-round simplified and former (1969–1976) Singaporean simplified',
		['dsgsv'] = 'the draft (1955) first-round simplified, former (1969–1976) Singaporean simplified<span class="serial-comma">,</span> and variant',
		['dsgssv'] = 'the draft (1955) first-round simplified, former (1969–1976) Singaporean simplified, second-round simplified<span class="serial-comma">,</span> and variant',
		['rocds'] = 'the former (1935–1936) ROC simplified and draft (1955) first-round simplified',
		['rocdsv'] = 'the former (1935–1936) ROC simplified, draft (1955) first-round simplified<span class="serial-comma">,</span> and variant',
		['rocdss'] = 'the former (1935–1936) ROC simplified, draft (1955) first-round simplified<span class="serial-comma">,</span> and second-round simplified',
		['rocdssv'] = 'the former (1935–1936) ROC simplified, draft (1955) first-round simplified, second-round simplified<span class="serial-comma">,</span> and variant',
		['rocdsgs'] = 'the former (1935–1936) ROC simplified, draft (1955) first-round simplified<span class="serial-comma">,</span> and former (1969–1976) Singaporean simplified',
		['rocdsgsv'] = 'the former (1935–1936) ROC simplified, draft (1955) first-round simplified, former (1969–1976) Singaporean simplified<span class="serial-comma">,</span> and variant',
		['rocdsgssv'] = 'the former (1935–1936) ROC simplified, draft (1955) first-round simplified, former (1969–1976) Singaporean simplified, second-round simplified<span class="serial-comma">,</span> and variant',
		['ns'] = 'a nonstandard simplified',
		['a'] = 'an ancient', ['ancient'] = 'an ancient',
		['o'] = 'an obsolete', ['obsolete'] = 'an obsolete',
		['v'] = 'a variant', ['var'] = 'a variant', ['variant'] = 'a variant',
		['vt'] = 'a variant traditional',
		['av'] = 'an ancient variant',
		['sv'] = 'the simplified and variant',
		['svt'] = 'the simplified and variant traditional',
		['hv'] = 'recorded in one or more historical dictionaries as a variant',
		['hdv'] = 'recorded in one or more historical dictionaries as a variant',
		['hduo'] = 'recorded in one or more historical dictionaries as an unorthodox',
		['ha'] = 'recorded in one or more historical dictionaries as an ancient',
		['hda'] = 'recorded in one or more historical dictionaries as an ancient',
		['poj'] = 'the [[Pe̍h-ōe-jī]]',
		['err'] = 'an erroneous or mistaken', -- 訛字

		['all'] = 'a simplified, obsolete or variant',
	}

	local args = frame:getParent().args
	local title = args[1]
	local curr_title = mw.title.getCurrentTitle().subpageText
	local content = mw.title.new(title):getContent()
	local title_exists = content ~= nil
	local simp = args["simp"] or false
	local non_lemma_abbrev = args[2] or ""

	if title == curr_title then
		return error("The soft-directed item is the same as the page title.")
	end

	if content then
		if not match(content, "==Chinese==") then
			require('Module:debug').track('zh-see/no Chinese section found')
		elseif not match(content, "zh%-pron") and not match(content, "zh%-see") then
			require('Module:debug').track('zh-see/unidirectional reference to variant')
		elseif not match(content, curr_title) then
			require('Module:debug').track('zh-see/unidirectional reference variant→orthodox')
		end

		occurrence = get_occurrence(content)
		if match(content, "zh%-see") and occurrence == 1 then
			new_title = match(content, "zh%-see%|([^%|%}]+)")
			if non_lemma_abbrev == "" and occurrence == 1 and match(content, "zh%-see%|([^%|%}]+)%|v") then
				chain = true
			end
			content = mw.title.new(new_title):getContent()
		end

		content = gsub(content, "zh%-forms", "Ѭ")
		content = gsub(content, "zh%-pron", "Ꙁ")
		if non_lemma_abbrev == "" then
			template = mw.ustring.match(content, "{{Ѭ[^}]*}}") or false
			if template then
				for forms_template in mw.ustring.gmatch(content, "{{Ѭ[^}]*}}") do
					if match(forms_template, curr_title) then
						if match(forms_template, "|s[0-9]*=" .. curr_title) then
							non_lemma_abbrev = non_lemma_abbrev .. "s"
						end
						if match(forms_template, "|t[0-9]*=" .. curr_title) then
							non_lemma_abbrev = non_lemma_abbrev .. "vt"
						end
						if match(forms_template, "|alt=[^|}\n]*" .. curr_title) then
							non_lemma_abbrev = non_lemma_abbrev .. "v"
						end
						break
					end
				end
			end
		end
	end

	local non_lemma_cat = non_lemma_type[non_lemma_abbrev ~= "" and non_lemma_abbrev or 's'] or 'the simplified'
	local note = (content or mw.title.getCurrentTitle().nsText ~= "") and "" or '[[Category:Chinese terms with uncreated forms]]'

	local gloss_text = args[3] or (content and m_zh.extract_gloss(gsub(content, "Ѭ", "zh%-forms"), true) or "")
	local box =
		'{| class="wikitable' .. (match(non_lemma_cat, 'simplified') and ' mw-collapsible mw-collapsed' or '') ..
			'" style="border:1px solid #797979; margin-left: 1px; text-align:left; min-width:' .. (chain and 80 or 70) .. '%"' ..

			'\n|-\n| style="background-color: #eeeeee; padding-left: 0.5em" | \'\'\'For pronunciation and definitions of \'\'\'' .. (non_lemma_abbrev=="poj" and curr_title or link(gsub(curr_title, '(.)', '[[%1#Chinese|%1]]'), false)) ..
			'\'\'\' – see ' .. link(chain and new_title or title, true) ..
			(gloss_text ~= "" and (' (“' .. gloss_text .. '”)') or '') .. '.\'\'\'' ..

			'<br>(This ' .. (mw.ustring.len(title) == 1 and 'character' or 'term' ) .. ', ' .. link(curr_title) ..
			', is ' .. ' \'\'' .. non_lemma_cat .. '\'\' form of ' .. link(title, chain and true or false) .. '' ..

			(simp and
				('<small>:&nbsp; ' .. link(sub(simp, 1, 1), true) .. ' → ' .. link(sub(simp, 2, 2), true) .. '</small>')
			or
				'') ..

			(chain and ', which is in turn a \'\'variant\'\' form of ' .. link(new_title, true) or '') .. '.)' ..

			(match(non_lemma_cat, 'simplified') and [=[

|-
| class="mw-collapsible-content" style="background-color: #F5DEB3; font-size: smaller" | <b>Notes:</b>
* [[w:Simplified Chinese|Simplified Chinese]] is mainly used in Mainland China, Malaysia and Singapore.
* [[w:Traditional Chinese|Traditional Chinese]] is mainly used in Hong Kong, Macau<span class="serial-comma">,</span> and Taiwan.]=] or '') ..

			'\n|}' .. note

	local cat = { "variant", "simplified", "obsolete" }
	local m_cat = require("Module:zh-cat")

	local categories = ''
	for _, word in ipairs(cat) do
		if match(non_lemma_cat, word) then
			categories = categories .. m_cat.categorize(word)
		end
	end

	if content then
		local part_a, part_b, part_c = '{{Ѭ[^%}]+' .. curr_title .. '[^%}]*}}', '[^ѬꙀ]+', '({{Ꙁ.+\n%|cat%=[^\n]*\n?}})'
		local match_group = mw.ustring.len(gsub(content, "[^Ѭ]", "")) == 1
			and mw.ustring.gmatch(content, '{{Ꙁ[^Ꙁ]+%|cat%=[^\n]*\n?}}')
			or (match(content, part_a)
				and (match(content, part_a .. part_b .. part_c)
					and mw.ustring.gmatch(content, part_a .. part_b .. part_c)
					or mw.ustring.gmatch(content, part_c .. part_b .. part_a))
				or mw.ustring.gmatch(content, part_c))

		for match_result in match_group do
			local function find_pron(variety)
				return match(match_result, '|' .. variety .. '=([^|}\n]*)') or ''
			end
			if non_lemma_abbrev == "poj" then
				categories = categories .. frame:expandTemplate{
					title = "Template:zh-pron",
					args = {
						['mn'] = find_pron('mn'),
						['cat'] = find_pron('cat'),
						['only_cat'] = 'yes',
						}
					}
			else
				categories = categories .. frame:expandTemplate{
					title = "Template:zh-pron",
					args = {
						['m'] = find_pron('m'),
						['c'] = find_pron('c'),
						['c-t'] = find_pron('c%-t'),
						['dg'] = find_pron('dg'),
						['g'] = find_pron('g'),
						['h'] = find_pron('h'),
						['j'] = find_pron('j'),
						['mb'] = find_pron('mb'),
						['md'] = find_pron('md'),
						['mn'] = find_pron('mn'),
						['mn-t'] = find_pron('mn%-t'),
						['w'] = find_pron('w'),
						['x'] = find_pron('x'),
						['cat'] = find_pron('cat'),
						['only_cat'] = 'yes',
						}
					}
			end
		end

		if non_lemma_abbrev ~= "poj" then
			local match_cat = mw.ustring.match(content, "{{zh%-cat%|([^}]+)}}") or nil
			if match_cat then
				match_cat_group = mw.text.split(match_cat, "|")
				categories = categories .. frame:expandTemplate{
					title = "Template:zh-cat",
					args = match_cat_group
				}
			end

			--local match_label = mw.ustring.gmatch(content, "{{lb%|zh%|([^}]+)}}") or nil
			--if match_label then
			--	local lang = require("Module:languages").getByCode("zh")
			--	for match_label_item in match_label do
			--		local match_label_group = mw.text.split(match_label_item, "|")
			--		local label_text = require("Module:labels").show_labels(match_label_group, lang)
			--		categories = categories .. (mw.ustring.match(label_text, "%[%[Category:[^%]]+%]%]") or "")
			--	end
			--end

			local match_char_comp = mw.ustring.match(content, "{{zh%-character component%|") or nil
			--mw.log(match_char_comp)
			if match_char_comp then
				categories = categories .. frame:expandTemplate{
					title = "Template:zh-cat",
					args = { "Chinese character components" }
				}
			end
		else
			categories = categories .. "[[Category:Min Nan Pe̍h-ōe-jī forms]]"
		end
	end

	return box .. categories
end

return export