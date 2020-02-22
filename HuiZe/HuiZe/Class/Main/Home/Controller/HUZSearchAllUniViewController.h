//
//  HUZSearchAllUniViewController.h
//  HuiZe
//
//  Created by  YIQI on 2019/4/24.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZViewController.h"

typedef NS_ENUM(NSInteger,HUZSearchType){
    HUZSearchAllUni = 1,     // 全部高校
    HUZSearchProvinceUni,    // 本省高校
};

NS_ASSUME_NONNULL_BEGIN

@interface HUZSearchAllUniViewController : HUZViewController

@property (nonatomic,assign) HUZSearchType searchType;



@end

NS_ASSUME_NONNULL_END
