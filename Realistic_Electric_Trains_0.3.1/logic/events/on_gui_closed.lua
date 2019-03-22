--on_gui_closed.lua

require("logic.modular_locomotive")

do

	function on_gui_closed(event) 
		local entity = event.entity
		if entity and entity.name == "ret-modular-locomotive" then
			global.fuel_for_loco[entity.unit_number] = nil
			if enable_modular_info then
				local c = get_module_counts(entity)
				local item_name = get_module_string(c.s, c.p, c.e, c.b)
				local prototype = game.item_prototypes["ret-dummy-fuel-modular-" .. item_name]
				if prototype then
					draw_statistics_message(entity, event.player_id)
				else
					draw_invalid_combination_message(entity, event.player_id)
				end
			end
		end
	end

	function draw_text(text, entity, color, offset, player)
		rendering.draw_text {
			text = text,
			surface = entity.surface,
			target = entity,
			target_offset = offset,
			scale_with_zoom = true,
			color = color,
			players = {player},
			time_to_live = 240
		}
	end

	function draw_invalid_combination_message(locomotive, player)
		local c = get_module_counts(locomotive)
		local count	= c.s + c.p + c.e + c.b
		draw_text({"message.ret-module-count", count}, locomotive, {r=1, g=0.5}, {-2.5, -2}, player)
		draw_text({"message.ret-invalid-module-explanation"}, locomotive, {r=1,g=0.5}, {-2.5, -2.5}, player)
		draw_text({"message.ret-invalid-module-combination"}, locomotive, {r=1,g=0.25}, {-3,-3}, player)
	end

	function draw_statistics_message(locomotive, player)
		local c = get_module_counts(locomotive)
		local item_name = get_module_string(c.s, c.p, c.e, c.b)
		local stats = get_module_stats(c.s, c.p, c.e, c.b)
		local prototype = game.item_prototypes["ret-dummy-fuel-modular-" .. item_name]
		local white = {r=1, g=1, b=1}

		draw_text({"message.ret-locomotive-battery-size", util.format_number(prototype.fuel_value * stats.power, true)},
			locomotive, white, {-2.5, -2}, player)
		draw_text({"message.ret-locomotive-acceleration", stats.acceleration * 100},
			locomotive, white, {-2.5, -2.5}, player)
		draw_text({"message.ret-locomotive-max-speed", string.format("%.0f", prototype.fuel_top_speed_multiplier * 259.2)},
			locomotive, white, {-2.5, -3}, player)
		local power = stats.power * locomotive.prototype.max_energy_usage * 60 / locomotive.prototype.burner_prototype.effectivity

		local y = -4
		if power <= config.power_soft_cap then
			draw_text({"message.ret-locomotive-energy-usage", util.format_number(power, true)},
				locomotive, white, {-2.5, -3.5}, player)
		else
			local color = {r=1, g=0.5}
			if power <= config.power_hard_cap then
				draw_text({"message.ret-locomotive-critical-energy"},
					locomotive, color, {-2, -3.5}, player)
			else
				color.g = 0.25
				draw_text({"message.ret-locomotive-too-much-energy"},
					locomotive, color, {-2, -3.5}, player)
			end
			y = -4.5
			draw_text({"message.ret-locomotive-energy-usage", util.format_number(power, true)},
				locomotive, color, {-2.5, -4}, player)
		end

		draw_text({"message.ret-module-updated"},
				locomotive, {g=0.75,b=0.75}, {-3, y}, player)
	end
end

return on_gui_closed
