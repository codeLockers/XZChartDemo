//
//  XZLineModel.m
//  XZChartDemo
//
//  Created by 徐章 on 16/8/23.
//  Copyright © 2016年 徐章. All rights reserved.
//

#import "XZLineModel.h"

@implementation XZLineModel

- (id)init{

    self = [super init];
    if (self) {
        
        self.lineColor         = [UIColor blackColor];
        self.lineWidth         = 1.0f;
        self.animationDuration = 1.0f;
    }
    return self;
}

@end
