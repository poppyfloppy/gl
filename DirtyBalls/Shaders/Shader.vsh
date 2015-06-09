//
//  Shader.vsh
//  DirtyBalls
//
//  Created by Valeriy on 19.05.15.
//  Copyright (c) 2015 Valeriy. All rights reserved.
//

#version 300 es

layout (location = 0) in vec4 position;
layout (location = 1) in vec3 normal;

out lowp vec4 colorVarying;

uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;

void main() {
    vec3 eyeNormal = normalize(normalMatrix * normal);
    vec3 lightPosition = vec3(0.0, 0.0, 1.0);
    vec4 diffuseColor = vec4(0.4, 0.4, 1.0, 1.0);
    
    float nDotVP = max(0.0, dot(eyeNormal, normalize(lightPosition)));
                 
    colorVarying = diffuseColor * nDotVP;
    
    gl_Position = modelViewProjectionMatrix * position;
}
