precision mediump float;
varying vec2 v_texcoord;
uniform sampler2D tex;

uniform float time;

uniform vec2 topLeft;
uniform vec2 fullSize;

void main() {
    vec4 pixColor = texture2D(tex, v_texcoord);
    float gray = dot(pixColor.rgb, vec3(0.299, 0.587, 0.114)); // Calculate grayscale value
    pixColor.rgb = vec3(gray); // Set all color channels to the grayscale value

    gl_FragColor = pixColor;
}
