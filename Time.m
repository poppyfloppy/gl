//
//  Time.m
//  DirtyBalls
//
//  Created by Валерий Борисов on 12.08.15.
//  Copyright (c) 2015 Valeriy. All rights reserved.
//

#import "Time.h"

#define DAY_DURATION 20

@interface Time () {
    int mDayDuration;
    int mDayCount;
    float mDayTime;
    float mDayPartTime;
    kDayPart mDayPart;
}

@end

@implementation Time

#pragma mark getters'n'setters
- (int)dayDuration {
    return mDayDuration;
}

- (int)dayCount {
    return mDayCount;
}

- (float)dayTime {
    return mDayTime;
}

- (kDayPart)dayPart {
    return mDayPart;
}

- (float)dayPartTime {
    return mDayPartTime;
}

#pragma mark init
+ (Time *)sharedTime {
    static Time *time = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        time = [Time new];
    });
    
    return time;
}

- (instancetype)init {
    if (self = [super init]) {
        mDayCount = 0;
        mDayPartTime = 0;
        mDayDuration = DAY_DURATION;
        mDayTime = [self getDurationDayPart];
        mDayPart = kMidday;
    }
    
    return self;
}

- (float)getDurationDayPart {
    return mDayDuration / DAY_PART_COUNT;
}

#pragma mark update
- (void)updateTime:(float)timeSinceLastUpdate {
    mDayTime += timeSinceLastUpdate;
    mDayPartTime += timeSinceLastUpdate;
    if (mDayPartTime >= [self getDurationDayPart]) {
        mDayPartTime = MAX([self getDurationDayPart] - mDayPartTime, 0);
        [self changeDayPart];
    }
    if (mDayTime >= mDayDuration) {
        mDayCount++;
        mDayTime = mDayDuration - mDayTime;
    }
}

- (void)changeDayPart {
    mDayPart++;
    if (mDayPart > DAY_PART_COUNT - 1)
        mDayPart = 0;
}

@end
