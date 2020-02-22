//
//  HUZHomeServiceCell.h
//  HuiZe
//
//  Created by  YIQI on 2019/4/18.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZTableViewCell.h"
#import "HUZServiceView.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,HUZHomeServiceCellType){
    HUZHomeServiceFunctionType = 1,  /// 功能位
    HUZHomeServiceAdtype,            /// 广告位
};

@interface HUZHomeServiceCell : HUZTableViewCell

@property (nonatomic,strong) HUZServiceView *serviceView1;
@property (nonatomic,strong) HUZServiceView *serviceView2;
@property (nonatomic,strong) HUZServiceView *serviceView3;
@property (nonatomic,strong) HUZServiceView *serviceView4;

@property (nonatomic,assign) HUZHomeServiceCellType type;

@end

NS_ASSUME_NONNULL_END
