// Blended keycolor transparancy by clort.  Jan, 2020
// all colors below 25% intensity get gradually less opaque, down 
// to the target opacity 
//
#version 130

in vec2 texcoord;

uniform float opacity;
uniform sampler2D tex;

vec4 default_post_processing(vec4 c);

vec4 window_shader() {
    vec4 c = texelFetch(tex, ivec2(texcoord), 0);
    {
        vec4 vdiff = abs(vec4(0.0, 0.0, 0.0, 1.0) - c);
        float diff = max(max(max(vdiff.r, vdiff.g), vdiff.b), vdiff.a);
        if (diff < 0.25)
            c *= 0.25 + (3*diff);
    }
    // c *= opacity;
    return default_post_processing(c);
}
