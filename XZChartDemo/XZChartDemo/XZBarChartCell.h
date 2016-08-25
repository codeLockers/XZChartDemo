//
//  XZBarChartCell.h
//  XZChartDemo
//
//  Created by 徐章 on 16/8/25.
//  Copyright © 2016年 徐章. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XZAxisCoordinateConfig.h"

@interface XZBarChartCell : UICollectionViewCell

@property (nonatomic, strong) XZAxisCoordinateConfig *axisCoordinateConfig;

- (void)setUpCellWithAxisLabel:(NSString *)xAxisLabel yValue:(CGFloat)yValue;

@end
