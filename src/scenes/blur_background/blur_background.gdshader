shader_type canvas_item;
render_mode unshaded;

// Godot 4: declare the screen texture with mipmaps
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

// Master intensity you animate 0..1 from script
uniform float amount : hint_range(0.0, 1.0) = 0.0;

// How soft the blur can get via mip levels (5–7 = very soft)
uniform float lod_max : hint_range(0.0, 7.0) = 5.0;

// Footprint for tap offsets in pixels (not too big; mip does most of the work)
uniform float radius_px : hint_range(0.0, 64.0) = 24.0;

// Frosted glass tends to desaturate a bit
uniform float desaturate : hint_range(0.0, 1.0) = 0.35;

// Subtle cool/white tint; alpha is the tint strength
uniform vec4 tint = vec4(0.9, 0.95, 1.0, 0.12);

// Tiny per-pixel jitter to avoid banding; set to 0.0 if you prefer none
uniform float jitter_strength : hint_range(0.0, 1.0) = 0.6;

float hash12(vec2 p){
    p = fract(p * 0.3183099 + vec2(0.71, 0.113));
    return fract(23.3 * dot(p, vec2(0.2, 0.7)));
}

vec4 sample_frost(vec2 uv, float lod, float r_px){
    vec2 ss = vec2(textureSize(SCREEN_TEXTURE, 0));
    vec2 texel = r_px / ss;

    // Small Poisson-like kernel for nice isotropic taps
    vec2 k0 = vec2(-0.326, -0.406);
    vec2 k1 = vec2(-0.840, -0.074);
    vec2 k2 = vec2(-0.696,  0.457);
    vec2 k3 = vec2(-0.203,  0.621);
    vec2 k4 = vec2( 0.962, -0.195);
    vec2 k5 = vec2( 0.473, -0.480);
    vec2 k6 = vec2( 0.519,  0.767);
    vec2 k7 = vec2( 0.185, -0.893);

    // Per-pixel stable jitter to kill “swim” artifacts
    vec2 px = floor(uv * ss);
    vec2 jitter = (vec2(hash12(px), hash12(px + 17.0)) - 0.5) * (texel * jitter_strength);

    vec4 c = textureLod(SCREEN_TEXTURE, uv + jitter, lod);
    c += textureLod(SCREEN_TEXTURE, uv + (k0 * texel), lod);
    c += textureLod(SCREEN_TEXTURE, uv + (k1 * texel), lod);
    c += textureLod(SCREEN_TEXTURE, uv + (k2 * texel), lod);
    c += textureLod(SCREEN_TEXTURE, uv + (k3 * texel), lod);
    c += textureLod(SCREEN_TEXTURE, uv + (k4 * texel), lod);
    c += textureLod(SCREEN_TEXTURE, uv + (k5 * texel), lod);
    c += textureLod(SCREEN_TEXTURE, uv + (k6 * texel), lod);
    c += textureLod(SCREEN_TEXTURE, uv + (k7 * texel), lod);
    return c / 9.0;
}

void fragment(){
    vec4 base = texture(SCREEN_TEXTURE, SCREEN_UV);

    // Drive softness from 'amount'
    float lod = amount * lod_max;
    float r   = mix(0.0, radius_px, amount);

    vec4 blurred = sample_frost(SCREEN_UV, lod, r);

    // Gentle desaturation for that “fogged glass” vibe
    float g = dot(blurred.rgb, vec3(0.2126, 0.7152, 0.0722));
    vec3 frosted = mix(blurred.rgb, vec3(g), desaturate * amount);

    // Subtle tint (controlled by tint.a)
    frosted = mix(frosted, tint.rgb, tint.a * amount);

    // Crossfade original → frosted by 'amount'
    COLOR = mix(base, vec4(frosted, 1.0), amount);
}
