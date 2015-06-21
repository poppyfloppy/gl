//
//  FirstRender2d.m
//  DirtyBalls
//
//  Created by Valeriy on 12.06.15.
//  Copyright (c) 2015 Valeriy. All rights reserved.
//

#import "FirstRender2d.h"

@interface FirstRender2d () {
    NSMutableArray *m_renderQue;
}

@end

@implementation FirstRender2d

- (instancetype)init {
    if (self = [super init]) {
        m_renderQue = [NSMutableArray new];
    }
    
    return self;
}

#pragma mark render
- (void)submit:(RenderableObject *)object {
    [m_renderQue addObject:object];
}

- (void)flush {
    for (int i = 0; i < m_renderQue.count; i++) {
        RenderableObject *object = [m_renderQue objectAtIndex:i];
        [object.arrayBuffer bind];
        [object.indexBuffer bind];
        [object.shader activateProgram];
        glUniformMatrix4fv([object.shader getUniformLocation:@"modelViewMatrix"], 1, 0, GLKMatrix4MakeTranslation(object.position.x, object.position.y, object.position.z).m);
        glDrawElements(GL_TRIANGLES, object.vertexBuffer.count, GL_UNSIGNED_SHORT, NULL);
        [object.shader disableProgram];
        [object.indexBuffer unbind];
        [object.arrayBuffer unbind];
    }
}
    
@end
