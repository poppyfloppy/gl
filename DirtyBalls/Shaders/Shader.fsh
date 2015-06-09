//
//  Shader.fsh
//  DirtyBalls
//
//  Created by Valeriy on 19.05.15.
//  Copyright (c) 2015 Valeriy. All rights reserved.
//

#version 300 es

in lowp vec4 colorVarying;
layout (location = 0) out lowp vec4 fragColor;
void main() {
    fragColor = colorVarying;
}
