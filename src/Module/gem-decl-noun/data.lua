local decl_data = {}

decl_data["a-m"] = {
	params = {
		[1] = {},
		["nopl"] = {},
	},
}
setmetatable(decl_data["a-m"], {__call = function(self, args, data)
	local stem = args[1]
	local stem_i = ""
	if mw.ustring.sub(stem, -2) == "ij" then
		stem_i = mw.ustring.sub(stem, 1, -3) .. "ī"
		data.decl_type = "masculine ja-stem"
		table.insert(data.categories, "Proto-Germanic ja-stem nouns")
	elseif mw.ustring.sub(stem, -1) == "j" then
		stem_i = mw.ustring.sub(stem, 1, -2) .. "i"
		data.decl_type = "masculine ja-stem"
		table.insert(data.categories, "Proto-Germanic ja-stem nouns")
	else
		stem_i = stem
		data.decl_type = "masculine a-stem"
		table.insert(data.categories, "Proto-Germanic a-stem nouns")
	end

	data.forms["nom_sg"] = {stem .. "az"}
	data.forms["voc_sg"] = {stem_i == stem and stem or stem_i}
	data.forms["acc_sg"] = {stem .. "ą"}
	data.forms["gen_sg"] = {stem .. "as", stem_i .. (stem_i == stem and "is" or "s")}
	data.forms["dat_sg"] = {stem .. "ai"}
	data.forms["ins_sg"] = {stem .. "ō"}

	if not args.nopl then
		data.forms["nom_pl"] = {stem .. "ōz", args[1] .. "ōs"}
		data.forms["voc_pl"] = data.forms["nom_pl"]
		data.forms["acc_pl"] = {stem .. "anz"}
		data.forms["gen_pl"] = {stem .. "ǫ̂"}
		data.forms["dat_pl"] = {stem .. "amaz"}
		data.forms["ins_pl"] = {stem .. "amiz"}
	end
end
})

decl_data["a-n"] = {
	params = {
		[1] = {},
		["nopl"] = {},
	},
}
setmetatable(decl_data["a-n"], {__call = function(self, args, data)
	decl_data["a-m"](args, data)
	
	data.decl_type = data.decl_type:gsub("masculine", "neuter")

	data.forms["nom_sg"] = data.forms["acc_sg"]
	data.forms["voc_sg"] = data.forms["acc_sg"]

	if not args.nopl then
		data.forms["nom_pl"] = {args[1] .. "ō"}
		data.forms["voc_pl"] = data.forms["nom_pl"]
		data.forms["acc_pl"] = data.forms["nom_pl"]
		data.forms["gen_pl"] = {args[1] .. "ǫ̂"}
		data.forms["dat_pl"] = {args[1] .. "amaz"}
		data.forms["ins_pl"] = {args[1] .. "amiz"}
	end
end
})

decl_data["cons-mf"] = {
	params = {
		[1] = {},
		["nopl"] = {},
		["nomsg"] = {},
		["vocsg"] = {},
	},
}
setmetatable(decl_data["cons-mf"], {__call = function(self, args, data)
	local pagename = mw.title.getCurrentTitle().subpageText

	local s = mw.ustring.sub(pagename, -1, -1)
	
	-- Check for s-stems
	if mw.ustring.sub(pagename, -1, -1) == "s" and not mw.ustring.find(mw.ustring.sub(pagename, -2, -2), "[fhkptþ]") then
		s = ""
	end

	-- (mw.ustring.find(mw.ustring.sub(args[1], -1, -1), "[fhkptþ]") and "s" or "z")
	
	data.decl_type = "consonant stem"
	
	data.forms["nom_sg"] = {args.nomsg or (args[1] .. s)}
	data.forms["voc_sg"] = {args.vocsg or args[1]}
	data.forms["acc_sg"] = {args[1] .. "ų"}
	data.forms["gen_sg"] = {args[1] .. "iz"}
	data.forms["dat_sg"] = {args[1] .. "i"}
	data.forms["ins_sg"] = {args[1] .. "ē"}

	if not args.nopl then
		data.forms["nom_pl"] = {args[1] .. "iz"}
		data.forms["voc_pl"] = data.forms["nom_pl"]
		data.forms["acc_pl"] = {args[1] .. "unz"}
		data.forms["gen_pl"] = {args[1] .. "ǫ̂"}
		data.forms["dat_pl"] = {args[1] .. "umaz"}
		data.forms["ins_pl"] = {args[1] .. "umiz"}
	end
	
	table.insert(data.categories, "Proto-Germanic consonant stem nouns")
end
})

decl_data["cons-n"] = {
	params = {
		[1] = {},
		["nopl"] = {},
	},
}
setmetatable(decl_data["cons-n"], {__call = function(self, args, data)
	decl_data["cons-mf"](args, data)
	
	data.decl_type = "neuter consonant stem"

	data.forms["nom_sg"] = {args[1]}
	data.forms["voc_sg"] = data.forms["nom_sg"]
	data.forms["acc_sg"] = data.forms["nom_sg"]
	
	if not args.nopl then
		data.forms["nom_pl"] = {args[1]}
		data.forms["voc_pl"] = data.forms["nom_pl"]
		data.forms["acc_pl"] = data.forms["nom_pl"]
	end
end
})

decl_data["i-mf"] = {
	params = {
		[1] = {},
		["nopl"] = {},
		["j"] = {},
		},
}
setmetatable(decl_data["i-mf"], {__call = function(self, args, data)
	data.decl_type = "i-stem"
	
	local j = args.j or require("Module:gem-pronunc").determine_sievers(args[1])
	
	data.forms["nom_sg"] = {args[1] .. "iz"}
	data.forms["voc_sg"] = {args[1] .. "i"}
	data.forms["acc_sg"] = {args[1] .. "į"}
	data.forms["gen_sg"] = {args[1] .. "īz"}
	data.forms["dat_sg"] = {args[1] .. "ī"}
	data.forms["ins_sg"] = {args[1] .. "ī"}

	if not args.nopl then
		data.forms["nom_pl"] = {args[1] .. "īz"}
		data.forms["voc_pl"] = data.forms["nom_pl"]
		data.forms["acc_pl"] = {args[1] .. "inz"}
		data.forms["gen_pl"] = {args[1] .. (j or "") .. "ǫ̂"}
		data.forms["dat_pl"] = {args[1] .. "imaz"}
		data.forms["ins_pl"] = {args[1] .. "imiz"}
	end
	
	table.insert(data.categories, "Proto-Germanic i-stem nouns")
end
})

decl_data["i-n"] = {
	params = {
		[1] = {},
		["nopl"] = {},
		["j"] = {},
		},
}
setmetatable(decl_data["i-n"], {__call = function(self, args, data)
	decl_data["i-mf"](args, data)
	
	data.decl_type = "neuter i-stem"
	
	data.forms["nom_sg"] = data.forms["voc_sg"]
	data.forms["acc_sg"] = data.forms["voc_sg"]

	if not args.nopl then
		data.forms["nom_pl"] = {args[1] .. "ī"}
		data.forms["voc_pl"] = data.forms["nom_pl"]
		data.forms["acc_pl"] = data.forms["nom_pl"]
	end
end
})

decl_data["ijo-f"] = {
	params = {
		[1] = {},
		["nopl"] = {},
		},
}
setmetatable(decl_data["ijo-f"], {__call = function(self, args, data)
	data.decl_type = "ī/jō-stem"
	
	local stem = args[1] .. require("Module:gem-pronunc").determine_sievers(args[1])
	
	data.forms["nom_sg"] = {args[1] .. "ī"}
	data.forms["voc_sg"] = data.forms["nom_sg"]
	data.forms["acc_sg"] = {stem .. "ǭ"}
	data.forms["gen_sg"] = {stem.. "ōz"}
	data.forms["dat_sg"] = {stem .. "ōi"}
	data.forms["ins_sg"] = {stem .. "ō"}

	if not args.nopl then
		data.forms["nom_pl"] = {stem .. "ôz"}
		data.forms["voc_pl"] = data.forms["nom_pl"]
		data.forms["acc_pl"] = {stem .. "ōz"}
		data.forms["gen_pl"] = {stem .. "ǫ̂"}
		data.forms["dat_pl"] = {stem .. "ōmaz"}
		data.forms["ins_pl"] = {stem .. "ōmiz"}
	end
	
	table.insert(data.categories, "Proto-Germanic ī/jō-stem nouns")
end
})

decl_data["n-f"] = {
	params = {
		[1] = {},
		["nopl"] = {},
		},
}
setmetatable(decl_data["n-f"], {__call = function(self, args, data)
	data.decl_type = "ōn-stem"
	
	data.forms["nom_sg"] = {args[1] .. "ǭ"}
	data.forms["voc_sg"] = data.forms["nom_sg"]
	data.forms["acc_sg"] = {args[1] .. "ōnų"}
	data.forms["gen_sg"] = {args[1] .. "ōniz"}
	data.forms["dat_sg"] = {args[1] .. "ōni"}
	data.forms["ins_sg"] = {args[1] .. "ōnē"}

	if not args.nopl then
		data.forms["nom_pl"] = {args[1] .. "ōniz"}
		data.forms["voc_pl"] = data.forms["nom_pl"]
		data.forms["acc_pl"] = {args[1] .. "ōnunz"}
		data.forms["gen_pl"] = {args[1] .. "ōnǫ̂"}
		data.forms["dat_pl"] = {args[1] .. "ōmaz"}
		data.forms["ins_pl"] = {args[1] .. "ōmiz"}
	end
	
	table.insert(data.categories, "Proto-Germanic ōn-stem nouns")
end
})

decl_data["n-m"] = {
	params = {
		[1] = {},
		["nopl"] = {},
		},
}
setmetatable(decl_data["n-m"], {__call = function(self, args, data)
	data.decl_type = "masculine an-stem"
	
	data.forms["nom_sg"] = {args[1] .. "ô"}
	data.forms["voc_sg"] = data.forms["nom_sg"]
	data.forms["acc_sg"] = {args[1] .. "anų"}
	data.forms["gen_sg"] = {args[1].. "iniz"}
	data.forms["dat_sg"] = {args[1] .. "ini"}
	data.forms["ins_sg"] = {args[1] .. "inē"}

	if not args.nopl then
		data.forms["nom_pl"] = {args[1] .. "aniz"}
		data.forms["voc_pl"] = data.forms["nom_pl"]
		data.forms["acc_pl"] = {args[1] .. "anunz"}
		data.forms["gen_pl"] = {args[1] .. "anǫ̂"}
		data.forms["dat_pl"] = {args[1] .. "ammaz"}
		data.forms["ins_pl"] = {args[1] .. "ammiz"}
	end
	
	table.insert(data.categories, "Proto-Germanic an-stem nouns")
end
})

decl_data["n-n"] = {
	params = {
		[1] = {},
		["nopl"] = {},
		},
}
setmetatable(decl_data["n-n"], {__call = function(self, args, data)
	decl_data["n-m"](args, data)
	
	data.decl_type = "neuter an-stem"

	data.forms["acc_sg"] = data.forms["nom_sg"]

	if not args.nopl then
		data.forms["nom_pl"] = {args[1] .. "ōnō"}
		data.forms["voc_pl"] = data.forms["nom_pl"]
		data.forms["acc_pl"] = data.forms["nom_pl"]
	end
	
	table.insert(data.categories, "Proto-Germanic an-stem nouns")
end
})

decl_data["in-f"] = {
	params = {
		[1] = {},
		["nopl"] = {},
		},
}
setmetatable(decl_data["in-f"], {__call = function(self, args, data)
	data.decl_type = "īn-stem"
	
	data.forms["nom_sg"] = {args[1] .. "į̄"}
	data.forms["voc_sg"] = data.forms["nom_sg"]
	data.forms["acc_sg"] = {args[1] .. "īnų"}
	data.forms["gen_sg"] = {args[1] .. "īniz"}
	data.forms["dat_sg"] = {args[1] .. "īni"}
	data.forms["ins_sg"] = {args[1] .. "īnē"}

	if not args.nopl then
		data.forms["nom_pl"] = {args[1] .. "īniz"}
		data.forms["voc_pl"] = data.forms["nom_pl"]
		data.forms["acc_pl"] = {args[1] .. "īnunz"}
		data.forms["gen_pl"] = {args[1] .. "īnǫ̂"}
		data.forms["dat_pl"] = {args[1] .. "īmaz"}
		data.forms["ins_pl"] = {args[1] .. "īmiz"}
	end
	
	table.insert(data.categories, "Proto-Germanic īn-stem nouns")
end
})

decl_data["o-f"] = {
	params = {
		[1] = {},
		["nopl"] = {},
		},
}
setmetatable(decl_data["o-f"], {__call = function(self, args, data)
	data.decl_type = "ō-stem"
	
	data.forms["nom_sg"] = {args[1] .. "ō"}
	data.forms["voc_sg"] = data.forms["nom_sg"]
	data.forms["acc_sg"] = {args[1] .. "ǭ"}
	data.forms["gen_sg"] = {args[1] .. "ōz"}
	data.forms["dat_sg"] = {args[1] .. "ōi"}
	data.forms["ins_sg"] = data.forms["nom_sg"]

	if not args.nopl then
		data.forms["nom_pl"] = {args[1] .. "ôz"}
		data.forms["voc_pl"] = data.forms["nom_pl"]
		data.forms["acc_pl"] = {args[1] .. "ōz"}
		data.forms["gen_pl"] = {args[1] .. "ǫ̂"}
		data.forms["dat_pl"] = {args[1] .. "ōmaz"}
		data.forms["ins_pl"] = {args[1] .. "ōmiz"}
	end
	
	table.insert(data.categories, "Proto-Germanic ō-stem nouns")
end
})

decl_data["r-mf"] = {
	params = {
		[1] = {},
		["nopl"] = {},
		},
}
setmetatable(decl_data["r-mf"], {__call = function(self, args, data)
	data.decl_type = "r-stem"
	
	data.forms["nom_sg"] = {args[1] .. "ēr"}
	data.forms["voc_sg"] = {args[1] .. "er"}
	data.forms["acc_sg"] = {args[1] .. "erų"}
	data.forms["gen_sg"] = {args[1] .. "urz"}
	data.forms["dat_sg"] = {args[1] .. "ri"}
	data.forms["ins_sg"] = {args[1] .. "rē"}

	if not args.nopl then
		data.forms["nom_pl"] = {args[1] .. "riz"}
		data.forms["voc_pl"] = data.forms["nom_pl"]
		data.forms["acc_pl"] = {args[1] .. "runz"}
		data.forms["gen_pl"] = {args[1] .. "rǫ̂"}
		data.forms["dat_pl"] = {args[1] .. "rumaz"}
		data.forms["ins_pl"] = {args[1] .. "rumiz"}
	end
	
	table.insert(data.categories, "Proto-Germanic r-stem nouns")
end
})

decl_data["u-mf"] = {
	params = {
		[1] = {},
		["nopl"] = {},
		},
}
setmetatable(decl_data["u-mf"], {__call = function(self, args, data)
	data.decl_type = "u-stem"
	
	data.forms["nom_sg"] = {args[1] .. "uz"}
	data.forms["voc_sg"] = {args[1] .. "u"}
	data.forms["acc_sg"] = {args[1] .. "ų"}
	data.forms["gen_sg"] = {args[1] .. "auz"}
	data.forms["dat_sg"] = {args[1] .. "iwi"}
	data.forms["ins_sg"] = {args[1] .. "ū"}

	if not args.nopl then
		data.forms["nom_pl"] = {args[1] .. "iwiz"}
		data.forms["voc_pl"] = data.forms["nom_pl"]
		data.forms["acc_pl"] = {args[1] .. "unz"}
		data.forms["gen_pl"] = {args[1] .. "iwǫ̂"}
		data.forms["dat_pl"] = {args[1] .. "umaz"}
		data.forms["ins_pl"] = {args[1] .. "umiz"}
	end
	
	table.insert(data.categories, "Proto-Germanic u-stem nouns")
end
})

decl_data["u-n"] = {
	params = {
		[1] = {},
		["nopl"] = {},
		},
}
setmetatable(decl_data["u-n"], {__call = function(self, args, data)
	decl_data["u-mf"](args, data)
	
	data.decl_type = "neuter u-stem"
	
	data.forms["nom_sg"] = data.forms["voc_sg"]
	data.forms["acc_sg"] = data.forms["voc_sg"]
	
	if not args.nopl then
		data.forms["nom_pl"] = data.forms["ins_sg"]
		data.forms["voc_pl"] = data.forms["ins_sg"]
		data.forms["acc_pl"] = data.forms["ins_sg"]
	end
end
})

decl_data["z-n"] = {
	params = {
		[1] = {},
		["nopl"] = {},
		},
}
setmetatable(decl_data["z-n"], {__call = function(self, args, data)
	data.decl_type = "z-stem"
	
	data.forms["nom_sg"] = {args[1] .. "az"}
	data.forms["voc_sg"] = data.forms["nom_sg"]
	data.forms["acc_sg"] = data.forms["nom_sg"]
	data.forms["gen_sg"] = {args[1] .. "iziz"}
	data.forms["dat_sg"] = {args[1] .. "izi"}
	data.forms["ins_sg"] = {args[1] .. "izē"}

	if not args.nopl then
		data.forms["nom_pl"] = {args[1] .. "izō"}
		data.forms["voc_pl"] = data.forms["nom_pl"]
		data.forms["acc_pl"] = data.forms["nom_pl"]
		data.forms["gen_pl"] = {args[1] .. "izǫ̂"}
		data.forms["dat_pl"] = {args[1] .. "izumaz"}
		data.forms["ins_pl"] = {args[1] .. "izumiz"}
	end
	
	table.insert(data.categories, "Proto-Germanic z-stem nouns")
end
})

decl_data["irreg"] = {}
setmetatable(decl_data["irreg"], {__call = function(self, args, data)
	local word = mw.title.getCurrentTitle().subpageText
	
	irreg_data = require("Module:gem-decl-noun/data/irreg")
	if irreg_data.irreg[word] then
		irreg_data.irreg[word](args, data)
	else
		error("Irregular inflection not found. Please check Module:gem-decl-noun/data.")
	end
	
	table.insert(data.categories, "Proto-Germanic irregular nouns")
end
})

return decl_data