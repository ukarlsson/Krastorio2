krastorio.matter_func = {}

-- -- -- PUBLIC

-- For use this functions call it with (ex):
-- local matter = require("__Krastorio__/lib/matter-util")
-- matter.whatfunctionyouwant()

--[[
	This function will create two recipes for convert one item to matter
	and the recipe for re-convert into the original(or another) item using matter,
	for the two(or one) generated recipes will be add a limitation on productivity modules too
	
	Can be converted only items, fluids and tools(science pack), not other items is accepted for conversions
	
	This is how must be defined the args table, only argument of function call
	(the first tree variable is mandatory, the other is optional)
	args=
	{
		item_name = a, -- (string) the name of raw product 
		minimum_conversion_quantity = b, -- (integer) the quantity of item necessary to make one conversion and the returned quantity
		matter_value = c, -- (integer) how much matter is gained by conversion and necessary to create the item from matter(minimum_conversion_quantity corresponds to matter_value)
		return_item = d, -- (optional)(string) if the return item from the decoversion(matter to item) is different from the first one
		unlocked_by_technology = e -- (optional)(string) what technology(the name) unlock the recipes, if isn't setted will be the first that make access to matter conversions
		energy_required = f, -- (optional)(integer) how much time need the conversion
		only_conversion = g, -- (optional)(boolean) if this param is true will be added only the recipe to get matter from the item, but not the deconversion from matter
		only_deconversion = h, -- (optional)(boolean) if this param is true will be added only the recipe to get the item(or return_item) from matter, but not the conversion to matter
		need_stabilizer = i, (optional)(boolean) if the item need stabilizer to be deconverted from matter to the original item(or return_item)
		allow_productivity = l, (optional)(boolean) if true, productivity modules can be used on de-conversion from matter (matter->item)
	}
]]--
-- @args, all defined arguments of function
function krastorio.matter_func.createMatterRecipe(args)

	local _item = krastorio.items.getItem(args.item_name)
	local true_item_type = _item.type
	if true_item_type == "tool" then
		true_item_type = "item"
	end

	if _item then
	
		local _return_item = krastorio.items.getItem(args.return_item)				
		if not _return_item then
			_return_item = _item
		end
		local true_return_item_type = _return_item.type	
		if true_return_item_type == "tool" then
			true_return_item_type = "item"
		end
		
		local _energy_required = args.energy_required or 2
		
		local _technology = args.unlocked_by_technology or "k-matter"

		if args.only_deconversion == nil or args.only_deconversion ~= true then
			local item_to_matter = 
			{
				type = "recipe",
				name = _item.name .. "-to-matter",
				localised_name={"recipe-name.to-matter", {true_item_type .. "-name." .. _item.name}},
				category = "matter-extraction",
				subgroup = "raw-to-matter",
				icons = 
				{
					{ icon = krstr_icon_path .. "arrows/arrow-m.png", icon_size = 64 },
					{ icon = _item.icon,                              icon_size = _item.icon_size, scale = 0.28 * (64/_item.icon_size), shift = {-8, -6} },
					{ icon = krstr_icon_path .. "matter.png",         icon_size = 64,              scale = 0.28,                        shift = {4, 8} }
				},
				energy_required = _energy_required,
				enabled = false,
				hidden = true,
				hide_from_player_crafting = true,
				always_show_made_in = true,
				always_show_products = true,
				show_amount_in_title = false,
				ingredients =
				{
					{ type = true_item_type, name = _item.name, amount = args.minimum_conversion_quantity }
				},
				results=
				{
					{ type = "fluid", name = "k-matter", amount = args.matter_value }
				},
				order = "z[".. _item.name .."-to-matter]"
			}
			data:extend({item_to_matter})
			krastorio.technologies.addUnlockRecipe(_technology, item_to_matter.name)
		end
		
		if args.only_conversion == nil or args.only_conversion ~= true then
			local stab_string = ""
			if args.need_stabilizer ~= nil and args.need_stabilizer == true then
				stab_string = "-with-stabilizer"
			end
		
			local matter_to_item = 
			{
				type = "recipe",
				name = "matter-to-".. _return_item.name,
				localised_name={"recipe-name.matter-to", {true_return_item_type .. "-name." .. _item.name}},
				category = "matter-usage",
				subgroup = "matter-to-" .. _return_item.type .. stab_string,
				icons = 
				{
					{ icon = krstr_icon_path .. "arrows/arrow-i.png", icon_size = 64 },
					{ icon = krstr_icon_path .. "matter.png",         icon_size = 64,                     scale = 0.28,                               shift = {8, -6} },
					{ icon = _return_item.icon,                       icon_size = _return_item.icon_size, scale = 0.28 * (64/_return_item.icon_size), shift = {-4, 8} }
				},
				energy_required = _energy_required,
				enabled = false,
				hide_from_player_crafting = true,
				always_show_made_in = true,
				always_show_products = true,
				show_amount_in_title = false,
				ingredients =
				{
					{ type = "fluid", name = "k-matter", amount = args.matter_value}
				},
				results=
				{
					{ type = true_return_item_type, name = _return_item.name, amount = args.minimum_conversion_quantity}
				},
				order = "z[matter-to-".. _return_item.name .."]"
			}		
			
			if args.need_stabilizer ~= nil and args.need_stabilizer == true then
				matter_to_item.localised_description = {"recipe-description.matter-recipe-with-stabilizer"}
				table.insert(matter_to_item.ingredients, {type="item", name="matter-stabilizer", amount=1, catalyst_amount = 1})
				table.insert(matter_to_item.results,     {type="item", name="empty-matter-stabilizer", probability = 0.99, amount=1, amount_max = 1, catalyst_amount = 1})
			end
			
			data:extend({matter_to_item})
			krastorio.technologies.addUnlockRecipe(_technology, matter_to_item.name)
			if args.allow_productivity then
				krastorio.modules.addProductivityLimitation(matter_to_item.name)
			end
		end
		
	end
		
end

--[[
	This is the argument that must be given for remove a matter recipe:
	
	item_name, -- (string) the name of raw product 
	return_item -- (optional)(string) if the return item from the decoversion(matter to item) is different from the first one
--]]
-- @item_name
-- @return_item
function krastorio.matter_func.removeMatterRecipe(item_name, return_item)

	local _item = krastorio.items.getItem(item_name)
	local _return_item = krastorio.items.getItem(return_item)
	if not _return_item then
		_return_item = _item
	end
	local matter_recipe_name = _item.name .. "-to-matter"
	local de_matter_recipe_name = "matter-to-".. _return_item.name
	
	if krastorio.recipes.exist(matter_recipe_name) then
		krastorio.modules.removeProductivityLimitation(matter_recipe_name)
		data.raw.recipe[matter_recipe_name] = nil 
		krastorio.technologies.removeUnlockRecipeFromAllTechnologies(matter_recipe_name)
	end	
		
	if krastorio.recipes.exist(de_matter_recipe_name) then
		krastorio.modules.removeProductivityLimitation(de_matter_recipe_name)
		data.raw.recipe[de_matter_recipe_name] = nil 
		krastorio.technologies.removeUnlockRecipeFromAllTechnologies(de_matter_recipe_name)
	end	
	
end


function krastorio.matter_func.removeAllKrastorioMatterRecipes()
	krastorio.matter_func.removeMatterRecipe("wood")
	krastorio.matter_func.removeMatterRecipe("iron-ore")
	krastorio.matter_func.removeMatterRecipe("copper-ore")
	krastorio.matter_func.removeMatterRecipe("sand")
	krastorio.matter_func.removeMatterRecipe("stone")
	krastorio.matter_func.removeMatterRecipe("coal")
	krastorio.matter_func.removeMatterRecipe("water")
	krastorio.matter_func.removeMatterRecipe("k-pure-water")
	krastorio.matter_func.removeMatterRecipe("crude-oil")
	krastorio.matter_func.removeMatterRecipe("gold-ore")
	krastorio.matter_func.removeMatterRecipe("uranium-ore")
	krastorio.matter_func.removeMatterRecipe("uranium-238")
	krastorio.matter_func.removeMatterRecipe("k-titanium")
	krastorio.matter_func.removeMatterRecipe("k-tantalum")
	krastorio.matter_func.removeMatterRecipe("menarite-powder")
	krastorio.matter_func.removeMatterRecipe("imersite-powder")
	krastorio.matter_func.removeMatterRecipe("k-quartz")
	krastorio.matter_func.removeMatterRecipe("raw-menarite")
	krastorio.matter_func.removeMatterRecipe("raw-imersite")
	krastorio.matter_func.removeMatterRecipe("automation-science-pack")
	krastorio.matter_func.removeMatterRecipe("logistic-science-pack")
	krastorio.matter_func.removeMatterRecipe("military-science-pack")
	krastorio.matter_func.removeMatterRecipe("chemical-science-pack")
	krastorio.matter_func.removeMatterRecipe("production-science-pack")
	krastorio.matter_func.removeMatterRecipe("utility-science-pack")
	-- krastorio.matter_func.removeMatterRecipe("k-experimental-data") (NOT USED)
	krastorio.matter_func.removeMatterRecipe("glass")
	krastorio.matter_func.removeMatterRecipe("sulfur")
	krastorio.matter_func.removeMatterRecipe("k-silicon")
	krastorio.matter_func.removeMatterRecipe("copper-plate")
	krastorio.matter_func.removeMatterRecipe("iron-plate")
	krastorio.matter_func.removeMatterRecipe("steel-plate")
	krastorio.matter_func.removeMatterRecipe("k-steel")
	krastorio.matter_func.removeMatterRecipe("plastic-bar")
	krastorio.matter_func.removeMatterRecipe("gold-plate")
	krastorio.matter_func.removeMatterRecipe("k-titanium-plate")
	krastorio.matter_func.removeMatterRecipe("k-tantalum-plate")
end

-- -- -- KRASTORIO ONLY (Use it if you know what you are doing)

function krastorio.matter_func.createStandardKrastorioMatterRecipes()

	-- -- Bidirectional

	-- k-matter technology
	----
	-- wood
	local wood =
	{
		item_name = "wood",
		minimum_conversion_quantity = 10, 
		matter_value = 2,
		energy_required = 1
	}
	krastorio.matter_func.createMatterRecipe(wood)
	
	-- iron_ore
	local iron_ore =
	{
		item_name = "iron-ore",
		minimum_conversion_quantity = 10, 
		matter_value = 5,
		energy_required = 1
	}
	krastorio.matter_func.createMatterRecipe(iron_ore)
	
	-- copper_ore
	local copper_ore =
	{
		item_name = "copper-ore",
		minimum_conversion_quantity = 10, 
		matter_value = 5,
		energy_required = 1
	}
	krastorio.matter_func.createMatterRecipe(copper_ore)
	----
	
	-- sand
	local sand =
	{
		item_name = "sand",
		minimum_conversion_quantity = 10, 
		matter_value = 2,
		unlocked_by_technology = "matter+sand-processing", 
		energy_required = 1
	}
	krastorio.matter_func.createMatterRecipe(sand)
	
	-- stone
	local stone =
	{
		item_name = "stone",
		minimum_conversion_quantity = 10, 
		matter_value = 3.25,
		unlocked_by_technology = "matter+stone-processing", 
		energy_required = 1
	}
	krastorio.matter_func.createMatterRecipe(stone)
	
	-- coal
	local coal =
	{
		item_name = "coal",
		minimum_conversion_quantity = 10, 
		matter_value = 3.25,
		unlocked_by_technology = "matter+coal-processing", 
		energy_required = 1
	}
	krastorio.matter_func.createMatterRecipe(coal)
		
	-- water
	local water =
	{
		item_name = "water",
		minimum_conversion_quantity = 100, 
		matter_value = 0.5,
		unlocked_by_technology = "matter+water-processing", 
		only_deconversion = true,
		energy_required = 1,
	}
	krastorio.matter_func.createMatterRecipe(water)
	
	-- pure water
	local pure_water =
	{
		item_name = "k-pure-water",
		minimum_conversion_quantity = 100, 
		matter_value = 0.5,
		unlocked_by_technology = "matter+water-processing", 
		energy_required = 1,
	}
	krastorio.matter_func.createMatterRecipe(pure_water)
		
	-- crude oil
	local crude_oil =
	{
		item_name = "crude-oil",
		minimum_conversion_quantity = 100, 
		matter_value = 10,
		unlocked_by_technology = "matter+oil-processing", 
		energy_required = 1
	}
	krastorio.matter_func.createMatterRecipe(crude_oil)
	
	-- gold-ore
	local gold_ore =
	{
		item_name = "gold-ore",
		minimum_conversion_quantity = 10, 
		matter_value = 6.5,
		unlocked_by_technology = "matter+gold-processing", 
		energy_required = 1
	}
	krastorio.matter_func.createMatterRecipe(gold_ore)
	
	-- uranium-ore
	local uranium_ore =
	{
		item_name = "uranium-ore",
		minimum_conversion_quantity = 10, 
		matter_value = 8,
		unlocked_by_technology = "matter+uranium-processing", 
		energy_required = 1
	}
	krastorio.matter_func.createMatterRecipe(uranium_ore)
	
	-- uranium 238
	local uranium_238 =
	{
		item_name = "uranium-238",
		minimum_conversion_quantity = 10,
		matter_value = 80,
		unlocked_by_technology = "matter+uranium-processing", 
		energy_required = 1
	}
	krastorio.matter_func.createMatterRecipe(uranium_238)
		
	-- titanium
	local titanium =
	{
		item_name = "k-titanium",
		minimum_conversion_quantity = 10, 
		matter_value = 10,
		unlocked_by_technology = "matter+minerals-processing", 
		energy_required = 1
	}
	krastorio.matter_func.createMatterRecipe(titanium)
	
	-- tantalum
	local tantalum =
	{
		item_name = "k-tantalum",
		minimum_conversion_quantity = 10, 
		matter_value = 10,
		unlocked_by_technology = "matter+minerals-processing", 
		energy_required = 1
	}
	krastorio.matter_func.createMatterRecipe(tantalum)

	-- menarite powder
	local menarite_powder =
	{
		item_name = "menarite-powder",
		minimum_conversion_quantity = 10, 
		matter_value = 10,
		unlocked_by_technology = "matter+minerals-processing", 
		energy_required = 1
	}
	krastorio.matter_func.createMatterRecipe(menarite_powder)	
	
	-- menarite powder
	local imersite_powder =
	{
		item_name = "imersite-powder",
		minimum_conversion_quantity = 10, 
		matter_value = 10,
		unlocked_by_technology = "matter+minerals-processing", 
		energy_required = 1
	}
	krastorio.matter_func.createMatterRecipe(imersite_powder)	
	
	-- -- Only to matter (item -> matter)
	
	-- quartz
	local quartz =
	{
		item_name = "k-quartz",
		minimum_conversion_quantity = 10, 
		matter_value = 2.25,
		unlocked_by_technology = "matter+sand-processing", 
		energy_required = 1,
		only_conversion = true
	}
	krastorio.matter_func.createMatterRecipe(quartz)
	
	-- raw-menarite
	local raw_menarite =
	{
		item_name = "raw-menarite",
		minimum_conversion_quantity = 10, 
		matter_value = 20,
		unlocked_by_technology = "matter+minerals-processing", 
		energy_required = 1,
		only_conversion = true
	}
	krastorio.matter_func.createMatterRecipe(raw_menarite)
	
	-- raw-imersite
	local raw_imersite =
	{
		item_name = "raw-imersite",
		minimum_conversion_quantity = 10, 
		matter_value = 20,
		unlocked_by_technology = "matter+minerals-processing", 
		energy_required = 1,
		only_conversion = true
	}
	krastorio.matter_func.createMatterRecipe(raw_imersite)

	-- sulfur
	local sulfur =
	{
		item_name = "sulfur",
		minimum_conversion_quantity = 10, 
		matter_value = 18,
		unlocked_by_technology = "matter-assembler-plus", 
		energy_required = 2,
		need_stabilizer = true,
		allow_productivity = true
	}
	krastorio.matter_func.createMatterRecipe(sulfur)
	
	-- -- Only from matter (matter -> item)
	-- nothing...
	
	-- -- -- Intermediate (need stabilizer)
	-- -- Only from matter (matter -> item)
	
	-- science
	
	-- automation-science-pack
	local automation_science_pack =
	{
		item_name = "automation-science-pack",
		minimum_conversion_quantity = 5, 
		matter_value = 9,
		unlocked_by_technology = "matter-is-science", 
		energy_required = 5,
		only_deconversion = true,
		need_stabilizer = true,
		allow_productivity = true
	}
	krastorio.matter_func.createMatterRecipe(automation_science_pack)
	
	-- logistic-science-pack
	local logistic_science_pack =
	{
		item_name = "logistic-science-pack",
		minimum_conversion_quantity = 5, 
		matter_value = 19,
		unlocked_by_technology = "matter-is-science", 
		energy_required = 5,
		only_deconversion = true,
		need_stabilizer = true,
		allow_productivity = true
	}
	krastorio.matter_func.createMatterRecipe(logistic_science_pack)
	
	-- military-science-pack
	local military_science_pack =
	{
		item_name = "military-science-pack",
		minimum_conversion_quantity = 5, 
		matter_value = 37,
		unlocked_by_technology = "matter-is-science", 
		energy_required = 5,
		only_deconversion = true,
		need_stabilizer = true,
		allow_productivity = true
	}
	krastorio.matter_func.createMatterRecipe(military_science_pack)
	
	-- chemical-science-pack
	local chemical_science_pack =
	{
		item_name = "chemical-science-pack",
		minimum_conversion_quantity = 5, 
		matter_value = 60,
		unlocked_by_technology = "matter-is-science", 
		energy_required = 5,
		only_deconversion = true,
		need_stabilizer = true,
		allow_productivity = true
	}
	krastorio.matter_func.createMatterRecipe(chemical_science_pack)
	
	-- production-science-pack
	local production_science_pack =
	{
		item_name = "production-science-pack",
		minimum_conversion_quantity = 5, 
		matter_value = 388,
		unlocked_by_technology = "matter-is-science", 
		energy_required = 5,
		only_deconversion = true,
		need_stabilizer = true,
		allow_productivity = true
	}
	krastorio.matter_func.createMatterRecipe(production_science_pack)

	-- utility-science-pack
	local utility_science_pack =
	{
		item_name = "utility-science-pack",
		minimum_conversion_quantity = 5, 
		matter_value = 432,
		unlocked_by_technology = "matter-is-science", 
		energy_required = 5,
		only_deconversion = true,
		need_stabilizer = true,
		allow_productivity = true
	}
	krastorio.matter_func.createMatterRecipe(utility_science_pack)
	
	--[[
	k_experimental_data
	local k_experimental_data =
	{
		item_name = "k-experimental-data",
		minimum_conversion_quantity = 5, 
		matter_value = 90,
		energy_required = 50,
		only_deconversion = true,
		need_stabilizer = true,
		allow_productivity = true
	}
	krastorio.matter_func.createMatterRecipe(k_experimental_data)
	--]]
	
	-- other

	-- glass
	local glass =
	{
		item_name = "glass",
		minimum_conversion_quantity = 10, 
		matter_value = 10,
		unlocked_by_technology = "matter-assembler-plus", 
		energy_required = 2,
		only_deconversion = true,
		need_stabilizer = true,
		allow_productivity = true
	}
	krastorio.matter_func.createMatterRecipe(glass)
		
	-- k-silicon
	local k_silicon =
	{
		item_name = "k-silicon",
		minimum_conversion_quantity = 10, 
		matter_value = 7,
		unlocked_by_technology = "matter-assembler-plus", 
		energy_required = 2,
		only_deconversion = true,
		need_stabilizer = true,
		allow_productivity = true
	}
	krastorio.matter_func.createMatterRecipe(k_silicon)
	
	-- copper_plate
	local copper_plate =
	{
		item_name = "copper-plate",
		minimum_conversion_quantity = 10, 
		matter_value = 6,
		unlocked_by_technology = "matter-assembler-plus", 
		energy_required = 2,
		only_deconversion = true,
		need_stabilizer = true,
		allow_productivity = true
	}
	krastorio.matter_func.createMatterRecipe(copper_plate)
	
	-- iron_plate
	local iron_plate =
	{
		item_name = "iron-plate",
		minimum_conversion_quantity = 10, 
		matter_value = 6,
		unlocked_by_technology = "matter-assembler-plus", 
		energy_required = 2,
		only_deconversion = true,
		need_stabilizer = true,
		allow_productivity = true
	}
	krastorio.matter_func.createMatterRecipe(iron_plate)
	
	-- steel plate (vanilla)
	local steel_plate =
	{
		item_name = "steel-plate",
		minimum_conversion_quantity = 10, 
		matter_value = 18,
		unlocked_by_technology = "matter-assembler-plus", 
		energy_required = 2,
		only_deconversion = true,
		need_stabilizer = true,
		allow_productivity = true
	}
	krastorio.matter_func.createMatterRecipe(steel_plate)
	
	-- k steel 
	local k_steel =
	{
		item_name = "k-steel",
		minimum_conversion_quantity = 10, 
		matter_value = 30,
		unlocked_by_technology = "matter-assembler-plus", 
		energy_required = 2,
		only_deconversion = true,
		need_stabilizer = true,
		allow_productivity = true
	}
	krastorio.matter_func.createMatterRecipe(k_steel)

	-- plastic bar
	local plastic_bar =
	{
		item_name = "plastic-bar",
		minimum_conversion_quantity = 10, 
		matter_value = 14,
		unlocked_by_technology = "matter-assembler-plus", 
		energy_required = 2,
		only_deconversion = true,
		need_stabilizer = true,
		allow_productivity = true
	}
	krastorio.matter_func.createMatterRecipe(plastic_bar)
	
	-- gold plate
	local gold_plate =
	{
		item_name = "gold-plate",
		minimum_conversion_quantity = 10, 
		matter_value = 20,
		unlocked_by_technology = "matter-assembler-plus", 
		energy_required = 2,
		only_deconversion = true,
		need_stabilizer = true,
		allow_productivity = true
	}
	krastorio.matter_func.createMatterRecipe(gold_plate)
	
	-- titanium plate
	local titanium_plate =
	{
		item_name = "k-titanium-plate",
		minimum_conversion_quantity = 10, 
		matter_value = 40,
		unlocked_by_technology = "matter-assembler-plus", 
		energy_required = 2,
		only_deconversion = true,
		need_stabilizer = true,
		allow_productivity = true
	}
	krastorio.matter_func.createMatterRecipe(titanium_plate)
	
	-- tantalum plate
	local tantalum_plate =
	{
		item_name = "k-tantalum-plate",
		minimum_conversion_quantity = 10, 
		matter_value = 40,
		unlocked_by_technology = "matter-assembler-plus", 
		energy_required = 2,
		only_deconversion = true,
		need_stabilizer = true,
		allow_productivity = true
	}
	krastorio.matter_func.createMatterRecipe(tantalum_plate)	
	
end

-- Remove all matter recipe, and recreate the Krastorio matter recipes
-- will keep all matter recipes of other mods
function krastorio.matter_func.recreateStandardKrastorioMatterRecipes()

	krastorio.matter_func.removeAllKrastorioMatterRecipes()
	krastorio.matter_func.createStandardKrastorioMatterRecipes()
	
end


return krastorio.matter_func