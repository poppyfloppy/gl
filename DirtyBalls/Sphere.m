//
//  Sphere.m
//  DirtyBalls
//
//  Created by Valeriy on 24.05.15.
//  Copyright (c) 2015 Valeriy. All rights reserved.
//

#import "Sphere.h"

@interface Sphere () {
    Vertex *vertex;
}

@end

@implementation Sphere

#pragma mark инициализация
- (instancetype)init {
    return [self initWith:1.0];
}

- (instancetype)initWith:(float)r {
    if (self = [super init]) {
        self.radious = r;
        vertex = malloc(10 * 10 * sizeof(Vertex));
        for (int i = 0; i < 10; i++) {
            for (int j = 0; j < 10 - 1; j++) {
                Vertex v = {{sin(M_PI * i / 10) * cos(2 * M_PI * j / 10), sin(M_PI * i / 10) * sin(2 * M_PI * j / 10), cos(M_PI * i / 10)}, {0, 0, 0}};
                vertex[i * j + j] = v;
            }
        }
        GLuint vbo;
        glGenVertexArrays(1, &_vao);
        glBindVertexArray(_vao);
        glGenBuffers(1, &vbo);
        glBindBuffer(GL_ARRAY_BUFFER, vbo);
        glBufferData(GL_ARRAY_BUFFER, sizeof(vertex), vertex, GL_STATIC_DRAW);
        glEnableVertexAttribArray(0);
        glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, sizeof(Vertex), offsetof(Vertex, position));
        glBindVertexArray(0);
    }
    
    return self;
}

#pragma mark
- (void)render {
    glBindVertexArray(self.vao);
    [self.program activateProgram];
    glUniformMatrix4fv([self.program getUniformLocation:@"modelViewProjectionMatrix"], 1, 0, self.mvp.m);
    glUniformMatrix3fv([self.program getUniformLocation:@"normalMatrix"], 1, 0, self.nm.m);
    glDrawArrays(GL_TRIANGLES, 0, 36);
}

@end
