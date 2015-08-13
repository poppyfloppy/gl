//
//  StaticShader.m
//  DirtyBalls
//
//  Created by Валерий Борисов on 19.07.15.
//  Copyright (c) 2015 Valeriy. All rights reserved.
//

#import "StaticShader.h"

@implementation StaticShader

- (void)setProjectionMatrix:(GLKMatrix4)projectionMatrix {
    [self activateProgram];
    [self setUniformMat4:@"projectionMatrix" :projectionMatrix];
    [self disableProgram];
}

- (void)setModelViewMatrix:(GLKMatrix4)modelViewMatrix {
    [self setUniformMat4:@"modelViewMatrix" :modelViewMatrix];
}

- (void)setLight1:(Light *)light1 {
    [self activateProgram];
    [self setUniform1f:@"lightIntensity" :light1.intensity];
    [self setUniformVec2:@"lightPosition" :light1.lightPosition];
    [self disableProgram];
}

@end
