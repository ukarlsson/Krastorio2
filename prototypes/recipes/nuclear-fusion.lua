-- Recipe used by fusion reactor to create steam
return
{
	{
		type = "recipe",
		name = "kr-fusion",
		category = "nuclear-fusion",
		icon = kr_recipes_icons_path .. "fusion-energy.png",
		icon_size = 64,
		energy_required = 2,
		enabled = true,
		hidden = true,
		ingredients =
		{
			{type="fluid", name="water", amount=350, catalyst_amount = 1000}
		},
		results =
		{
			{type="fluid", name="steam", amount=7000, temperature = 975}
		},
		subgroup = "intermediate-product",
		order = "z[fusion]"
    }
}