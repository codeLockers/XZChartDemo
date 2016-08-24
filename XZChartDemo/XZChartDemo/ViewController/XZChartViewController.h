//
//  XZChartViewController.h
//  XZChartDemo
//
//  Created by 徐章 on 16/8/22.
//  Copyright © 2016年 徐章. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    
    XZLineChart,    /** 折线图*/
    XZBarChart,     /** 柱状图*/
    XZPieChart,     /** 饼状图*/
    XZRadarChart    /** 雷达图*/
    
} XZChartType;

@interface XZChartViewController : UIViewController
/** 统计图类型*/
@property (nonatomic, assign) XZChartType chartType;

@end
