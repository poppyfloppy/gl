//
//  Projection.m
//  DirtyBalls
//
//  Created by Валерий Борисов on 25.07.15.
//  Copyright (c) 2015 Valeriy. All rights reserved.
//

#import "Projection.h"

@implementation Projection

+ (instancetype)sharedProjection {
    static Projection *projection = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        projection = [Projection new];
    });
    
    return projection;
}

- (void)initOrthoProjectionWidth:(float)width height:(float)height depth:(float)depth {
    [self initOrthoProjectionLeft:0 right:width bottom:0 top:height nearZ:0 andFarZ:depth];
}

- (void)initOrthoProjectionLeft:(float)left right:(float)right bottom:(float)bottom top:(float)top nearZ:(float)nearZ andFarZ:(float)farZ {
    self.projectionMatrix = GLKMatrix4MakeOrtho(left, right, bottom, top, nearZ, farZ);
    self.width = right - left;
    self.height = top - bottom;
    self.depth = farZ - nearZ;
}

- (void)initPerspectiveProjection {
}

@end
