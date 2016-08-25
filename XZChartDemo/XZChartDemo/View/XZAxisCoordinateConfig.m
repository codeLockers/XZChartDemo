//
//  XZAxisCoordinateConfig.m
//  XZChartDemo
//
//  Created by 徐章 on 16/8/25.
//  Copyright © 2016年 徐章. All rights reserved.
//

#import "XZAxisCoordinateConfig.h"

@implementation XZAxisCoordinateConfig
- (id)init{
    
    self = [super init];
    if (self) {
        
        self.color                 = [UIColor blackColor];
        self.lineWidth             = 1.0f;
        self.arrowVerticalOffset   = 8.0f;
        self.arrowHorizontalOffset = 5.0f;
        self.dialLegth             = 5.0f;
        self.dialFont              = [UIFont systemFontOfSize:11.0f];
        self.xAxisStartMargin      = 15.0f;
        self.yAxisStartMargin      = 15.0f;
        self.yAxisLeftMargin       = 20.0f;
        self.xAxisBottomMargin     = 20.0f;
        self.xDialSpace            = 40.0f;
        self.barWidth              = 30.0f;
    }
    return self;
}
@end
