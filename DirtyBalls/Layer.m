//
//  Layer.m
//  DirtyBalls
//
//  Created by Valeriy on 22.06.15.
//  Copyright (c) 2015 Valeriy. All rights reserved.
//

#import "Layer.h"

@implementation Layer

- (instancetype)init {
    if (self = [super init]) {
        objects = [NSMutableArray new];
    }
    
    return self;
}

- (void)add:(RenderableObject *)object {
    [objects addObject:object];
}

- (void)render {
    [self.shader activateProgram];
    glUniformMatrix4fv([self.shader getUniformLocation:@"modelViewMatrix"], 1, 0, GLKMatrix4Identity.m);
    glUniformMatrix4fv([self.shader getUniformLocation:@"projectionMatrix"], 1, GL_FALSE, self.projectionMatrix.m);
    [self.renderer start];
    for (int i = 0; i < objects.count; i++) {
        [self.renderer submit:objects[i]];
    }
    [self.renderer end];
    [self.renderer flush];
    [self.shader disableProgram];
}

@end
