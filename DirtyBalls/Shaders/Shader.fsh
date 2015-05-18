//
//  Shader.fsh
//  DirtyBalls
//
//  Created by Valeriy on 19.05.15.
//  Copyright (c) 2015 Valeriy. All rights reserved.
//

varying lowp vec4 colorVarying;

void main()
{
    gl_FragColor = colorVarying;
}
