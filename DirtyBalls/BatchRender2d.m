//
//  BatchRender2d.m
//  DirtyBalls
//
//  Created by Valeriy on 16.06.15.
//  Copyright (c) 2015 Valeriy. All rights reserved.
//

#import "BatchRender2d.h"

@implementation BatchRender2d

#pragma mark init
- (instancetype)init {
    if (self = [super init]) {
        [self initVbo];
        [self initVao];
        [self initIbo];
    }
    
    return self;
}

- (void)initVbo {
    glGenBuffers(1, &vbo);
    glBindBuffer(GL_ARRAY_BUFFER, vbo);
    glBufferData(GL_ARRAY_BUFFER, BUFFER_SIZE, NULL, GL_DYNAMIC_DRAW);
    glBindBuffer(GL_ARRAY_BUFFER, 0);
}

- (void)initVao {
    glGenVertexArrays(1, &vao);
    glBindVertexArray(vao);
    glBindBuffer(GL_ARRAY_BUFFER, vbo);
    //Вершина
    glEnableVertexAttribArray(0);
    glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, VERTEX_SIZE, (GLvoid *)offsetof(Vertex, position));
    //Цвет
    glEnableVertexAttribArray(1);
    glVertexAttribPointer(1, 4, GL_FLOAT, GL_FALSE, VERTEX_SIZE, (GLvoid *)offsetof(Vertex, color));
    //Текстура
    glEnableVertexAttribArray(2);
    glVertexAttribPointer(2, 2, GL_FLOAT, GL_FALSE, VERTEX_SIZE, (GLvoid *)offsetof(Vertex, texture));
    glBindBuffer(GL_ARRAY_BUFFER, 0);
    glBindVertexArray(0);
}

- (void)initIbo {
    ibo = [IndexBuffer new];
    GLushort data[INDEX_BUFFER_SIZE];
    int offset = 0;
    for (int i = 0; i < INDEX_BUFFER_SIZE; i += 6) {
        data[i + 0] = offset + 0;
        data[i + 1] = offset + 1;
        data[i + 2] = offset + 2;
        data[i + 3] = offset + 2;
        data[i + 4] = offset + 3;
        data[i + 5] = offset + 0;
        offset += 4;
    }
    [ibo setData:data count:INDEX_BUFFER_SIZE];
}

- (void)dealloc {
    [ibo deleteBuffer];
    glDeleteBuffers(1, &vbo);
    glDeleteBuffers(1, &vao);
}

- (void)start {
    spritesInBuffer = 0;
    glBindBuffer(GL_ARRAY_BUFFER, vbo);
    buffer = (Vertex *)glMapBufferRange(GL_ARRAY_BUFFER, 0, BUFFER_SIZE, GL_MAP_WRITE_BIT);
}

- (void)end {
    glUnmapBuffer(GL_ARRAY_BUFFER);
    glBindBuffer(GL_ARRAY_BUFFER, 0);
}

- (void)submit:(RenderableObject *)object {
    spritesInBuffer++;
    buffer->position = object.position;
    buffer->color = object.color;
    buffer->texture = GLKVector2Make(0.0, 0.0);
    buffer++;
    buffer->position = GLKVector3Make(object.position.x, object.position.y + object.size.height, object.position.z);
    buffer->color = object.color;
    buffer->texture = GLKVector2Make(0.0, 1.0);
    buffer++;
    buffer->position = GLKVector3Make(object.position.x + object.size.width, object.position.y + object.size.height, object.position.z);
    buffer->color = object.color;
    buffer->texture = GLKVector2Make(1.0, 1.0);
    buffer++;
    buffer->position = GLKVector3Make(object.position.x + object.size.width, object.position.y, object.position.z);
    buffer->color = object.color;
    buffer->texture = GLKVector2Make(1.0, 0.0);
    buffer++;
}

- (void)flush {
    glBindVertexArray(vao);
    [ibo bind];
    glDrawElements(GL_TRIANGLES, spritesInBuffer * 6, GL_UNSIGNED_SHORT, NULL);
    [ibo unbind];
    glBindVertexArray(0);
}

@end
