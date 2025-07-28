#version 450

// Input uniforms
uniform float uTime;        // Animation time
uniform vec2 uSize;         // Window/surface size
uniform sampler2D uTexture; // Input texture

// Animation progress (0.0 to 1.0)
uniform float uProgress;

// Input from vertex shader
in vec2 vTexCoord;
out vec4 fragColor;

// Blur parameters
const int BLUR_SAMPLES = 9;
const float BLUR_RADIUS = 8.0;

vec4 gaussianBlur(sampler2D tex, vec2 texCoord, vec2 direction, float radius) {
    vec4 color = vec4(0.0);
    vec2 texelSize = 1.0 / textureSize(tex, 0);
    
    // Gaussian weights for 9-tap blur
    float weights[BLUR_SAMPLES] = float[](
        0.013519569015984728,
        0.047662179108871855,
        0.11723004402070096,
        0.20116755999375591,
        0.240841295721373,
        0.20116755999375591,
        0.11723004402070096,
        0.047662179108871855,
        0.013519569015984728
    );
    
    for (int i = 0; i < BLUR_SAMPLES; i++) {
        float offset = float(i - BLUR_SAMPLES / 2);
        vec2 sampleCoord = texCoord + direction * texelSize * offset * radius;
        color += texture(tex, sampleCoord) * weights[i];
    }
    
    return color;
}

void main() {
    vec2 texCoord = vTexCoord;
    
    // Sample original texture
    vec4 originalColor = texture(uTexture, texCoord);
    
    // Calculate blur intensity based on animation progress
    float blurIntensity = sin(uProgress * 3.14159) * BLUR_RADIUS;
    
    // Perform two-pass blur (horizontal then vertical)
    vec4 horizontalBlur = gaussianBlur(uTexture, texCoord, vec2(1.0, 0.0), blurIntensity);
    
    // For a proper two-pass blur, you'd need a second texture
    // This is a simplified single-pass approximation
    vec4 blurredColor = gaussianBlur(uTexture, texCoord, vec2(0.0, 1.0), blurIntensity * 0.5) +
                       gaussianBlur(uTexture, texCoord, vec2(1.0, 0.0), blurIntensity * 0.5);
    blurredColor *= 0.5;
    
    // Mix original and blurred based on animation progress
    fragColor = mix(originalColor, blurredColor, uProgress);
}
