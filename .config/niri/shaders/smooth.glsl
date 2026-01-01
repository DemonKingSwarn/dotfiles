#version 450

uniform float uTime;        // Animation time
uniform vec2 uSize;         // Window/surface size
uniform sampler2D uTexture; // Input texture
uniform float uProgress;    // Animation progress (0.0 to 1.0)

// Input from vertex shader
in vec2 vTexCoord;
out vec4 fragColor;

// Animation parameters for macOS-style effect
const float BOUNCE_INTENSITY = 0.15;
const float ZOOM_START = 0.3;
const float FADE_DURATION = 0.2;

// Easing functions for smooth animation
float easeOutBounce(float t) {
    if (t < (1.0 / 2.75)) {
        return 7.5625 * t * t;
    } else if (t < (2.0 / 2.75)) {
        t -= (1.5 / 2.75);
        return 7.5625 * t * t + 0.75;
    } else if (t < (2.5 / 2.75)) {
        t -= (2.25 / 2.75);
        return 7.5625 * t * t + 0.9375;
    } else {
        t -= (2.625 / 2.75);
        return 7.5625 * t * t + 0.984375;
    }
}

float easeOutCubic(float t) {
    float f = t - 1.0;
    return f * f * f + 1.0;
}

void main() {
    vec2 center = vec2(0.5, 0.5);
    vec2 fromCenter = vTexCoord - center;
    
    // Calculate scaling with bounce effect
    float bounceProgress = easeOutBounce(uProgress);
    float scaleProgress = easeOutCubic(uProgress);
    
    // Start from smaller scale and zoom in with bounce
    float baseScale = mix(ZOOM_START, 1.0, scaleProgress);
    float bounceOffset = sin(bounceProgress * 3.14159) * BOUNCE_INTENSITY * (1.0 - uProgress);
    float finalScale = baseScale + bounceOffset;
    
    // Apply scaling transformation
    vec2 scaledCoord = center + fromCenter / finalScale;
    
    // Sample texture with transformed coordinates
    vec4 color = vec4(0.0);
    if (scaledCoord.x >= 0.0 && scaledCoord.x <= 1.0 && 
        scaledCoord.y >= 0.0 && scaledCoord.y <= 1.0) {
        color = texture(uTexture, scaledCoord);
    }
    
    // Fade in effect similar to macOS
    float fadeIn = smoothstep(0.0, FADE_DURATION, uProgress);
    
    // Apply glow effect during animation
    float glowIntensity = sin(uProgress * 3.14159) * 0.1;
    color.rgb += vec3(glowIntensity);
    
    // Final color with fade
    fragColor = vec4(color.rgb, color.a * fadeIn);
}
