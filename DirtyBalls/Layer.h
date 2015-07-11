//
//  Layer.h
//  DirtyBalls
//
//  Created by Valeriy on 22.06.15.
//  Copyright (c) 2015 Valeriy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>
#import "ShaderProgram.h"
#import "RenderableObject.h"
#import "Render2d.h"


//Нужен ли ты? Хранить ли в тебе шейдер? 
@interface Layer : NSObject {
    NSMutableArray *objects;
}

@property (nonatomic) GLKMatrix4 projectionMatrix;
@property (nonatomic, strong) ShaderProgram *shader;
@property (nonatomic, strong) Render2d *renderer;

- (void)add:(RenderableObject *)object;
- (void)render;

@end
