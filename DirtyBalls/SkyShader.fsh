#version 300 es

layout (location = 0) out mediump vec4 outputColor;
in mediump vec4 col;

void main() {
    outputColor = col;
}