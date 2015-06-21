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

@interface RenderableObject : NSObject {
    
}

@property (nonatomic, strong) ShaderProgram *shader;
@property (nonatomic) GLKVector3 position;
@property (nonatomic, readonly) CGSize size;
@property (nonatomic) GLKVector4 color;

@property (nonatomic, strong) ArrayBuffer *arrayBuffer;
@property (nonatomic, strong) Buffer *vertexBuffer;
@property (nonatomic, strong) Buffer *colorBuffer;
@property (nonatomic, strong) IndexBuffer *indexBuffer;
//Текстура в будущем

- (instancetype)initWithPosition:(GLKVector3)position size:(CGSize)size andColor:(GLKVector4)color;

@end
