#version 300 es

layout (location = 0) out mediump vec4 outputColor;
in mediump vec4 pos;
in mediump vec4 col;
in mediump vec2 tex;
uniform highp vec2 lightPosition;
uniform highp float lightIntensity;
uniform sampler2D textureSampler;

void main() {
    mediump float intensity = 1.0 / length(pos.xy - lightPosition) * lightIntensity;
    mediump vec4 textureColor = texture(textureSampler, tex);
    outputColor = vec4(textureColor.rgb * intensity, textureColor.a);
}