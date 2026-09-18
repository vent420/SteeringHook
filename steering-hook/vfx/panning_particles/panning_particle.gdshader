shader_type canvas_item;

// --- Uniforms --- //
uniform sampler2D noise_texture;
uniform float panning_speed = 0.1;
uniform vec2 panning_direction_1 = vec2(1.0, -0.5);
uniform vec2 panning_direction_2 = vec2(-1.0, 1.0);

// --- Functions --- //
void fragment() {
	COLOR = texture(noise_texture, UV + panning_direction_1 * TIME * panning_speed);
}