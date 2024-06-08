#version 130
#extension GL_ARB_shading_language_420pack: enable

in vec2 texcoord;

#define CYCLE 10000 // The amount of miliseconds it takes to do a full "loop" around all the colors.

uniform float opacity;
uniform bool invert_color;
uniform sampler2D tex;
uniform float time;

vec4 default_post_processing(vec4 c);

float get_decimal_part(float f) {
	return f - int(f);
}

float snap0(float f) {
	return (f < 0) ? 0 : f;
}

vec4 window_shader() {
    vec4 c = texelFetch(tex, ivec2(texcoord), 0);
	float f = get_decimal_part(time / CYCLE);


	float p[3] = {
		snap0(0.33 - abs(f - 0.33)) * 4,
		snap0(0.33 - abs(f - 0.66)) * 4,
		snap0(0.33 - abs(f - 1.00)) * 4 + snap0(0.33 - abs(f - 0.0)) * 4
	};
	c.r = p[0] * c.r + p[1] * c.g + p[2] * c.b;
	c.g = p[2] * c.r + p[0] * c.g + p[1] * c.b;
	c.b = p[1] * c.r + p[2] * c.g + p[0] * c.b;

	return default_post_processing(c);
}
