//
//  ArrayBuffer.h
//  DirtyBalls
//
//  Created by Valeriy on 11.06.15.
//  Copyright (c) 2015 Valeriy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Buffer.h"
#import <OpenGLES/ES3/glext.h>

@interface ArrayBuffer : NSObject {
    
}

//Передевать еще страйд и смещение

@property (nonatomic, readonly) GLuint vao;
@property (nonatomic, strong, readonly) NSArray *buffers;

- (void)addBuffer:(Buffer *)buffer atIndex:(GLint)index;
- (void)bind;
- (void)unbind;

- (void)deleteArrayBuffer;

@end
