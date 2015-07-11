//
//  ArrayBuffer.m
//  DirtyBalls
//
//  Created by Valeriy on 11.06.15.
//  Copyright (c) 2015 Valeriy. All rights reserved.
//

#import "ArrayBuffer.h"

@interface ArrayBuffer () {
    GLuint m_vao;
    NSMutableArray *m_buffers;
}


@end

@implementation ArrayBuffer

- (GLuint)vao {
    return m_vao;
}

- (NSArray *)buffers {
    return m_buffers;
}

- (instancetype)init {
    if (self = [super init]) {
        glGenVertexArrays(1, &m_vao);
        m_buffers = [NSMutableArray new];
    }
    
    return self;
}


- (void)addBuffer:(Buffer *)buffer atIndex:(GLint)index {
    [m_buffers addObject:[NSNumber numberWithInt:buffer.vbo]];
    [self bind];
    [buffer bind];
    glEnableVertexAttribArray(index);
    glVertexAttribPointer(index, buffer.componentCount, GL_FLOAT, GL_FALSE, 0, 0);
    [buffer unbind];
    [self unbind];
}

- (void)bind {
    glBindVertexArray(m_vao);
}

- (void)unbind {
    glBindVertexArray(0);
}

- (void)deleteArrayBuffer {
    for (NSNumber *number in m_buffers) {
        GLuint vboId = [number unsignedIntValue];
        glDeleteBuffers(1, &vboId);
    }
    m_buffers = nil;
    glDeleteBuffers(1, &m_vao);
}


@end
