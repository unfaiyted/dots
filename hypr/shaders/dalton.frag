precision mediump float;
varying vec2 v_texcoord;
uniform sampler2D tex;

// Modulo-based noise with much larger pattern size
float modNoise(vec2 p) {
    // Use prime numbers that are much larger to create a larger pattern
    // before it repeats
    float largeX = 127.0; // Larger prime
    float largeY = 151.0; // Larger prime

    // Convert to pixel space with very high resolution
    vec2 pixelPos = floor(p * 4048.0);

    // Use modulo operations with larger primes to create larger boxes
    float x = mod(pixelPos.x, largeX) * mod(pixelPos.y, largeY);
    float y = mod(pixelPos.y, 149.0) * mod(pixelPos.x, 173.0);

    // Mix in a non-repeating way with smaller coefficient for larger pattern
    return fract((x + y) * 0.00213);
}

void main() {
    // Sample the original texture
    vec4 color = texture2D(tex, v_texcoord);

    // Generate noise - with much larger pattern size
    float noise = modNoise(v_texcoord);

    // Apply the noise with reduced strength
    float noiseStrength = 0.05; // Reduced from 0.10 to 0.05
    color.rgb += (noise - 0.5) * noiseStrength;

    // Ensure we stay in valid range
    color.rgb = clamp(color.rgb, 0.0, 1.0);

    // Output
    gl_FragColor = color;
}
