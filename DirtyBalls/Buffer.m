//
//  Buffer.m
//  DirtyBalls
//
//  Created by Valeriy on 12.06.15.
//  Copyright (c) 2015 Valeriy. All rights reserved.
//

#import "Buffer.h"

@interface Buffer () {
    GLuint m_vbo;
    GLuint m_count;
    GLuint m_componentCount;
}

@end

@implementation Buffer

- (GLuint)vbo {
    return m_vbo;
}

- (GLuint)count {
    return m_count;
}

- (GLuint)componentCount {
    return m_componentCount;
}

- (instancetype)init {
    if (self = [super init]) {
        glGenBuffers(1, &m_vbo);
    }
    
    return self;
}

- (void)setData:(GLfloat *)data count:(GLuint)count perComponent:(GLuint)componentCount {
    m_count = count;
    m_componentCount = componentCount;
    [self bind];
    glBufferData(GL_ARRAY_BUFFER, count * sizeof(GLfloat), data, GL_STATIC_DRAW);
    [self unbind];
}

- (void)bind {
    glBindBuffer(GL_ARRAY_BUFFER, m_vbo);
}

- (void)unbind {
    glBindBuffer(GL_ARRAY_BUFFER, 0);
}

- (void)deleteBuffer {
    glDeleteBuffers(1, &m_vbo);
}


@end
