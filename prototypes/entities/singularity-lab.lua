local hit_effects = require("__base__.prototypes.entity.hit-effects")
local sounds = require("__base__.prototypes.entity.sounds")

-- Labs do not support entity info icon scaling...
-- local kr_icons_size = false

-- if krastorio.general.getSafeSettingValue("kr-large-icons") then
--   kr_icons_size = true
-- end

data:extend({
  {
    type = "lab",
    name = "kr-singularity-lab",
    icon = "__Krastorio2Assets__/icons/entities/singularity-lab.png",
    icon_size = 64,
    icon_mipmaps = 4,
    flags = { "placeable-player", "player-creation" },
    minable = { mining_time = 2, result = "kr-singularity-lab" },
    max_health = 2000,
    damaged_trigger_effect = hit_effects.entity(),
    dying_explosion = "big-explosion",
    corpse = "kr-big-random-pipes-remnant",
    resistances = {
      { type = "physical", percent = 60 },
      { type = "fire", percent = 90 },
      { type = "impact", percent = 90 },
    },
    collision_box = { { -3.75, -3.75 }, { 3.75, 3.75 } },
    selection_box = { { -3.9, -3.9 }, { 3.9, 3.9 } },
    fast_replaceable_group = "assembling-machine",
    -- scale_entity_info_icon = kr_icons_size,
    off_animation = {
      layers = {
        {
          filename = "__Krastorio2Assets__/entities/singularity-lab/singularity-lab.png",
          priority = "high",
          width = 520,
          height = 500,
          shift = { 0.0, -0.1 },
          frame_count = 1,
          scale = 0.5,
        },
        {
          filename = "__Krastorio2Assets__/entities/singularity-lab/singularity-lab-sh.png",
          priority = "high",
          width = 548,
          height = 482,
          shift = { 0.22, 0.18 },
          frame_count = 1,
          draw_as_shadow = true,
          scale = 0.5,
        },
      },
    },
    on_animation = {
      layers = {
        {
          filename = "__Krastorio2Assets__/entities/singularity-lab/singularity-lab-glow-light.png",
          priority = "high",
          width = 153,
          height = 117,
          shift = { 0, -0.8 },
          frame_count = 60,
          line_length = 6,
          scale = 0.5,
          animation_speed = 0.85,
          draw_as_light = true,
        },
        {
          filename = "__Krastorio2Assets__/entities/singularity-lab/singularity-lab-glow.png",
          priority = "high",
          width = 153,
          height = 117,
          shift = { 0, -0.8 },
          frame_count = 60,
          line_length = 6,
          scale = 0.5,
          animation_speed = 0.85,
          blend_mode = "additive",
        },
        {
          filename = "__Krastorio2Assets__/entities/singularity-lab/singularity-lab-light.png",
          priority = "high",
          width = 520,
          height = 500,
          shift = { 0.0, -0.1 },
          draw_as_light = true,
          frame_count = 1,
          repeat_count = 60,
          scale = 0.5,
        },
        {
          filename = "__Krastorio2Assets__/entities/singularity-lab/singularity-lab-working.png",
          width = 520,
          height = 500,
          shift = { 0.0, -0.1 },
          frame_count = 60,
          line_length = 10,
          scale = 0.5,
          animation_speed = 0.85,
        },
        {
          filename = "__Krastorio2Assets__/entities/singularity-lab/singularity-lab-sh.png",
          priority = "medium",
          width = 548,
          height = 482,
          shift = { 0.22, 0.18 },
          frame_count = 1,
          repeat_count = 60,
          draw_as_shadow = true,
          scale = 0.5,
        },
      },
    },
    light = {
      {
        intensity = 0.95,
        size = 5,
        shift = { 0.0, -0.6 },
        color = { r = 0, g = 0.917, b = 1 },
      },
    },
    researching_speed = 1,
    inputs = {},
    vehicle_impact_sound = sounds.generic_impact,
    working_sound = {
      sound = {
        filename = "__Krastorio2Assets__/sounds/buildings/singularity-lab.ogg",
        volume = 0.5,
      },
      idle_sound = { filename = "__base__/sound/idle1.ogg", volume = 1 },
      max_sounds_per_type = 6,
      apparent_volume = 1.25,
    },
    audible_distance_modifier = 25,
    energy_source = {
      type = "electric",
      usage_priority = "secondary-input",
      --emissions_per_minute = { pollution = 10 }
    },
    energy_usage = "10MW",
    module_specification = { module_slots = 4, module_info_icon_shift = { 0, 2.1 }, module_info_icon_scale = 0.6 },
    open_sound = { filename = "__Krastorio2Assets__/sounds/buildings/open.ogg", volume = 1 },
    close_sound = { filename = "__Krastorio2Assets__/sounds/buildings/close.ogg", volume = 1 },
  },
})