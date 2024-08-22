data:extend({
  {
    type = "splitter",
    name = "kr-superior-splitter",
    localised_description = { "entity-description.splitter" },
    icon = kr_entities_icons_path .. "transport-belts/superior-transport-belt/superior-splitter.png",
    icon_size = 64,
    flags = { "placeable-neutral", "player-creation" },
    minable = { mining_time = 0.2, result = "kr-superior-splitter" },
    max_health = 250,
    corpse = "kr-superior-splitter-remnant",
    resistances = {
      {
        type = "fire",
        percent = 50,
      },
    },
    collision_box = { { -0.9, -0.4 }, { 0.9, 0.4 } },
    selection_box = { { -0.9, -0.5 }, { 0.9, 0.5 } },
    structure_animation_speed_coefficient = 1.2,
    structure_animation_movement_cooldown = 10,
    belt_animation_set = kr_superior_transport_belt_animation_set,
    fast_replaceable_group = "transport-belt",
    speed = 0.1875,
    animation_speed_coefficient = 30,
    structure = {
      north = {
        filename = kr_entities_path
          .. "transport-belts/superior-transport-belt/splitter/hr-superior-splitter-north.png",
        frame_count = 32,
        line_length = 8,
        priority = "extra-high",
        width = 160,
        height = 70,
        shift = util.by_pixel(7, 0),
        scale = 0.5,
      },
      east = {
        filename = kr_entities_path
          .. "transport-belts/superior-transport-belt/splitter/hr-superior-splitter-east.png",
        frame_count = 32,
        line_length = 8,
        priority = "extra-high",
        width = 90,
        height = 84,
        shift = util.by_pixel(4, 13),
        scale = 0.5,
      },
      south = {
        filename = kr_entities_path
          .. "transport-belts/superior-transport-belt/splitter/hr-superior-splitter-south.png",
        frame_count = 32,
        line_length = 8,
        priority = "extra-high",
        width = 164,
        height = 64,
        shift = util.by_pixel(4, 0),
        scale = 0.5,
      },
      west = {
        filename = kr_entities_path
          .. "transport-belts/superior-transport-belt/splitter/hr-superior-splitter-west.png",
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
        filename = kr_entities_path
          .. "transport-belts/superior-transport-belt/splitter/hr-superior-splitter-east-top_patch.png",
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
        filename = kr_entities_path
          .. "transport-belts/superior-transport-belt/splitter/hr-superior-splitter-west-top_patch.png",
        frame_count = 32,
        line_length = 8,
        priority = "extra-high",
        width = 90,
        height = 96,
        shift = util.by_pixel(6, -18),
        scale = 0.5,
      },
    },
  },
})
