//
//  HUZMyVipCardViewTypeCollCellCollViewCell.m
//  HuiZe
//
//  Created by tbb on 2019/9/3.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZMyVipCardViewTypeCollCellCollViewCell.h"
#import "HUZMyVipCardPriceModel.h"
@implementation HUZMyVipCardViewTypeCollCellCollViewCell
-(void)setPriceModel:(HUZMyVipCardPriceModel *)priceModel {
    _priceModel = priceModel;
    self.typeLb.text = priceModel.title;
    self.priceLb.text = [NSString stringWithFormat:@"￥%@",priceModel.upgradePrice];
    self.oldPriceLb.text = [NSString stringWithFormat:@"￥%@",priceModel.price];
    if (priceModel.isSelection) {
        self.contentView.layer.borderColor = ColorS(COLOR_BG_2E86FF).CGColor;
    }else{
        self.contentView.layer.borderColor = ColorS(COLOR_848484).CGColor;
    }
}
- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentView.layer.cornerRadius = 8;
    self.contentView.layer.borderColor = ColorS(COLOR_848484).CGColor;
    self.contentView.layer.borderWidth = 1.0;
}

@end
