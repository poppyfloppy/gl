//
//  Sun.h
//  DirtyBalls
//
//  Created by Валерий Борисов on 07.08.15.
//  Copyright (c) 2015 Valeriy. All rights reserved.
//

#import "Sprite.h"
#import "Projection.h"
#import "Sky.h"

@interface Sun : Sprite

- (void)updateSun:(float)timeSinceLastUpdate;
- (instancetype)initWithProjection:(Projection *)projection;

@property (nonatomic, strong) Sky *sky;
@property (nonatomic) float r;
@property (nonatomic) GLKVector2 sunPosition;

@end
