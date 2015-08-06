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

@interface Sky : Sprite {
    
}

- (void)updateSky:(float)timeSinceLastUpdate;
- (instancetype)initWithProjection:(Projection *)projection;

@end
