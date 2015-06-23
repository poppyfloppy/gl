#version 300 es

layout (location = 0) in vec4 position;
layout (location = 1) in vec4 color;
layout (location = 2) in vec2 texturePosition;

uniform mat4 modelViewMatrix;
uniform mat4 projectionMatrix;

out vec4 pos;
out vec4 col;
out vec2 tex;

void main() {
    gl_Position = projectionMatrix * modelViewMatrix * position;
    pos = modelViewMatrix * position;
    col = color;
    tex = texturePosition;
}