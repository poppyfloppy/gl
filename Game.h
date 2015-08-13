//
//  Game.h
//  DirtyBalls
//
//  Created by Валерий Борисов on 24.07.15.
//  Copyright (c) 2015 Valeriy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Game : NSObject
/*
 TODO
 Также создать класс света (Что такое свет -- это позиция и интенсивность)
 Надо создать два объекта для Луны и Солнца как основные, и добавлять/вычитать шумы (Возможно класс света подойдет как синглетон, а объект света как раз можно выбрать из фазы дня,которую я описал выше)
 
 Шейдер для солнца хорошо впишется и в шейдер длядругих осещений (возможо его можно объеденить и с 2dLight)
 
 batch renderer по map buffer (возможно, сортировать оп шейдерам слои)
 */

- (void)reset;
- (void)pause;
- (void)start;
- (void)render;
- (void)update:(float)timeSinceLastUpdate;

@end
