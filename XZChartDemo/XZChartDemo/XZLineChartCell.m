//
//  XZLineChartCell.m
//  XZChartDemo
//
//  Created by 徐章 on 16/8/26.
//  Copyright © 2016年 徐章. All rights reserved.
//

#import "XZLineChartCell.h"
@interface XZLineChartCell()

@property (nonatomic, strong) UILabel *dialLabel;
@property (nonatomic, strong) CAShapeLayer *lineLayer;
@property (nonatomic, strong) XZAxisCoordinateConfig *axisCoordinateConfig;
@property (nonatomic, strong) XZLineModel *lineModel;
@end

@implementation XZLineChartCell

- (UILabel *)dialLabel{

    if (!_dialLabel) {
        
        _dialLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.frame) - self.axisCoordinateConfig.xAxisBottomMargin, CGRectGetWidth(self.frame), self.axisCoordinateConfig.xAxisBottomMargin)];
        _dialLabel.font = self.axisCoordinateConfig.dialFont;
        _dialLabel.textAlignment = NSTextAlignmentCenter;
        _dialLabel.textColor = self.axisCoordinateConfig.color;
        
        [self addSubview:_dialLabel];
        
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.lineWidth = self.axisCoordinateConfig.lineWidth;
        layer.strokeColor = self.axisCoordinateConfig.color.CGColor;
        layer.fillColor = [UIColor clearColor].CGColor;
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(0, CGRectGetHeight(self.frame) - self.axisCoordinateConfig.xAxisBottomMargin)];
        [path addLineToPoint:CGPointMake(CGRectGetWidth(self.frame) - self.axisCoordinateConfig.xDialSpace/2.0f, CGRectGetHeight(self.frame) - self.axisCoordinateConfig.xAxisBottomMargin)];
        [path addLineToPoint:CGPointMake(CGRectGetWidth(self.frame)-self.axisCoordinateConfig.xDialSpace/2.0f, CGRectGetHeight(self.frame) - self.axisCoordinateConfig.xAxisBottomMargin-self.axisCoordinateConfig.dialLegth)];
        [path addLineToPoint:CGPointMake(CGRectGetWidth(self.frame)-self.axisCoordinateConfig.xDialSpace/2.0f, CGRectGetHeight(self.frame) - self.axisCoordinateConfig.xAxisBottomMargin)];
        [path addLineToPoint:CGPointMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) - self.axisCoordinateConfig.xAxisBottomMargin)];
        layer.path = path.CGPath;
        [self.layer addSublayer:layer];
    }
    return _dialLabel;
}

#pragma mark - Setter && Getter
- (CAShapeLayer *)lineLayer{

    if (!_lineLayer) {
    
        _lineLayer = [CAShapeLayer layer];
        _lineLayer.lineWidth = self.lineModel.lineWidth;
        _lineLayer.strokeColor = self.lineModel.lineColor.CGColor;
        _lineLayer.fillColor = [UIColor clearColor].CGColor;
    }
    return _lineLayer;
}

- (void)setUpCellAtIndexPath:(NSIndexPath *)indexPath axisCoordinateConfig:(XZAxisCoordinateConfig *)axisCoordinateConfig lineModel:(XZLineModel *)lineModel{

    self.axisCoordinateConfig = axisCoordinateConfig;
    self.lineModel = lineModel;
    
    self.dialLabel.text = self.axisCoordinateConfig.xAxisLabelArray[indexPath.row+1];
    
    if (self.lineLayer)
        [self.lineLayer removeFromSuperlayer];
    
    CGFloat perYValue = ((NSString *)lineModel.yValues[indexPath.row]).floatValue;
    CGFloat yValue = ((NSString *)lineModel.yValues[indexPath.row+1]).floatValue;
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    [linePath moveToPoint:CGPointMake(0, [self calculateCoordinateOfYValue:(perYValue + yValue)/2.0f])];
    [linePath addLineToPoint:CGPointMake(self.axisCoordinateConfig.xDialSpace/2.0f, [self calculateCoordinateOfYValue:yValue])];

    if (indexPath.row + 1 < lineModel.yValues.count - 1) {
         CGFloat nextYValue = ((NSString *)lineModel.yValues[indexPath.row+2]).floatValue;
        [linePath addLineToPoint:CGPointMake(self.axisCoordinateConfig.xDialSpace, [self calculateCoordinateOfYValue:(yValue + nextYValue)/2.0f])];
    }
    
    self.lineLayer.path = linePath.CGPath;
    [self.layer addSublayer:self.lineLayer];
}

- (CGFloat)calculateCoordinateOfYValue:(CGFloat)yValue{
    
    CGFloat yDialSpace = (self.frame.size.height - self.axisCoordinateConfig.xAxisBottomMargin - self.axisCoordinateConfig.yAxisStartMargin - self.axisCoordinateConfig.arrowVerticalOffset)/self.axisCoordinateConfig.yAxisLabelArray.count;
    
    CGFloat yAxisValueDiff = ((NSString *)self.axisCoordinateConfig.yAxisLabelArray[1]).floatValue - ((NSString *)self.axisCoordinateConfig.yAxisLabelArray[0]).floatValue;
    
    CGFloat yPoint = (yValue - ((NSString *)self.axisCoordinateConfig.yAxisLabelArray.firstObject).floatValue)/yAxisValueDiff * yDialSpace;
    yPoint = self.frame.size.height - yPoint - self.axisCoordinateConfig.xAxisBottomMargin - self.axisCoordinateConfig.yAxisStartMargin;
    return yPoint;
}
@end
