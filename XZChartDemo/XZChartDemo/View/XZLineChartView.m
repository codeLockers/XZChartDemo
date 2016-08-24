//
//  XZLineChartView.m
//  XZChartDemo
//
//  Created by 徐章 on 16/8/22.
//  Copyright © 2016年 徐章. All rights reserved.
//

#import "XZLineChartView.h"
#import "XZLineModel.h"
@interface XZLineView()

@end

@implementation XZLineView

- (id)initWithFrame:(CGRect)frame withAxisCoordinateConfig:(XZAxisCoordinateConfig *)axisCoordinateConfig withData:(NSArray *)dataArray{

    self = [super initWithFrame:frame];
    if (self) {
        
        self.axisCoordinateConfig = axisCoordinateConfig;
        self.backgroundColor = [UIColor whiteColor];
        [self drawLineWithData:dataArray];
    }
    return self;
}

#pragma mark - Private_Methods
/**
 *  绘制折线
 *
 *  @param dataArray 数据源
 */
- (void)drawLineWithData:(NSArray *)dataArray{

    for (XZLineModel *lineModel in dataArray) {
        
        NSMutableArray *pointArray = [self calculateCoordinateOfXValues:lineModel.xValues YValues:lineModel.yValues];

        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.lineWidth     = lineModel.lineWidth;
        layer.strokeColor   = lineModel.lineColor.CGColor;
        layer.fillColor     = [UIColor clearColor].CGColor;
        
        UIBezierPath *path = [[UIBezierPath alloc] init];

        for (NSInteger i = 0; i < pointArray.count; i++) {

            NSValue *value = pointArray[i];
            CGPoint point = value.CGPointValue;
    
            if (i == 0)
                [path moveToPoint:point];
            else
                [path addLineToPoint:point];

            //关键点圆形标志
            CAShapeLayer *pointLayer = [CAShapeLayer layer];
            pointLayer.lineWidth = 2.5f;
            pointLayer.fillColor = lineModel.lineColor.CGColor;
            UIBezierPath *pointPath = [UIBezierPath bezierPathWithArcCenter:point radius:2.0f startAngle:0 endAngle:2*M_PI clockwise:YES];
            pointLayer.path = pointPath.CGPath;
            [self.layer addSublayer:pointLayer];
        }
        
        layer.path = path.CGPath;
        
        //动画
        CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        pathAnimation.fromValue         = @0;
        pathAnimation.toValue           = @1;
        pathAnimation.duration          = lineModel.animationDuration;
        [layer addAnimation:pathAnimation forKey:@"animationKey"];
        [self.layer addSublayer:layer];
        
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
        CGFloat xPoint = self.axisCoordinateConfig.yAxisLeftMargin + self.axisCoordinateConfig.xAxisStartMargin + self.axisCoordinateConfig.xDialSpace*i;
        
        CGFloat yAxisValueDiff = ((NSString *)self.axisCoordinateConfig.yAxisLabelArray[1]).floatValue - ((NSString *)self.axisCoordinateConfig.yAxisLabelArray[0]).floatValue;
        
        CGFloat yPoint = (yValue - ((NSString *)self.axisCoordinateConfig.yAxisLabelArray.firstObject).floatValue)/yAxisValueDiff * yDialSpace;
        yPoint = self.frame.size.height - yPoint - self.axisCoordinateConfig.xAxisBottomMargin - self.axisCoordinateConfig.yAxisStartMargin;
        
        CGPoint point = CGPointMake(xPoint, yPoint);
        [pointArray addObject:[NSValue valueWithCGPoint:point]];
        
    }
    return pointArray;
}

@end


@implementation XZLineChartView

- (id)initWithFrame:(CGRect)frame withAxisCoordinateConfig:(XZAxisCoordinateConfig *)axisCoordinateConfig withData:(NSArray *)dataArray{

    self = [super initWithFrame:frame];
    if (self) {
        
        self.bounces = NO;
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        
        //坐标系的横坐标轴最短于View等宽
        CGFloat width = axisCoordinateConfig.xAxisLabelArray.count * axisCoordinateConfig.xDialSpace + axisCoordinateConfig.xAxisStartMargin + axisCoordinateConfig.yAxisLeftMargin;
        width = (width < frame.size.width) ? frame.size.width: width;
        
        XZLineView *lineView = [[XZLineView alloc] initWithFrame:CGRectMake(0, 0,width, frame.size.height) withAxisCoordinateConfig:axisCoordinateConfig withData:dataArray];
        
        [self addSubview:lineView];
        self.contentSize = CGSizeMake(width, frame.size.height);
        
    }
    return self;
}
@end
