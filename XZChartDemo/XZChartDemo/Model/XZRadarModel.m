//
//  XZRadarModel.m
//  XZChartDemo
//
//  Created by 徐章 on 16/8/24.
//  Copyright © 2016年 徐章. All rights reserved.
//

#import "XZRadarModel.h"

@implementation XZRadarModel

- (id)init{

    self = [super init];
    if (self) {
        
        self.lineWidth         = 0.0;
        self.lineColor         = [UIColor clearColor];
        self.fillColor         = [UIColor colorWithRed:0 green:255 blue:0 alpha:0.8];
        self.animationDuration = 1.0f;
    }
    return self;
}

@end
