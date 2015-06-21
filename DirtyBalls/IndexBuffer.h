//
//  IndexBuffer.h
//  DirtyBalls
//
//  Created by Valeriy on 12.06.15.
//  Copyright (c) 2015 Valeriy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>

@interface IndexBuffer : NSObject {
}

@property (nonatomic, readonly) GLuint ibo;
@property (nonatomic, readonly) GLuint count;

- (void)setData:(GLushort *)data count:(GLuint)count;
- (void)bind;
- (void)unbind;

- (void)deleteBuffer;

@end
