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
- (void)start {
    m_renderQue = [NSMutableArray new];
}

- (void)submit:(RenderableObject *)object {
    [m_renderQue addObject:object];
}

- (void)flush {
    for (int i = 0; i < m_renderQue.count; i++) {
        RenderableObject *object = [m_renderQue objectAtIndex:i];
        glActiveTexture(GL_TEXTURE0);
//        glActiveTexture(GL_TEXTURE1);
//        glActiveTexture(GL_TEXTURE2);
        [object.texture1 bind];
//        [object.texture2 bind];
//        [object.texture3 bind];
        [object.mesh.vao bind];
        [object.mesh.indexBuffer bind];
        [object.shader activateProgram];
        [object.shader setModelViewMatrix:object.modelViewMatrix];
        glUniform1i([object.shader getUniformLocation:@"textureSampler"], 0);
        glDrawElements(GL_TRIANGLES, object.mesh.positionBuffer.count, GL_UNSIGNED_SHORT, NULL);
        [object.shader disableProgram];
        [object.mesh.vao unbind];
        [object.mesh.indexBuffer unbind];
        [object.texture1 unbind];
//        [object.texture2 unbind];
//        [object.texture3 unbind];
    }
}
    
@end
