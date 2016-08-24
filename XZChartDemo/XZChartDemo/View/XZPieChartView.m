//
//  XZPieChartView.m
//  XZChartDemo
//
//  Created by 徐章 on 16/8/23.
//  Copyright © 2016年 徐章. All rights reserved.
//

#import "XZPieChartView.h"

@implementation XZPieCoordinateConfig

- (id)init{

    self = [super init];
    if (self) {
        
        self.radius = 30.0f;
        self.titlFont = [UIFont systemFontOfSize:11.0f];
    }
    return self;
}
@end


@interface XZPieChartView(){

    XZPieCoordinateConfig *_pieCoordinateConfig;
    NSArray *_dataArray;
}

@end

@implementation XZPieChartView
- (id)initWithFrame:(CGRect)frame withPieCoordinateConfig:(XZPieCoordinateConfig *)pieCoordinateConfig withData:(NSArray *)dataArray{

    self = [super initWithFrame:frame];
    if (self) {
        _pieCoordinateConfig = pieCoordinateConfig;
        _dataArray = dataArray;
        [self drawPieWithCenter:CGPointMake(frame.size.width/2.0f, frame.size.height/2.0f)];
    }
    return self;
}

/**
 *  绘制饼状图
 *
 *  @param pieModel 数据源
 *  @param center   中心点
 */
- (void)drawPieWithCenter:(CGPoint)center{

    CAShapeLayer *pieLayer  = [CAShapeLayer layer];
    CGFloat startPercentage = 0;

    for (XZPieModel *pieModel in _dataArray) {
        
        for (NSDictionary *dic in pieModel.dataArray) {
            
            //会饼状图
            UIColor *color     = dic[@"color"];
            CGFloat percentage = ((NSString *)dic[@"scale"]).floatValue;
            NSString *title    = dic[@"title"];
            
            CAShapeLayer *layer = [self layerWithRadius:_pieCoordinateConfig.radius lineWidth:_pieCoordinateConfig.radius strokeColor:color center:center startPercentage:startPercentage endPercentage:startPercentage + percentage];
            startPercentage += percentage;
            [pieLayer addSublayer:layer];
            
            //绘制标题引导线
            CGFloat scale = (2*startPercentage - percentage)/2.0;
            CGFloat angle = scale * (2 * M_PI);
            CGPoint startPoint = CGPointMake(center.x + _pieCoordinateConfig.radius * sin(angle), center.y - _pieCoordinateConfig.radius * cos(angle));
            
            UIBezierPath *path = [UIBezierPath bezierPath];
            [path moveToPoint:startPoint];
            CGPoint endPoint = CGPointMake(startPoint.x + _pieCoordinateConfig.radius * sin(angle), startPoint.y - _pieCoordinateConfig.radius * cos(angle));
            [path addLineToPoint:endPoint];
            
            //绘制标题Label
            title = [NSString stringWithFormat:@"%@ %0.2f%%",title,percentage*100];
            CGSize size = [title sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12.0f]}];
            
            UILabel *label  = [[UILabel alloc] init];
            label.text      = title;
            label.font      = _pieCoordinateConfig.titlFont;
            label.textColor = color;
            [self addSubview:label];
            
            if (scale >= 0.5){
                
                [path addLineToPoint:CGPointMake(endPoint.x - 10, endPoint.y)];
                label.frame = CGRectMake(endPoint.x - 10 - size.width, endPoint.y - size.height/2.0f, size.width, size.height);
            }
            else{
                [path addLineToPoint:CGPointMake(endPoint.x + 10, endPoint.y)];
                label.frame = CGRectMake(endPoint.x + 10, endPoint.y - size.height/2.0f, size.width, size.height);
            }
            
            CAShapeLayer *lineLayer = [CAShapeLayer layer];
            lineLayer.strokeColor   = color.CGColor;
            lineLayer.fillColor     = [UIColor clearColor].CGColor;
            lineLayer.lineWidth     = 1.0f;
            lineLayer.path          = path.CGPath;
            
            //lineLayer动画
            CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
            pathAnimation.fromValue         = @0;
            pathAnimation.toValue           = @1;
            pathAnimation.duration          = pieModel.animationDuration;
            [lineLayer addAnimation:pathAnimation forKey:@"animationKey"];
            
            [self.layer addSublayer:lineLayer];
            
        }
    
        CAShapeLayer *maskLayer = [self layerWithRadius:_pieCoordinateConfig.radius lineWidth:_pieCoordinateConfig.radius strokeColor:[UIColor whiteColor] center:center startPercentage:0 endPercentage:1];
        pieLayer.mask = maskLayer;
        [self.layer addSublayer:pieLayer];

        //peiLayer动画
        CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        pathAnimation.fromValue         = @0;
        pathAnimation.toValue           = @1;
        pathAnimation.duration          = pieModel.animationDuration;
        [pieLayer.mask addAnimation:pathAnimation forKey:@"animationKey"];
    }
}

#pragma mark - Private_Methods
/**
 *  绘制每一部分的饼状图
 *
 *  @param radius          半径
 *  @param lineWidth       线宽
 *  @param strokeColor     线条颜色
 *  @param center          中心点
 *  @param startPercentage 开始位置
 *  @param endPercentage   结束位置
 *
 *  @return CAShapeLayer
 */
- (CAShapeLayer *)layerWithRadius:(CGFloat)radius
                        lineWidth:(CGFloat)lineWidth
                      strokeColor:(UIColor *)strokeColor
                           center:(CGPoint)center
                  startPercentage:(CGFloat)startPercentage
                    endPercentage:(CGFloat)endPercentage{

    CAShapeLayer *layer = [CAShapeLayer layer];

    UIBezierPath *path  = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:-M_PI_2 endAngle:3*M_PI_2 clockwise:YES];

    layer.strokeColor   = strokeColor.CGColor;
    layer.fillColor     = [UIColor clearColor].CGColor;
    layer.strokeStart   = startPercentage;
    layer.strokeEnd     = endPercentage;
    layer.lineWidth     = lineWidth;
    layer.path = path.CGPath;
    
    return layer;
}

@end
