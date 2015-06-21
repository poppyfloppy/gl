//
//  IndexBuffer.m
//  DirtyBalls
//
//  Created by Valeriy on 12.06.15.
//  Copyright (c) 2015 Valeriy. All rights reserved.
//

#import "IndexBuffer.h"

@interface IndexBuffer () {
    GLuint m_ibo;
    GLuint m_count;
}

@end

@implementation IndexBuffer

- (GLuint)ibo {
    return m_ibo;
}

- (GLuint)count {
    return m_count;
}

- (instancetype)init {
    if (self = [super init]) {
        glGenBuffers(1, &m_ibo);
    }
    
    return self;
}

- (void)setData:(GLushort *)data count:(GLuint)count {
    m_count = count;
    [self bind];
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, count * sizeof(GLushort), data, GL_STATIC_DRAW);
    [self unbind];
}

- (void)bind {
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, m_ibo);
}

- (void)unbind {
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, 0);
}

- (void)deleteBuffer {
    glDeleteBuffers(1, &m_ibo);
}

@end
