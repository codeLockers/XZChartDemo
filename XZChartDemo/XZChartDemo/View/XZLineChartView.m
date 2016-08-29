//
//  XZLineChartView.m
//  XZChartDemo
//
//  Created by 徐章 on 16/8/22.
//  Copyright © 2016年 徐章. All rights reserved.
//

#import "XZLineChartView.h"
#import "XZLineModel.h"
#import "XZLineChartCell.h"
#import "XZYAxisView.h"
#define MC_RandomColor              [UIColor colorWithHue:(arc4random()%256/256.0) saturation:(arc4random()%128/256.0)+0.5 brightness:(arc4random()%128/256.0)+0.5 alpha:1];
/*
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
/*
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
*/
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
*/
@interface XZLineChartView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>{

    XZAxisCoordinateConfig *_axisCoordinateConfig;
    NSArray *_dataArray;
}

@end

@implementation XZLineChartView

- (id)initWithFrame:(CGRect)frame withAxisCoordinateConfig:(XZAxisCoordinateConfig *)axisCoordinateConfig withData:(NSArray *)dataArray{

    self = [super initWithFrame:frame];
    if (self) {

        self.backgroundColor = [UIColor whiteColor];
        
        _axisCoordinateConfig = axisCoordinateConfig;
        _dataArray = dataArray;
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing          = 0.0;
        layout.minimumInteritemSpacing     = 0.0;
        layout.itemSize                    = CGSizeMake(_axisCoordinateConfig.xDialSpace, frame.size.height);
        layout.scrollDirection             = UICollectionViewScrollDirectionHorizontal;
        
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(_axisCoordinateConfig.yAxisLeftMargin, 0, frame.size.width - _axisCoordinateConfig.yAxisLeftMargin, frame.size.height) collectionViewLayout:layout];
        collectionView.backgroundColor = [UIColor clearColor];
        
        [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([UICollectionReusableView class])];
        [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:NSStringFromClass([UICollectionReusableView class])];
        [collectionView registerClass:[XZLineChartCell class] forCellWithReuseIdentifier:NSStringFromClass([XZLineChartCell class])];
        
        collectionView.delegate                       = self;
        collectionView.dataSource                     = self;
        collectionView.showsVerticalScrollIndicator   = NO;
        collectionView.showsHorizontalScrollIndicator = NO;
        collectionView.bounces                        = NO;
        
        [self addSubview:collectionView];
        
        //绘制Y轴
        XZYAxisView *yAxisView = [[XZYAxisView alloc] initWithFrame:CGRectMake(0, 0, _axisCoordinateConfig.yAxisLeftMargin+MAX(_axisCoordinateConfig.dialLegth, _axisCoordinateConfig.arrowHorizontalOffset),frame.size.height) withAxisCoordinateModel:_axisCoordinateConfig];
        [self addSubview:yAxisView];
        
/*
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(_axisCoordinateConfig.yAxisLeftMargin, 0, frame.size.width - _axisCoordinateConfig.yAxisLeftMargin, frame.size.height)];
        scrollView.contentSize = CGSizeMake(_axisCoordinateConfig.xDialSpace * _axisCoordinateConfig.xAxisLabelArray.count, CGRectGetHeight(scrollView.frame));
        scrollView.bounces = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:scrollView];
        
        XZLineView *lineView =[[XZLineView alloc] initWithFrame:CGRectMake(0, 0, scrollView.contentSize.width, CGRectGetHeight(scrollView.frame)) withAxisCoordinateConfig:axisCoordinateConfig withData:dataArray];
        [scrollView addSubview:lineView];
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

#pragma mark - UICollectionView_DataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return _axisCoordinateConfig.xAxisLabelArray.count-1;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(_axisCoordinateConfig.xAxisStartMargin + _axisCoordinateConfig.xDialSpace/2.0f, CGRectGetHeight(collectionView.frame));
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    
    CGFloat width = (_axisCoordinateConfig.yAxisLeftMargin + (_axisCoordinateConfig.xAxisStartMargin + _axisCoordinateConfig.xDialSpace/2.0f) + _axisCoordinateConfig.xDialSpace * (_axisCoordinateConfig.xAxisLabelArray.count - 1));
    
    width = width >= CGRectGetWidth(collectionView.frame) ? _axisCoordinateConfig.arrowVerticalOffset : CGRectGetWidth(self.frame) - width;
    
    return CGSizeMake(width, CGRectGetHeight(collectionView.frame));
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionReusableView *reusableview = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass([UICollectionReusableView class]) forIndexPath:indexPath];
    
    if (kind == UICollectionElementKindSectionHeader)
        return [self fillCollectionView:collectionView reuseHeaderView:reusableview];
    else if (kind == UICollectionElementKindSectionFooter)
        return [self fillCollectionView:collectionView reuseFooterView:reusableview];
    return reusableview;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    XZLineChartCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([XZLineChartCell class]) forIndexPath:indexPath];
    
    XZLineModel *lineModel = _dataArray[0];
    [cell setUpCellAtIndexPath:indexPath axisCoordinateConfig:_axisCoordinateConfig lineModel:lineModel];
    return cell;
}

#pragma mark - Private_Methods
/**
 *  根据相应的值计算出在坐标系中的Y轴坐标
 *
 *  @param yValue Y轴的值
 *
 *  @return Y轴的坐标
 */
- (CGFloat)calculateCoordinateOfYValue:(CGFloat)yValue{
    
    CGFloat yDialSpace = (self.frame.size.height - _axisCoordinateConfig.xAxisBottomMargin - _axisCoordinateConfig.yAxisStartMargin - _axisCoordinateConfig.arrowVerticalOffset)/_axisCoordinateConfig.yAxisLabelArray.count;
    
    CGFloat yAxisValueDiff = ((NSString *)_axisCoordinateConfig.yAxisLabelArray[1]).floatValue - ((NSString *)_axisCoordinateConfig.yAxisLabelArray[0]).floatValue;

    CGFloat yPoint = (yValue - ((NSString *)_axisCoordinateConfig.yAxisLabelArray.firstObject).floatValue)/yAxisValueDiff * yDialSpace;
    yPoint = self.frame.size.height - yPoint - _axisCoordinateConfig.xAxisBottomMargin - _axisCoordinateConfig.yAxisStartMargin;
    return yPoint;
}

- (UICollectionReusableView *)fillCollectionView:(UICollectionView *)collectionView reuseHeaderView:(UICollectionReusableView *)reusableview{

    NSString *labelStr = _axisCoordinateConfig.xAxisLabelArray[0];
    CGSize size = [labelStr sizeWithAttributes:@{NSFontAttributeName : _axisCoordinateConfig.dialFont}];
    //刻度标签
    UILabel *label  = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, size.width, _axisCoordinateConfig.xAxisBottomMargin)];
    label.center    = CGPointMake(_axisCoordinateConfig.xAxisStartMargin, CGRectGetHeight(collectionView.frame) - _axisCoordinateConfig.xAxisBottomMargin/2.0f);
    label.textColor = _axisCoordinateConfig.color;
    label.font      = _axisCoordinateConfig.dialFont;
    label.text      = _axisCoordinateConfig.xAxisLabelArray[0];
    [reusableview addSubview:label];

    //坐标轴线条
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.lineWidth     = _axisCoordinateConfig.lineWidth;
    layer.strokeColor   = _axisCoordinateConfig.color.CGColor;
    layer.fillColor     = [UIColor clearColor].CGColor;

    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, CGRectGetHeight(collectionView.frame)-_axisCoordinateConfig.xAxisBottomMargin)];
    [path addLineToPoint:CGPointMake(_axisCoordinateConfig.xAxisStartMargin, CGRectGetHeight(collectionView.frame)-_axisCoordinateConfig.xAxisBottomMargin)];
    [path addLineToPoint:CGPointMake(_axisCoordinateConfig.xAxisStartMargin, CGRectGetHeight(collectionView.frame)-_axisCoordinateConfig.xAxisBottomMargin-_axisCoordinateConfig.dialLegth)];
    [path moveToPoint:CGPointMake(_axisCoordinateConfig.xAxisStartMargin, CGRectGetHeight(collectionView.frame)-_axisCoordinateConfig.xAxisBottomMargin)];
    [path addLineToPoint:CGPointMake(_axisCoordinateConfig.xAxisStartMargin+_axisCoordinateConfig.xDialSpace/2.0f, CGRectGetHeight(collectionView.frame)-_axisCoordinateConfig.xAxisBottomMargin)];
    layer.path = path.CGPath;
    [reusableview.layer addSublayer:layer];

    //绘制第一条数据
    XZLineModel *lineModel = _dataArray[0];
    CGFloat yValue = ((NSString *)lineModel.yValues[0]).floatValue;
    if (lineModel.yValues.count <= 1)
        return reusableview;
    CGFloat nextYValue = ((NSString *)lineModel.yValues[1]).floatValue;

    CAShapeLayer *lineLayer = [CAShapeLayer layer];
    lineLayer.lineWidth     = lineModel.lineWidth;
    lineLayer.strokeColor   = lineModel.lineColor.CGColor;
    lineLayer.fillColor     = [UIColor clearColor].CGColor;

    UIBezierPath *linePath = [UIBezierPath bezierPath];
    [linePath moveToPoint:CGPointMake(_axisCoordinateConfig.xAxisStartMargin, [self calculateCoordinateOfYValue:yValue])];
    [linePath addLineToPoint:CGPointMake(_axisCoordinateConfig.xAxisStartMargin + _axisCoordinateConfig.xDialSpace/2.0f, [self calculateCoordinateOfYValue:(nextYValue+yValue)/2.0f])];
    
    lineLayer.path = linePath.CGPath;
    [reusableview.layer addSublayer:lineLayer];
    
    return reusableview;
}

- (UICollectionReusableView *)fillCollectionView:(UICollectionView *)collectionView reuseFooterView:(UICollectionReusableView *)reusableview{

    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.lineWidth = _axisCoordinateConfig.lineWidth;
    layer.strokeColor = _axisCoordinateConfig.color.CGColor;
    layer.fillColor = [UIColor clearColor].CGColor;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, CGRectGetHeight(collectionView.frame) - _axisCoordinateConfig.xAxisBottomMargin)];
    CGPoint point = CGPointMake(CGRectGetWidth(reusableview.frame), CGRectGetHeight(collectionView.frame) - _axisCoordinateConfig.xAxisBottomMargin);
    [path addLineToPoint:point];
    [path addLineToPoint:CGPointMake(point.x - _axisCoordinateConfig.arrowVerticalOffset, point.y - _axisCoordinateConfig.arrowHorizontalOffset)];
    [path moveToPoint:point];
    [path addLineToPoint:CGPointMake(point.x - _axisCoordinateConfig.arrowVerticalOffset, point.y + _axisCoordinateConfig.arrowHorizontalOffset)];
    
    layer.path = path.CGPath;
    [reusableview.layer addSublayer:layer];
    return reusableview;
}
@end
