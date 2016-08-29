//
//  XZChartViewController.m
//  XZChartDemo
//
//  Created by 徐章 on 16/8/22.
//  Copyright © 2016年 徐章. All rights reserved.
//

#import "XZChartViewController.h"
#import "XZLineChartView.h"
#import "XZBarChartView.h"
#import "XZLineModel.h"
#import "XZBarModel.h"
#import "XZPieChartView.h"
#import "XZPieModel.h"
#import "XZRadarChartView.h"
#import "XZRadarModel.h"


@interface XZChartViewController ()

@end

@implementation XZChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadUI];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Load_UI
- (void)loadUI{

    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    switch (self.chartType) {
        case XZLineChart:
            [self loadLineChart];
            break;
        case XZBarChart:
            [self loadBarChart];
            break;
        case XZPieChart:
            [self loadPieChart];
            break;
        case XZRadarChart:
            [self loadRadarChart];
            break;
        default:
            break;
    }
}

/**
 *  折线图
 */
- (void)loadLineChart{
    
    //十万条数据测试
    NSMutableArray *xTestArray = [NSMutableArray array];
    NSMutableArray *yTestArray = [NSMutableArray array];
    for (NSInteger i=0; i<100000; i++) {
        
        [xTestArray addObject:[NSString stringWithFormat:@"%ld",(long)(2000+i)]];
        [yTestArray addObject:[NSString stringWithFormat:@"%ld",(long)(arc4random()%60)]];
    }
    
    //配置折线数据
    XZLineModel *lineModel1 = [[XZLineModel alloc] init];
    lineModel1.lineColor    = [UIColor redColor];
    lineModel1.xValues      =xTestArray;
    lineModel1.yValues      = yTestArray;
    
    //配置坐标轴数据
    XZAxisCoordinateConfig *axisCoordinateConfig = [[XZAxisCoordinateConfig alloc] init];
    axisCoordinateConfig.yAxisStartMargin= 0.0f;
    axisCoordinateConfig.xAxisStartMargin = 15.0f;
    axisCoordinateConfig.yAxisLabelArray         = @[@"0",@"10",@"20",@"30",@"40",@"50",@"60"];
    /** 通常情况下X轴的刻度看数据内容*/
    axisCoordinateConfig.xAxisLabelArray         = xTestArray;
    
    XZLineChartView *lineChartView = [[XZLineChartView alloc] initWithFrame:CGRectMake(10, 100, [UIScreen mainScreen].bounds.size.width - 20.0f, 250.0f) withAxisCoordinateConfig:axisCoordinateConfig withData:@[lineModel1]];
    [self.view addSubview:lineChartView];
}

/**
 *  柱状图
 */
- (void)loadBarChart{
    
    //10W条数据测试
    NSMutableArray *xTestArray = [NSMutableArray array];
    NSMutableArray *yTestArray = [NSMutableArray array];
    for (NSInteger i=0; i<100000; i++) {
        
        [xTestArray addObject:[NSString stringWithFormat:@"%ld",(long)(2000+i)]];
        [yTestArray addObject:[NSString stringWithFormat:@"%ld",(long)(arc4random()%60)]];
    }
    
    //配置坐标轴数据
    XZAxisCoordinateConfig *axisCoordinateConfig = [[XZAxisCoordinateConfig alloc] init];
    axisCoordinateConfig.yAxisLabelArray         = @[@"0",@"10",@"20",@"30",@"40",@"50",@"60"];
    axisCoordinateConfig.xAxisLabelArray         = xTestArray;
    axisCoordinateConfig.xDialSpace              = 10.0f;
    
    //配置折线数据
    XZBarModel *barModel = [[XZBarModel alloc] init];
    barModel.xValues     = xTestArray;
    barModel.yValues     = yTestArray;
    
    XZBarChartView *barChartView = [[XZBarChartView alloc] initWithFrame:CGRectMake(10, 100, [UIScreen mainScreen].bounds.size.width - 20.0f, 250.0f) withAxisCoordinateConfig:axisCoordinateConfig withBarModel:barModel];
    [self.view addSubview:barChartView];
}

/**
 *  饼状图
 */
- (void)loadPieChart{
    
    //配置数据
    XZPieModel *pieModel = [[XZPieModel alloc] init];
    pieModel.dataArray   = @[@{
                               @"title":@"食物",
                               @"color":[UIColor redColor],
                               @"scale":@"0.2"
                               },
                           @{
                               @"title":@"衣服",
                               @"color":[UIColor greenColor],
                               @"scale":@"0.3"
                               },
                           @{
                               @"title":@"餐饮喝茶",
                               @"color":[UIColor blueColor],
                               @"scale":@"0.1"
                               },
                           @{
                               @"title":@"旅游文化",
                               @"color":[UIColor yellowColor],
                               @"scale":@"0.25"
                               },
                             @{
                               @"title":@"火",
                               @"color":[UIColor purpleColor],
                               @"scale":@"0.15"
                                 }];
    
    //配置饼状图坐标
    XZPieCoordinateConfig *pieCoordinateConfig = [[XZPieCoordinateConfig alloc] init];
    
    XZPieChartView *pieChartView = [[XZPieChartView alloc] initWithFrame:CGRectMake(10, 100, [UIScreen mainScreen].bounds.size.width - 20.0f, 250.0f) withPieCoordinateConfig:pieCoordinateConfig withData:@[pieModel]];
    [self.view addSubview:pieChartView];
}

/**
 *  雷达图
 */
- (void)loadRadarChart{

    //统计图数据
    XZRadarModel *radarModel = [[XZRadarModel alloc] init];
    radarModel.dataDic       = @{@"属性一":@"15",
                               @"属性二":@"21",
                               @"属性三":@"13",
                               @"属性四":@"35",
                               @"属性五":@"45",
                               @"属性六":@"37",
                               @"属性七":@"17"};
    //坐标系配置
    XZRadarCoordinateConfig *radarCoordinateConfig = [[XZRadarCoordinateConfig alloc] init];
    radarCoordinateConfig.radius                   = 100.0f;
    radarCoordinateConfig.propertyName             = @[@"属性一",@"属性二",@"属性三",@"属性四",@"属性五",@"属性六",@"属性七"];
    radarCoordinateConfig.dialLabelArray           = @[@"10",@"20",@"30",@"40",@"50"];
    
    XZRadarChartView *radarView = [[XZRadarChartView alloc] initWithFrame:CGRectMake(10, 100, [UIScreen mainScreen].bounds.size.width - 20.0f, 250.0f) withRadarCoordinateConfig:radarCoordinateConfig withData:@[radarModel]];
    
    [self.view addSubview:radarView];
}

@end
