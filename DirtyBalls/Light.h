//
//  Light.h
//  DirtyBalls
//
//  Created by Валерий Борисов on 12.08.15.
//  Copyright (c) 2015 Valeriy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>

@interface Light : NSObject {
    
}

@property (nonatomic) float intensity;
@property (nonatomic) GLKVector2 lightPosition;

@end
