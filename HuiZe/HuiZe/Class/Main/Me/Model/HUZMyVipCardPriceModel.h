//
//  HUZMyVipCardPriceModel.h
//  HuiZe
//
//  Created by tbb on 2019/9/3.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HUZMyVipCardPriceModel : NSObject
@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) NSString * price;
@property (nonatomic, copy) NSString * upgradePrice;
@property (nonatomic, assign) NSInteger upgradeType;
@property (nonatomic, assign,getter=isSelection) BOOL selection;

@property (nonatomic, copy) NSString * headerIcon;
@property (nonatomic, copy) NSString * bigIcon;
@end

NS_ASSUME_NONNULL_END
