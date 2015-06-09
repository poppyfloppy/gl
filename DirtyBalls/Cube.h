//
//  Cube.h
//  DirtyBalls
//
//  Created by Valeriy on 09.06.15.
//  Copyright (c) 2015 Valeriy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>
#import "ShaderProgram.h"

@interface Cube : NSObject {
    
}

@property (nonatomic) float side;

//рендер
@property (nonatomic) GLuint vao;
@property (nonatomic) GLKMatrix4 mvp;
@property (nonatomic) GLKMatrix3 nm;
@property (nonatomic, strong) ShaderProgram *program;

- (void)render;

@end
