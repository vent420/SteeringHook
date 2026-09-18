shader_type canvas_item;

uniform sampler2D noiseTexture;

void fragment(){
	COLOR = texture(noiseTexture, UV);
}
