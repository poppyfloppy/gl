//
//  Game.m
//  DirtyBalls
//
//  Created by Валерий Борисов on 24.07.15.
//  Copyright (c) 2015 Valeriy. All rights reserved.
//

#import "Game.h"
#import "Sky.h"
#import "Sun.h"
#import "FirstRender2d.h"
#import "StaticShader.h"
#import "Projection.h"
#import "Sprite.h"
#import "Texture.h"
#import "Time.h"

@interface Game () {
    Time *time;
    Projection *projection;
    FirstRender2d *renderer;
    Sky *sky;
    Sprite *grass;
    Sprite *grass2;
    Sprite *corn;
    Sprite *corn2;
    Sprite *cloud1;
    Sprite *cloud2;
    Sprite *cloud3;
    Sun *sun;
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
    time = [Time sharedTime];
    [self initRenderer];
    [self initSky];
    [self initCorn];
    [self initGrass];
    [self initCloud];
    [self initSun];
}

- (void)initRenderer {
    renderer = [FirstRender2d new];
}

- (void)initSky {
    sky = [[Sky alloc] initWithProjection:projection andTime:time];
}

- (void)initSun {
    sun = [[Sun alloc] initWithProjection:projection andTime:time];
}

- (void)initCorn {
    StaticShader *cornShader = [[StaticShader alloc] initWithVShader:@"2dLight.vsh" andFShader:@"2dLight.fsh"];
    [cornShader setProjectionMatrix:projection.projectionMatrix];
    Texture *cornTexture = [[Texture alloc] initWith:@"corn3.png"];
    corn = [[Sprite alloc] initWithPosition:GLKVector3Make(0, 0, 0) size:CGSizeMake(projection.width, projection.height / 2.0) andTexture1:cornTexture];
    corn.renderableObject.shader = cornShader;
    
    corn2 = [[Sprite alloc] initWithPosition:GLKVector3Make(projection.width, 0, 0) size:CGSizeMake(projection.width, projection.height / 2.0) andTexture1:cornTexture];
    corn2.renderableObject.shader = cornShader;
}

- (void)initGrass {
    StaticShader *grassShader = [[StaticShader alloc] initWithVShader:@"2dLight.vsh" andFShader:@"2dLight.fsh"];
    [grassShader setProjectionMatrix:projection.projectionMatrix];
    Texture *grassTexture = [[Texture alloc] initWith:@"grass.png"];
    grass = [[Sprite alloc] initWithPosition:GLKVector3Make(0, 0, 0) size:CGSizeMake(projection.width, projection.height / 12.0) andTexture1:grassTexture];
    grass.renderableObject.shader = grassShader;
    
    grass2 = [[Sprite alloc] initWithPosition:GLKVector3Make(projection.width, 0, 0) size:CGSizeMake(projection.width, projection.height / 12.0) andTexture1:grassTexture];
    grass2.renderableObject.shader = grassShader;
}

- (void)initCloud {
    StaticShader *cloudShader = [[StaticShader alloc] initWithVShader:@"2dLight.vsh" andFShader:@"2dLight.fsh"];
    [cloudShader setProjectionMatrix:projection.projectionMatrix];
    Texture *cloud1Texture = [[Texture alloc] initWith:@"Cloud1.png"];
    cloud1 = [[Sprite alloc] initWithPosition:GLKVector3Make(0, projection.height / 2.0, 0) size:CGSizeMake(40, 20) andTexture1:cloud1Texture];
    cloud1.renderableObject.shader = cloudShader;
    
    Texture *cloud2Texture = [[Texture alloc] initWith:@"Cloud2.png"];
    cloud2 = [[Sprite alloc] initWithPosition:GLKVector3Make(projection.width / 2.0, 2 * projection.height / 3.0, 0) size:CGSizeMake(40, 10) andTexture1:cloud2Texture];
    cloud2.renderableObject.shader = cloudShader;
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
    [renderer submit:sun.renderableObject];
    [renderer submit:corn.renderableObject];
    [renderer submit:corn2.renderableObject];
    [renderer submit:grass.renderableObject];
    [renderer submit:grass2.renderableObject];
    [renderer submit:cloud1.renderableObject];
    [renderer submit:cloud2.renderableObject];
    [renderer end];
    [renderer flush];
}

#pragma mark update
- (void)update:(float)timeSinceLastUpdate {
    [time updateTime:timeSinceLastUpdate];
    [sky updateSky];
    [sun updateSun:timeSinceLastUpdate];
    [self updateCorn:timeSinceLastUpdate];
    [self updateCloud:timeSinceLastUpdate];
    [self updateGrass:timeSinceLastUpdate];
}

- (void)updateCorn:(float)timeSinceLastUpdate {
    [corn move:GLKVector3Make(-10 * timeSinceLastUpdate, 0, 0)];
    [corn2 move:GLKVector3Make(-10 * timeSinceLastUpdate, 0, 0)];
    if (corn.position.x + corn.size.width <= 0)
        [corn setPosition:GLKVector3Make(corn2.position.x + corn2.size.width, 0, 0)];
    if (corn2.position.x + corn2.size.width <= 0)
        [corn2 setPosition:GLKVector3Make(corn.position.x + corn.size.width, 0, 0)];
}

- (void)updateCloud:(float)timeSinceLastUpdate {
    [cloud1 move:GLKVector3Make(-5 * timeSinceLastUpdate, 0, 0)];
    [cloud2 move:GLKVector3Make(-5 * timeSinceLastUpdate, 0, 0)];
    if (cloud1.position.x + cloud1.size.width <= 0) {
        [cloud1 setPosition:GLKVector3Make(projection.width, 2 * projection.height / 3.0, 0)];
    }
    if (cloud2.position.x + cloud2.size.width <= 0) {
        [cloud2 setPosition:GLKVector3Make(projection.width, projection.height / 2.0, 0)];
    }
}

- (void)updateGrass:(float)timeSinceLastUpdate {
    [grass move:GLKVector3Make(-30 * timeSinceLastUpdate, 0, 0)];
    [grass2 move:GLKVector3Make(-30 * timeSinceLastUpdate, 0, 0)];
    if (grass.position.x + grass.size.width <= 0)
        [grass setPosition:GLKVector3Make(grass2.position.x + grass2.size.width, 0, 0)];
    if (grass2.position.x + grass2.size.width <= 0)
        [grass2 setPosition:GLKVector3Make(grass.position.x + grass.size.width, 0, 0)];
}

@end
