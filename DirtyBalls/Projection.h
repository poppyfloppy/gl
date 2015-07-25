//
//  Projection.h
//  DirtyBalls
//
//  Created by Валерий Борисов on 25.07.15.
//  Copyright (c) 2015 Valeriy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>

@interface Projection : NSObject

+ (instancetype)sharedProjection;
- (void)initOrthoProjectionLeft:(float)left right:(float)right bottom:(float)bottom top:(float)top nearZ:(float)nearZ andFarZ:(float)farZ;
- (void)initOrthoProjectionWidth:(float)width height:(float)height depth:(float)depth;
- (void)initPerspectiveProjection;

@property (nonatomic) GLKMatrix4 projectionMatrix;
//ортогональная проекция
@property (nonatomic) float width;
@property (nonatomic) float height;
@property (nonatomic) float depth;

//перспективная проекция


@end
