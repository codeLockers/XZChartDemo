//
//  XZPieModel.h
//  XZChartDemo
//
//  Created by 徐章 on 16/8/23.
//  Copyright © 2016年 徐章. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface XZPieModel : NSObject
/** 统计图的动画时间*/
@property (nonatomic, assign) CGFloat animationDuration;
/** 饼状图的数据*/
@property (nonatomic, strong) NSArray *dataArray;

@end
