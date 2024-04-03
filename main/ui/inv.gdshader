shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE: hint_screen_texture;

void fragment() {
	float ir = textureLod(SCREEN_TEXTURE, SCREEN_UV, 0.0).r;
	if (ir > 0.2) {
		ir = 0.0; 
	} else {
		ir = 1.0;
	}
	COLOR = vec4(ir, ir, ir, texture(TEXTURE, UV).a);
}