//
//  StaticShader.h
//  DirtyBalls
//
//  Created by Валерий Борисов on 19.07.15.
//  Copyright (c) 2015 Valeriy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShaderProgram.h"
#import <GLKit/GLKit.h>

@interface StaticShader : ShaderProgram

- (void)setProjectionMatrix:(GLKMatrix4)projectionMatrix;
- (void)setModelViewMatrix:(GLKMatrix4)modelViewMatrix;


@end
