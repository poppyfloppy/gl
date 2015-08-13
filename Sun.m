//
//  Sun.m
//  DirtyBalls
//
//  Created by Валерий Борисов on 07.08.15.
//  Copyright (c) 2015 Valeriy. All rights reserved.
//

#import "Sun.h"
#import "SunShader.h"

#define DEFAULT_SUN_POSITION GLKVector2Make(50, 30)
#define DEFAULT_SUN_R 5.0

GLfloat color[] = {
    249.0 / 255.0, 241.0 / 255.0, 7.0 / 255.0, 1.0,
    249.0 / 255.0, 241.0 / 255.0, 7.0 / 255.0, 1.0,
    249.0 / 255.0, 241.0 / 255.0, 7.0 / 255.0, 1.0,
    249.0 / 255.0, 241.0 / 255.0, 7.0 / 255.0, 1.0,
};

@interface Sun() {
    SunShader *sunShader;
    Time *mTime;
}

@end

@implementation Sun

- (void)setSunPosition:(GLKVector2)sunPosition {
    _sunPosition = sunPosition;
    [sunShader setSunPos:sunPosition];
}

- (void)setR:(float)r {
    _r = r;
    [sunShader setR:r];
}

- (instancetype)initWithProjection:(Projection *)projection andTime:(Time *)time {
    if (self = [super initWithPosition:GLKVector3Make(0, 0, -10) size:CGSizeMake(projection.width, projection.height) andColor:color]) {
        sunShader = [[SunShader alloc] initWithVShader:@"SunShader.vsh" andFShader:@"SunShader.fsh"];
        self.sunPosition = DEFAULT_SUN_POSITION;
        self.r = DEFAULT_SUN_R;
        [sunShader setProjectionMatrix:projection.projectionMatrix];
        self.renderableObject.shader = sunShader;
        mTime = time;
    }
    
    return self;
}

- (void)updateSun:(float)timeSinceLastUpdate {
    //Закат
    if (mTime.dayPart == kEvening) {
        float v = (DEFAULT_SUN_POSITION.y + 2 * DEFAULT_SUN_R) / [mTime getDurationDayPart];
        self.sunPosition = GLKVector2Make(self.sunPosition.x, self.sunPosition.y - timeSinceLastUpdate * v);
    }
    //Рассвет
    if (mTime.dayPart == kMidnight) {
        float v = (DEFAULT_SUN_POSITION.y + 2 * DEFAULT_SUN_R) / [mTime getDurationDayPart];
        self.sunPosition = GLKVector2Make(self.sunPosition.x, self.sunPosition.y + timeSinceLastUpdate * v);
    }
}

@end
