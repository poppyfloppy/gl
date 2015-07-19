//
//  Mesh2d.h
//  DirtyBalls
//
//  Created by Валерий Борисов on 19.07.15.
//  Copyright (c) 2015 Valeriy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Buffer.h"
#import "ArrayBuffer.h"
#import "IndexBuffer.h"

#define POSITION_INDEX 0
#define COLOR_INDEX 1
#define TEXTURE1_INDEX 2
#define TEXTURE2_INDEX 3
#define TEXTURE3_INDEX 4

@interface Mesh2d : NSObject {
    
}

@property (nonatomic, strong) ArrayBuffer *vao;
@property (nonatomic, strong) Buffer *positionBuffer;
@property (nonatomic, strong) Buffer *colorBuffer;
@property (nonatomic, strong) Buffer *texture1Buffer;
@property (nonatomic, strong) Buffer *texture2Buffer;
@property (nonatomic, strong) Buffer *texture3Buffer;
@property (nonatomic, strong) IndexBuffer *indexBuffer;

- (instancetype)initWith:(GLfloat *)position andCount:(size_t)count1 andColor:(GLfloat *)color andCount:(size_t)count2 andIndices:(GLushort *)indices andCount:(size_t)count3;
- (instancetype)initWith:(GLfloat *)position andCount:(size_t)count1 andTexure1:(GLfloat *)texture1 andCount:(size_t)count2 andIndices:(GLushort *)indices andCount:(size_t)count3;
- (instancetype)initWith:(GLfloat *)position andCount:(size_t)count1 andTexure1:(GLfloat *)texture1 andCount:(size_t)count2 andTexure2:(GLfloat *)texture2 andCount:(size_t)count3 andIndices:(GLushort *)indices andCount:(size_t)count4;
- (instancetype)initWith:(GLfloat *)position andCount:(size_t)count1 andTexure1:(GLfloat *)texture1 andCount:(size_t)count2 andTexure2:(GLfloat *)texture2 andCount:(size_t)count3 andTexure3:(GLfloat *)texture3 andCount:(size_t)count4 andIndices:(GLushort *)indices andCount:(size_t)count5;

@end
