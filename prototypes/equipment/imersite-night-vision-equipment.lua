data:extend({
  {
    type = "recipe",
    name = "imersite-night-vision-equipment",
    enabled = false,
    energy_required = 10,
    category = "crafting-with-fluid",
    ingredients = {
      { type = "item", name = "night-vision-equipment", amount = 1 },
      { type = "item", name = "low-density-structure", amount = 10 },
      { type = "item", name = "advanced-circuit", amount = 10 },
      { type = "item", name = "imersite-crystal", amount = 5 },
      { type = "fluid", name = "nitric-acid", amount = 25 },
    },
    results = { { type = "item", name = "imersite-night-vision-equipment", amount = 1 } },
  },
  {
    type = "item",
    name = "imersite-night-vision-equipment",
    icons = {
      { icon = "__Krastorio2Assets__/icons/equipments/character/imersite-night-vision-equipment.png", icon_size = 64 },
      { icon = "__Krastorio2Assets__/icons/equipments/tiers/2.png", icon_size = 64 },
    },
    placed_as_equipment_result = "imersite-night-vision-equipment",
    subgroup = "character-equipment",
    order = "f[night-vision]-b[imersite-night-vision-equipment]",
    stack_size = 10,
  },
  {
    type = "night-vision-equipment",
    name = "imersite-night-vision-equipment", -- TODO: Rename to `superior-night-vision-equipment`
    sprite = {
      filename = "__Krastorio2Assets__/equipments/character/imersite-night-vision-equipment.png",
      width = 128,
      height = 128,
      priority = "medium",
      scale = 0.5,
    },
    shape = {
      width = 1,
      height = 1,
      type = "full",
    },
    energy_source = {
      type = "electric",
      buffer_capacity = "180kJ",
      input_flow_limit = "360kW",
      usage_priority = "primary-input",
    },
    categories = { "armor" },
    energy_input = "15kW",
    darkness_to_turn_on = 0.45,
    color_lookup = { { 0.75, "__Krastorio2Assets__/others/nightvision-2.png" } },
  },
})
