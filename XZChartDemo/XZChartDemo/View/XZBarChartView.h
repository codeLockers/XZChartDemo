//
//  XZBarChartView.h
//  XZChartDemo
//
//  Created by 徐章 on 16/8/23.
//  Copyright © 2016年 徐章. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XZAxisCoordinateConfig.h"

@interface XZBarView : UIView

@end

@interface XZBarChartView : UIView
/**
 *  创建折线统计图
 *
 *  @param frame                frame
 *  @param axisCoordinateConfig 坐标系配置
 *  @param dataArray            数据源
 *
 *  @return self
 */
- (id)initWithFrame:(CGRect)frame withAxisCoordinateConfig:(XZAxisCoordinateConfig *)axisCoordinateConfig withData:(NSArray *)dataArray;

@end
