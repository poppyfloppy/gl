//
//  ShaderProgram.h
//  DirtyBalls
//
//  Created by Valeriy on 23.05.15.
//  Copyright (c) 2015 Valeriy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenGLES/ES3/glext.h>

@interface ShaderProgram : NSObject {
    GLuint program;
    GLuint vShader, fShader;
}

@property (nonatomic, readonly) BOOL isFailed;

- (instancetype)initWithVShader:(NSString *)vShader andFShader:(NSString *)fShader;
- (GLuint)getProgram;
- (GLuint)getVShader;
- (GLuint)getFShader;
- (BOOL)validateProgram;
- (void)activateProgram;
- (void)disableProgram;
- (void)deleteProgram;
- (GLuint)getUniformLocation:(NSString *)name;

@end
