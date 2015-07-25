//
//  Game.h
//  DirtyBalls
//
//  Created by Валерий Борисов on 24.07.15.
//  Copyright (c) 2015 Valeriy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Game : NSObject

- (void)reset;
- (void)pause;
- (void)start;
- (void)render;
- (void)update:(float)timeSinceLastUpdate;

@end
