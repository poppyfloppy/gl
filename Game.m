//
//  Game.m
//  DirtyBalls
//
//  Created by Валерий Борисов on 24.07.15.
//  Copyright (c) 2015 Valeriy. All rights reserved.
//

#import "Game.h"
#import "Sky.h"
#import "FirstRender2d.h"
#import "StaticShader.h"
#import "Projection.h"
#import "Sprite.h"
#import "Texture.h"

@interface Game () {
    Projection *projection;
    FirstRender2d *renderer;
    Sprite *sky;
    Sprite *corn;
}

@end

@implementation Game

- (instancetype)init {
    if (self = [super init]) {
        [self initGame];
    }
    
    return self;
}

- (void)initGame {
    projection = [Projection sharedProjection];
    [self initRenderer];
    [self initSky];
    [self initCorn];
}

- (void)initRenderer {
    renderer = [FirstRender2d new];
}

- (void)initSky {
    StaticShader *skyShader = [[StaticShader alloc] initWithVShader:@"SkyShader.vsh" andFShader:@"SkyShader.fsh"];
    [skyShader setProjectionMatrix:projection.projectionMatrix];
    GLfloat color[] = {
        1.0, 1.0, 1.0, 1.0,
        14 / 255.0, 139 / 255.0, 235 / 255.0, 1.0,
        14 / 255.0, 139 / 255.0, 235 / 255.0, 1.0,
        1.0, 1.0, 1.0, 1.0,
    };
    sky = [[Sprite alloc] initWithPosition:GLKVector3Make(0, 0, 0) size:CGSizeMake(projection.width, projection.height) andColor:color];
    sky.renderableObject.shader = skyShader;
}

- (void)initCorn {
    StaticShader *cornShader = [[StaticShader alloc] initWithVShader:@"2dLight.vsh" andFShader:@"2dLight.fsh"];
    [cornShader setProjectionMatrix:projection.projectionMatrix];
    Texture *cornTexture = [[Texture alloc] initWith:@"corn3.png"];
    corn = [[Sprite alloc] initWithPosition:GLKVector3Make(0, 0, 0) size:CGSizeMake([UIScreen mainScreen].bounds.size.width / 10, [UIScreen mainScreen].bounds.size.height/ 20) andTexture1:cornTexture];
    corn.renderableObject.shader = cornShader;
}

#pragma mark game control
- (void)reset {
    
}

- (void)start {
    
}

- (void)pause {
    
}

#pragma mark render
- (void)render {
    [renderer start];
    [renderer submit:sky.renderableObject];
    [renderer submit:corn.renderableObject];
    [renderer end];
    [renderer flush];
}

#pragma mark update
- (void)update:(float)timeSinceLastUpdate {
    
}

@end
