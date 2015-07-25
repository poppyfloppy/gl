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
#import "StaticShader.h"
#import "Buffer.h"
#import "ArrayBuffer.h"
#import "RenderableObject.h"
#import "FirstRender2d.h"
#import "BatchRender2d.h"
#import "Layer.h"
#import "Texture.h"
#import "Sprite.h"
#import "Projection.h"

#import "Game.h"

@interface GameViewController () {
    StaticShader *program;
    StaticShader *skyShader;
    FirstRender2d *render;
    BatchRender2d *render2;
    Layer *layer;
    NSMutableArray *sprites;
    Sprite *sky;
    Sprite *grass;
    Projection *projection;
    
    Game *game;
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
    game = [[Game alloc] init];
}

- (void)setupGL {
    [EAGLContext setCurrentContext:self.context];
    program = [[StaticShader alloc] initWithVShader:@"2dLight.vsh" andFShader:@"2dLight.fsh"];
    skyShader = [[StaticShader alloc] initWithVShader:@"SkyShader.vsh" andFShader:@"SkyShader.fsh"];
    
//    glEnable(GL_DEPTH_TEST);
    projection = [Projection sharedProjection];
    [projection initOrthoProjectionWidth:[UIScreen mainScreen].bounds.size.width / 10 height:[UIScreen mainScreen].bounds.size.height / 10 depth:20];
    [skyShader setProjectionMatrix:projection.projectionMatrix];
    [program setProjectionMatrix:projection.projectionMatrix];
    GLfloat color[] = {
        1.0, 1.0, 1.0, 1.0,
        14 / 255.0, 139 / 255.0, 235 / 255.0, 1.0,
        14 / 255.0, 139 / 255.0, 235 / 255.0, 1.0,
        1.0, 1.0, 1.0, 1.0,
    };
    sky = [[Sprite alloc] initWithPosition:GLKVector3Make(0, 0, 0) size:CGSizeMake([UIScreen mainScreen].bounds.size.width / 10, [UIScreen mainScreen].bounds.size.height/ 10) andColor:color];
    sky.renderableObject.shader = skyShader;
    Texture *grassTexture = [[Texture alloc] initWith:@"corn3.png"];
    grass = [[Sprite alloc] initWithPosition:GLKVector3Make(0, 0, 0) size:CGSizeMake([UIScreen mainScreen].bounds.size.width / 10, [UIScreen mainScreen].bounds.size.height/ 20) andTexture1:grassTexture];
    grass.renderableObject.shader = program;
    
    render = [FirstRender2d new];
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
    NSLog(@"fps: %f", 1 / self.timeSinceLastUpdate);
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
    glClearColor(1.0f, 0.0f, 0.0f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
//    [render start];
//    [render submit:sky.renderableObject];
//    [render submit:grass.renderableObject];
//    [render end];
//    [render flush];
    [game render];
    NSLog(@"OpenGl error: %d", glGetError());
}

@end
