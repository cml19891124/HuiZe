//
//  HUZPostInfoHeaderView.h
//  HuiZe
//
//  Created by  YIQI on 2019/5/5.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZView.h"
#import "HUZFriendListModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^LikeBlock)();

@interface HUZPostInfoHeaderView : HUZView

@property (nonatomic,strong) HUZFriendListDataListModel *model;

- (CGFloat)cacluateHeightWithModel:(HUZFriendListDataListModel *)model;

@property (nonatomic,copy) LikeBlock likeBlock;
@property (nonatomic,strong) UIButton *btnRanking;
@end

NS_ASSUME_NONNULL_END
