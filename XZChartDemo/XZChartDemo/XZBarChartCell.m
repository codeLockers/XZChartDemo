//
//  XZBarChartCell.m
//  XZChartDemo
//
//  Created by 徐章 on 16/8/25.
//  Copyright © 2016年 徐章. All rights reserved.
//

#import "XZBarChartCell.h"
#import "XZBarModel.h"
@interface XZBarChartCell()

@property (nonatomic, strong) UILabel *dialLabel;
@property (nonatomic, strong) CAShapeLayer *barLayer;
@property (nonatomic, strong) XZAxisCoordinateConfig *axisCoordinateConfig;
@property (nonatomic, strong) XZBarModel *XZBarModel;
@end

@implementation XZBarChartCell


#pragma mark - Setter && Getter
- (UILabel *)dialLabel{

    if (!_dialLabel) {
        //添加X轴标签
        _dialLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.frame)-self.axisCoordinateConfig.xAxisBottomMargin, CGRectGetWidth(self.frame)-self.axisCoordinateConfig.xDialSpace, self.axisCoordinateConfig.xAxisBottomMargin)];
        _dialLabel.textColor = self.axisCoordinateConfig.color;
        _dialLabel.font = self.axisCoordinateConfig.dialFont;
        _dialLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_dialLabel];
        
        //绘制X轴以及刻度
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
    return _dialLabel;
}

- (CAShapeLayer *)barLayer{

    if (!_barLayer) {
        
        _barLayer = [CAShapeLayer layer];
        _barLayer.lineWidth = self.axisCoordinateConfig.barWidth;
        _barLayer.strokeColor = [UIColor greenColor].CGColor;
    }
    return _barLayer;
}

#pragma mark - Public_Methods
- (void)setUpCellAtIndexPath:(NSIndexPath *)indexPath axisCoordinateConfig:(XZAxisCoordinateConfig *)axisCoordinateConfig barModel:(XZBarModel *)barModel{

    CGFloat yValue = ((NSString *)barModel.yValues[indexPath.row]).floatValue;
    
    self.axisCoordinateConfig = axisCoordinateConfig;
    self.dialLabel.text = self.axisCoordinateConfig.xAxisLabelArray[indexPath.row];
    
    if (self.barLayer)
        [self.barLayer removeFromSuperlayer];

    CGFloat yDialSpace = (self.frame.size.height - self.axisCoordinateConfig.xAxisBottomMargin - self.axisCoordinateConfig.yAxisStartMargin - self.axisCoordinateConfig.arrowVerticalOffset)/self.axisCoordinateConfig.yAxisLabelArray.count;
    
    CGFloat yAxisValueDiff = ((NSString *)self.axisCoordinateConfig.yAxisLabelArray[1]).floatValue - ((NSString *)self.axisCoordinateConfig.yAxisLabelArray[0]).floatValue;
    
    CGFloat yPoint = (yValue - ((NSString *)self.axisCoordinateConfig.yAxisLabelArray.firstObject).floatValue)/yAxisValueDiff * yDialSpace;
    yPoint = self.frame.size.height - yPoint - self.axisCoordinateConfig.xAxisBottomMargin - self.axisCoordinateConfig.yAxisStartMargin;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(self.axisCoordinateConfig.barWidth/2.0f, CGRectGetHeight(self.frame) - self.axisCoordinateConfig.xAxisBottomMargin-1)];
    [path addLineToPoint:CGPointMake(self.axisCoordinateConfig.barWidth/2.0f, yPoint)];
    self.barLayer.path = path.CGPath;
    [self.layer addSublayer:self.barLayer];
}
@end
