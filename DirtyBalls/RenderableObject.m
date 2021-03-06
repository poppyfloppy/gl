//
//  RenderableObject.m
//  DirtyBalls
//
//  Created by Valeriy on 12.06.15.
//  Copyright (c) 2015 Valeriy. All rights reserved.
//

#import "RenderableObject.h"

@interface RenderableObject () {
    GLKVector3 m_Position;
    CGSize m_Size;
    GLKVector4 m_Color;
    Texture *m_Texture;
}

@end

@implementation RenderableObject

#pragma mark setters`n`getters
- (CGSize)size {
    return m_Size;
}

- (GLKVector3)position {
    return m_Position;
}

- (Texture *)texture {
    return m_Texture;
}

- (void)setPosition:(GLKVector3)position {
    m_Position = position;
}

- (GLKVector4)color {
    return m_Color;
}

- (void)setColor:(GLKVector4)color {
    m_Color = color;
}

#pragma mark init
- (instancetype)initWithMesh:(Mesh2d *)mesh {
    if (self = [super init]) {
        self.mesh = mesh;
    }
    
    return self;
}

- (instancetype)initWithPosition:(GLKVector3)position size:(CGSize)size andColor:(GLKVector4)color {
    if (self = [super init]) {
        m_Position = position;
        m_Color = color;
        m_Size = size;
    }
    
    return self;
}

- (instancetype)initWithPosition:(GLKVector3)position size:(CGSize)size andTexture:(Texture *)texture {
    if (self = [super init]) {
        m_Position = position;
        m_Texture = texture;
        m_Size = size;
    }
    
    return self;
}

- (void)initBuffers {
    [self initVertexBuffer];
    [self initTextureBuffer];
    [self initColorBuffer];
    [self initIndexBuffer];
    [self initArrayBuffer];
}

- (void)initVertexBuffer {
    float data[] = {
        0, 0, 0,
        0, m_Size.height, 0,
        m_Size.width, m_Size.height, 0,
        m_Size.width, 0, 0,
    };
    self.vertexBuffer = [Buffer new];
    [self.vertexBuffer setData:data count:3 * 4 perComponent:3];
}

- (void)initColorBuffer {
    float data[] = {
        m_Color.r, m_Color.g, m_Color.b, m_Color.a,
        m_Color.r, m_Color.g, m_Color.b, m_Color.a,
        m_Color.r, m_Color.g, m_Color.b, m_Color.a,
        m_Color.r, m_Color.g, m_Color.b, m_Color.a
    };
    self.colorBuffer = [Buffer new];
    [self.colorBuffer setData:data count:4 * 4 perComponent:4];
}

- (void)initTextureBuffer {
    float data[] = {
        0.0, 0.0,
        0.0, 1.0,
        1.0, 1.0,
        1.0, 0.0
    };
    self.textureBuffer = [Buffer new];
    [self.textureBuffer setData:data count:4 * 2 perComponent:2];
}

- (void)initIndexBuffer {
    GLushort data[] = {
        0, 1, 2,
        2, 3, 0
    };
    self.indexBuffer = [IndexBuffer new];
    [self.indexBuffer setData:data count:3 * 2];
}

- (void)initArrayBuffer {
    self.arrayBuffer = [ArrayBuffer new];
    [self.arrayBuffer addBuffer:self.vertexBuffer atIndex:0];
    [self.arrayBuffer addBuffer:self.colorBuffer atIndex:1];
    [self.arrayBuffer addBuffer:self.textureBuffer atIndex:2];
}

- (void)dealloc {
    [self.arrayBuffer deleteArrayBuffer];
}

@end
