//
//  XZLineChartView.m
//  XZChartDemo
//
//  Created by 徐章 on 16/8/22.
//  Copyright © 2016年 徐章. All rights reserved.
//

#import "XZLineChartView.h"
#import "XZLineModel.h"
@interface XZLineView(){

    XZAxisCoordinateConfig *_axisCoordinateConfig;
    NSArray *_dataArray;
}

@end

@implementation XZLineView

- (id)initWithFrame:(CGRect)frame withAxisCoordinateConfig:(XZAxisCoordinateConfig *)axisCoordinateConfig withData:(NSArray *)dataArray{

    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        _axisCoordinateConfig = axisCoordinateConfig;
        _dataArray = dataArray;
        
        [self loadXAxisWithFrame:frame];
        
        [self drawLineWithData:dataArray];
    }
    return self;
}

- (void)loadXAxisWithFrame:(CGRect)frame{
    //坐标原点
    CGPoint originPoint = CGPointMake(0, frame.size.height - _axisCoordinateConfig.xAxisBottomMargin);
    CAShapeLayer *xAxisLayer = [CAShapeLayer layer];
    xAxisLayer.lineWidth = _axisCoordinateConfig.lineWidth;
    xAxisLayer.strokeColor = _axisCoordinateConfig.color.CGColor;
    xAxisLayer.fillColor = [UIColor clearColor].CGColor;
    
    UIBezierPath *xAxisPath = [UIBezierPath bezierPath];
    [xAxisPath moveToPoint:originPoint];
    [xAxisPath addLineToPoint:CGPointMake(frame.size.width, originPoint.y)];
    //绘制X轴尖头
    [xAxisPath addLineToPoint:CGPointMake(frame.size.width - _axisCoordinateConfig.arrowVerticalOffset, originPoint.y - _axisCoordinateConfig.arrowHorizontalOffset)];
    [xAxisPath moveToPoint:CGPointMake(frame.size.width, originPoint.y)];
    [xAxisPath addLineToPoint:CGPointMake(frame.size.width - _axisCoordinateConfig.arrowVerticalOffset, originPoint.y + _axisCoordinateConfig.arrowHorizontalOffset)];
    
    //绘制X轴上的刻度
    for (NSInteger i = 0; i < _axisCoordinateConfig.xAxisLabelArray.count ; i ++) {
//        NSLog(@"%ld",(long)i);
        CGPoint dialPoint = CGPointMake(originPoint.x + _axisCoordinateConfig.xAxisStartMargin + _axisCoordinateConfig.xDialSpace*i, originPoint.y);

        [xAxisPath moveToPoint:CGPointMake(dialPoint.x, dialPoint.y)];
        [xAxisPath addLineToPoint:CGPointMake(dialPoint.x, dialPoint.y - _axisCoordinateConfig.dialLegth)];

        NSString *dialStr = _axisCoordinateConfig.xAxisLabelArray[i];
        CGSize size = [dialStr sizeWithAttributes:@{NSFontAttributeName:_axisCoordinateConfig.dialFont}];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(dialPoint.x - size.width/2.0f, dialPoint.y, size.width, size.height)];
        label.text = dialStr;
        label.textColor = _axisCoordinateConfig.color;
        label.font = _axisCoordinateConfig.dialFont;
        [self addSubview:label];
    }
    
    xAxisLayer.path = xAxisPath.CGPath;
    
    [self.layer addSublayer:xAxisLayer];
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
    
    CGFloat yDialSpace = (self.frame.size.height - _axisCoordinateConfig.xAxisBottomMargin - _axisCoordinateConfig.yAxisStartMargin - _axisCoordinateConfig.arrowVerticalOffset)/_axisCoordinateConfig.yAxisLabelArray.count;
    
    CGFloat yAxisValueDiff = ((NSString *)_axisCoordinateConfig.yAxisLabelArray[1]).floatValue - ((NSString *)_axisCoordinateConfig.yAxisLabelArray[0]).floatValue;
    CGFloat xAxisValueDiff = ((NSString *)_axisCoordinateConfig.xAxisLabelArray[1]).floatValue - ((NSString *)_axisCoordinateConfig.xAxisLabelArray[0]).floatValue;
    
    for (NSInteger i = 0; i < xValues.count; i++) {

        CGFloat yValue = ((NSString *)yValues[i]).floatValue;
        CGFloat xValue = ((NSString *)xValues[i]).floatValue;
    
        CGFloat yPoint = (yValue - ((NSString *)_axisCoordinateConfig.yAxisLabelArray.firstObject).floatValue)/yAxisValueDiff * yDialSpace;
        yPoint = self.frame.size.height - yPoint - _axisCoordinateConfig.xAxisBottomMargin - _axisCoordinateConfig.yAxisStartMargin;
        
        CGFloat xPoint = (xValue - ((NSString *)_axisCoordinateConfig.xAxisLabelArray.firstObject).floatValue)/xAxisValueDiff * _axisCoordinateConfig.xDialSpace;
        xPoint = xPoint + _axisCoordinateConfig.xAxisStartMargin;
        
        
        CGPoint point = CGPointMake(xPoint, yPoint);
        [pointArray addObject:[NSValue valueWithCGPoint:point]];
        
    }
    return pointArray;
}

@end

@interface XZLineChartView (){

    XZAxisCoordinateConfig *_axisCoordinateConfig;
}

@end

@implementation XZLineChartView

- (id)initWithFrame:(CGRect)frame withAxisCoordinateConfig:(XZAxisCoordinateConfig *)axisCoordinateConfig withData:(NSArray *)dataArray{

    self = [super initWithFrame:frame];
    if (self) {

        self.backgroundColor = [UIColor whiteColor];
        
        _axisCoordinateConfig = axisCoordinateConfig;
        
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(_axisCoordinateConfig.yAxisLeftMargin, 0, frame.size.width - _axisCoordinateConfig.yAxisLeftMargin, frame.size.height)];
        scrollView.contentSize = CGSizeMake(_axisCoordinateConfig.xDialSpace * _axisCoordinateConfig.xAxisLabelArray.count, CGRectGetHeight(scrollView.frame));
        scrollView.bounces = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:scrollView];
        
        XZLineView *lineView =[[XZLineView alloc] initWithFrame:CGRectMake(0, 0, scrollView.contentSize.width, CGRectGetHeight(scrollView.frame)) withAxisCoordinateConfig:axisCoordinateConfig withData:dataArray];
        [scrollView addSubview:lineView];
        
        
    }
    return self;
}

- (void)drawRect:(CGRect)rect{

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
