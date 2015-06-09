//
//  Sphere.h
//  DirtyBalls
//
//  Created by Valeriy on 24.05.15.
//  Copyright (c) 2015 Valeriy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>
#import "ShaderProgram.h"
#import "Vertex.h"

@interface Sphere : NSObject {
    
}

@property (nonatomic) float radious;

//рендер
@property (nonatomic) GLuint vao;
@property (nonatomic) GLKMatrix4 mvp;
@property (nonatomic) GLKMatrix3 nm;
@property (nonatomic, strong) ShaderProgram *program;

- (instancetype)initWith:(float)r;
- (void)render;

@end
