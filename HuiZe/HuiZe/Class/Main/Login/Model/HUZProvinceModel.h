//
//  HUZProvinceModel.h
//  HuiZe
//
//  Created by mac on 2019/5/8.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HUZProvince : NSObject
@property (nonatomic,copy)NSString *Id;
@property (nonatomic,copy)NSString *title;
@property (nonatomic,copy)NSString *abbreviation;
@property (nonatomic,copy)NSString *createTime;

@property (copy, nonatomic) NSString *isSelected;
@end


@interface HUZProvinceModel : HUZModel
@property (nonatomic,strong)NSArray<HUZProvince *> *data;

@end

NS_ASSUME_NONNULL_END
