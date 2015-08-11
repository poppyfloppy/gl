#version 300 es

layout (location = 0) out mediump vec4 outputColor;
in mediump vec4 col;
in mediump vec4 pos;
uniform mediump float r;
uniform mediump vec2 sunPos;


void main() {
    mediump float intensity;
    if (length(pos.xy - sunPos) <= r) {
        intensity = 1.0;
    } else {
        intensity = 1.0 / length(pos.xy - sunPos) * r;
    }
    outputColor = col * intensity;
}