//
//  Sky.h
//  DirtyBalls
//
//  Created by Валерий Борисов on 24.07.15.
//  Copyright (c) 2015 Valeriy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Sprite.h"
#import "Projection.h"
typedef enum SKY_TIME {
    kMorning = 0,
    kMidday = 1,
    kEvening = 2,
    kMidnight = 3,
} kSkyTime;

@interface Sky : Sprite {
    
}

@property (nonatomic, readonly) kSkyTime skyTime;

- (float)getPeriodtime;
- (void)updateSky:(float)timeSinceLastUpdate;
- (instancetype)initWithProjection:(Projection *)projection;

@end
