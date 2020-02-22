//
//  HUZMyVipCardViewTypeCollCellCollViewCell.h
//  HuiZe
//
//  Created by tbb on 2019/9/3.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class HUZMyVipCardPriceModel;
@interface HUZMyVipCardViewTypeCollCellCollViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *typeLb;
@property (weak, nonatomic) IBOutlet UILabel *priceLb;
@property (weak, nonatomic) IBOutlet UILabel *oldPriceLb;
@property (nonatomic, strong) HUZMyVipCardPriceModel * priceModel;
@end

NS_ASSUME_NONNULL_END
