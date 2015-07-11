//
//  Vertex.h
//  DirtyBalls
//
//  Created by Valeriy on 24.05.15.
//  Copyright (c) 2015 Valeriy. All rights reserved.
//
#import <GLKit/GLKit.h>

#ifndef DirtyBalls_Vertex_h
#define DirtyBalls_Vertex_h
typedef struct {
    GLKVector3 position;
    GLKVector4 color;
} Vertex1P1C;

typedef struct {
    GLKVector3 position;
    GLKVector4 color;
    GLKVector2 texture;
} Vertex1P1C1T;

typedef struct {
    GLKVector3 position;
    GLKVector2 texture1;
    GLKVector2 texture2;
} Vertex1P2T;

typedef struct {
    GLKVector3 position;
    GLKVector2 texture1;
    GLKVector2 texture2;
    GLKVector2 texture3;
} Vertex1P3T;

#endif
