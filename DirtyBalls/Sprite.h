//
//  Sprite.h
//  DirtyBalls
//
//  Created by Valeriy on 07.07.15.
//  Copyright (c) 2015 Valeriy. All rights reserved.
//

#import "RenderableObject.h"

@interface Sprite : RenderableObject
//Передаем вершины и их тип и из них генерируем буферы? Что делать с шейдерами? А может сделать один буфер под вершину с оффсетами? А не несеольео как сейчас (тогда по идеи можно будет Renderable objects использовать в batch renderere)


@end
