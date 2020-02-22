//
//  HUZVolunteerWishController.h
//  HuiZe
//
//  Created by mac on 2019/5/5.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZTableViewController.h"

#import "HUZProvinceModel.h"

typedef void(^SelectPrivinceIdsBlock)(NSString * _Nullable provinceIds,NSString * _Nullable provinceNames);

typedef void(^SelectBoysAndGirlsBlock)(NSString * _Nullable menId);

typedef void(^SelectMajorIdsBlock)(NSString * _Nullable majorIds,NSString * _Nullable majorNames);

NS_ASSUME_NONNULL_BEGIN

@interface HUZVolunteerWishController : HUZTableViewController

@property (nonatomic, copy) SelectPrivinceIdsBlock provinceIdsBlock;

@property (nonatomic, copy) SelectBoysAndGirlsBlock menIdBlock;

@property (nonatomic, copy) SelectMajorIdsBlock majorIdsBlock;
@property (nonatomic, copy) void (^selectCharactersBlock)(NSString *charactersIds);

@property (nonatomic, copy) NSString *schoolProvinceIds;
@property (nonatomic, copy) NSString *schoolProvinceNames;

@property (nonatomic, copy) NSString *majorEntitiesIds;
@property (nonatomic, copy) NSString *majorEntitiesIdsNames;

@end

NS_ASSUME_NONNULL_END
