--entities.lua

-- assuming this is called from data.lua only
require("copy_prototype")
require("util")


local empty_circuit_connector = {
	led_red = { filename = graphics .. "empty.png", width = 1, height = 1 },
	led_green = { filename = graphics .. "empty.png", width = 1, height = 1 },
	led_blue = { filename = graphics .. "empty.png", width = 1, height = 1 },
	led_light = { type = "basic", intensity = 0, size = 0 }
}

local empty_connection_point = {
	wire = { red = {0, 0}, green = {0, 0} },
	shadow = { red = {0, 0}, green = {0, 0} }
}

local empty_circuit_connector_array = {
	empty_circuit_connector, empty_circuit_connector, empty_circuit_connector,
	empty_circuit_connector, empty_circuit_connector, empty_circuit_connector,
	empty_circuit_connector, empty_circuit_connector
}

local empty_connection_point_array = {
	empty_connection_point, empty_connection_point, empty_connection_point,
	empty_connection_point, empty_connection_point, empty_connection_point,
	empty_connection_point, empty_connection_point
}

local empty_4connection_point_array = {
	empty_connection_point, empty_connection_point, 
	empty_connection_point, empty_connection_point
}

local dummy_energy_source = {
	type = "electric",
	buffer_capacity = "0J",
	usage_priority = "secondary-output",
	render_no_power_icon = false,
	render_no_network_icon = false
}


--==============================================================================
-- Overhead Line Poles: Placer

local simple_pole_placer = {
	type = "rail-signal",
	name = "ret-pole-placer",
	icon = graphics .. "items/power-pole.png",
	icon_size = 32,
	animation = {
		filename = graphics .. "entities/pole-placer.png",
		width = 160, height = 160,
		frame_count = 1, direction_count = 8,
		shift = util.by_pixel(0, -55)
	},
	flags = {"placeable-neutral", "player-creation", "building-direction-8-way", 
	         "filter-directions", "fast-replaceable-no-build-while-moving" },
	fast_replaceable_group = "rail-signal",
	max_health = 100,
	corpse = "small-remnants",
	collision_box = {{-0.2, -0.2}, {0.2, 0.2}},
	selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
	drawing_box = {{-2.5, -6.0}, {2.5, 1.0}},
	circuit_wire_max_distance = config.pole_max_wire_distance,
	circuit_wire_connection_points = empty_connection_point_array,
	circuit_connector_sprites = empty_circuit_connector_array
}

local signal_pole_placer = {
	type = "rail-signal",
	name = "ret-signal-pole-placer",
	icon = graphics .. "items/signal-pole.png",
	icon_size = 32,
	animation = {
		filename = graphics .. "entities/pole-placer.png",
		width = 160, height = 160,
		frame_count = 1, direction_count = 8,
		shift = util.by_pixel(0, -55)
	},
	flags = {"placeable-neutral", "player-creation", "building-direction-8-way", 
	         "filter-directions", "fast-replaceable-no-build-while-moving" },
	fast_replaceable_group = "rail-signal",
	max_health = 100,
	corpse = "small-remnants",
	collision_box = {{-0.2, -0.2}, {0.2, 0.2}},
	selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
	drawing_box = {{-2.5, -6.0}, {2.5, 1.0}},
	circuit_wire_max_distance = config.pole_max_wire_distance,
	circuit_wire_connection_points = empty_connection_point_array,
	circuit_connector_sprites = empty_circuit_connector_array
}

local chain_pole_placer = {
	type = "rail-signal",
	name = "ret-chain-pole-placer",
	icon = graphics .. "items/chain-pole.png",
	icon_size = 32,
	animation = {
		filename = graphics .. "entities/pole-placer.png",
		width = 160, height = 160,
		frame_count = 1, direction_count = 8,
		shift = util.by_pixel(0, -55)
	},
	flags = {"placeable-neutral", "player-creation", "building-direction-8-way", 
	         "filter-directions", "fast-replaceable-no-build-while-moving" },
	fast_replaceable_group = "rail-signal",
	max_health = 100,
	corpse = "small-remnants",
	collision_box = {{-0.2, -0.2}, {0.2, 0.2}},
	selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
	drawing_box = {{-2.5, -6.0}, {2.5, 1.0}},
	circuit_wire_max_distance = config.pole_max_wire_distance,
	circuit_wire_connection_points = empty_connection_point_array,
	circuit_connector_sprites = empty_circuit_connector_array
}

-- Extend

data:extend{simple_pole_placer, signal_pole_placer, chain_pole_placer}

--==============================================================================
-- Overhead Line Poles: Base entities

local simple_pole_straight = {
	type = "constant-combinator",
	name = "ret-pole-base-straight",
	icon = graphics .. "items/power-pole.png",
	icon_size = 32,
	sprites = { sheet = {
		filename = graphics .. "entities/pole-base-straight.png",
		width = 48, height = 48,
		shift = util.by_pixel(0, 8)
	}},
	flags = { "player-creation" },
	fast_replaceable_group = "rail-signal",
	max_health = 100,
	corpse = "small-remnants",
	minable = { hardness = 0.2, mining_time = 0.5, result = "ret-pole-placer" },
	placeable_by = { item = "ret-pole-placer", count = 1 },
	collision_box = {{-0.2, -0.2}, {0.2, 0.2}},
	selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
	collision_mask = { "item-layer", "floor-layer", "train-layer", "player-layer" },
	circuit_wire_max_distance = config.pole_max_wire_distance,
	circuit_wire_connection_points = empty_4connection_point_array,
	item_slot_count = 0,
	activity_led_sprites = { sheet = {
		filename = graphics .. "empty.png", width = 0.25, height = 1
	}},
	activity_led_light_offsets = { {0, 0}, {0, 0}, {0, 0}, {0, 0}}
}

local simple_pole_diagonal = {
	type = "constant-combinator",
	name = "ret-pole-base-diagonal",
	icon = graphics .. "items/power-pole.png",
	icon_size = 32,
	sprites = { sheet = {
		filename = graphics .. "entities/pole-base-diagonal.png",
		width = 48, height = 48,
		shift = util.by_pixel(0, 8)
	}},
	flags = { "player-creation" },
	fast_replaceable_group = "rail-signal",
	max_health = 100,
	corpse = "small-remnants",
	minable = { hardness = 0.2, mining_time = 0.5, result = "ret-pole-placer" },
	placeable_by = { item = "ret-pole-placer", count = 1 },
	collision_box = {{-0.2, -0.2}, {0.2, 0.2}},
	selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
	collision_mask = { "item-layer", "floor-layer", "train-layer", "player-layer" },
	circuit_wire_max_distance = config.pole_max_wire_distance,
	circuit_wire_connection_points = empty_4connection_point_array,
	item_slot_count = 0,
	activity_led_sprites = { sheet = {
		filename = graphics .. "empty.png", width = 0.25, height = 1
	}},
	activity_led_light_offsets = { {0, 0}, {0, 0}, {0, 0}, {0, 0}}
}

local signal_pole = {
	type = "rail-signal",
	name = "ret-signal-pole-base",
	icon = graphics .. "items/signal-pole.png",
	icon_size = 32,
	animation = {
		filename = graphics .. "entities/signal-pole-base.png",
		width = 48, height = 48,
		frame_count = 3, direction_count = 8,
		shift = util.by_pixel(0, 8)
	},
	flags = { "player-creation", "building-direction-8-way" },
	fast_replaceable_group = "rail-signal",
	max_health = 100,
	corpse = "small-remnants",
	minable = { hardness = 0.2, mining_time = 0.5, result = "ret-signal-pole-placer" },
	placeable_by = { item = "ret-signal-pole-placer", count = 1 },
	collision_box = {{-0.2, -0.2}, {0.2, 0.2}},
	selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
	collision_mask = { "item-layer", "floor-layer", "train-layer", "player-layer" },
	circuit_wire_max_distance = config.pole_max_wire_distance,
	circuit_wire_connection_points = empty_connection_point_array,
	circuit_connector_sprites = empty_circuit_connector_array
}

local chain_pole = {
	type = "rail-chain-signal",
	name = "ret-chain-pole-base",
	icon = graphics .. "items/chain-pole.png",
	icon_size = 32,
	animation = {
		filename = graphics .. "entities/chain-pole-base.png",
		width = 136, height = 136,
		frame_count = 5, direction_count = 8,
		shift = util.by_pixel(15, 17)
	},
	flags = { "player-creation", "building-direction-8-way" },
	fast_replaceable_group = "rail-signal",
	max_health = 100,
	corpse = "small-remnants",
	minable = { hardness = 0.2, mining_time = 0.5, result = "ret-chain-pole-placer" },
	placeable_by = { item = "ret-chain-pole-placer", count = 1 },
	collision_box = {{-0.2, -0.2}, {0.2, 0.2}},
	selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
	selection_box_offsets = { {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0} },
	collision_mask = { "item-layer", "floor-layer", "train-layer", "player-layer" },
	circuit_wire_max_distance = config.pole_max_wire_distance,
	circuit_wire_connection_points = empty_connection_point_array,
	circuit_connector_sprites = empty_circuit_connector_array
}

-- Extend

data:extend{simple_pole_straight, simple_pole_diagonal, signal_pole, chain_pole}

--==============================================================================
-- Pole wire and power consumer

local pole_wire = {
	type = "electric-pole",
	name = "ret-pole-wire",
	icon = graphics .. "items/pole-wire.png",
	icon_size = 32,
	flags = { "placeable-off-grid", "not-blueprintable", "not-deconstructable" },
	collision_box = {{0, 0}, {0, 0}},
	collision_mask = {},
	selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
	drawing_box = {{-0.5, -0.5}, {0.5, 0.5}},
	pictures = { 
		filename = graphics .. "empty.png",
		width = 1, height = 1, direction_count = 1
	},
	selection_priority = 100,
	maximum_wire_distance = config.pole_max_wire_distance,
	supply_area_distance = config.pole_supply_area,
	connection_points = { {
		shadow = { copper = {2.0, 0.1}, green = {0.0, 0.0}, red = {0.0, 0.0} },
		wire   = { copper = {0.0, -2.25}, green = {0.0, 0.0}, red = {0.0, 0.0} },
	} },
	radius_visualisation_picture =
	{
		filename = "__base__/graphics/entity/small-electric-pole/electric-pole-radius-visualization.png",
		width = 12, height = 12, priority = "extra-high-no-scale"
    }
}

local pole_power = {
	type = "electric-energy-interface",
	name = "ret-pole-energy",
	icon = graphics .. "items/pole-wire.png",
	icon_size = 32,
	flags = { "placeable-off-grid", "not-blueprintable", "not-deconstructable" },
	collision_mask = {},
	pictures = { sheet = {
		filename = graphics .. "entities/pole-image.png",
		width = 128, height = 160,
		frames = 2,
		shift = util.by_pixel(45, -55)
	}},
	energy_source = {
		type = "electric",
		buffer_capacity = config.pole_power_buffer,
		usage_priority = "secondary-input",
		input_flow_limit = "6MW"
	}
}

-- Extend

data:extend{pole_wire, pole_power}

--==============================================================================
-- Graphics entities

local pole_holder_straight = {
	type = "electric-energy-interface",
	name = "ret-pole-holder-straight",
	icon = graphics .. "items/pole-wire.png",
	icon_size = 32,
	flags = { "placeable-off-grid", "not-blueprintable", "not-deconstructable" },
	collision_mask = {},
	render_layer = "wires-above",
	pictures = { sheets = {
	{
		filename = graphics .. "entities/wire-holder-straight.png",
		width = 148, height = 108,
		frames = 4,
		shift = util.by_pixel(0, -74)
	},
	{
		filename = graphics .. "entities/wire-holder-straight-shadow.png",
		width = 148, height = 108,
		frames = 4, draw_as_shadow = 1,
		shift = util.by_pixel(67, 9)
	}
	}},
	energy_source = dummy_energy_source
}

local pole_holder_diagonal = {
	type = "electric-energy-interface",
	name = "ret-pole-holder-diagonal",
	icon = graphics .. "items/pole-wire.png",
	icon_size = 32,
	flags = { "placeable-off-grid", "not-blueprintable", "not-deconstructable" },
	collision_mask = {},
	render_layer = "wires-above",
	pictures = { sheets = {
	{
		filename = graphics .. "entities/wire-holder-diagonal.png",
		width = 148, height = 108,
		frames = 4,
		shift = util.by_pixel(0, -74)
	},
	{
		filename = graphics .. "entities/wire-holder-diagonal-shadow.png",
		width = 148, height = 108,
		frames = 4, draw_as_shadow = 1,
		shift = util.by_pixel(67, 9)
	}
	}},
	energy_source = dummy_energy_source
}

-- Extend

data:extend{pole_holder_straight, pole_holder_diagonal}

--==============================================================================
-- Particles

local connected_particle = {
	type = "particle",
	name = "ret-connected-particle",
    flags = { "not-on-map", "placeable-off-grid" },
	pictures = {{
		filename = graphics .. "entities/powered-particle.png",
		width = 32, height = 32, frame_count = 1
	}},
	life_time = 180
}

local disconnected_particle = {
	type = "particle",
	name = "ret-disconnected-particle",
    flags = { "not-on-map", "placeable-off-grid" },
	pictures = {{
		filename = graphics .. "entities/unpowered-particle.png",
		width = 32, height = 32, frame_count = 1
	}},
	life_time = 180
}

data:extend{connected_particle, disconnected_particle}

--==============================================================================
-- Electric Locomotives

local electric_locomotive =
	copy_prototype("locomotive", "locomotive", "ret-electric-locomotive")
electric_locomotive.burner.fuel_inventory_size = 0
electric_locomotive.burner.smoke = nil
electric_locomotive.reversing_power_modifier = 0.8
electric_locomotive.color = { r = 0.00, g = 0.76, b = 0.96, a = 0.5 }

data:extend{electric_locomotive}
