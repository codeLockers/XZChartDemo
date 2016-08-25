//
//  XZAxisCoordinateConfig.h
//  XZChartDemo
//
//  Created by 徐章 on 16/8/25.
//  Copyright © 2016年 徐章. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
/*
 用于配置坐标轴的相关设置,X轴可以设置每个单位的长度越界了则可以拖动,Y轴高度固定,每个单位的长度根据刻度的多少平均分配,最小值与scrollView等宽
 */
@interface XZAxisCoordinateConfig : NSObject
/** 坐标轴颜色*/
@property (nonatomic, strong) UIColor *color;
/** 坐标轴的线宽*/
@property (nonatomic, assign) CGFloat lineWidth;
/** 坐标轴箭头水平偏移,PS:这是以Y轴为基准在X轴上的话这个就变成了垂直方向上的偏移*/
@property (nonatomic, assign) CGFloat arrowHorizontalOffset;
/** 坐标轴箭头垂直偏移,PS:这是以Y轴为基准在X轴上的话这个就变成了水平方向上的偏移*/
@property (nonatomic, assign) CGFloat arrowVerticalOffset;
/** 刻度的长度*/
@property (nonatomic, assign) CGFloat dialLegth;
/** 刻度字体的大小*/
@property (nonatomic, strong) UIFont *dialFont;
/** 坐标轴x轴第一个刻度的起始位置*/
@property (nonatomic, assign) CGFloat xAxisStartMargin;
/** 坐标轴y轴第一个刻度的起始位置*/
@property (nonatomic, assign) CGFloat yAxisStartMargin;
/** Y轴距离view左边的间距*/
@property (nonatomic, assign) CGFloat yAxisLeftMargin;
/** X轴距离view底边的间距*/
@property (nonatomic, assign) CGFloat xAxisBottomMargin;
/** X轴刻度的间距*/
@property (nonatomic, assign) CGFloat xDialSpace;
/** 柱状图的柱体的宽度*/
@property (nonatomic, assign) CGFloat barWidth;

#pragma mark - Required_Property
/** Y轴刻度数组*/
@property (nonatomic, strong) NSArray *yAxisLabelArray;
/** X轴刻度数组*/
@property (nonatomic, strong) NSArray *xAxisLabelArray;
@end
