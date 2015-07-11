//
//  BatchRender2d.h
//  DirtyBalls
//
//  Created by Valeriy on 16.06.15.
//  Copyright (c) 2015 Valeriy. All rights reserved.
//

#import "Render2d.h"
#import <OpenGLES/ES3/glext.h>
#import "IndexBuffer.h"
#import "Vertex.h"

#define MAX_SPRITES 10000
#define VERTEX_SIZE sizeof(Vertex1P1C1T)
#define SPRITE_SIZE 4 * VERTEX_SIZE
#define BUFFER_SIZE MAX_SPRITES * SPRITE_SIZE
#define INDEX_BUFFER_SIZE 6 * MAX_SPRITES


//Должен получать шейдер и тип вертекса из первого добавленного объекта?
//Можно ли как-то вплиить разные текстуры?
//Продумать задаваемую конфигрурацию
//Что делать с транформами? Считать их при добавление? Можно ли как-то посчитать в шейдере? Массив?
@interface BatchRender2d : Render2d {
    //VAO, VBO, IBO
    GLuint vao;
    //Массив Vertex
    GLuint vbo;
    IndexBuffer *ibo;
    Vertex1P1C1T *buffer;
    GLushort spritesInBuffer;
}

- (void)start;
- (void)end;

@end
