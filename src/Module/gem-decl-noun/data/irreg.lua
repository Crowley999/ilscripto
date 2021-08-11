irreg_data = {}

------ a-stems ------

irreg_data["blōþą"] = function(args, data)
	data.decl_type = "neuter a-stem"
	
	data.forms["nom_sg"] = {"blōþą"}
	data.forms["voc_sg"] = data.forms["nom_sg"]
	data.forms["acc_sg"] = data.forms["nom_sg"]
	data.forms["gen_sg"] = {"blōþas", "blōþis"}
	data.forms["dat_sg"] = {"blōþai"}
	data.forms["ins_sg"] = {"blōþō"}

	data.forms["nom_pl"] = {"blōdō"}
	data.forms["voc_pl"] = data.forms["nom_pl"]
	data.forms["acc_pl"] = data.forms["nom_pl"]
	data.forms["gen_pl"] = {"blōdǫ̂"}
	data.forms["dat_pl"] = {"blōdamaz"}
	data.forms["ins_pl"] = {"blōdamiz"}

	table.insert(data.categories, "Proto-Germanic a-stem nouns")
end

irreg_data["glasą"] = function(args, data)
	data.decl_type = "neuter a-stem"
	
	data.forms["nom_sg"] = {"glasą"}
	data.forms["voc_sg"] = data.forms["nom_sg"]
	data.forms["acc_sg"] = data.forms["nom_sg"]
	data.forms["gen_sg"] = {"glasas", "glasis"}
	data.forms["dat_sg"] = {"glasai"}
	data.forms["ins_sg"] = {"glasō"}

	data.forms["nom_pl"] = {"glazō"}
	data.forms["voc_pl"] = data.forms["nom_pl"]
	data.forms["acc_pl"] = data.forms["nom_pl"]
	data.forms["gen_pl"] = {"glazǫ̂"}
	data.forms["dat_pl"] = {"glazamaz"}
	data.forms["ins_pl"] = {"glazamiz"}

	table.insert(data.categories, "Proto-Germanic a-stem nouns")
end

irreg_data["gulþą"] = function(args, data)
	data.decl_type = "neuter a-stem"
	
	data.forms["nom_sg"] = {"gulþą"}
	data.forms["voc_sg"] = data.forms["nom_sg"]
	data.forms["acc_sg"] = data.forms["nom_sg"]
	data.forms["gen_sg"] = {"gulþas", "gulþis"}
	data.forms["dat_sg"] = {"gulþai"}
	data.forms["ins_sg"] = {"gulþō"}

	data.forms["nom_pl"] = {"guldō"}
	data.forms["voc_pl"] = data.forms["nom_pl"]
	data.forms["acc_pl"] = data.forms["nom_pl"]
	data.forms["gen_pl"] = {"guldǫ̂"}
	data.forms["dat_pl"] = {"guldamaz"}
	data.forms["ins_pl"] = {"guldamiz"}

	table.insert(data.categories, "Proto-Germanic a-stem nouns")
end

irreg_data["hwehwlą"] = function(args, data)
	data.decl_type = "neuter a-stem"
	
	data.forms["nom_sg"] = {"hwehwlą"}
	data.forms["voc_sg"] = data.forms["nom_sg"]
	data.forms["acc_sg"] = data.forms["nom_sg"]
	data.forms["gen_sg"] = {"hwehwlas", "hwihwlis"}
	data.forms["dat_sg"] = {"hwihwlai"}
	data.forms["ins_sg"] = {"hwehwlō"}

	data.forms["nom_pl"] = {"hweulō"}
	data.forms["voc_pl"] = data.forms["nom_pl"]
	data.forms["acc_pl"] = data.forms["nom_pl"]
	data.forms["gen_pl"] = {"hweulǫ̂"}
	data.forms["dat_pl"] = {"hweulamaz"}
	data.forms["ins_pl"] = {"hweulamiz"}

	table.insert(data.categories, "Proto-Germanic a-stem nouns")
end

irreg_data["jehwlą"] = function(args, data)
	data.decl_type = "neuter a-stem"
	
	data.forms["nom_sg"] = {"jehwlą"}
	data.forms["voc_sg"] = data.forms["nom_sg"]
	data.forms["acc_sg"] = data.forms["nom_sg"]
	data.forms["gen_sg"] = {"jehwlas", "jihwlis"}
	data.forms["dat_sg"] = {"jihwlai"}
	data.forms["ins_sg"] = {"jehwlō"}

	data.forms["nom_pl"] = {"jeulō"}
	data.forms["voc_pl"] = data.forms["nom_pl"]
	data.forms["acc_pl"] = data.forms["nom_pl"]
	data.forms["gen_pl"] = {"jeulǫ̂"}
	data.forms["dat_pl"] = {"jeulamaz"}
	data.forms["ins_pl"] = {"jeulamiz"}

	table.insert(data.categories, "Proto-Germanic a-stem nouns")
end

irreg_data["tahrą"] = function(args, data)
	data.decl_type = "neuter a-stem"
	
	data.forms["nom_sg"] = {"tahrą"}
	data.forms["voc_sg"] = data.forms["nom_sg"]
	data.forms["acc_sg"] = data.forms["nom_sg"]
	data.forms["gen_sg"] = {"tahras", "tahris"}
	data.forms["dat_sg"] = {"tahrai"}
	data.forms["ins_sg"] = {"tahrō"}

	data.forms["nom_pl"] = {"tagrō"}
	data.forms["voc_pl"] = data.forms["nom_pl"]
	data.forms["acc_pl"] = data.forms["nom_pl"]
	data.forms["gen_pl"] = {"tagrǫ̂"}
	data.forms["dat_pl"] = {"tagramaz"}
	data.forms["ins_pl"] = {"tagramiz"}

	table.insert(data.categories, "Proto-Germanic a-stem nouns")
end

------ Consonant stems ------

irreg_data["aigin"] = function(args, data)
	data.decl_type = "neuter consonant stem"
	
	data.forms["nom_sg"] = {"aigin"}
	data.forms["voc_sg"] = data.forms["nom_sg"]
	data.forms["acc_sg"] = data.forms["nom_sg"]
	data.forms["gen_sg"] = {"aiginþiz"}
	data.forms["dat_sg"] = {"aiginþi"}
	data.forms["ins_sg"] = {"aiginþē"}

	data.forms["nom_pl"] = {"aiginþ"}
	data.forms["voc_pl"] = data.forms["nom_pl"]
	data.forms["acc_pl"] = data.forms["nom_pl"]
	data.forms["gen_pl"] = {"aiginþǫ̂"}
	data.forms["dat_pl"] = {"aiginþumaz"}
	data.forms["ins_pl"] = {"aiginþumiz"}

	table.insert(data.categories, "Proto-Germanic consonant stem nouns")
end

irreg_data["alu"] = function(args, data)
	data.decl_type = "neuter consonant stem"
	
	data.forms["nom_sg"] = {"alu"}
	data.forms["voc_sg"] = data.forms["nom_sg"]
	data.forms["acc_sg"] = data.forms["nom_sg"]
	data.forms["gen_sg"] = {"aluþiz"}
	data.forms["dat_sg"] = {"aluþi"}
	data.forms["ins_sg"] = {"aluþē"}

	data.forms["nom_pl"] = {"aluþ"}
	data.forms["voc_pl"] = data.forms["nom_pl"]
	data.forms["acc_pl"] = data.forms["nom_pl"]
	data.forms["gen_pl"] = {"aluþǫ̂"}
	data.forms["dat_pl"] = {"aluþumaz"}
	data.forms["ins_pl"] = {"aluþumiz"}

	table.insert(data.categories, "Proto-Germanic consonant stem nouns")
end

irreg_data["arô"] = function(args, data)
	data.decl_type = "consonant stem"
	
	data.forms["nom_sg"] = {"arô"}
	data.forms["voc_sg"] = data.forms["nom_sg"]
	data.forms["acc_sg"] = {"arnų"}
	data.forms["gen_sg"] = {"arniz"}
	data.forms["dat_sg"] = {"arni"}
	data.forms["ins_sg"] = {"arnē"}

	data.forms["nom_pl"] = {"arniz"}
	data.forms["voc_pl"] = data.forms["nom_pl"]
	data.forms["acc_pl"] = {"arnunz"}
	data.forms["gen_pl"] = {"arnǫ̂"}
	data.forms["dat_pl"] = {"arnumaz"}
	data.forms["ins_pl"] = {"arnumiz"}

	table.insert(data.categories, "Proto-Germanic consonant stem nouns")
end

irreg_data["asunz"] = function(args, data)
	data.decl_type = "consonant stem"
	
	data.forms["nom_sg"] = {"asunz"}
	data.forms["voc_sg"] = {"asų"}
	data.forms["acc_sg"] = {"asnų"}
	data.forms["gen_sg"] = {"asniz"}
	data.forms["dat_sg"] = {"asni"}
	data.forms["ins_sg"] = {"asnē"}

	data.forms["nom_pl"] = {"asniz"}
	data.forms["voc_pl"] = data.forms["nom_pl"]
	data.forms["acc_pl"] = {"asnunz"}
	data.forms["gen_pl"] = {"asnǫ̂"}
	data.forms["dat_pl"] = {"asnumaz"}
	data.forms["ins_pl"] = {"asnumiz"}

	table.insert(data.categories, "Proto-Germanic consonant stem nouns")
end

irreg_data["berô"] = function(args, data)
	data.decl_type = "consonant stem"
	
	data.forms["nom_sg"] = {"berô"}
	data.forms["voc_sg"] = data.forms["nom_sg"]
	data.forms["acc_sg"] = {"bernų"}
	data.forms["gen_sg"] = {"berniz"}
	data.forms["dat_sg"] = {"berni"}
	data.forms["ins_sg"] = {"bernē"}

	data.forms["nom_pl"] = {"berniz"}
	data.forms["voc_pl"] = data.forms["nom_pl"]
	data.forms["acc_pl"] = {"bernunz"}
	data.forms["gen_pl"] = {"bernǫ̂"}
	data.forms["dat_pl"] = {"bernumaz"}
	data.forms["ins_pl"] = {"bernumiz"}

	table.insert(data.categories, "Proto-Germanic consonant stem nouns")
end

irreg_data["ēbanþs"] = function(args, data)
	data.decl_type = "consonant stem"
	
	data.forms["nom_sg"] = {"ēbanþs"}
	data.forms["voc_sg"] = {"ēbanþ"}
	data.forms["acc_sg"] = {"ēbanþų"}
	data.forms["gen_sg"] = {"ēbundiz"}
	data.forms["dat_sg"] = {"ēbundi"}
	data.forms["ins_sg"] = {"ēbundē"}

	data.forms["nom_pl"] = {"ēbanþiz"}
	data.forms["voc_pl"] = data.forms["nom_pl"]
	data.forms["acc_pl"] = {"ēbanþunz"}
	data.forms["gen_pl"] = {"ēbundǫ̂"}
	data.forms["dat_pl"] = {"ēbundumaz"}
	data.forms["ins_pl"] = {"ēbundumiz"}

	table.insert(data.categories, "Proto-Germanic consonant stem nouns")
end

irreg_data["ili"] = function(args, data)
	data.decl_type = "neuter consonant stem"
	
	data.forms["nom_sg"] = {"ili"}
	data.forms["voc_sg"] = data.forms["nom_sg"]
	data.forms["acc_sg"] = data.forms["nom_sg"]
	data.forms["gen_sg"] = {"iliþiz"}
	data.forms["dat_sg"] = {"iliþi"}
	data.forms["ins_sg"] = {"iliþē"}

	data.forms["nom_pl"] = {"iliþ"}
	data.forms["voc_pl"] = data.forms["nom_pl"]
	data.forms["acc_pl"] = data.forms["nom_pl"]
	data.forms["gen_pl"] = {"iliþǫ̂"}
	data.forms["dat_pl"] = {"iliþumaz"}
	data.forms["ins_pl"] = {"iliþumiz"}

	table.insert(data.categories, "Proto-Germanic consonant stem nouns")
end

irreg_data["kūz"] = function(args, data)
	data.decl_type = "consonant stem"
	
	data.forms["nom_sg"] = {"kūz"}
	data.forms["voc_sg"] = {"kū"}
	data.forms["acc_sg"] = {"kwǭ"}
	data.forms["gen_sg"] = {"kwōiz"}
	data.forms["dat_sg"] = {"kwōi"}
	data.forms["ins_sg"] = {"kwōē"}

	data.forms["nom_pl"] = {"kwōiz"}
	data.forms["voc_pl"] = data.forms["nom_pl"]
	data.forms["acc_pl"] = {"kwōnz"}
	data.forms["gen_pl"] = {"kwōǫ̂"}
	data.forms["dat_pl"] = {"kwōmaz"}
	data.forms["ins_pl"] = {"kwōmiz"}

	table.insert(data.categories, "Proto-Germanic consonant stem nouns")
end

irreg_data["mann-"] = function(args, data)
	data.decl_type = "consonant stem"
	
	data.forms["nom_sg"] = {"mann-", "manô", "mannô"}
	data.forms["voc_sg"] = {"mann"}
	data.forms["acc_sg"] = {"mannų"}
	data.forms["gen_sg"] = {"manniz"}
	data.forms["dat_sg"] = {"manni"}
	data.forms["ins_sg"] = {"mannē"}

	data.forms["nom_pl"] = {"manniz"}
	data.forms["voc_pl"] = data.forms["nom_pl"]
	data.forms["acc_pl"] = {"mannunz"}
	data.forms["gen_pl"] = {"mannǫ̂"}
	data.forms["dat_pl"] = {"mannumaz"}
	data.forms["ins_pl"] = {"mannumiz"}

	table.insert(data.categories, "Proto-Germanic consonant stem nouns")
end

irreg_data["gawjamann-"] = function(args, data)
	data.decl_type = "consonant stem"
	
	data.forms["nom_sg"] = {"gawjamann-", "gawjamanô", "gawjamannô"}
	data.forms["voc_sg"] = {"gawjamann"}
	data.forms["acc_sg"] = {"gawjamannų"}
	data.forms["gen_sg"] = {"gawjamanniz"}
	data.forms["dat_sg"] = {"gawjamanni"}
	data.forms["ins_sg"] = {"gawjamannē"}

	data.forms["nom_pl"] = {"gawjamanniz"}
	data.forms["voc_pl"] = data.forms["nom_pl"]
	data.forms["acc_pl"] = {"gawjamannunz"}
	data.forms["gen_pl"] = {"gawjamannǫ̂"}
	data.forms["dat_pl"] = {"gawjamannumaz"}
	data.forms["ins_pl"] = {"gawjamannumiz"}

	table.insert(data.categories, "Proto-Germanic consonant stem nouns")
end

irreg_data["kaupamann-"] = function(args, data)
	data.decl_type = "consonant stem"
	
	data.forms["nom_sg"] = {"kaupamann-", "kaupamanô", "kaupamannô"}
	data.forms["voc_sg"] = {"kaupamann"}
	data.forms["acc_sg"] = {"kaupamannų"}
	data.forms["gen_sg"] = {"kaupamanniz"}
	data.forms["dat_sg"] = {"kaupamanni"}
	data.forms["ins_sg"] = {"kaupamannē"}

	data.forms["nom_pl"] = {"kaupamanniz"}
	data.forms["voc_pl"] = data.forms["nom_pl"]
	data.forms["acc_pl"] = {"kaupamannunz"}
	data.forms["gen_pl"] = {"kaupamannǫ̂"}
	data.forms["dat_pl"] = {"kaupamannumaz"}
	data.forms["ins_pl"] = {"kaupamannumiz"}

	table.insert(data.categories, "Proto-Germanic consonant stem nouns")
end

irreg_data["skipamann-"] = function(args, data)
	data.decl_type = "consonant stem"
	
	data.forms["nom_sg"] = {"skipamann-", "skipamanô", "skipamannô"}
	data.forms["voc_sg"] = {"skipamann"}
	data.forms["acc_sg"] = {"skipamannų"}
	data.forms["gen_sg"] = {"skipamanniz"}
	data.forms["dat_sg"] = {"skipamanni"}
	data.forms["ins_sg"] = {"skipamannē"}

	data.forms["nom_pl"] = {"skipamanniz"}
	data.forms["voc_pl"] = data.forms["nom_pl"]
	data.forms["acc_pl"] = {"skipamannunz"}
	data.forms["gen_pl"] = {"skipamannǫ̂"}
	data.forms["dat_pl"] = {"skipamannumaz"}
	data.forms["ins_pl"] = {"skipamannumiz"}

	table.insert(data.categories, "Proto-Germanic consonant stem nouns")
end

irreg_data["harjamann-"] = function(args, data)
	data.decl_type = "consonant stem"
	
	data.forms["nom_sg"] = {"harjamann-", "harjamanô", "harjamannô"}
	data.forms["voc_sg"] = {"harjamann"}
	data.forms["acc_sg"] = {"harjamannų"}
	data.forms["gen_sg"] = {"harjamanniz"}
	data.forms["dat_sg"] = {"harjamanni"}
	data.forms["ins_sg"] = {"harjamannē"}

	data.forms["nom_pl"] = {"harjamanniz"}
	data.forms["voc_pl"] = data.forms["nom_pl"]
	data.forms["acc_pl"] = {"harjamannunz"}
	data.forms["gen_pl"] = {"harjamannǫ̂"}
	data.forms["dat_pl"] = {"harjamannumaz"}
	data.forms["ins_pl"] = {"harjamannumiz"}

	table.insert(data.categories, "Proto-Germanic consonant stem nouns")
end

irreg_data["metaþs"] = function(args, data)
	data.decl_type = "consonant stem"
	
	data.forms["nom_sg"] = {"metaþs"}
	data.forms["voc_sg"] = {"metaþ"}
	data.forms["acc_sg"] = {"metaþų"}
	data.forms["gen_sg"] = {"metadiz"}
	data.forms["dat_sg"] = {"metadi"}
	data.forms["ins_sg"] = {"metadē"}

	data.forms["nom_pl"] = {"metaþiz"}
	data.forms["voc_pl"] = data.forms["nom_pl"]
	data.forms["acc_pl"] = {"metaþunz"}
	data.forms["gen_pl"] = {"metadǫ̂"}
	data.forms["dat_pl"] = {"metadumaz"}
	data.forms["ins_pl"] = {"metadumiz"}

	table.insert(data.categories, "Proto-Germanic consonant stem nouns")
end

irreg_data["mili"] = function(args, data)
	data.decl_type = "neuter consonant stem"
	
	data.forms["nom_sg"] = {"mili"}
	data.forms["voc_sg"] = data.forms["nom_sg"]
	data.forms["acc_sg"] = data.forms["nom_sg"]
	data.forms["gen_sg"] = {"milidiz"}
	data.forms["dat_sg"] = {"milidi"}
	data.forms["ins_sg"] = {"milidē"}

	table.insert(data.categories, "Proto-Germanic consonant stem nouns")
end

irreg_data["stuþs"] = function(args, data)
	data.decl_type = "consonant stem"
	
	data.forms["nom_sg"] = {"stuþs"}
	data.forms["voc_sg"] = {"stuþ"}
	data.forms["acc_sg"] = {"stuþų"}
	data.forms["gen_sg"] = {"studiz"}
	data.forms["dat_sg"] = {"studi"}
	data.forms["ins_sg"] = {"studē"}

	data.forms["nom_pl"] = {"stuþiz"}
	data.forms["voc_pl"] = data.forms["nom_pl"]
	data.forms["acc_pl"] = {"stuþunz"}
	data.forms["gen_pl"] = {"studǫ̂"}
	data.forms["dat_pl"] = {"studumaz"}
	data.forms["ins_pl"] = {"studumiz"}

	table.insert(data.categories, "Proto-Germanic consonant stem nouns")
end

irreg_data["sūz"] = function(args, data)
	data.decl_type = "consonant stem"
	
	data.forms["nom_sg"] = {"sūz"}
	data.forms["voc_sg"] = {"sū"}
	data.forms["acc_sg"] = {"suwų"}
	data.forms["gen_sg"] = {"suwiz"}
	data.forms["dat_sg"] = {"suwi"}
	data.forms["ins_sg"] = {"sūē"}

	data.forms["nom_pl"] = {"suwiz"}
	data.forms["voc_pl"] = data.forms["nom_pl"]
	data.forms["acc_pl"] = {"suwunz"}
	data.forms["gen_pl"] = {"sūǫ̂"}
	data.forms["dat_pl"] = {"suwumaz"}
	data.forms["ins_pl"] = {"suwumiz"}

	table.insert(data.categories, "Proto-Germanic consonant stem nouns")
end

irreg_data["tanþs"] = function(args, data)
	data.decl_type = "consonant stem"
	
	data.forms["nom_sg"] = {"tanþs"}
	data.forms["voc_sg"] = {"tanþ"}
	data.forms["acc_sg"] = {"tanþų"}
	data.forms["gen_sg"] = {"tundiz"}
	data.forms["dat_sg"] = {"tundi"}
	data.forms["ins_sg"] = {"tundē"}

	data.forms["nom_pl"] = {"tanþiz"}
	data.forms["voc_pl"] = data.forms["nom_pl"]
	data.forms["acc_pl"] = {"tanþunz"}
	data.forms["gen_pl"] = {"tundǫ̂"}
	data.forms["dat_pl"] = {"tundumaz"}
	data.forms["ins_pl"] = {"tundumiz"}

	table.insert(data.categories, "Proto-Germanic consonant stem nouns")
end

irreg_data["wrōts"] = function(args, data)
	data.decl_type = "consonant stem"
	
	data.forms["nom_sg"] = {"wrōts"}
	data.forms["voc_sg"] = {"wrōt"}
	data.forms["acc_sg"] = {"wrōtų"}
	data.forms["gen_sg"] = {"wurtiz"}
	data.forms["dat_sg"] = {"wurti"}
	data.forms["ins_sg"] = {"wurtē"}

	data.forms["nom_pl"] = {"wrōtiz"}
	data.forms["voc_pl"] = data.forms["nom_pl"]
	data.forms["acc_pl"] = {"wrōtunz"}
	data.forms["gen_pl"] = {"wurtǫ̂"}
	data.forms["dat_pl"] = {"wurtumaz"}
	data.forms["ins_pl"] = {"wurtumiz"}

	table.insert(data.categories, "Proto-Germanic consonant stem nouns")
end

------ i-stems ------

irreg_data["burþiz"] = function(args, data)
	if not args[1] then
		irreg_data["burþiz"]({""}, data)
		return
	end
	
	data.decl_type = "i-stem"
	
	data.forms["nom_sg"] = {args[1] .. "burþiz"}
	data.forms["voc_sg"] = {args[1] .. "burþi"}
	data.forms["acc_sg"] = {args[1] .. "burþį"}
	data.forms["gen_sg"] = {args[1] .. "burdīz"}
	data.forms["dat_sg"] = {args[1] .. "burdī"}
	data.forms["ins_sg"] = {args[1] .. "burdī"}

	data.forms["nom_pl"] = {args[1] .. "burþīz"}
	data.forms["voc_pl"] = data.forms["nom_pl"]
	data.forms["acc_pl"] = {args[1] .. "burþīnz"}
	data.forms["gen_pl"] = {args[1] .. "burdijǫ̂"}
	data.forms["dat_pl"] = {args[1] .. "burdimaz"}
	data.forms["ins_pl"] = {args[1] .. "burdimiz"}

	table.insert(data.categories, "Proto-Germanic i-stem nouns")
end

irreg_data["fraburþiz"] = function(args, data)
	irreg_data["burþiz"]({"fra"}, data)
end

irreg_data["gaburþiz"] = function(args, data)
	irreg_data["burþiz"]({"ga"}, data)
end

irreg_data["kinþiz"] = function(args, data)
	data.decl_type = "i-stem"
	
	data.forms["nom_sg"] = {"kinþiz"}
	data.forms["voc_sg"] = {"kinþi"}
	data.forms["acc_sg"] = {"kinþį"}
	data.forms["gen_sg"] = {"kundīz"}
	data.forms["dat_sg"] = {"kundī"}
	data.forms["ins_sg"] = {"kundī"}

	data.forms["nom_pl"] = {"kinþīz"}
	data.forms["voc_pl"] = data.forms["nom_pl"]
	data.forms["acc_pl"] = {"kinþīnz"}
	data.forms["gen_pl"] = {"kundijǫ̂"}
	data.forms["dat_pl"] = {"kundimaz"}
	data.forms["ins_pl"] = {"kundimiz"}

	table.insert(data.categories, "Proto-Germanic i-stem nouns")
end

irreg_data["kumþiz"] = function(args, data)
	data.decl_type = "i-stem"
	
	data.forms["nom_sg"] = {"kumþiz"}
	data.forms["voc_sg"] = {"kumþi"}
	data.forms["acc_sg"] = {"kumþį"}
	data.forms["gen_sg"] = {"kundīz"}
	data.forms["dat_sg"] = {"kundī"}
	data.forms["ins_sg"] = {"kundī"}

	data.forms["nom_pl"] = {"kumþīz"}
	data.forms["voc_pl"] = data.forms["nom_pl"]
	data.forms["acc_pl"] = {"kumþīnz"}
	data.forms["gen_pl"] = {"kundijǫ̂"}
	data.forms["dat_pl"] = {"kundimaz"}
	data.forms["ins_pl"] = {"kundimiz"}

	table.insert(data.categories, "Proto-Germanic i-stem nouns")
end

------ u-stems ------

irreg_data["grunduz"] = function(args, data)
	data.decl_type = "u-stem"
	
	data.forms["nom_sg"] = {"grumþuz"}
	data.forms["voc_sg"] = {"grumþu"}
	data.forms["acc_sg"] = {"grumþų"}
	data.forms["gen_sg"] = {"grundauz"}
	data.forms["dat_sg"] = {"grundiwi"}
	data.forms["ins_sg"] = {"grundū"}

	data.forms["nom_pl"] = {"grumþiwiz"}
	data.forms["voc_pl"] = data.forms["nom_pl"]
	data.forms["acc_pl"] = {"grumþunz"}
	data.forms["gen_pl"] = {"grundiwǫ̂"}
	data.forms["dat_pl"] = {"grundumaz"}
	data.forms["ins_pl"] = {"grundumiz"}

	table.insert(data.categories, "Proto-Germanic u-stem nouns")
end

------ i/jo stems ------

irreg_data["akwisī"] = function(args, data)
	data.decl_type = "ī/jō-stem"
	
	data.forms["nom_sg"] = {"akwisī"}
	data.forms["voc_sg"] = data.forms["nom_sg"]
	data.forms["acc_sg"] = {"akuzijǭ"}
	data.forms["gen_sg"] = {"akuzijōz"}
	data.forms["dat_sg"] = {"akuzijōi"}
	data.forms["ins_sg"] = {"akuzijō"}

	data.forms["nom_pl"] = {"akuzijôz"}
	data.forms["voc_pl"] = data.forms["nom_pl"]
	data.forms["acc_pl"] = {"akuzijōz"}
	data.forms["gen_pl"] = {"akuzijǫ̂"}
	data.forms["dat_pl"] = {"akuzijōmaz"}
	data.forms["ins_pl"] = {"akuzijōmiz"}

	table.insert(data.categories, "Proto-Germanic ī/jō-stem nouns")
end

------ n-stems ------

irreg_data["abô"] = function(args, data)
	data.decl_type = "masculine an-stem"
	
	data.forms["nom_sg"] = {"abô"}
	data.forms["voc_sg"] = data.forms["nom_sg"]
	data.forms["acc_sg"] = {"abanų"}
	data.forms["gen_sg"] = {"abniz"}
	data.forms["dat_sg"] = {"abni"}
	data.forms["ins_sg"] = {"abnē"}

	data.forms["nom_pl"] = {"abniz"}
	data.forms["voc_pl"] = data.forms["nom_pl"]
	data.forms["acc_pl"] = {"abnuz"}
	data.forms["gen_pl"] = {"abnǫ̂"}
	data.forms["dat_pl"] = {"abnamaz"}
	data.forms["ins_pl"] = {"abnamiz"}

	table.insert(data.categories, "Proto-Germanic an-stem nouns")
end

irreg_data["namô"] = function(args, data)
	data.decl_type = "neuter an-stem"
	
	data.forms["nom_sg"] = {"namô"}
	data.forms["voc_sg"] = data.forms["nom_sg"]
	data.forms["acc_sg"] = data.forms["nom_sg"]
	data.forms["gen_sg"] = {"namniz"}
	data.forms["dat_sg"] = {"namni"}
	data.forms["ins_sg"] = {"namnē"}

	data.forms["nom_pl"] = {"namnō"}
	data.forms["voc_pl"] = data.forms["nom_pl"]
	data.forms["acc_pl"] = data.forms["nom_pl"]
	data.forms["gen_pl"] = {"namnǫ̂"}
	data.forms["dat_pl"] = {"namnamaz"}
	data.forms["ins_pl"] = {"namnamiz"}

	table.insert(data.categories, "Proto-Germanic an-stem nouns")
end

irreg_data["sēmô"] = function(args, data)
	data.decl_type = "neuter an-stem"
	
	data.forms["nom_sg"] = {"sēmô"}
	data.forms["voc_sg"] = data.forms["nom_sg"]
	data.forms["acc_sg"] = data.forms["nom_sg"]
	data.forms["gen_sg"] = {"sēmniz"}
	data.forms["dat_sg"] = {"sēmni"}
	data.forms["ins_sg"] = {"sēmnē"}

	data.forms["nom_pl"] = {"sēmnō"}
	data.forms["voc_pl"] = data.forms["nom_pl"]
	data.forms["acc_pl"] = data.forms["nom_pl"]
	data.forms["gen_pl"] = {"sēmnǫ̂"}
	data.forms["dat_pl"] = {"sēmnamaz"}
	data.forms["ins_pl"] = {"sēmnamiz"}

	table.insert(data.categories, "Proto-Germanic an-stem nouns")
end

irreg_data["uhsô"] = function(args, data)
	data.decl_type = "masculine an-stem"
	
	data.forms["nom_sg"] = {"uhsô"}
	data.forms["voc_sg"] = data.forms["nom_sg"]
	data.forms["acc_sg"] = {"uhsanų"}
	data.forms["gen_sg"] = {"uhsniz"}
	data.forms["dat_sg"] = {"uhsni"}
	data.forms["ins_sg"] = {"uhsnē"}

	data.forms["nom_pl"] = {"uhsniz"}
	data.forms["voc_pl"] = data.forms["nom_pl"]
	data.forms["acc_pl"] = {"uhsnuz"}
	data.forms["gen_pl"] = {"uhsnǫ̂"}
	data.forms["dat_pl"] = {"uhsnamaz"}
	data.forms["ins_pl"] = {"uhsnamiz"}

	table.insert(data.categories, "Proto-Germanic an-stem nouns")
end

irreg_data["hesô"] = function(args, data)
	data.decl_type = "masculine an-stem"
	
	data.forms["nom_sg"] = {"hesô"}
	data.forms["voc_sg"] = data.forms["nom_sg"]
	data.forms["acc_sg"] = {"hesanų"}
	data.forms["gen_sg"] = {"hazniz"}
	data.forms["dat_sg"] = {"hazni"}
	data.forms["ins_sg"] = {"haznē"}

	data.forms["nom_pl"] = {"hesniz"}
	data.forms["voc_pl"] = data.forms["nom_pl"]
	data.forms["acc_pl"] = {"hesnuz"}
	data.forms["gen_pl"] = {"haznǫ̂"}
	data.forms["dat_pl"] = {"haznamaz"}
	data.forms["ins_pl"] = {"haznamiz"}

	table.insert(data.categories, "Proto-Germanic an-stem nouns")
end

irreg_data["maþô"] = function(args, data)
	data.decl_type = "masculine an-stem"
	
	data.forms["nom_sg"] = {"maþô"}
	data.forms["voc_sg"] = data.forms["nom_sg"]
	data.forms["acc_sg"] = {"maþanų"}
	data.forms["gen_sg"] = {"muttaz"}
	data.forms["dat_sg"] = {"madini"}
	data.forms["ins_sg"] = {"muttē"}

	data.forms["nom_pl"] = {"maþaniz"}
	data.forms["voc_pl"] = data.forms["nom_pl"]
	data.forms["acc_pl"] = {"muttunz"}
	data.forms["gen_pl"] = {"muttǫ̂"}
	data.forms["dat_pl"] = {"madummiz"}
	data.forms["ins_pl"] = {"muttamiz"}

	table.insert(data.categories, "Proto-Germanic irregular nouns")
end

irreg_data["tōgô"] = function(args, data)
	data.decl_type = "masculine an-stem"
	
	data.forms["nom_sg"] = {"tōgô"}
	data.forms["voc_sg"] = data.forms["nom_sg"]
	data.forms["acc_sg"] = {"taganų"}
	data.forms["gen_sg"] = {"takkaz"}
	data.forms["dat_sg"] = {"tagini"}
	data.forms["ins_sg"] = {"takkē"}

	data.forms["nom_pl"] = {"tōganiz"}
	data.forms["voc_pl"] = data.forms["nom_pl"]
	data.forms["acc_pl"] = {"takkunz"}
	data.forms["gen_pl"] = {"takkǫ̂"}
	data.forms["dat_pl"] = {"tagummiz"}
	data.forms["ins_pl"] = {"takkamiz"}

	table.insert(data.categories, "Proto-Germanic irregular nouns")
end

irreg_data["mōhô"] = function(args, data)
	data.decl_type = "masculine an-stem"
	
	data.forms["nom_sg"] = {"mōhô"}
	data.forms["voc_sg"] = data.forms["nom_sg"]
	data.forms["acc_sg"] = {"mōhanų"}
	data.forms["gen_sg"] = {"makkaz"}
	data.forms["dat_sg"] = {"magini"}
	data.forms["ins_sg"] = {"makkē"}

	data.forms["nom_pl"] = {"mōhaniz"}
	data.forms["voc_pl"] = data.forms["nom_pl"]
	data.forms["acc_pl"] = {"makkunz"}
	data.forms["gen_pl"] = {"makkǫ̂"}
	data.forms["dat_pl"] = {"magummiz"}
	data.forms["ins_pl"] = {"makkamiz"}

	table.insert(data.categories, "Proto-Germanic irregular nouns")
end

irreg_data["bijǭ"] = function(args, data)
	data.decl_type = "feminine on-stem"
	
	data.forms["nom_sg"] = {"bijǭ"}
	data.forms["voc_sg"] = data.forms["nom_sg"]
	data.forms["acc_sg"] = {"bijōnų"}
	data.forms["gen_sg"] = {"biniz"}
	data.forms["dat_sg"] = {"binini"}
	data.forms["ins_sg"] = {"binē"}

	data.forms["nom_pl"] = {"bijōniz"}
	data.forms["voc_pl"] = data.forms["nom_pl"]
	data.forms["acc_pl"] = {"binunz"}
	data.forms["gen_pl"] = {"binǫ̂"}
	data.forms["dat_pl"] = {"bijummiz"}
	data.forms["ins_pl"] = {"binōmiz"}

	table.insert(data.categories, "Proto-Germanic irregular nouns")
end

irreg_data["tīgô"] = function(args, data)
	data.decl_type = "masculine an-stem"
	
	data.forms["nom_sg"] = {"tīgô"}
	data.forms["voc_sg"] = data.forms["nom_sg"]
	data.forms["acc_sg"] = {"tīganų"}
	data.forms["gen_sg"] = {"tikkaz"}
	data.forms["dat_sg"] = {"tigini"}
	data.forms["ins_sg"] = {"tikkē"}

	data.forms["nom_pl"] = {"tīganiz"}
	data.forms["voc_pl"] = data.forms["nom_pl"]
	data.forms["acc_pl"] = {"tikkunz"}
	data.forms["gen_pl"] = {"tikkǫ̂"}
	data.forms["dat_pl"] = {"tigummiz"}
	data.forms["ins_pl"] = {"tikkamiz"}

	table.insert(data.categories, "Proto-Germanic irregular nouns")
end

irreg_data["wīwô"] = function(args, data)
	data.decl_type = "masculine an-stem"
	
	data.forms["nom_sg"] = {"wīwô"}
	data.forms["voc_sg"] = data.forms["nom_sg"]
	data.forms["acc_sg"] = {"wīwanų"}
	data.forms["gen_sg"] = {"wiunaz"}
	data.forms["dat_sg"] = {"wiwini"}
	data.forms["ins_sg"] = {"wiunē"}

	data.forms["nom_pl"] = {"wīwaniz"}
	data.forms["voc_pl"] = data.forms["nom_pl"]
	data.forms["acc_pl"] = {"wiununz"}
	data.forms["gen_pl"] = {"wiunǫ̂"}
	data.forms["dat_pl"] = {"wiwummiz"}
	data.forms["ins_pl"] = {"wiunamiz"}

	table.insert(data.categories, "Proto-Germanic irregular nouns")
end

irreg_data["brahsm-"] = function(args, data)
	data.decl_type = "masculine an-stem"
	
	data.forms["nom_sg"] = {"brahsmô"}
	data.forms["voc_sg"] = data.forms["nom_sg"]
	data.forms["acc_sg"] = {"brahsmanų"}
	data.forms["gen_sg"] = {"bruhsnaz"}
	data.forms["dat_sg"] = {"bruhsmini"}
	data.forms["ins_sg"] = {"bruhsnē"}

	data.forms["nom_pl"] = {"brahsmaniz"}
	data.forms["voc_pl"] = data.forms["nom_pl"]
	data.forms["acc_pl"] = {"bruhsnunz"}
	data.forms["gen_pl"] = {"bruhsnǫ̂"}
	data.forms["dat_pl"] = {"bruhsmummiz"}
	data.forms["ins_pl"] = {"bruhsnamiz"}

	table.insert(data.categories, "Proto-Germanic irregular nouns")
end

irreg_data["hrīþô"] = function(args, data)
	data.decl_type = "masculine an-stem"
	
	data.forms["nom_sg"] = {"hrīþô"}
	data.forms["voc_sg"] = data.forms["nom_sg"]
	data.forms["acc_sg"] = {"hrīþanų"}
	data.forms["gen_sg"] = {"hrittaz"}
	data.forms["dat_sg"] = {"hridini"}
	data.forms["ins_sg"] = {"hrittē"}

	data.forms["nom_pl"] = {"hrīþaniz"}
	data.forms["voc_pl"] = data.forms["nom_pl"]
	data.forms["acc_pl"] = {"hrittunz"}
	data.forms["gen_pl"] = {"hrittǫ̂"}
	data.forms["dat_pl"] = {"hridummiz"}
	data.forms["ins_pl"] = {"hrittamiz"}

	table.insert(data.categories, "Proto-Germanic irregular nouns")
end

irreg_data["kradô"] = function(args, data)
	data.decl_type = "masculine an-stem"
	
	data.forms["nom_sg"] = {"kradô"}
	data.forms["voc_sg"] = data.forms["nom_sg"]
	data.forms["acc_sg"] = {"kradanų"}
	data.forms["gen_sg"] = {"krattaz"}
	data.forms["dat_sg"] = {"kradini"}
	data.forms["ins_sg"] = {"krattē"}

	data.forms["nom_pl"] = {"kradaniz"}
	data.forms["voc_pl"] = data.forms["nom_pl"]
	data.forms["acc_pl"] = {"krattunz"}
	data.forms["gen_pl"] = {"krattǫ̂"}
	data.forms["dat_pl"] = {"kradummiz"}
	data.forms["ins_pl"] = {"krattamiz"}

	table.insert(data.categories, "Proto-Germanic irregular nouns")
end

irreg_data["hrīmô"] = function(args, data)
	data.decl_type = "masculine an-stem"
	
	data.forms["nom_sg"] = {"hrīmô"}
	data.forms["voc_sg"] = data.forms["nom_sg"]
	data.forms["acc_sg"] = {"hrīmanų"}
	data.forms["gen_sg"] = {"hrīpaz"}
	data.forms["dat_sg"] = {"hrīmini"}
	data.forms["ins_sg"] = {"hrīpē"}

	data.forms["nom_pl"] = {"hrīmaniz"}
	data.forms["voc_pl"] = data.forms["nom_pl"]
	data.forms["acc_pl"] = {"hrīpunz"}
	data.forms["gen_pl"] = {"hrīpǫ̂"}
	data.forms["dat_pl"] = {"hrīmummiz"}
	data.forms["ins_pl"] = {"hrīpamiz"}

	table.insert(data.categories, "Proto-Germanic irregular nouns")
end

------ ō-stems ------

irreg_data["mēþwō"] = function(args, data)
	data.decl_type = "ō-stem"
	
	data.forms["nom_sg"] = {"mēþwō"}
	data.forms["voc_sg"] = data.forms["nom_sg"]
	data.forms["acc_sg"] = {"mēþwǭ"}
	data.forms["gen_sg"] = {"madwōz"}
	data.forms["dat_sg"] = {"madwōi"}
	data.forms["ins_sg"] = {"madwō"}

	data.forms["nom_pl"] = {"mēþwôz"}
	data.forms["voc_pl"] = data.forms["nom_pl"]
	data.forms["acc_pl"] = {"mēþwōz"}
	data.forms["gen_pl"] = {"madwǫ̂"}
	data.forms["dat_pl"] = {"madwōmaz"}
	data.forms["ins_pl"] = {"madwōmiz"}

	table.insert(data.categories, "Proto-Germanic ō-stem nouns")
end

------ Miscellaneous ------

irreg_data["fōr"] = function(args, data)
	data.decl_type = "paradigm " .. args[1]
	
	data.forms["nom_sg"] = {"fōr"}
	data.forms["voc_sg"] = data.forms["nom_sg"]
	data.forms["acc_sg"] = data.forms["nom_sg"]
	
	if args[1] == "1" then
		data.forms["gen_sg"] = {"funiz"}
		data.forms["dat_sg"] = {"funi"}
		data.forms["ins_sg"] = {"funē"}
	elseif args[1] == "2" then
		data.forms["gen_sg"] = {"fuiniz"}
		data.forms["dat_sg"] = {"fuini"}
		data.forms["ins_sg"] = {"fuinē"}
	elseif args[1] == "3" then
		data.forms["gen_sg"] = {"funiniz"}
		data.forms["dat_sg"] = {"funini"}
		data.forms["ins_sg"] = {"funinē"}
	end
end

irreg_data["watōr"] = function(args, data)
	data.decl_type = "heteroclitic, irregular"
	
	data.forms["nom_sg"] = {"watōr"}
	data.forms["voc_sg"] = data.forms["nom_sg"]
	data.forms["acc_sg"] = data.forms["nom_sg"]
	data.forms["gen_sg"] = {"watiniz"}
	data.forms["dat_sg"] = {"watini"}
	data.forms["ins_sg"] = {"watinē"}

	data.forms["nom_pl"] = {"watnō"}
	data.forms["voc_pl"] = data.forms["nom_pl"]
	data.forms["acc_pl"] = data.forms["nom_pl"]
	data.forms["gen_pl"] = {"watnǫ̂"}
	data.forms["dat_pl"] = {"watnamaz"}
	data.forms["ins_pl"] = {"watnamiz"}
end

irreg_data["eudur"] = function(args, data)
	data.decl_type = "heteroclitic, irregular"
	
	data.forms["nom_sg"] = {"eudur"}
	data.forms["voc_sg"] = data.forms["nom_sg"]
	data.forms["acc_sg"] = data.forms["nom_sg"]
	data.forms["gen_sg"] = {"ūdraz"}
	data.forms["dat_sg"] = {"ūdiri"}
	data.forms["ins_sg"] = {"ūdrē"}
end

return irreg_data