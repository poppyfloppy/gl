//
//  Buffer.h
//  DirtyBalls
//
//  Created by Valeriy on 12.06.15.
//  Copyright (c) 2015 Valeriy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>

@interface Buffer : NSObject {
}

@property (nonatomic, readonly) GLuint vbo;
@property (nonatomic, readonly) GLuint count;
@property (nonatomic, readonly) GLuint componentCount;

- (void)setData:(GLfloat *)data count:(GLuint)count perComponent:(GLuint)componentCount;
- (void)bind;
- (void)unbind;

- (void)deleteBuffer;

@end
