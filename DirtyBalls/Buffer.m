//
//  Buffer.m
//  DirtyBalls
//
//  Created by Valeriy on 12.06.15.
//  Copyright (c) 2015 Valeriy. All rights reserved.
//

#import "Buffer.h"
//#import "Mesh2d.h"

@interface Buffer () {
    GLuint m_vbo;
    GLuint m_count;
    GLuint m_componentCount;
    DRAW_TYPE m_type;
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

- (DRAW_TYPE)type {
    return m_type;
}

- (instancetype)init {
    if (self = [super init]) {
        glGenBuffers(1, &m_vbo);
    }
    
    return self;
}

- (void)setData:(GLfloat *)data count:(GLuint)count perComponent:(GLuint)componentCount {
    [self setData:data count:count perComponent:componentCount andType:STATIC];
}

- (void)setData:(GLfloat *)data count:(GLuint)count perComponent:(GLuint)componentCount andType:(DRAW_TYPE)type {
    m_count = count;
    m_componentCount = componentCount;
    m_type = type;
    [self bind];
    [self allocate];
    glBufferSubData(GL_ARRAY_BUFFER, 0, count * sizeof(GLfloat), data);
    [self unbind];
}

- (void)allocate {
    if (m_type == STATIC) {
        glBufferData(GL_ARRAY_BUFFER, m_count * sizeof(GLfloat), NULL, GL_STATIC_DRAW);
    } else if (m_type == DYNAMIC) {
        glBufferData(GL_ARRAY_BUFFER, m_count * sizeof(GLfloat), NULL, GL_DYNAMIC_DRAW);
    }
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
