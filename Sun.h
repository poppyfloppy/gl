//
//  Sun.h
//  DirtyBalls
//
//  Created by Валерий Борисов on 07.08.15.
//  Copyright (c) 2015 Valeriy. All rights reserved.
//

#import "Sprite.h"
#import "Time.h"
#import "Projection.h"

@interface Sun : Sprite

- (void)updateSun:(float)timeSinceLastUpdate;
- (instancetype)initWithProjection:(Projection *)projection andTime:(Time *)time;

@property (nonatomic) float r;
@property (nonatomic) GLKVector2 sunPosition;

@end
