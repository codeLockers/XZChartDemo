//
//  XZLineChartCell.h
//  XZChartDemo
//
//  Created by 徐章 on 16/8/26.
//  Copyright © 2016年 徐章. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XZAxisCoordinateConfig.h"
#import "XZLineModel.h"

@interface XZLineChartCell : UICollectionViewCell

- (void)setUpCellAtIndexPath:(NSIndexPath *)indexPath axisCoordinateConfig:(XZAxisCoordinateConfig *)axisCoordinateConfig lineModel:(XZLineModel *)lineModel;
+ (CGFloat)calculateCoordinateOfYValue:(CGFloat)yValue;
@end
