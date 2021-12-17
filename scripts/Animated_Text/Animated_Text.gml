/// @func Animated_Text(text, *width)
function Animated_Text() constructor {
	var parsed = new Parse(argument0)
	text = argument_count > 1 ? new Text(parsed.result_string, argument[1]) : new Text(parsed.result_string)
	typer = new Typer(text)
	typer.set_finished()
	typing = false
	var parsed_effects = parsed.effects

	static color_to_rgb = function(fx) {
		var set_rgb = false
		if (fx.command == "aqua") {
			set_rgb = true
			fx.args = [color_get_red(c_aqua), color_get_green(c_aqua), color_get_blue(c_aqua)]
		}
		if (fx.command == "black") {
			set_rgb = true
			fx.args = [0, 0, 0]
		}
		if (fx.command == "blue") {
			set_rgb = true
			fx.args = [color_get_red(c_blue), color_get_green(c_blue), color_get_blue(c_blue)]
		}
		if (fx.command == "dkgray" || fx.command == "dkgrey") {
			set_rgb = true
			fx.args = [color_get_red(c_dkgray), color_get_green(c_dkgray), color_get_blue(c_dkgray)]
		}
		if (fx.command == "fuchsia" || fx.command == "pink") {
			set_rgb = true
			fx.args = [color_get_red(c_fuchsia), color_get_green(c_fuchsia), color_get_blue(c_fuchsia)]
		}
		if (fx.command == "gray" || fx.command == "grey") {
			set_rgb = true
			fx.args = [color_get_red(c_gray), color_get_green(c_gray), color_get_blue(c_gray)]
		}
		if (fx.command == "green") {
			set_rgb = true
			fx.args = [color_get_red(c_green), color_get_green(c_green), color_get_blue(c_green)]
		}
		if (fx.command == "lime") {
			set_rgb = true
			fx.args = [color_get_red(c_lime), color_get_green(c_lime), color_get_blue(c_lime)]
		}
		if (fx.command == "ltgray" || fx.command == "ltgrey") {
			set_rgb = true
			fx.args = [color_get_red(c_ltgray), color_get_green(c_ltgray), color_get_blue(c_ltgray)]
		}
		if (fx.command == "maroon") {
			set_rgb = true
			fx.args = [color_get_red(c_maroon), color_get_green(c_maroon), color_get_blue(c_maroon)]
		}
		if (fx.command == "navy") {
			set_rgb = true
			fx.args = [color_get_red(c_navy), color_get_green(c_navy), color_get_blue(c_navy)]
		}
		if (fx.command == "olive") {
			set_rgb = true
			fx.args = [color_get_red(c_olive), color_get_green(c_olive), color_get_blue(c_olive)]
		}
		if (fx.command == "orange") {
			set_rgb = true
			fx.args = [color_get_red(c_orange), color_get_green(c_orange), color_get_blue(c_orange)]
		}
		if (fx.command == "purple") {
			set_rgb = true
			fx.args = [color_get_red(c_purple), color_get_green(c_purple), color_get_blue(c_purple)]
		}
		if (fx.command == "red") {
			set_rgb = true
			fx.args = [color_get_red(c_red), color_get_green(c_red), color_get_blue(c_red)]
		}
		if (fx.command == "silver") {
			set_rgb = true
			fx.args = [color_get_red(c_silver), color_get_green(c_silver), color_get_blue(c_silver)]
		}
		if (fx.command == "teal") {
			set_rgb = true
			fx.args = [color_get_red(c_teal), color_get_green(c_teal), color_get_blue(c_teal)]
		}
		if (fx.command == "white") {
			set_rgb = true
			fx.args = [255, 255, 255]
		}
		if (fx.command == "yellow") {
			set_rgb = true
			fx.args = [color_get_red(c_yellow), color_get_green(c_yellow), color_get_blue(c_yellow)]
		}
		
		if (set_rgb) {
			fx.command = "rgb"
		}
	}

	effects = []
	for (var i = 0; i < array_length(parsed_effects); i++) {
		var fx = parsed_effects[i]
		
		// typing effects
		
		
		
		// regular effects
		color_to_rgb(fx)
		
		if (fx.command == "rgb") {
			if (array_length(fx.args) != 3) throw "Animated Text Error: rgb command must have 3 arguments"
			text.set_base_color(fx.index_start, fx.index_end, make_color_rgb(fx.args[0], fx.args[1], fx.args[2]))
		}
		
		if (fx.command == "hover") {
			array_push(effects, {
				text:		text,
				i_start:	fx.index_start,
				i_end:		fx.index_end,
				increment:	array_length(fx.args) > 0 && is_real(fx.args[0]) ? fx.args[0] : 0.1,
				magnitude:	array_length(fx.args) > 1 && is_real(fx.args[1]) ? fx.args[1] : 4,
				progress:	0,
				reset:		function() {
					progress = 0
				},
				update:		function(mult = 1) {
					progress += increment * mult
					var mod_y = sin(progress * 2 * pi + pi * 0.5) * magnitude * -1 // recall y is reversed
					text.mod_offset_y(i_start, i_end, mod_y)
				}
			})
		}
	}
}

function animated_text_typing_start(animated_text) {
	if (!animated_text_typing_is_finished(animated_text)) {
		animated_text.typing = true
	}
}

function animated_text_typing_pause(animated_text) {
	animated_text.typing = false
}

function animated_text_is_typing(animated_text) {
	return animated_text.typing && !animated_text.typer.typing_is_finished()
}

function animated_text_typing_is_finished(animated_text) {
	return animated_text.typer.typing_is_finished()
}

function animated_text_typing_set_finished(animated_text) {
	animated_text.typer.set_finished()
	animated_text.typing = false
}

function animated_text_typing_reset(animated_text) {
	animated_text.typer.reset()
	animated_text.typing = false
}

/// @func animated_string_update(animated_string, *update_multiplier)
function animated_text_update() {
	var anim_string = argument0
	var mult = argument_count > 1 ? argument[1] : 1
	with (anim_string) {
		typer.update(typing ? 0.2 : 0, 2)
		for (var i = 0; i < array_length(effects); i++) {
			effects[i].update(mult)
		}
	}
}

function animated_text_draw(x, y, animated_text) {
	animated_text_update(animated_text)
	animated_text.text.draw(x, y)
}