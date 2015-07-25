//
//  RenderableObject.h
//  DirtyBalls
//
//  Created by Valeriy on 12.06.15.
//  Copyright (c) 2015 Valeriy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>
#import "ArrayBuffer.h"
#import "Buffer.h"
#import "IndexBuffer.h"
#import "ShaderProgram.h"
#import "StaticShader.h"
#import "Texture.h"
#import "Mesh2d.h"

@interface RenderableObject : NSObject {
    
}

//Шейдер не нужен? Перенести его в Layer?
@property (nonatomic, strong) Mesh2d *mesh;
@property (nonatomic, strong) StaticShader *shader;
@property (nonatomic) GLfloat *color;
@property (nonatomic, strong) Texture *texture1;
@property (nonatomic, strong) Texture *texture2;
@property (nonatomic, strong) Texture *texture3;

@property (nonatomic) GLKMatrix4 modelViewMatrix;
@property (nonatomic) GLKMatrix4 projectionMatrix;

- (instancetype)initWithMesh:(Mesh2d *)mesh;

@end
