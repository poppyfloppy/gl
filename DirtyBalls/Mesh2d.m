//
//  Mesh2d.m
//  DirtyBalls
//
//  Created by Валерий Борисов on 19.07.15.
//  Copyright (c) 2015 Valeriy. All rights reserved.
//

#import "Mesh2d.h"

@implementation Mesh2d

#pragma mark init
- (instancetype)initWith:(GLfloat *)position andColor:(GLfloat *)color andIndices:(GLushort *)indices {
    if (self = [super init]) {
        [self initPositionBuffer:position];
        [self initColorBuffer:color];
        [self initIndexBuffer:indices];
        [self initVao];
    }
    
    return self;
}

- (instancetype)initWith:(GLfloat *)position andTexure1:(GLfloat *)texture1 andIndices:(GLushort *)indices {
    if (self = [super init]) {
        [self initPositionBuffer:position];
        [self initTexture1Buffer:texture1];
        [self initIndexBuffer:indices];
        [self initVao];
    }
    
    return self;
}


- (instancetype)initWith:(GLfloat *)position andTexure1:(GLfloat *)texture1 andTexure2:(GLfloat *)texture2 andIndices:(GLushort *)indices {
    if (self = [super init]) {
        [self initPositionBuffer:position];
        [self initTexture1Buffer:texture1];
        [self initTexture2Buffer:texture2];
        [self initIndexBuffer:indices];
        [self initVao];
    }
    
    return self;
}

- (instancetype)initWith:(GLfloat *)position andTexure1:(GLfloat *)texture1 andTexure2:(GLfloat *)texture2 andTexure3:(GLfloat *)texture3 andIndices:(GLushort *)indices {
    if (self = [super init]) {
        [self initPositionBuffer:position];
        [self initTexture1Buffer:texture1];
        [self initTexture2Buffer:texture2];
        [self initTexture3Buffer:texture3];
        [self initIndexBuffer:indices];
        [self initVao];
    }
    
    return self;
}

#pragma mark init buffers
- (void)initVao {
    self.vao = [ArrayBuffer new];
    [self.vao addBuffer:self.positionBuffer atIndex:POSITION_INDEX];
    if (self.colorBuffer) {
        [self.vao addBuffer:self.colorBuffer atIndex:COLOR_INDEX];
    }
    if (self.texture1Buffer) {
        [self.vao addBuffer:self.texture1Buffer atIndex:TEXTURE1_INDEX];
    }
    if (self.texture2Buffer) {
        [self.vao addBuffer:self.texture2Buffer atIndex:TEXTURE2_INDEX];
    }
    if (self.texture3Buffer) {
        [self.vao addBuffer:self.texture3Buffer atIndex:TEXTURE3_INDEX];
    }
}

- (void)initPositionBuffer:(GLfloat *)position {
    self.positionBuffer = [[Buffer alloc] init];
    [self.positionBuffer setData:position count:sizeof(position) / sizeof(position[0]) perComponent:3];
}

- (void)initColorBuffer:(GLfloat *)color {
    self.colorBuffer = [Buffer new];
    [self.colorBuffer setData:color count:sizeof(color) / sizeof(color[0]) perComponent:4];
}

- (void)initTexture1Buffer:(GLfloat *)texture1 {
    self.texture1Buffer = [Buffer new];
    [self.texture1Buffer setData:texture1 count:sizeof(texture1) / sizeof(texture1[0]) perComponent:2];
}

- (void)initTexture2Buffer:(GLfloat *)texture2 {
    self.texture2Buffer = [Buffer new];
    [self.texture2Buffer setData:texture2 count:sizeof(texture2) / sizeof(texture2[0]) perComponent:2];
}

- (void)initTexture3Buffer:(GLfloat *)texture3 {
    self.texture3Buffer = [Buffer new];
    [self.texture3Buffer setData:texture3 count:sizeof(texture3) / sizeof(texture3[0]) perComponent:2];
}

- (void)initIndexBuffer:(GLushort *)indices {
    self.indexBuffer = [[IndexBuffer alloc] init];
    [self.indexBuffer setData:indices count:sizeof(indices) / sizeof(indices[0])];
}

@end
