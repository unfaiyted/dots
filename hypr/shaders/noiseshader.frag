precision highp float;

varying vec2 v_texcoord;
uniform sampler2D tex;

float blendSoftLight(float base, float blend) {
    return (blend < 0.5) ? (2.0 * base * blend + base * base * (1.0 - 2.0 * blend)) : (sqrt(base) * (2.0 * blend - 1.0) + 2.0 * base * (1.0 - blend));
}

vec3 blendSoftLight(vec3 base, vec3 blend) {
    return vec3(blendSoftLight(base.r, blend.r), blendSoftLight(base.g, blend.g), blendSoftLight(base.b, blend.b));
}

vec3 blendSoftLight(vec3 base, vec3 blend, float opacity) {
    return (blendSoftLight(base, blend) * opacity + base * (1.0 - opacity));
}

float rand(vec2 co) {
    return fract(sin(dot(co.xy, vec2(12.9898, 78.233))) * 43758.5453);
}

void main() {
    vec2 tc = v_texcoord;

    vec4 base = texture2D(tex, tc);

    float grain = rand(tc) - 0.5;

    vec3 blend = base.rgb + grain * 0.3;

    float grainIntensity = 0.19;
    vec3 result = blendSoftLight(base.rgb, vec3(grain), grainIntensity);

    gl_FragColor = vec4(result, base.a);
}
