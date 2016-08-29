//
//  XZYAxisView.m
//  XZChartDemo
//
//  Created by 徐章 on 16/8/29.
//  Copyright © 2016年 徐章. All rights reserved.
//

#import "XZYAxisView.h"

@interface XZYAxisView()

@property (nonatomic, strong) XZAxisCoordinateConfig *axisCoordinateConfig;
@end

@implementation XZYAxisView

- (id)initWithFrame:(CGRect)frame withAxisCoordinateModel:(XZAxisCoordinateConfig *)axisCoordinateConfig{

    self = [super initWithFrame:frame];
    if (self) {
      
        self.backgroundColor = [UIColor clearColor];
        self.axisCoordinateConfig = axisCoordinateConfig;
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
   
    //绘制坐标轴
    CGContextRef context = UIGraphicsGetCurrentContext();
    //设置坐标轴宽度
    CGContextSetLineWidth(context, _axisCoordinateConfig.lineWidth);
    //设置坐标轴颜色
    CGContextSetStrokeColorWithColor(context, _axisCoordinateConfig.color.CGColor);
    
    //坐标原点
    CGPoint originPoint = CGPointMake(_axisCoordinateConfig.yAxisLeftMargin, rect.size.height - _axisCoordinateConfig.xAxisBottomMargin);
    CGContextMoveToPoint(context, originPoint.x, originPoint.y);
    
    //绘制Y轴
    CGContextAddLineToPoint(context, originPoint.x, 0);
    
    //绘制Y轴尖头
    CGContextAddLineToPoint(context, originPoint.x - _axisCoordinateConfig.arrowHorizontalOffset, _axisCoordinateConfig.arrowVerticalOffset);
    CGContextMoveToPoint(context, originPoint.x, 0);
    CGContextAddLineToPoint(context, originPoint.x + _axisCoordinateConfig.arrowHorizontalOffset, _axisCoordinateConfig.arrowVerticalOffset);
    
    //每个刻度的间隔
    CGFloat yDistance = (rect.size.height - _axisCoordinateConfig.xAxisBottomMargin - _axisCoordinateConfig.yAxisStartMargin - _axisCoordinateConfig.arrowVerticalOffset)/_axisCoordinateConfig.yAxisLabelArray.count;
    
    //绘制Y轴上刻度
    for (NSInteger i = 0; i < _axisCoordinateConfig.yAxisLabelArray.count; i++) {
        
        CGPoint dialPoint = CGPointMake(originPoint.x, originPoint.y - _axisCoordinateConfig.yAxisStartMargin - yDistance*i);
        CGContextMoveToPoint(context, dialPoint.x, dialPoint.y);
        CGContextAddLineToPoint(context, dialPoint.x + _axisCoordinateConfig.dialLegth, dialPoint.y);
        
        NSString *dialStr = _axisCoordinateConfig.yAxisLabelArray[i];
        CGSize size = [dialStr sizeWithAttributes:@{NSFontAttributeName:_axisCoordinateConfig.dialFont}];
        
        [dialStr drawInRect:CGRectMake((_axisCoordinateConfig.yAxisLeftMargin - size.width)/2.0f, dialPoint.y-size.height/2.0f, size.width, size.height) withAttributes:@{NSFontAttributeName:_axisCoordinateConfig.dialFont}];
    }
    CGContextStrokePath(context);
}


@end
