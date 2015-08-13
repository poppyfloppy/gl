//
//  Sky.m
//  DirtyBalls
//
//  Created by Валерий Борисов on 24.07.15.
//  Copyright (c) 2015 Valeriy. All rights reserved.
//

#import "Sky.h"

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
    StaticShader *skyShader;
    Time *mTime;
}

@end

@implementation Sky

#pragma mark init
- (instancetype)initWithProjection:(Projection *)projection andTime:(Time *)time {
    if (self = [super initWithPosition:GLKVector3Make(0, 0, 0) size:CGSizeMake(projection.width, projection.height) andColor:midday]) {
        mTime = time;
        skyShader = [[StaticShader alloc] initWithVShader:@"SkyShader.vsh" andFShader:@"SkyShader.fsh"];
        [skyShader setProjectionMatrix:projection.projectionMatrix];
        self.renderableObject.shader = skyShader;
    }

    return self;
}

- (instancetype)init {
    return [self initWithProjection:nil andTime:nil];
}

#pragma mark update
- (void)updateSky {
    //Утро
    if (kMorning == mTime.dayPart) {
        GLfloat *color = [self interpolateColor1:midday color2:morning andK:mTime.dayPartTime / [mTime getDurationDayPart]];
        [self.renderableObject.mesh initColorBuffer:color count:16];
    //День
    } else if (kMidday == mTime.dayPart) {
        GLfloat *color = [self interpolateColor1:evening color2:midday andK:mTime.dayPartTime / [mTime getDurationDayPart]];
        [self.renderableObject.mesh initColorBuffer:color count:16];
    //Вечер
    } else if (kEvening == mTime.dayPart) {
        GLfloat *color = [self interpolateColor1:midnight color2:evening andK:mTime.dayPartTime / [mTime getDurationDayPart]];
        [self.renderableObject.mesh initColorBuffer:color count:16];
    //Ночь
    } else if (kMidnight == mTime.dayPart) {
        GLfloat *color = [self interpolateColor1:morning color2:midnight andK:mTime.dayPartTime / [mTime getDurationDayPart]];
        [[[self renderableObject] mesh] initColorBuffer:color count:16];
    }
}

- (GLfloat *)interpolateColor1:(GLfloat *)color1 color2:(GLfloat *)color2 andK:(float)k {
    NSLog(@"k:%f", k);
    GLfloat *interColor = malloc(sizeof(GLfloat) * 16);
    for (int i = 0; i < 16; i++) {
        interColor[i] = k * color1[i] + (1 - k) * color2[i];
    }
    
    return interColor;
}

@end
