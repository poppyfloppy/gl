//
//  Texture.h
//  DirtyBalls
//
//  Created by Valeriy on 22.06.15.
//  Copyright (c) 2015 Valeriy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>
#import <OpenGLES/ES3/glext.h>


//Добавить второй тип массив текстур для поддержки спрайт-анимации
@interface Texture : NSObject {
    
}

@property (nonatomic, readonly) GLuint tid;
@property (nonatomic, readonly) GLsizei width;
@property (nonatomic, readonly) GLsizei height;

- (instancetype)initWith:(NSString *)imageName;
- (void)deleteTexture;
- (void)bind;
- (void)unbind;

@end
