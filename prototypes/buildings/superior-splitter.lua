data:extend({
  {
    type = "recipe",
    name = "kr-superior-splitter",
    energy_required = 2,
    enabled = false,
    ingredients = {
      { type = "item", name = "kr-advanced-splitter", amount = 1 },
      { type = "item", name = "imersium-gear-wheel", amount = 4 },
      { type = "item", name = "processing-unit", amount = 1 },
    },
    results = { { type = "item", name = "kr-superior-splitter", amount = 1 } },
  },
  {
    type = "item",
    name = "kr-superior-splitter",
    localised_description = { "entity-description.splitter" },
    icon = "__Krastorio2Assets__/icons/entities/superior-splitter.png",
    subgroup = "belt",
    order = "c[splitter]-e[superior-splitter]",
    place_result = "kr-superior-splitter",
    stack_size = 50,
  },
  {
    type = "splitter",
    name = "kr-superior-splitter",
    localised_description = { "entity-description.splitter" },
    icon = "__Krastorio2Assets__/icons/entities/superior-splitter.png",
    fast_replaceable_group = "transport-belt",
    flags = { "placeable-neutral", "player-creation" },
    minable = { mining_time = 0.2, result = "kr-superior-splitter" },
    collision_box = { { -0.9, -0.4 }, { 0.9, 0.4 } },
    selection_box = { { -0.9, -0.5 }, { 0.9, 0.5 } },
    speed = 0.1875,
    max_health = 250,
    corpse = "kr-superior-splitter-remnant",
    resistances = {
      {
        type = "fire",
        percent = 50,
      },
    },
    belt_animation_set = require("prototypes.buildings.superior-belt-animation-set"),
    structure = {
      north = {
        filename = "__Krastorio2Assets__/entities/superior-splitter/superior-splitter-north.png",
        frame_count = 32,
        line_length = 8,
        priority = "extra-high",
        width = 160,
        height = 70,
        shift = util.by_pixel(7, 0),
        scale = 0.5,
      },
      east = {
        filename = "__Krastorio2Assets__/entities/superior-splitter/superior-splitter-east.png",
        frame_count = 32,
        line_length = 8,
        priority = "extra-high",
        width = 90,
        height = 84,
        shift = util.by_pixel(4, 13),
        scale = 0.5,
      },
      south = {
        filename = "__Krastorio2Assets__/entities/superior-splitter/superior-splitter-south.png",
        frame_count = 32,
        line_length = 8,
        priority = "extra-high",
        width = 164,
        height = 64,
        shift = util.by_pixel(4, 0),
        scale = 0.5,
      },
      west = {
        filename = "__Krastorio2Assets__/entities/superior-splitter/superior-splitter-west.png",
        frame_count = 32,
        line_length = 8,
        priority = "extra-high",
        width = 90,
        height = 86,
        shift = util.by_pixel(6, 12),
        scale = 0.5,
      },
    },
    structure_patch = {
      north = util.empty_sprite(),
      east = {
        filename = "__Krastorio2Assets__/entities/superior-splitter/superior-splitter-east-top_patch.png",
        frame_count = 32,
        line_length = 8,
        priority = "extra-high",
        width = 90,
        height = 104,
        shift = util.by_pixel(4, -20),
        scale = 0.5,
      },
      south = util.empty_sprite(),
      west = {
        filename = "__Krastorio2Assets__/entities/superior-splitter/superior-splitter-west-top_patch.png",
        frame_count = 32,
        line_length = 8,
        priority = "extra-high",
        width = 90,
        height = 96,
        shift = util.by_pixel(6, -18),
        scale = 0.5,
      },
    },
    animation_speed_coefficient = 30,
    structure_animation_speed_coefficient = 1.2,
    structure_animation_movement_cooldown = 10,
  },
})
