#version 300 es

layout (location = 0) out mediump vec4 outputColor;
in mediump vec4 pos;
in mediump vec4 col;
uniform highp vec2 lightPosition;

void main() {
    mediump float intensity = 1.0 / length(pos.xy - lightPosition) * 1.0;
    outputColor = col * intensity;
}