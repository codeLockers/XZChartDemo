//
//  XZBarChartCell.h
//  XZChartDemo
//
//  Created by 徐章 on 16/8/25.
//  Copyright © 2016年 徐章. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XZAxisCoordinateConfig.h"
#import "XZBarModel.h"

@interface XZBarChartCell : UICollectionViewCell

- (void)setUpCellAtIndexPath:(NSIndexPath *)indexPath axisCoordinateConfig:(XZAxisCoordinateConfig *)axisCoordinateConfig barModel:(XZBarModel *)barModel;

@end
