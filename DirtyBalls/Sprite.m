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

- (void)setPosition:(GLKVector3)position {
    _position = position;
    if (self.renderableObject) {
        self.renderableObject.modelViewMatrix = GLKMatrix4MakeTranslation(position.x, position.y, position.z);
    }
}

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
        self.renderableObject.modelViewMatrix = GLKMatrix4MakeTranslation(self.position.x, self.position.y, self.position.z);
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
        self.renderableObject.modelViewMatrix = GLKMatrix4MakeTranslation(self.position.x, self.position.y, self.position.z);
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

- (void)move:(GLKVector3)velocity {
    self.position = GLKVector3Make(self.position.x + velocity.x, self.position.y + velocity.y, self.position.z + velocity.z);
    self.renderableObject.modelViewMatrix = GLKMatrix4MakeTranslation(self.position.x, self.position.y, self.position.z);
}

@end
