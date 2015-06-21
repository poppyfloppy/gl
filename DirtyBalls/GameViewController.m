//
//  GameViewController.m
//  DirtyBalls
//
//  Created by Valeriy on 19.05.15.
//  Copyright (c) 2015 Valeriy. All rights reserved.
//

#import "GameViewController.h"
#import <OpenGLES/ES3/glext.h>
#import "ShaderProgram.h"
#import "Buffer.h"
#import "ArrayBuffer.h"
#import "RenderableObject.h"
#import "FirstRender2d.h"
#import "BatchRender2d.h"

@interface GameViewController () {
    ShaderProgram *program;
    RenderableObject *sprite, *sprite2, *sprite3;
    FirstRender2d *render;
    BatchRender2d *render2;
    NSMutableArray *sprites;
    
    GLKVector2 pos;
}

@property (strong, nonatomic) EAGLContext *context;

- (void)setupGL;
- (void)tearDownGL;

@end

@implementation GameViewController

- (BOOL)prefersStatusBarHidden {
    return YES;
}

#pragma mark OpenGL setup
- (void)viewDidLoad {
    [super viewDidLoad];
    self.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES3];
    GLKView *view = (GLKView *)self.view;
    view.context = self.context;
    view.drawableDepthFormat = GLKViewDrawableDepthFormat24;
    [self setupGL];
}

- (void)setupGL {
    [EAGLContext setCurrentContext:self.context];
    program = [[ShaderProgram alloc] initWithVShader:@"2dLight.vsh" andFShader:@"2dLight.fsh"];
    glEnable(GL_DEPTH_TEST);
    GLKMatrix4 projectionMatrix = GLKMatrix4MakeOrtho(0, [UIScreen mainScreen].bounds.size.width / 10, 0, [UIScreen mainScreen].bounds.size.height/ 10, -10, 10);
    [program activateProgram];
    glUniformMatrix4fv([program getUniformLocation:@"modelViewMatrix"], 1, 0, GLKMatrix4Identity.m);
    glUniformMatrix4fv([program getUniformLocation:@"projectionMatrix"], 1, 0, projectionMatrix.m);
    [program disableProgram];
   
    sprite = [[RenderableObject alloc] initWithPosition:GLKVector3Make(0, 0, 0) size:CGSizeMake(10, 10) andColor:GLKVector4Make(1.0, 0.0, 0.0, 1.0)];
    sprite2 = [[RenderableObject alloc] initWithPosition:GLKVector3Make(11, 0, 0) size:CGSizeMake(10, 10) andColor:GLKVector4Make(0.0, 0.0, 1.0, 1.0)];
    sprite3 = [[RenderableObject alloc] initWithPosition:GLKVector3Make(0, 15, 0) size:CGSizeMake(10, 10) andColor:GLKVector4Make(0.0, 0.0, 1.0, 1.0)];
    
    sprites = [NSMutableArray new];
    float gap = 0.2;
    int count = 100;
    float width = [UIScreen mainScreen].bounds.size.width / 10 - gap * (count - 1);
    float height = [UIScreen mainScreen].bounds.size.height/ 10 - gap * (count - 1);
    float spriteWidth = width / count;
    float spriteHeight = height / count;
    for (int i = 0; i < count; i++) {
        for (int j = 0; j < count; j++) {
            RenderableObject *object = [[RenderableObject alloc] initWithPosition:GLKVector3Make((spriteWidth + gap) * i, (spriteHeight + gap) * j, 0) size:CGSizeMake(spriteWidth, spriteHeight) andColor:GLKVector4Make(0.0, 1.0, 1.0, 1.0)];
            [object setShader:program];
            [sprites addObject:object];
        }
    }
    
    [sprite setShader:program];
    [sprite2 setShader:program];
    [sprite3 setShader:program];
    render = [FirstRender2d new];
    render2 = [BatchRender2d new];
}

#pragma mark dealloc OpenGL
- (void)dealloc {
    [self tearDownGL];
    if ([EAGLContext currentContext] == self.context) {
        [EAGLContext setCurrentContext:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    if ([self isViewLoaded] && ([[self view] window] == nil)) {
        self.view = nil;
        [self tearDownGL];
        if ([EAGLContext currentContext] == self.context) {
            [EAGLContext setCurrentContext:nil];
        }
        self.context = nil;
    }
}

- (void)tearDownGL {
    [EAGLContext setCurrentContext:self.context];
    if ([program getProgram] > 0) {
        [program deleteProgram];
    }
}

#pragma mark - GLKView and GLKViewController delegate methods
- (void)update {
    float width = [UIScreen mainScreen].bounds.size.width / 10;
    float height = [UIScreen mainScreen].bounds.size.height/ 10;
    pos = GLKVector2Make(pos.x + width / 300.0f, pos.y + height / 300.0f);
    [program activateProgram];
    glUniform2f([program getUniformLocation:@"lightPosition"], pos.x, pos.y);
    [program disableProgram];
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
    glClearColor(0.0f, 0.0f, 0.0f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
//    [render flush];
    [program activateProgram];
    [render2 start];
    for (int i = 0; i < sprites.count; i++)
        [render2 submit:[sprites objectAtIndex:i]];
    [render2 end];
    [render2 flush];
    [program disableProgram];
//    NSLog(@"OpenGl error: %d", glGetError());
}

@end
