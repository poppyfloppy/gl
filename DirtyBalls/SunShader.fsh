#version 300 es

layout (location = 0) out mediump vec4 outputColor;
in mediump vec4 col;
in mediump vec4 pos;

void main() {
    mediump float intensity = 1.0 / length(pos.xy - vec2(50, 30)) * 5.0;
    outputColor = col * intensity;
}