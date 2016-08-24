//
//  XZRadarChartView.h
//  XZChartDemo
//
//  Created by 徐章 on 16/8/24.
//  Copyright © 2016年 徐章. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XZRadarModel.h"

/**
 *  雷达图坐标系统配置
 */
@interface XZRadarCoordinateConfig : NSObject
/** 雷达图的半径范围*/
@property (nonatomic, assign) CGFloat radius;
/** 坐标系线条宽度*/
@property (nonatomic, assign) CGFloat lineWidth;
/** 坐标轴线条颜色*/
@property (nonatomic, strong) UIColor *lineColor;
/** 属性名的字体大小*/
@property (nonatomic, strong) UIFont *propertyFont;

#pragma mark - Required Porperty
/** 坐标系的刻度数组*/
@property (nonatomic, strong) NSArray *dialLabelArray;
/** 雷达图有几个属性值,这个值决定了坐标系是正几边形*/
@property (nonatomic, strong) NSArray *propertyName;

@end

@interface XZRadarChartView : UIView

/**
 *  创建雷达统计图
 *
 *  @param frame                 frame
 *  @param radarCoordinateConfig 坐标系配置
 *  @param radarModel            数据源
 *
 *  @return self
 */
- (id)initWithFrame:(CGRect)frame withRadarCoordinateConfig:(XZRadarCoordinateConfig *)radarCoordinateConfig withData:(NSArray *)dataArray;
@end
