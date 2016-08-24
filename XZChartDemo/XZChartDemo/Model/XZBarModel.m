//
//  XZBarModel.m
//  XZChartDemo
//
//  Created by 徐章 on 16/8/23.
//  Copyright © 2016年 徐章. All rights reserved.
//

#import "XZBarModel.h"

@implementation XZBarModel

- (id)init{

    self = [super init];
    if (self) {
        
        self.barColor          = [UIColor greenColor];
        self.animationDuration = 1.0f;
    }
    return self;
}

@end
