//
//  Sprite.h
//  DirtyBalls
//
//  Created by Valeriy on 07.07.15.
//  Copyright (c) 2015 Valeriy. All rights reserved.
//

#import "RenderableObject.h"
#import "Texture.h"

@interface Sprite : NSObject {
    
}

@property (nonatomic, strong) RenderableObject *renderableObject;
@property (nonatomic) GLKVector3 position;
@property (nonatomic) CGSize size;

//А может сделать один буфер под вершину с оффсетами? А не несеольео как сейчас (тогда по идеи можно будет Renderable objects использовать в batch renderere)
- (instancetype)initWithPosition:(GLKVector3)position size:(CGSize)size andColor:(GLfloat *)color;
- (instancetype)initWithPosition:(GLKVector3)position size:(CGSize)size andTexture1:(Texture *)texture1;
- (instancetype)initWithPosition:(GLKVector3)position size:(CGSize)size andTexture1:(Texture *)texture1 andTexture2:(Texture *)texture2;
- (instancetype)initWithPosition:(GLKVector3)position size:(CGSize)size andTexture1:(Texture *)texture1 andTexture2:(Texture *)texture2 andTexture3:(Texture *)texture3;

- (void)move:(GLKVector3)velocity;
- (void)rotate:(GLKVector3)rotataion;
- (void)scale:(GLKVector3)scale;

@end
