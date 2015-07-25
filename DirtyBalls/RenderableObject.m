//
//  RenderableObject.m
//  DirtyBalls
//
//  Created by Valeriy on 12.06.15.
//  Copyright (c) 2015 Valeriy. All rights reserved.
//

#import "RenderableObject.h"

@interface RenderableObject () {
}

@end

@implementation RenderableObject

#pragma mark init
- (instancetype)initWithMesh:(Mesh2d *)mesh {
    if (self = [super init]) {
        self.modelViewMatrix = GLKMatrix4Identity;
        self.mesh = mesh;
    }
    
    return self;
}

- (instancetype)init {
    return [self initWithMesh:nil];
}

@end
