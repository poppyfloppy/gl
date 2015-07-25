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
- (instancetype)initWith:(GLfloat *)position andCount:(size_t)count1 andColor:(GLfloat *)color andCount:(size_t)count2 andIndices:(GLushort *)indices andCount:(size_t)count3 {
    if (self = [super init]) {
        [self initVao];
        [self initPositionBuffer:position count:count1];
        [self initColorBuffer:color count:count2];
        [self initIndexBuffer:indices count:count3];
    }
    
    return self;
}

- (instancetype)initWith:(GLfloat *)position andCount:(size_t)count1 andTexure1:(GLfloat *)texture1 andCount:(size_t)count2 andIndices:(GLushort *)indices andCount:(size_t)count3 {
    if (self = [super init]) {
        [self initVao];
        [self initPositionBuffer:position count:count1];
        [self initTexture1Buffer:texture1 count:count2];
        [self initIndexBuffer:indices count:count3];
    }
    
    return self;
}

- (instancetype)initWith:(GLfloat *)position andCount:(size_t)count1 andTexure1:(GLfloat *)texture1 andCount:(size_t)count2 andTexure2:(GLfloat *)texture2 andCount:(size_t)count3 andIndices:(GLushort *)indices andCount:(size_t)count4 {
    if (self = [super init]) {
        [self initVao];
        [self initPositionBuffer:position count:count1];
        [self initTexture1Buffer:texture1 count:count2];
        [self initTexture2Buffer:texture2 count:count3];
        [self initIndexBuffer:indices count:count4];
    }
    
    return self;
}

- (instancetype)initWith:(GLfloat *)position andCount:(size_t)count1 andTexure1:(GLfloat *)texture1 andCount:(size_t)count2 andTexure2:(GLfloat *)texture2 andCount:(size_t)count3 andTexure3:(GLfloat *)texture3 andCount:(size_t)count4 andIndices:(GLushort *)indices andCount:(size_t)count5 {
    if (self = [super init]) {
        [self initVao];
        [self initPositionBuffer:position count:count1];
        [self initTexture1Buffer:texture1 count:count2];
        [self initTexture2Buffer:texture2 count:count3];
        [self initTexture3Buffer:texture3 count:count4];
        [self initIndexBuffer:indices count:count5];
    }
    
    return self;
}

- (instancetype)init {
    if (self = [super init]) {
        [self initVao];
    }
    
    return self;
}

#pragma mark init buffers
- (void)initVao {
    if (!self.vao) {
        self.vao = [ArrayBuffer new];
    }
}

- (void)initPositionBuffer:(GLfloat *)position count:(size_t)count {
    if (!self.positionBuffer) {
        self.positionBuffer = [[Buffer alloc] init];
        [self.positionBuffer setData:position count:(GLuint)count perComponent:3];
        [self.vao addBuffer:self.positionBuffer atIndex:POSITION_INDEX];
    }
}

- (void)initColorBuffer:(GLfloat *)color count:(size_t)count {
    if (!self.colorBuffer) {
        self.colorBuffer = [Buffer new];
        [self.colorBuffer setData:color count:(GLuint)count perComponent:4];
        [self.vao addBuffer:self.colorBuffer atIndex:COLOR_INDEX];
    }
}

- (void)initTexture1Buffer:(GLfloat *)texture1 count:(size_t)count {
    if (!self.texture1Buffer) {
        self.texture1Buffer = [Buffer new];
        [self.texture1Buffer setData:texture1 count:(GLuint)count perComponent:2];
        [self.vao addBuffer:self.texture1Buffer atIndex:TEXTURE1_INDEX];
    }
}

- (void)initTexture2Buffer:(GLfloat *)texture2 count:(size_t)count {
    if (!self.texture2Buffer) {
        self.texture2Buffer = [Buffer new];
        [self.texture2Buffer setData:texture2 count:(GLuint)count perComponent:2];
        [self.vao addBuffer:self.texture2Buffer atIndex:TEXTURE2_INDEX];
    }
}

- (void)initTexture3Buffer:(GLfloat *)texture3 count:(size_t)count {
    if (!self.texture3Buffer) {
        self.texture3Buffer = [Buffer new];
        [self.texture3Buffer setData:texture3 count:(GLuint)count perComponent:2];
        [self.vao addBuffer:self.texture3Buffer atIndex:TEXTURE3_INDEX];
    }
}

- (void)initIndexBuffer:(GLushort *)indices count:(size_t)count {
    if (!self.indexBuffer) {
        self.indexBuffer = [[IndexBuffer alloc] init];
        [self.indexBuffer setData:indices count:(GLuint)count];
    }
}

@end
