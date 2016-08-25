//
//  XZBarChartCell.m
//  XZChartDemo
//
//  Created by 徐章 on 16/8/25.
//  Copyright © 2016年 徐章. All rights reserved.
//

#import "XZBarChartCell.h"
@interface XZBarChartCell()

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) CAShapeLayer *barLayer;
//@property (nonatomic, assign) BOOL isAniamtion;

@end

@implementation XZBarChartCell

- (id)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    
    if (self) {
       
//        self.isAniamtion = YES;
    }
    return self;
}

#pragma mark - Setter && Getter
- (UILabel *)label{

    if (!_label) {
        _label = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.frame)-self.axisCoordinateConfig.xAxisBottomMargin, CGRectGetWidth(self.frame)-self.axisCoordinateConfig.xDialSpace, self.axisCoordinateConfig.xAxisBottomMargin)];
        _label.textColor = self.axisCoordinateConfig.color;
        _label.font = self.axisCoordinateConfig.dialFont;
        [self addSubview:_label];
        
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.lineWidth = self.axisCoordinateConfig.lineWidth;
        layer.strokeColor = self.axisCoordinateConfig.color.CGColor;
        layer.fillColor = [UIColor clearColor].CGColor;
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(0, CGRectGetHeight(self.frame) - self.axisCoordinateConfig.xAxisBottomMargin - self.axisCoordinateConfig.dialLegth)];
        [path addLineToPoint:CGPointMake(0, CGRectGetHeight(self.frame) - self.axisCoordinateConfig.xAxisBottomMargin)];
        [path addLineToPoint:CGPointMake(CGRectGetWidth(self.frame)-self.axisCoordinateConfig.xDialSpace, CGRectGetHeight(self.frame) - self.axisCoordinateConfig.xAxisBottomMargin)];
        [path addLineToPoint:CGPointMake(CGRectGetWidth(self.frame)-self.axisCoordinateConfig.xDialSpace, CGRectGetHeight(self.frame) - self.axisCoordinateConfig.xAxisBottomMargin-self.axisCoordinateConfig.dialLegth)];
        [path moveToPoint:CGPointMake(CGRectGetWidth(self.frame)-self.axisCoordinateConfig.xDialSpace, CGRectGetHeight(self.frame) - self.axisCoordinateConfig.xAxisBottomMargin)];
        [path addLineToPoint:CGPointMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) - self.axisCoordinateConfig.xAxisBottomMargin)];
        layer.path = path.CGPath;
        [self.layer addSublayer:layer];
    }
    return _label;
}

- (void)setUpCellWithAxisLabel:(NSString *)xAxisLabel yValue:(CGFloat)yValue{

    self.label.text = xAxisLabel;
    
    if (self.barLayer){
        [self.barLayer removeAllAnimations];
        [self.barLayer removeFromSuperlayer];
    }
    
    self.barLayer = [CAShapeLayer layer];
    self.barLayer.lineWidth = _axisCoordinateConfig.barWidth;
    self.barLayer.strokeColor = [UIColor greenColor].CGColor;
    
    
    
//    NSMutableArray *pointArray = [NSMutableArray array];
    
    CGFloat yDialSpace = (self.frame.size.height - _axisCoordinateConfig.xAxisBottomMargin - _axisCoordinateConfig.yAxisStartMargin - _axisCoordinateConfig.arrowVerticalOffset)/_axisCoordinateConfig.yAxisLabelArray.count;
    
//    for (NSInteger i = 0; i < xValues.count; i++) {
    
//        CGFloat yValue = ((NSString *)yValues[i]).floatValue;
//        CGFloat xPoint = _axisCoordinateConfig.xAxisStartMargin + (_axisCoordinateConfig.xDialSpace + _axisCoordinateConfig.barWidth)*i;
    
        CGFloat yAxisValueDiff = ((NSString *)_axisCoordinateConfig.yAxisLabelArray[1]).floatValue - ((NSString *)_axisCoordinateConfig.yAxisLabelArray[0]).floatValue;
        
        CGFloat yPoint = (yValue - ((NSString *)_axisCoordinateConfig.yAxisLabelArray.firstObject).floatValue)/yAxisValueDiff * yDialSpace;
        yPoint = self.frame.size.height - yPoint - _axisCoordinateConfig.xAxisBottomMargin - _axisCoordinateConfig.yAxisStartMargin;
        
//        CGPoint point = CGPointMake(xPoint, yPoint);
//        [pointArray addObject:[NSValue valueWithCGPoint:point]];
    
    
    
    
    
    
    
    
    
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(_axisCoordinateConfig.barWidth/2.0f, CGRectGetHeight(self.frame) - self.axisCoordinateConfig.xAxisBottomMargin-1)];
    [path addLineToPoint:CGPointMake(_axisCoordinateConfig.barWidth/2.0f, yPoint)];
    self.barLayer.path = path.CGPath;
    [self.layer addSublayer:self.barLayer];

    
//    if (self.isAniamtion) {
//        self.isAniamtion = NO;
//        //动画
//        CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
//        pathAnimation.fromValue         = @0;
//        pathAnimation.toValue           = @1;
//        pathAnimation.duration          = 1.0f;
//        [self.barLayer addAnimation:pathAnimation forKey:@"animationKey"];
//    }
}
@end
