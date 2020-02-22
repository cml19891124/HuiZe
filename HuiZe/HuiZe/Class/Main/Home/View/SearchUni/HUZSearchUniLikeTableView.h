//
//  HUZSearchUniLikeTableView.h
//  HuiZe
//
//  Created by  YIQI on 2019/4/23.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZSegmentTableView.h"
//#import "HUZSearchUniSectionView.h"

typedef NS_ENUM(NSInteger,HUZSearchUniType){
    HUZSearchUniLike = 1,  //猜你喜欢
    HUZSearchUniHot,       //名企热招
};

NS_ASSUME_NONNULL_BEGIN

@interface HUZSearchUniLikeTableView : HUZSegmentTableView

@property (nonatomic,assign) HUZSearchUniType type;

/// 菜单数据源
@property (nonatomic,strong) NSArray *datasType;

@end

NS_ASSUME_NONNULL_END
