shader_type canvas_item;

uniform sampler2D crack;
uniform float scale: hint_range(0.0, 1.0);

void fragment() {
	if (texture(crack, UV).r > scale) {
		COLOR.a = 0.0;
	}
}
