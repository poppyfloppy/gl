//
//  ShaderProgram.m
//  DirtyBalls
//
//  Created by Valeriy on 23.05.15.
//  Copyright (c) 2015 Valeriy. All rights reserved.
//

#import "ShaderProgram.h"

@interface ShaderProgram () {
    BOOL failed;
}

@end

@implementation ShaderProgram

#pragma mark акссесоры
- (BOOL)isFailed {
    return failed;
}

- (GLuint)getProgram {
    return program;
}

- (GLuint)getVShader {
    return vShader;
}

- (GLuint)getFShader {
    return fShader;
}

#pragma mark Инициализация
- (instancetype)initWithVShader:(NSString *)vertexShader andFShader:(NSString *)fragmentShader {
    if (self = [super init]) {
        if (![self createProgram:vertexShader :fragmentShader]) {
            failed = YES;
        }
    }
    
    return self;
}

- (BOOL)createProgram:(NSString *)vertexShader :(NSString *)fragmentShader {
    program = glCreateProgram();
    if (program == 0) {
        return NO;
    }
    NSString *vShaderPath = [[NSBundle mainBundle] pathForResource:vertexShader ofType:@""];
    NSString *fShaderPath = [[NSBundle mainBundle] pathForResource:fragmentShader ofType:@""];
    if (![self compileShader:&vShader andType:GL_VERTEX_SHADER andFile:vShaderPath]) {
        glDeleteShader(vShader);
        return NO;
    }
    if (![self compileShader:&fShader andType:GL_FRAGMENT_SHADER andFile:fShaderPath]) {
        glDeleteShader(fShader);
        return NO;
    }
    glAttachShader(program, vShader);
    glAttachShader(program, fShader);
    if (![self link]) {
        if (vShader > 0) {
            glDeleteShader(vShader);
        }
        if (fShader > 0) {
            glDeleteShader(fShader);
        }
        if (program > 0) {
            glDeleteProgram(program);
        }
        return NO;
    }
    if (vShader > 0) {
        glDetachShader(program, vShader);
        glDeleteShader(vShader);
    }
    if (fShader > 0) {
        glDetachShader(program, fShader);
        glDeleteShader(fShader);
    }
    
    return YES;
}

- (BOOL)compileShader:(GLuint *)shader andType:(GLenum)type andFile:(NSString *)file {
    *shader = glCreateShader(type);
    if (shader == 0) {
        return NO;
    }
    const GLchar *src = (GLchar *)[[NSString stringWithContentsOfFile:file encoding:NSUTF8StringEncoding error:nil] UTF8String];
    const GLchar *codeArray[] = {src};
    glShaderSource(*shader, 1, codeArray, NULL);
    glCompileShader(*shader);
    GLint result;
    glGetShaderiv(*shader, GL_COMPILE_STATUS, &result);
    if (result == GL_FALSE) {
        //Получения ошибки
        GLint logLength;
        glGetShaderiv(*shader, GL_INFO_LOG_LENGTH, &logLength);
        if (logLength > 0) {
            char *log = malloc(logLength * sizeof(char));
            glGetShaderInfoLog(*shader, logLength, &logLength, log);
            NSLog(@"Ошибка компиляции:%s", log);
            free(log);
        }
        return NO;
    }
    
    return YES;
}

- (BOOL)link {
    glLinkProgram(program);
    GLint result;
    glGetProgramiv(program, GL_LINK_STATUS, &result);
    if (result == GL_FALSE) {
        GLint logLength;
        glGetProgramiv(program, GL_INFO_LOG_LENGTH, &logLength);
        if (logLength > 0) {
            GLchar *log = malloc(logLength * sizeof(GLchar));
            glGetProgramInfoLog(program, logLength, &logLength, log);
            NSLog(@"Ошибка линковки: %s", log);
            free(log);
        }
        return NO;
    }
    
    return YES;
}

#pragma mark работа
- (void)deleteProgram {
    glDeleteProgram(program);
}

- (BOOL)validateProgram {
    glValidateProgram(program);
    GLint result;
    glGetProgramiv(program, GL_VALIDATE_STATUS, &result);
    if (result == GL_FALSE) {
        GLint logLength;
        glGetProgramiv(program, GL_INFO_LOG_LENGTH, &logLength);
        if (logLength > 0) {
            GLchar *log = malloc(logLength * sizeof(GLchar));
            glGetProgramInfoLog(program, logLength, &logLength, log);
            NSLog(@"Ошибка валидации: %s", log);
            free(log);
        }
        return NO;
    }
    
    return YES;
}

- (void)activateProgram {
    glUseProgram(program);
}

- (void)disableProgram {
    glUseProgram(0);
}

- (GLuint)getUniformLocation:(NSString *)name {
    return glGetUniformLocation(program, [name cStringUsingEncoding:NSUTF8StringEncoding]);
}

@end
