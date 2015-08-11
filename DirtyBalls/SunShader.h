//
//  SunShader.h
//  DirtyBalls
//
//  Created by Валерий Борисов on 08.08.15.
//  Copyright (c) 2015 Valeriy. All rights reserved.
//

#import "StaticShader.h"
#import <GLKit/GLKit.h>

@interface SunShader : StaticShader

@property (nonatomic) GLKVector2 sunPos;
@property (nonatomic) float r;

@end
