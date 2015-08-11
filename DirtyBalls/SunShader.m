//
//  SunShader.m
//  DirtyBalls
//
//  Created by Валерий Борисов on 08.08.15.
//  Copyright (c) 2015 Valeriy. All rights reserved.
//

#import "SunShader.h"

@implementation SunShader

- (void)setSunPos:(GLKVector2)sunPos {
    _sunPos = sunPos;
    [self activateProgram];
    [self setUniformVec2:@"sunPos" :sunPos];
    [self disableProgram];
}

- (void)setR:(float)r {
    _r = r;
    [self activateProgram];
    [self setUniform1f:@"r" :r];
    [self disableProgram];
}

@end
