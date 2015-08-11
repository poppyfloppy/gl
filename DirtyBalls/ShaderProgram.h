//
//  ShaderProgram.h
//  DirtyBalls
//
//  Created by Valeriy on 23.05.15.
//  Copyright (c) 2015 Valeriy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>
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

- (void)setUniform1i:(NSString *)name :(GLint)i;
- (void)setUniform1f:(NSString *)name :(GLfloat)f;
- (void)setUniformMat4:(NSString *)name :(GLKMatrix4)m;
- (void)setUniformMat3:(NSString *)name :(GLKMatrix3)m;
- (void)setUniformVec4:(NSString *)name :(GLKVector4)v;
- (void)setUniformVec3:(NSString *)name :(GLKVector3)v;
- (void)setUniformVec2:(NSString *)name :(GLKVector2)v;

@end
