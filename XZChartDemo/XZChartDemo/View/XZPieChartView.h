//
//  XZPieChartView.h
//  XZChartDemo
//
//  Created by 徐章 on 16/8/23.
//  Copyright © 2016年 徐章. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XZPieModel.h"

@interface XZPieCoordinateConfig : NSObject

/** 饼状图的半径*/
@property (nonatomic, assign) CGFloat radius;
/** 标题字体的*/
@property (nonatomic, strong) UIFont *titlFont;

@end

@interface XZPieChartView : UIView
/**
 *  创建饼状图
 *
 *  @param frame    frame
 *  @param pieModel 数据源
 *
 *  @return self
 */
- (id)initWithFrame:(CGRect)frame withPieCoordinateConfig:(XZPieCoordinateConfig *)pieCoordinateConfig withData:(NSArray *)dataArray;

@end
