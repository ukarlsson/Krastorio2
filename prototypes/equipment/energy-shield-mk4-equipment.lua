data:extend({
  {
    type = "recipe",
    name = "energy-shield-mk4-equipment",
    energy_required = 80,
    enabled = false,
    ingredients = {
      { type = "item", name = "energy-shield-mk3-equipment", amount = 5 },
      { type = "item", name = "ai-core", amount = 5 },
      { type = "item", name = "imersium-plate", amount = 10 },
    },
    results = { { type = "item", name = "energy-shield-mk4-equipment", amount = 1 } },
  },
  {
    type = "item",
    name = "energy-shield-mk4-equipment",
    localised_name = { "equipment-name.shield-generator-mk4" },
    localised_description = { "equipment-description.shield-generator-mk4" },
    icons = {
      {
        icon = "__Krastorio2Assets__/icons/equipments/universal/energy-shield-mk4-equipment.png",
        icon_size = 64,
        mipmap_count = 4,
      },
      { icon = "__Krastorio2Assets__/icons/equipments/tiers/4.png", icon_size = 64 },
    },
    placed_as_equipment_result = "energy-shield-mk4-equipment",
    subgroup = "equipment",
    order = "b[shield]-c[energy-shield-equipment-mk4]",
    stack_size = 50,
  },
  {
    type = "energy-shield-equipment",
    name = "energy-shield-mk4-equipment",
    localised_name = { "equipment-name.shield-generator-mk4" },
    localised_description = { "equipment-description.shield-generator-mk4" },
    sprite = {
      filename = "__Krastorio2Assets__/equipments/universal/energy-shield-mk4-equipment.png",
      width = 128,
      height = 128,
      scale = 0.5,
      priority = "medium",
    },
    shape = {
      type = "full",
      width = 2,
      height = 2,
    },
    max_shield_value = 300,
    energy_per_shield = "50kJ",
    energy_source = {
      type = "electric",
      usage_priority = "primary-input",
      buffer_capacity = "405kJ",
      input_flow_limit = "810kW",
    },
    categories = { "universal-equipment" },
  },
})
