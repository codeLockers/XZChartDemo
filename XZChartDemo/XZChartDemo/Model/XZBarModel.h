//
//  XZBarModel.h
//  XZChartDemo
//
//  Created by 徐章 on 16/8/23.
//  Copyright © 2016年 徐章. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface XZBarModel : NSObject

/** 一个数据的Y值*/
@property (nonatomic, strong) NSArray *yValues;
/** 一个数据的X值*/
@property (nonatomic, strong) NSArray *xValues;
/** 线条的颜色*/
@property (nonatomic, strong) UIColor *barColor;
/** 统计图的动画时间*/
@property (nonatomic, assign) CGFloat animationDuration;

@end
