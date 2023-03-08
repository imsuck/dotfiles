#version 330

in vec2 texcoord;

uniform float opacity;
uniform bool invert_color;
uniform sampler2D tex;
uniform float time;

float amt = 3000.0;

vec4 default_post_processing(vec4 c);

vec4 window_shader() {
    // float pct = mod(time, amt)/amt * 5000;
    float pct = mod(time, amt) / amt * 1000;
    vec2 pos = texcoord;
	vec4 c = texelFetch(tex, ivec2(texcoord), 0);

    if (pos.x + pos.y < pct * 4.0 && pos.x + pos.y > pct * 4.0 - .5 * pct
        || pos.x + pos.y < pct * 4.0 - .8 * pct && pos.x + pos.y > pct * 3.0)
       c *= vec4(2, 2, 2, 1);
    if (invert_color)
    	c = vec4(vec3(c.a, c.a, c.a) - vec3(c), c.a);

	c *= opacity;
	return default_post_processing(c);
}
