//
//  XZRadarChartView.m
//  XZChartDemo
//
//  Created by 徐章 on 16/8/24.
//  Copyright © 2016年 徐章. All rights reserved.
//

#import "XZRadarChartView.h"

@implementation XZRadarCoordinateConfig

- (id)init{

    self = [super init];
    if (self) {
        //设置默认值
        self.radius            = 100.0f;
        self.lineWidth         = 1.0f;
        self.lineColor         = [UIColor blackColor];
        self.propertyFont      = [UIFont systemFontOfSize:12.0f];
    }
    return self;
}

@end

@interface XZRadarChartView(){

    /** 坐标轴中心点*/
    CGPoint _center;
    XZRadarCoordinateConfig *_radarCoordinateConfig;
    NSArray *_dataArray;
}


@end

@implementation XZRadarChartView

- (id)initWithFrame:(CGRect)frame withRadarCoordinateConfig:(XZRadarCoordinateConfig *)radarCoordinateConfig withData:(NSArray *)dataArray{

    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        _radarCoordinateConfig = radarCoordinateConfig;
        _center                = CGPointMake(frame.size.width/2.0f, frame.size.height/2.0f);
        _dataArray             = dataArray;
        
        //检查两个必要属性是否设置
        NSAssert(!(_radarCoordinateConfig.propertyName.count < 3), @"雷达坐标系属性数量必须 >= 3");
        NSAssert(!(_radarCoordinateConfig.dialLabelArray.count == 0), @"雷达坐标系刻度值数量必须 >= 1");
        
        [self drawRadarChart];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    //绘制坐标系
    CGContextRef context = UIGraphicsGetCurrentContext();
    //设置线宽
    CGContextSetLineWidth(context, _radarCoordinateConfig.lineWidth);
    //设置线条颜色
    CGContextSetStrokeColorWithColor(context, _radarCoordinateConfig.lineColor.CGColor);
    
    //刻度之间的间距
    CGFloat dialSpace = _radarCoordinateConfig.radius/_radarCoordinateConfig.dialLabelArray.count;
    //绘制多边形
    for (NSInteger i = 0; i < _radarCoordinateConfig.dialLabelArray.count; i++)
        [self drawPolygonWithContext:context radius:_radarCoordinateConfig.radius-dialSpace*i];
    
    //绘制中心点与顶点连线
    CGFloat angle = 2*M_PI/_radarCoordinateConfig.propertyName.count;
    for (NSInteger i = 0 ; i <_radarCoordinateConfig.propertyName.count; i++) {
        
        CGContextMoveToPoint(context, _center.x, _center.y);
        //顶点坐标
        CGPoint point          = CGPointMake(_center.x + _radarCoordinateConfig.radius * sin(angle*i), _center.y - _radarCoordinateConfig.radius * cos(angle*i));
        CGContextAddLineToPoint(context, point.x, point.y);

        //属性名称
        NSString *porpertyName = _radarCoordinateConfig.propertyName[i];
        CGSize size            = [porpertyName sizeWithAttributes:@{NSFontAttributeName : _radarCoordinateConfig.propertyFont}];
        
        //属性名城绘制的位置
        CGFloat x,y = 0.0f;
        
        if (point.x == _center.x)
            x = point.x - size.width/2.0f;
        else if (point.x > _center.x)
            x = point.x;
        else
            x = point.x - size.width;
        
        if (point.y == _center.y)
            y = point.y - size.height/2.0f;
        else if (point.y > _center.y)
            y = point.y;
        else
            y = point.y - size.height;
        
        CGRect rect = CGRectMake(x, y, size.width, size.height);
        //绘制属性名称
        [porpertyName drawInRect:rect withAttributes:@{NSFontAttributeName : _radarCoordinateConfig.propertyFont}];
        
    }

    CGContextStrokePath(context);
}

#pragma mark - Private_Methods
/**
 *  绘制雷达坐标系中的多边形
 *
 *  @param context 上下文
 *  @param radius  多边形的半径范围
 */
- (void)drawPolygonWithContext:(CGContextRef)context radius:(CGFloat)radius{

    CGFloat angle = 2*M_PI/_radarCoordinateConfig.propertyName.count;
    
    CGContextMoveToPoint(context, _center.x, _center.y - radius);
    
    for (NSInteger i = 1 ; i <_radarCoordinateConfig.propertyName.count; i++) {
        //顶点坐标
        CGPoint point = CGPointMake(_center.x + radius * sin(angle*i), _center.y - radius * cos(angle*i));
        CGContextAddLineToPoint(context, point.x, point.y);
    }
    
    CGContextAddLineToPoint(context, _center.x, _center.y - radius);
}

#pragma mark - Public_Methods
/**
 *  绘制雷达统计图
 */
- (void)drawRadarChart{

    //刻度值之间的差值
    CGFloat dialDiff  = ((NSString *)_radarCoordinateConfig.dialLabelArray[1]).floatValue - ((NSString *)_radarCoordinateConfig.dialLabelArray[0]).floatValue;
    //刻度之间的间距
    CGFloat dialSpace = _radarCoordinateConfig.radius/_radarCoordinateConfig.dialLabelArray.count;
    CGFloat angle     = 2*M_PI/_radarCoordinateConfig.propertyName.count;

    for (XZRadarModel *radarModel in _dataArray) {
        
        //绘制雷达图
        if (radarModel.dataDic.count == 0)
            continue;
        
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.lineWidth     = radarModel.lineWidth;
        layer.strokeColor   = radarModel.lineColor.CGColor;
        layer.fillColor     = radarModel.fillColor.CGColor;
        UIBezierPath *path  = [UIBezierPath bezierPath];
        
        for (NSInteger i = 0; i < _radarCoordinateConfig.propertyName.count; i++) {
            //某一属性上的值
            CGFloat value  = ((NSString *)radarModel.dataDic[_radarCoordinateConfig.propertyName[i]]).floatValue;
            CGFloat diff   = value - ((NSString *)_radarCoordinateConfig.dialLabelArray[0]).floatValue;
            //该属性在坐标系统上的占据的长度
            CGFloat length = dialSpace + dialSpace*(diff/dialDiff);
            //该属性值的坐标位置
            CGPoint point  = CGPointMake(_center.x + length * sin(angle*i), _center.y - length * cos(angle*i));
            
            if (i == 0)
                [path moveToPoint:point];
            else
                [path addLineToPoint:point];
        }
        [path closePath];
        
        layer.path = path.CGPath;
        [self.layer addSublayer:layer];
        
        //动画
        CABasicAnimation *animateScale = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        animateScale.fromValue         = [NSNumber numberWithFloat:0.f];
        animateScale.toValue           = [NSNumber numberWithFloat:1.0f];
        CABasicAnimation *animateMove  = [CABasicAnimation animationWithKeyPath:@"position"];
        animateMove.fromValue          = [NSValue valueWithCGPoint:CGPointMake(_center.x, _center.y)];
        animateMove.toValue            = [NSValue valueWithCGPoint:CGPointMake(0, 0)];
        CAAnimationGroup *aniGroup     = [CAAnimationGroup animation];
        aniGroup.duration              = radarModel.animationDuration;
        aniGroup.repeatCount           = 1;
        aniGroup.animations            = [NSArray arrayWithObjects:animateScale,animateMove, nil];
        aniGroup.removedOnCompletion   = YES;
        [layer addAnimation:aniGroup forKey:nil];
    }
}
@end
