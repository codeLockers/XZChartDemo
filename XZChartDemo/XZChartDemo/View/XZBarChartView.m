//
//  XZBarChartView.m
//  XZChartDemo
//
//  Created by 徐章 on 16/8/23.
//  Copyright © 2016年 徐章. All rights reserved.
//

#import "XZBarChartView.h"
#import "XZBarModel.h"

@implementation XZBarView

- (id)initWithFrame:(CGRect)frame withAxisCoordinateConfig:(XZAxisCoordinateConfig *)axisCoordinateConfig withData:(NSArray *)dataArray{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.axisCoordinateConfig = axisCoordinateConfig;
        self.backgroundColor = [UIColor whiteColor];
        [self drawBarWithData:dataArray];
    }
    return self;
}

/**
 *  绘制柱形
 *
 *  @param dataArray 数据源
 */
- (void)drawBarWithData:(NSArray *)dataArray{

    for (XZBarModel *barModel in dataArray) {
        
        NSMutableArray *pointArray = [self calculateCoordinateOfXValues:barModel.xValues YValues:barModel.yValues];
        
        for (NSValue *value in pointArray) {
            
            CAShapeLayer *layer = [CAShapeLayer layer];
            layer.strokeColor   = barModel.barColor.CGColor;
            layer.lineWidth     = self.axisCoordinateConfig.barWidth;
            
            UIBezierPath *path = [UIBezierPath bezierPath];
            
            CGPoint point = value.CGPointValue;
            
            [path moveToPoint:CGPointMake(point.x + self.axisCoordinateConfig.barWidth/2.0f, self.frame.size.height - self.axisCoordinateConfig.xAxisBottomMargin - self.axisCoordinateConfig.lineWidth)];
            [path addLineToPoint:CGPointMake(point.x + self.axisCoordinateConfig.barWidth/2.0f, point.y)];
            layer.path = path.CGPath;
            //动画
            CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
            pathAnimation.fromValue         = @0;
            pathAnimation.toValue           = @1;
            pathAnimation.duration          = barModel.animationDuration;
            [layer addAnimation:pathAnimation forKey:@"animationKey"];
            
            [self.layer addSublayer:layer];
        }
    }
}

/**
 *  根据每个点的值计算出他在坐标系中的位置
 *
 *  @param xValues 横坐标的值
 *  @param yValues 纵坐标的值
 *
 *  @return 坐标数组
 */
- (NSMutableArray *)calculateCoordinateOfXValues:(NSArray *)xValues YValues:(NSArray *)yValues{
    
    NSMutableArray *pointArray = [NSMutableArray array];
    
    CGFloat yDialSpace = (self.frame.size.height - self.axisCoordinateConfig.xAxisBottomMargin - self.axisCoordinateConfig.yAxisStartMargin - self.axisCoordinateConfig.arrowVerticalOffset)/self.axisCoordinateConfig.yAxisLabelArray.count;
    
    for (NSInteger i = 0; i < xValues.count; i++) {
        
        CGFloat yValue = ((NSString *)yValues[i]).floatValue;
        CGFloat xPoint = self.axisCoordinateConfig.yAxisLeftMargin + self.axisCoordinateConfig.xAxisStartMargin + (self.axisCoordinateConfig.xDialSpace + self.axisCoordinateConfig.barWidth)*i;
        
        CGFloat yAxisValueDiff = ((NSString *)self.axisCoordinateConfig.yAxisLabelArray[1]).floatValue - ((NSString *)self.axisCoordinateConfig.yAxisLabelArray[0]).floatValue;
        
        CGFloat yPoint = (yValue - ((NSString *)self.axisCoordinateConfig.yAxisLabelArray.firstObject).floatValue)/yAxisValueDiff * yDialSpace;
        yPoint = self.frame.size.height - yPoint - self.axisCoordinateConfig.xAxisBottomMargin - self.axisCoordinateConfig.yAxisStartMargin;
        
        CGPoint point = CGPointMake(xPoint, yPoint);
        [pointArray addObject:[NSValue valueWithCGPoint:point]];
        
    }
    return pointArray;
}


@end

@implementation XZBarChartView

- (id)initWithFrame:(CGRect)frame withAxisCoordinateConfig:(XZAxisCoordinateConfig *)axisCoordinateConfig withData:(NSArray *)dataArray{

    self = [super initWithFrame:frame];
    if (self) {
        
        self.bounces = NO;
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        //坐标系的横坐标轴最短于View等宽
        CGFloat width = (axisCoordinateConfig.xAxisLabelArray.count) * (axisCoordinateConfig.xDialSpace + axisCoordinateConfig.barWidth ) + axisCoordinateConfig.xAxisStartMargin + axisCoordinateConfig.yAxisLeftMargin;
        width = (width < frame.size.width) ? frame.size.width: width;
        
        XZBarView *barView = [[XZBarView alloc] initWithFrame:CGRectMake(0, 0,width, frame.size.height) withAxisCoordinateConfig:axisCoordinateConfig withData:dataArray];
        [self addSubview:barView];
        self.contentSize = CGSizeMake(width, frame.size.height);
    }
    return self;

}

@end
