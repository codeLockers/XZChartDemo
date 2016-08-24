//
//  XZRadarModel.h
//  XZChartDemo
//
//  Created by 徐章 on 16/8/24.
//  Copyright © 2016年 徐章. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface XZRadarModel : NSObject
/** 雷达图线宽*/
@property (nonatomic, assign) CGFloat lineWidth;
/** 雷达图线条颜色*/
@property (nonatomic, strong) UIColor *lineColor;
/** 雷达图填充颜色*/
@property (nonatomic, strong) UIColor *fillColor;
/** 具体的各项数据值*/
@property (nonatomic, strong) NSDictionary *dataDic;
/** 动画时长*/
@property (nonatomic, assign) CGFloat animationDuration;

@end
