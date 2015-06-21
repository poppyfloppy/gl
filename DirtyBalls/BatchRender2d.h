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
#define VERTEX_SIZE sizeof(Vertex)
#define SPRITE_SIZE 4 * VERTEX_SIZE
#define BUFFER_SIZE MAX_SPRITES * SPRITE_SIZE
#define INDEX_BUFFER_SIZE 6 * MAX_SPRITES

@interface BatchRender2d : Render2d {
    //VAO, VBO, IBO
    GLuint vao;
    //Массив Vertex
    GLuint vbo;
    IndexBuffer *ibo;
    Vertex *buffer;
    GLushort spritesInBuffer;
}

- (void)start;
- (void)end;

@end
