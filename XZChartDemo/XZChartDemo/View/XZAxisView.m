//
//  XZAxisView.m
//  XZChartDemo
//
//  Created by 徐章 on 16/8/23.
//  Copyright © 2016年 徐章. All rights reserved.
//

#import "XZAxisView.h"
#import "XZLineChartView.h"
#import "XZBarChartView.h"

@implementation XZAxisCoordinateConfig

- (id)init{
    
    self = [super init];
    if (self) {
        
        self.color                 = [UIColor blackColor];
        self.lineWidth             = 1.0f;
        self.arrowVerticalOffset   = 8.0f;
        self.arrowHorizontalOffset = 5.0f;
        self.dialLegth             = 5.0f;
        self.dialFont              = [UIFont systemFontOfSize:11.0f];
        self.xAxisStartMargin      = 10.0f;
        self.yAxisStartMargin      = 10.0f;
        self.yAxisLeftMargin       = 20.0f;
        self.xAxisBottomMargin     = 20.0f;
        self.xDialSpace            = 40.0f;
        self.barWidth              = 30.0f;
    }
    return self;
}

@end


@implementation XZAxisView

- (void)drawRect:(CGRect)rect{
    
    NSAssert(!(self.axisCoordinateConfig.xAxisLabelArray.count == 0), @"坐标系X轴没有配置");
    NSAssert(!(self.axisCoordinateConfig.yAxisLabelArray.count == 0), @"坐标系Y轴没有配置");

    //绘制坐标轴
    CGContextRef context = UIGraphicsGetCurrentContext();
    //设置坐标轴宽度
    CGContextSetLineWidth(context, self.axisCoordinateConfig.lineWidth);
    //设置坐标轴颜色
    CGContextSetStrokeColorWithColor(context, self.axisCoordinateConfig.color.CGColor);
   
    //坐标原点
    CGPoint originPoint = CGPointMake(self.axisCoordinateConfig.yAxisLeftMargin, rect.size.height - self.axisCoordinateConfig.xAxisBottomMargin);
    CGContextMoveToPoint(context, originPoint.x, originPoint.y);
    
    //绘制Y轴
    CGContextAddLineToPoint(context, originPoint.x, 0);
    
    //绘制Y轴尖头
    CGContextAddLineToPoint(context, originPoint.x - self.axisCoordinateConfig.arrowHorizontalOffset, self.axisCoordinateConfig.arrowVerticalOffset);
    CGContextMoveToPoint(context, originPoint.x, 0);
    CGContextAddLineToPoint(context, originPoint.x + self.axisCoordinateConfig.arrowHorizontalOffset, self.axisCoordinateConfig.arrowVerticalOffset);
    
    //每个刻度的间隔
    CGFloat yDistance = (rect.size.height - self.axisCoordinateConfig.xAxisBottomMargin - self.axisCoordinateConfig.yAxisStartMargin - self.axisCoordinateConfig.arrowVerticalOffset)/self.axisCoordinateConfig.yAxisLabelArray.count;
    
    //绘制Y轴上刻度
    for (NSInteger i = 0; i < self.axisCoordinateConfig.yAxisLabelArray.count; i++) {
        
        CGPoint dialPoint = CGPointMake(originPoint.x, originPoint.y - self.axisCoordinateConfig.yAxisStartMargin - yDistance*i);
        CGContextMoveToPoint(context, dialPoint.x, dialPoint.y);
        CGContextAddLineToPoint(context, dialPoint.x + self.axisCoordinateConfig.dialLegth, dialPoint.y);
        
        NSString *dialStr = self.axisCoordinateConfig.yAxisLabelArray[i];
        CGSize size = [dialStr sizeWithAttributes:@{NSFontAttributeName:self.axisCoordinateConfig.dialFont}];
        
        [dialStr drawInRect:CGRectMake((self.axisCoordinateConfig.yAxisLeftMargin - size.width)/2.0f, dialPoint.y-size.height/2.0f, size.width, size.height) withAttributes:@{NSFontAttributeName:self.axisCoordinateConfig.dialFont}];
    }
    
    //绘制X轴
    CGContextMoveToPoint(context, originPoint.x, originPoint.y);
    CGContextAddLineToPoint(context, rect.size.width, originPoint.y);
    
    //绘制X轴尖头
    CGContextAddLineToPoint(context, rect.size.width - self.axisCoordinateConfig.arrowVerticalOffset, originPoint.y - self.axisCoordinateConfig.arrowHorizontalOffset);
    CGContextMoveToPoint(context, rect.size.width, originPoint.y);
    CGContextAddLineToPoint(context, rect.size.width- self.axisCoordinateConfig.arrowVerticalOffset, originPoint.y + self.axisCoordinateConfig.arrowHorizontalOffset);
    
    //绘制X轴上的刻度
    if ([self isKindOfClass:[XZLineView class]]) {
        //折线图
        for (NSInteger i = 0; i < self.axisCoordinateConfig.xAxisLabelArray.count ; i ++) {
            
            CGPoint dialPoint = CGPointMake(originPoint.x + self.axisCoordinateConfig.xAxisStartMargin + self.axisCoordinateConfig.xDialSpace*i, originPoint.y);
            
            CGContextMoveToPoint(context, dialPoint.x, dialPoint.y);
            CGContextAddLineToPoint(context, dialPoint.x, dialPoint.y - self.axisCoordinateConfig.dialLegth);
            
            NSString *dialStr = self.axisCoordinateConfig.xAxisLabelArray[i];
            CGSize size = [dialStr sizeWithAttributes:@{NSFontAttributeName:self.axisCoordinateConfig.dialFont}];
            [dialStr drawInRect:CGRectMake(dialPoint.x - size.width/2.0f, dialPoint.y, size.width, size.height) withAttributes:@{NSFontAttributeName:self.axisCoordinateConfig.dialFont}];
        }
        
    }else if ([self isKindOfClass:[XZBarView class]]){
    
        //柱状图
        for (NSInteger i = 0; i < self.axisCoordinateConfig.xAxisLabelArray.count ; i ++) {
            
            CGPoint dialPoint = CGPointMake(originPoint.x + self.axisCoordinateConfig.xAxisStartMargin + (self.axisCoordinateConfig.xDialSpace + self.axisCoordinateConfig.barWidth)*i, originPoint.y);
            
            CGContextMoveToPoint(context, dialPoint.x, dialPoint.y);
            CGContextAddLineToPoint(context, dialPoint.x, dialPoint.y - self.axisCoordinateConfig.dialLegth);
            CGContextMoveToPoint(context, dialPoint.x + self.axisCoordinateConfig.barWidth, dialPoint.y);
            CGContextAddLineToPoint(context, dialPoint.x + self.axisCoordinateConfig.barWidth, dialPoint.y - self.axisCoordinateConfig.dialLegth);
            
            NSString *dialStr = self.axisCoordinateConfig.xAxisLabelArray[i];
            CGSize size = [dialStr sizeWithAttributes:@{NSFontAttributeName:self.axisCoordinateConfig.dialFont}];

            [dialStr drawInRect:CGRectMake(dialPoint.x+(self.axisCoordinateConfig.barWidth - size.width)/2.0f, originPoint.y, size.width, size.height) withAttributes:@{NSFontAttributeName:self.axisCoordinateConfig.dialFont}];
        }
    }
    CGContextStrokePath(context);
}


@end
