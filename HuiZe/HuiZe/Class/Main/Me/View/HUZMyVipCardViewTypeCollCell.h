//
//  HUZMyVipCardViewTypeCollCell.h
//  HuiZe
//
//  Created by tbb on 2019/9/3.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HUZTableViewCell.h"
NS_ASSUME_NONNULL_BEGIN

@protocol HUZMyVipCardViewTypeCollCellDelegate <NSObject>

-(void)selectPriceIndex:(NSInteger)index;

@end

@interface HUZMyVipCardViewTypeCollCell : HUZTableViewCell
@property(nonatomic, weak) id <HUZMyVipCardViewTypeCollCellDelegate> delegate;
@property (nonatomic, copy) NSArray * dataArr;
@end

NS_ASSUME_NONNULL_END

