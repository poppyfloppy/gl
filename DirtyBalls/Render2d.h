//
//  Render2d.h
//  DirtyBalls
//
//  Created by Valeriy on 12.06.15.
//  Copyright (c) 2015 Valeriy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RenderableObject.h"

//Абстрактный класс
@interface Render2d : NSObject {
}

- (void)submit:(RenderableObject *)object;
- (void)flush;

@end
