shader_type canvas_item;

uniform vec4 flash_color : source_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform float flash_amount : hint_range(0.0, 1.0) = 0.0;
// Higher = faster initial drop-off, more "punchy" like a kick drum
uniform float curve : hint_range(0.5, 4.0) = 2.0;

void fragment() {
	float a = pow(flash_amount, curve);
	COLOR = vec4(flash_color.rgb, flash_color.a * a);
}
