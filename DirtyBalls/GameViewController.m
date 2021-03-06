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
#import "Layer.h"
#import "Texture.h"

@interface GameViewController () {
    ShaderProgram *program;
    ShaderProgram *skyShader;
    FirstRender2d *render;
    BatchRender2d *render2;
    Layer *layer;
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
    skyShader = [[ShaderProgram alloc] initWithVShader:@"SkyShader.vsh" andFShader:@"SkyShader.fsh"];
    
    glEnable(GL_DEPTH_TEST);
    GLKMatrix4 projectionMatrix = GLKMatrix4MakeOrtho(0, [UIScreen mainScreen].bounds.size.width / 10, 0, [UIScreen mainScreen].bounds.size.height/ 10, -10, 10);
    sprites = [NSMutableArray new];
    
    
    GLfloat data1[] = {
        0, 0, 0,
        0, 10, 0,
        10, 10, 0,
        10, 0, 0,
    };
    
    GLfloat data2[] = {
        1.0, 1.0, 0.0, 1.0,
        1.0, 1.0, 0.0, 1.0,
        1.0, 1.0, 0.0, 1.0,
        1.0, 1.0, 0.0, 1.0,
    };
    
    GLushort data3[] = {
        0, 1, 2,
        2, 3, 0
    };
    Mesh2d *mesh = [[Mesh2d alloc] initWith:data1 andCount:3 * 4 andColor:data2 andCount:4 * 4 andIndices:data3 andCount:3 * 2];
    RenderableObject *sky = [[RenderableObject new] initWithMesh:mesh];
    [sky setShader:skyShader];
    
    [sprites addObject:sky];
    
    render = [FirstRender2d new];
    layer = [Layer new];
    [layer setShader:skyShader];
    [layer setProjectionMatrix:projectionMatrix];
    [layer setRenderer:render];
    for (int i = 0; i < sprites.count; i++) {
        [layer add:sprites[i]];
    }
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
    [layer render];
    NSLog(@"OpenGl error: %d", glGetError());
}

@end
