//
//  XZBarChartView.m
//  XZChartDemo
//
//  Created by 徐章 on 16/8/23.
//  Copyright © 2016年 徐章. All rights reserved.
//

#import "XZBarChartView.h"
#import "XZBarChartCell.h"
#import "XZYAxisView.h"

/*
@interface XZBarView(){
    
    XZAxisCoordinateConfig *_axisCoordinateConfig;
}

@end

@implementation XZBarView

- (id)initWithFrame:(CGRect)frame withAxisCoordinateConfig:(XZAxisCoordinateConfig *)axisCoordinateConfig withData:(NSArray *)dataArray{
    
    self = [super initWithFrame:frame];
    if (self) {

        self.backgroundColor = [UIColor clearColor];
        _axisCoordinateConfig = axisCoordinateConfig;
        
        [self loadXAxisWithFrame:frame];
        [self drawBarWithData:dataArray];
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
        CGPoint dialPoint = CGPointMake(originPoint.x + _axisCoordinateConfig.xAxisStartMargin + (_axisCoordinateConfig.xDialSpace+_axisCoordinateConfig.barWidth)*i, originPoint.y);
        
        [xAxisPath moveToPoint:CGPointMake(dialPoint.x, dialPoint.y)];
        [xAxisPath addLineToPoint:CGPointMake(dialPoint.x, dialPoint.y - _axisCoordinateConfig.dialLegth)];
        [xAxisPath moveToPoint:CGPointMake(dialPoint.x+_axisCoordinateConfig.barWidth, originPoint.y)];
        [xAxisPath addLineToPoint:CGPointMake(dialPoint.x+_axisCoordinateConfig.barWidth, dialPoint.y - _axisCoordinateConfig.dialLegth)];
        
        NSString *dialStr = _axisCoordinateConfig.xAxisLabelArray[i];
        CGSize size = [dialStr sizeWithAttributes:@{NSFontAttributeName:_axisCoordinateConfig.dialFont}];

        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(dialPoint.x +(_axisCoordinateConfig.barWidth - size.width)/2.0f, dialPoint.y, size.width, size.height)];
        label.text = dialStr;
        label.textColor = _axisCoordinateConfig.color;
        label.font = _axisCoordinateConfig.dialFont;
        [self addSubview:label];
    }
    
    xAxisLayer.path = xAxisPath.CGPath;
    
    [self.layer addSublayer:xAxisLayer];
}



/**
 *  绘制柱形
 *
 *  @param dataArray 数据源
 */
/*
- (void)drawBarWithData:(NSArray *)dataArray{

    for (XZBarModel *barModel in dataArray) {
        
        NSMutableArray *pointArray = [self calculateCoordinateOfXValues:barModel.xValues YValues:barModel.yValues];
        
        for (NSValue *value in pointArray) {
            
            CAShapeLayer *layer = [CAShapeLayer layer];
            layer.strokeColor   = barModel.barColor.CGColor;
            layer.lineWidth     = _axisCoordinateConfig.barWidth;
            
            UIBezierPath *path = [UIBezierPath bezierPath];
            
            CGPoint point = value.CGPointValue;
            
            [path moveToPoint:CGPointMake(point.x + _axisCoordinateConfig.barWidth/2.0f, self.frame.size.height - _axisCoordinateConfig.xAxisBottomMargin - _axisCoordinateConfig.lineWidth)];
            [path addLineToPoint:CGPointMake(point.x + _axisCoordinateConfig.barWidth/2.0f, point.y)];
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
}*/

/**
 *  根据每个点的值计算出他在坐标系中的位置
 *
 *  @param xValues 横坐标的值
 *  @param yValues 纵坐标的值
 *
 *  @return 坐标数组
 */
/*
- (NSMutableArray *)calculateCoordinateOfXValues:(NSArray *)xValues YValues:(NSArray *)yValues{
    
    NSMutableArray *pointArray = [NSMutableArray array];
    
    CGFloat yDialSpace = (self.frame.size.height - _axisCoordinateConfig.xAxisBottomMargin - _axisCoordinateConfig.yAxisStartMargin - _axisCoordinateConfig.arrowVerticalOffset)/_axisCoordinateConfig.yAxisLabelArray.count;
    
    for (NSInteger i = 0; i < xValues.count; i++) {
        
        CGFloat yValue = ((NSString *)yValues[i]).floatValue;
        CGFloat xPoint = _axisCoordinateConfig.xAxisStartMargin + (_axisCoordinateConfig.xDialSpace + _axisCoordinateConfig.barWidth)*i;
        
        CGFloat yAxisValueDiff = ((NSString *)_axisCoordinateConfig.yAxisLabelArray[1]).floatValue - ((NSString *)_axisCoordinateConfig.yAxisLabelArray[0]).floatValue;
        
        CGFloat yPoint = (yValue - ((NSString *)_axisCoordinateConfig.yAxisLabelArray.firstObject).floatValue)/yAxisValueDiff * yDialSpace;
        yPoint = self.frame.size.height - yPoint - _axisCoordinateConfig.xAxisBottomMargin - _axisCoordinateConfig.yAxisStartMargin;
        
        CGPoint point = CGPointMake(xPoint, yPoint);
        [pointArray addObject:[NSValue valueWithCGPoint:point]];
        
    }
    return pointArray;

}


@end
*/

@interface XZBarChartView()<UICollectionViewDelegate,UICollectionViewDataSource>{

    XZAxisCoordinateConfig *_axisCoordinateConfig;
    XZBarModel *_barModel;
}

@end

@implementation XZBarChartView

- (id)initWithFrame:(CGRect)frame withAxisCoordinateConfig:(XZAxisCoordinateConfig *)axisCoordinateConfig withBarModel:(id)barModel{

    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        _axisCoordinateConfig = axisCoordinateConfig;
        _barModel = barModel;
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing          = 0.0;
        layout.minimumInteritemSpacing     = 0.0;
        layout.itemSize                    = CGSizeMake(_axisCoordinateConfig.barWidth+_axisCoordinateConfig.xDialSpace, frame.size.height);
        layout.scrollDirection             = UICollectionViewScrollDirectionHorizontal;
        
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(_axisCoordinateConfig.yAxisLeftMargin, 0, frame.size.width - _axisCoordinateConfig.yAxisLeftMargin, frame.size.height) collectionViewLayout:layout];
        [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([UICollectionReusableView class])];
        [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:NSStringFromClass([UICollectionReusableView class])];
        [collectionView registerClass:[XZBarChartCell class] forCellWithReuseIdentifier:NSStringFromClass([XZBarChartCell class])];
        collectionView.backgroundColor                = [UIColor clearColor];
        collectionView.delegate                       = self;
        collectionView.dataSource                     = self;
        collectionView.showsVerticalScrollIndicator   = NO;
        collectionView.showsHorizontalScrollIndicator = NO;
        collectionView.bounces                        = NO;
        [self addSubview:collectionView];
        
        //Y轴View
        XZYAxisView *yAxixView = [[XZYAxisView alloc] initWithFrame:CGRectMake(0, 0, _axisCoordinateConfig.yAxisLeftMargin+MAX(_axisCoordinateConfig.dialLegth, _axisCoordinateConfig.arrowHorizontalOffset), frame.size.height) withAxisCoordinateModel:_axisCoordinateConfig];
        [self addSubview:yAxixView];
        
#warning 被注视的方法只适合在数据量在百量极的情况下,不然内存会溢出并且会出现明显卡顿
        /*
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(_axisCoordinateConfig.yAxisLeftMargin, 0, frame.size.width - _axisCoordinateConfig.yAxisLeftMargin, frame.size.height)];
        scrollView.contentSize = CGSizeMake(_axisCoordinateConfig.yAxisStartMargin + (_axisCoordinateConfig.xDialSpace+_axisCoordinateConfig.barWidth) * _axisCoordinateConfig.xAxisLabelArray.count, CGRectGetHeight(scrollView.frame));
        scrollView.bounces = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:scrollView];

        XZBarView *barView = [[XZBarView alloc] initWithFrame:CGRectMake(0, 0,scrollView.contentSize.width, frame.size.height) withAxisCoordinateConfig:axisCoordinateConfig withData:dataArray];
        
        [scrollView addSubview:barView];
         */
    }
    return self;

}

/*
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
 */

#pragma mark - UIColectionView_DataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return _axisCoordinateConfig.xAxisLabelArray.count;
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(_axisCoordinateConfig.xAxisStartMargin, CGRectGetHeight(collectionView.frame));
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{

    CGFloat width = (_axisCoordinateConfig.yAxisLeftMargin + _axisCoordinateConfig.xAxisStartMargin + (_axisCoordinateConfig.xDialSpace + _axisCoordinateConfig.barWidth)*_axisCoordinateConfig.xAxisLabelArray.count);
    
    width = width >= CGRectGetWidth(collectionView.frame) ? _axisCoordinateConfig.arrowVerticalOffset : CGRectGetWidth(self.frame) - width;
    
    return CGSizeMake(width, CGRectGetHeight(collectionView.frame));

}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{

    UICollectionReusableView *reusableview = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass([UICollectionReusableView class]) forIndexPath:indexPath];
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.lineWidth     = _axisCoordinateConfig.lineWidth;
    layer.strokeColor   = _axisCoordinateConfig.color.CGColor;
    layer.fillColor     = [UIColor clearColor].CGColor;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, CGRectGetHeight(collectionView.frame)-_axisCoordinateConfig.xAxisBottomMargin)];
    CGPoint point = CGPointMake(CGRectGetWidth(reusableview.frame), CGRectGetHeight(collectionView.frame)-_axisCoordinateConfig.xAxisBottomMargin);
    [path addLineToPoint:point];
    
    if (kind == UICollectionElementKindSectionFooter) {
        [path addLineToPoint:CGPointMake(point.x - _axisCoordinateConfig.arrowVerticalOffset, point.y - _axisCoordinateConfig.arrowHorizontalOffset)];
        [path moveToPoint:point];
        [path addLineToPoint:CGPointMake(point.x - _axisCoordinateConfig.arrowVerticalOffset, point.y + _axisCoordinateConfig.arrowHorizontalOffset)];
    }
    
    layer.path = path.CGPath;
    [reusableview.layer addSublayer:layer];
    return reusableview;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    XZBarChartCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([XZBarChartCell class]) forIndexPath:indexPath];
    [cell setUpCellAtIndexPath:indexPath axisCoordinateConfig:_axisCoordinateConfig barModel:_barModel];
    return cell;
}
@end
