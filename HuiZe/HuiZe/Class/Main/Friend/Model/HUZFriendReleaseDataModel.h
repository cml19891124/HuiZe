//
//  HUZFriendReleaseDataModel.h
//  HuiZe
//
//  Created by  YIQI on 2019/5/7.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HUZFriendReleaseDataModel : HUZModel

@property (nonatomic,strong) NSString *commentNum;    /// 评论次数
@property (nonatomic,strong) NSString *content;       /// 内容
@property (nonatomic,strong) NSString *createTime;
@property (nonatomic,strong) NSString *createUser;
@property (nonatomic,strong) NSString *likeNum;       /// 点赞次数
@property (nonatomic,strong) NSString *readNum;       /// 已读次数
@property (nonatomic,strong) NSString *id;            /// id
@property (nonatomic,strong) NSString *typeId;        ///
@property (nonatomic,strong) NSString *refinement;    /// 0-普通帖子  1-加精贴


@end

NS_ASSUME_NONNULL_END
