//
//  Texture.m
//  DirtyBalls
//
//  Created by Valeriy on 22.06.15.
//  Copyright (c) 2015 Valeriy. All rights reserved.
//

#import "Texture.h"

@interface Texture () {
    GLsizei mWidth, mHeight;
    GLuint mTid;
}

- (GLuint)load:(NSString *)imageNamed width:(GLsizei *)w height:(GLsizei *)h;

@end

@implementation Texture

- (GLuint)tid {
    return mTid;
}

- (GLsizei)height {
    return mHeight;
}

- (GLsizei)width {
    return mWidth;
}

- (instancetype)initWith:(NSString *)imageName {
    if (self = [super init]) {
        mTid = [self load:imageName width:&mWidth height:&mHeight];
    }
    
    return self;
}

- (GLuint)load:(NSString *)imageNamed width:(GLsizei *)w height:(GLsizei *)h {
    UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:imageNamed ofType:nil]];
    CGImageRef cgImage = image.CGImage;
    *w = (GLsizei)CGImageGetWidth(cgImage);
    *h = (GLsizei)CGImageGetHeight(cgImage);
    GLsizei width = *w;
    GLsizei height = *h;
    GLubyte *data = (GLubyte *)calloc(width * height * 4, sizeof(GLubyte));
    CGContextRef context = CGBitmapContextCreate(data, width, height, 8, width * 4, CGImageGetColorSpace(cgImage), (CGBitmapInfo)kCGImageAlphaPremultipliedLast);
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), cgImage);
    CGContextRelease(context);

    GLuint texture;
    glGenTextures(1, &texture);
    glBindTexture(GL_TEXTURE_2D, texture);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, width, height, 0, GL_RGBA, GL_UNSIGNED_BYTE, data);
    glBindTexture(GL_TEXTURE_2D, 0);
    free(data);
    
    return texture;
}

- (void)deleteTexture {
    glDeleteTextures(1, &mTid);
}

- (void)bind {
    glBindTexture(GL_TEXTURE_2D, mTid);
}

- (void)unbind {
    glBindTexture(GL_TEXTURE_2D, 0);
}

@end
