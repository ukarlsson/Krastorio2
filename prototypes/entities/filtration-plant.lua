local hit_effects = require("__base__.prototypes.entity.hit-effects")
local sounds = require("__base__.prototypes.entity.sounds")

data:extend({
  {
    type = "recipe",
    name = "kr-filtration-plant",
    energy_required = 10,
    enabled = false,
    ingredients = {
      { type = "item", name = "steel-beam", amount = 10 },
      { type = "item", name = "automation-core", amount = 3 },
      { type = "item", name = "glass", amount = 10 },
      { type = "item", name = "engine-unit", amount = 4 },
    },
    results = { { type = "item", name = "kr-filtration-plant", amount = 1 } },
  },
  {
    type = "item",
    name = "kr-filtration-plant",
    icon = "__Krastorio2Assets__/icons/entities/filtration-plant.png",
    subgroup = "production-machine",
    order = "e-b1[filtration-plant]",
    place_result = "kr-filtration-plant",
    stack_size = 50,
  },
  {
    type = "assembling-machine",
    name = "kr-filtration-plant",
    icon = "__Krastorio2Assets__/icons/entities/filtration-plant.png",
    flags = { "placeable-neutral", "placeable-player", "player-creation" },
    minable = { mining_time = 1, result = "kr-filtration-plant" },
    max_health = 1000,
    corpse = "kr-big-random-pipes-remnant",
    dying_explosion = "big-explosion",
    damaged_trigger_effect = hit_effects.entity(),
    resistances = {
      { type = "physical", percent = 50 },
      { type = "fire", percent = 50 },
      { type = "impact", percent = 50 },
    },
    fluid_boxes = {
      {
        production_type = "input",
        pipe_covers = pipecoverspictures(),
        pipe_picture = require("prototypes.entities.pipe-picture"),
        volume = 1000,
        pipe_connections = { { flow_direction = "input", direction = defines.direction.north, position = { 0, -3 } } },
      },
      {
        production_type = "output",
        pipe_covers = pipecoverspictures(),
        pipe_picture = require("prototypes.entities.pipe-picture"),
        volume = 1000,
        pipe_connections = { { flow_direction = "output", direction = defines.direction.south, position = { 0, 3 } } },
      },
      off_when_no_fluid_recipe = false,
    },
    collision_box = { { -3.25, -3.25 }, { 3.25, 3.25 } },
    selection_box = { { -3.5, -3.5 }, { 3.5, 3.5 } },
    fast_replaceable_group = "assembling-machine",
    crafting_speed = 1.0,
    crafting_categories = { "fluid-filtration" },
    scale_entity_info_icon = true,
    ingredient_count = 6,
    module_slots = 2,
    allowed_effects = { "consumption", "speed", "productivity", "pollution" },
    energy_source = {
      type = "electric",
      usage_priority = "secondary-input",
      emissions_per_minute = { pollution = 5 },
    },
    energy_usage = "500kW",
    open_sound = sounds.machine_open,
    close_sound = sounds.machine_close,
    vehicle_impact_sound = sounds.generic_impact,
    working_sound = {
      sound = { filename = "__Krastorio2Assets__/sounds/buildings/filtration-plant.ogg", volume = 0.5 },
      idle_sound = { filename = "__base__/sound/idle1.ogg" },
      apparent_volume = 1,
    },
    graphics_set = {
      animation = {
        layers = {
          {
            filename = "__Krastorio2Assets__/entities/filtration-plant/filtration-plant.png",
            priority = "high",
            width = 460,
            height = 520,
            shift = { 0, -0.2 },
            frame_count = 1,
            scale = 0.5,
          },
          {
            filename = "__Krastorio2Assets__/entities/filtration-plant/filtration-plant-sh.png",
            priority = "high",
            width = 498,
            height = 438,
            shift = { 0.33, 0.32 },
            frame_count = 1,
            scale = 0.5,
            draw_as_shadow = true,
          },
        },
      },
      working_visualisations = {
        {
          animation = {
            filename = "__Krastorio2Assets__/entities/filtration-plant/filtration-plant-working.png",
            priority = "high",
            width = 340,
            height = 370,
            shift = { 0.3, -0.59 },
            frame_count = 30,
            line_length = 6,
            animation_speed = 0.6,
            scale = 0.5,
          },
        },
        {
          apply_recipe_tint = "primary",
          animation = {
            filename = "__Krastorio2Assets__/entities/filtration-plant/filtration-plant-dirty-mask.png",
            width = 156,
            height = 120,
            scale = 0.5,
            frame_count = 30,
            line_length = 6,
            animation_speed = 0.6,
            shift = { 1.61, -1.02 },
          },
        },
        {
          apply_recipe_tint = "secondary",
          animation = {
            filename = "__Krastorio2Assets__/entities/filtration-plant/filtration-plant-clear-mask.png",
            width = 156,
            height = 120,
            scale = 0.5,
            frame_count = 30,
            line_length = 6,
            animation_speed = 0.6,
            shift = { 1.61, 1.31 },
          },
        },
      },
    },
  },
})