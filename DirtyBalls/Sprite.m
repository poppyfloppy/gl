//
//  Sprite.m
//  DirtyBalls
//
//  Created by Valeriy on 07.07.15.
//  Copyright (c) 2015 Valeriy. All rights reserved.
//

#import "Sprite.h"
#import "Mesh2d.h"

@interface Sprite () {
}

@end

@implementation Sprite

#pragma mark init
- (instancetype)initWithPosition:(GLKVector3)position size:(CGSize)size andColor:(GLfloat *)color {
    if (self = [super init]) {
        self.position = position;
        self.size = size;
        Mesh2d *mesh = [self getBasicMesh];
        self.renderableObject.mesh = [self getBasicMesh];
        [mesh initColorBuffer:color count:16];
        self.renderableObject = [[RenderableObject alloc] initWithMesh:mesh];
        self.renderableObject.color = color;
    }
    
    return self;
}

- (instancetype)initWithPosition:(GLKVector3)position size:(CGSize)size andTexture1:(Texture *)texture1 {
    if (self = [super init]) {
        self.position = position;
        self.size = size;
        Mesh2d *mesh = [self getBasicMesh];
        self.renderableObject.mesh = [self getBasicMesh];
        GLfloat texture[8] = {
            0.0, 0.0,
            0.0, 1.0,
            1.0, 1.0,
            1.0, 0.0
        };
        [mesh initTexture1Buffer:texture count:8];
        self.renderableObject = [[RenderableObject alloc] initWithMesh:mesh];
        self.renderableObject.texture1 = texture1;
    }
    
    return self;
}

- (instancetype)initWithPosition:(GLKVector3)position size:(CGSize)size andTexture1:(Texture *)texture1 andTexture2:(Texture *)texture2 {
    if (self = [super init]) {
        
    }
    
    return self;
}

- (instancetype)initWithPosition:(GLKVector3)position size:(CGSize)size andTexture1:(Texture *)texture1 andTexture2:(Texture *)texture2 andTexture3:(Texture *)texture3 {
    if (self = [super init]) {
        
    }
    
    return self;
}

- (Mesh2d *)getBasicMesh {
    Mesh2d *mesh = [Mesh2d new];
    GLfloat vertex[12] = {
        0, 0, 0,
        0, self.size.height, 0,
        self.size.width, self.size.height, 0,
        self.size.width, 0, 0,
    };
    [mesh initPositionBuffer:vertex count:12];
    GLushort indices[6] = {
        0, 1, 2,
        2, 3, 0
    };
    [mesh initIndexBuffer:indices count:6];
    
    return mesh;
}

@end
