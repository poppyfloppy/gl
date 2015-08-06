//
//  Sky.m
//  DirtyBalls
//
//  Created by Валерий Борисов on 24.07.15.
//  Copyright (c) 2015 Valeriy. All rights reserved.
//

#import "Sky.h"
#define DAY_TIME 20 //s

GLfloat morning[] = {
    192 / 255.0, 80 / 255.0, 185 / 255.0, 1.0,
    90 / 255.0, 136 / 255.0, 182 / 255.0, 1.0,
    90 / 255.0, 136 / 255.0, 182 / 255.0, 1.0,
    192 / 255.0, 80 / 255.0, 185 / 255.0, 1.0,
};

GLfloat midday[] = {
    1.0, 1.0, 1.0, 1.0,
    14 / 255.0, 139 / 255.0, 235 / 255.0, 1.0,
    14 / 255.0, 139 / 255.0, 235 / 255.0, 1.0,
    1.0, 1.0, 1.0, 1.0,
};

GLfloat evening[] = {
    196 / 255.0, 142 / 255.0, 71 / 255.0, 1.0,
    38 / 255.0, 84 / 255.0, 176 / 255.0, 1.0,
    38 / 255.0, 84 / 255.0, 176 / 255.0, 1.0,
    196 / 255.0, 142 / 255.0, 71 / 255.0, 1.0,
};

GLfloat midnight[] = {
    0.0, 0.0, 0.0, 1.0,
    0.0, 0.0, 0.0, 1.0,
    0.0, 0.0, 0.0, 1.0,
    0.0, 0.0, 0.0, 1.0,
};

//morning -> midday -> evening -> midnight
@interface Sky () {
    float currentTime;
    StaticShader *skyShader;
    kSkyTime mSkyTime;
}

@end

@implementation Sky

- (kSkyTime)skyTime {
    return mSkyTime;
}

#pragma mark init
- (instancetype)initWithProjection:(Projection *)projection {
    if (self = [super initWithPosition:GLKVector3Make(0, 0, 0) size:CGSizeMake(projection.width, projection.height) andColor:midday]) {
        skyShader = [[StaticShader alloc] initWithVShader:@"SkyShader.vsh" andFShader:@"SkyShader.fsh"];
        [skyShader setProjectionMatrix:projection.projectionMatrix];
        self.renderableObject.shader = skyShader;
        currentTime = [self getPeriodtime];
        mSkyTime = kMidday;
    }

    return self;
}

- (instancetype)init {
    return [self initWithProjection:nil];
}

#pragma mark update
- (void)updateSky:(float)timeSinceLastUpdate {
    //Обновление времени
    currentTime += timeSinceLastUpdate;
    if (currentTime >= DAY_TIME)
        currentTime = 0;
    //Утро
    if (currentTime < [self getPeriodtime]) {
        mSkyTime = kMorning;
        GLfloat *color = [self interpolateColor1:midday color2:morning andK:currentTime / [self getPeriodtime]];
        [self.renderableObject.mesh initColorBuffer:color count:16];
    //День
    } else if (currentTime >= [self getPeriodtime] && currentTime < 2 * [self getPeriodtime]) {
        mSkyTime = kMidday;
        GLfloat *color = [self interpolateColor1:evening color2:midday andK:(currentTime - [self getPeriodtime]) / [self getPeriodtime]];
        [self.renderableObject.mesh initColorBuffer:color count:16];
    //Вечер
    } else if (currentTime >= 2 * [self getPeriodtime] && currentTime < 3 * [self getPeriodtime]) {
        mSkyTime = kEvening;
        GLfloat *color = [self interpolateColor1:midnight color2:evening andK:(currentTime - 2 * [self getPeriodtime]) / [self getPeriodtime]];
        [self.renderableObject.mesh initColorBuffer:color count:16];
    //Ночь
    } else if (currentTime >= 3 * [self getPeriodtime] && currentTime < 4 * [self getPeriodtime]) {
        mSkyTime = kMidnight;
        GLfloat *color = [self interpolateColor1:morning color2:midnight andK:(currentTime - 3 * [self getPeriodtime]) / [self getPeriodtime]];
        [[[self renderableObject] mesh] initColorBuffer:color count:16];
    }
}

- (GLfloat *)interpolateColor1:(GLfloat *)color1 color2:(GLfloat *)color2 andK:(float)k {
    GLfloat *interColor = malloc(sizeof(GLfloat) * 16);
    for (int i = 0; i < 16; i++) {
        interColor[i] = k * color1[i] + (1 - k) * color2[i];
    }
    
    return interColor;
}

- (float)getPeriodtime {
    return DAY_TIME / 4.0;
}

@end
