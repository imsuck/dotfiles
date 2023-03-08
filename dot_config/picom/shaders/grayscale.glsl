#version 330
in vec2 texcoord;             // texture coordinate of the fragment

uniform sampler2D tex;        // texture of the window

vec4 default_post_processing(vec4 c);

// Default window shader:
// 1) fetch the specified pixel
// 2) apply default post-processing
vec4 window_shader() {
    vec4 c = texelFetch(tex, ivec2(texcoord), 0);

    float grayscale = c.r * 0.2126 + c.g * 0.7152 + c.b * 0.0722;

    c.r = grayscale;
	c.g = grayscale;
	c.b = grayscale;
    return default_post_processing(c);
}
