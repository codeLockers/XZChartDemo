//
//  XZYAxisView.h
//  XZChartDemo
//
//  Created by 徐章 on 16/8/29.
//  Copyright © 2016年 徐章. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XZAxisCoordinateConfig.h"

@interface XZYAxisView : UIView

- (id)initWithFrame:(CGRect)frame withAxisCoordinateModel:(XZAxisCoordinateConfig *)axisCoordinateConfig;
@end
