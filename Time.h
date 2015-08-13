//
//  Time.h
//  DirtyBalls
//
//  Created by Валерий Борисов on 12.08.15.
//  Copyright (c) 2015 Valeriy. All rights reserved.
//

#import <Foundation/Foundation.h>
#define DAY_PART_COUNT 4

typedef enum DAY_PART {
    kMorning = 0,
    kMidday = 1,
    kEvening = 2,
    kMidnight = 3,
} kDayPart;

@interface Time : NSObject

@property (nonatomic, readonly) kDayPart dayPart;
//Время дня в секундах
@property (nonatomic, readonly) int dayDuration;
@property (nonatomic, readonly) float dayTime;
//Кол-во прошедших дней
@property (nonatomic, readonly) int dayCount;
@property (nonatomic, readonly) float dayPartTime;

+ (Time *)sharedTime;
- (void)updateTime:(float)timeSinceLastUpdate;
- (float)getDurationDayPart;

@end
