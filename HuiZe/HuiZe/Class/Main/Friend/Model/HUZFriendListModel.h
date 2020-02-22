//
//  HUZFriendListModel.h
//  HuiZe
//
//  Created by  YIQI on 2019/5/7.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZModel.h"
#import "HUZListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HUZFriendListDataListModel : NSObject

@property (nonatomic,strong) NSString *id;          /// 帖子id
@property (nonatomic,strong) NSString *content;     /// 内容
@property (nonatomic,strong) NSString *readNum;     /// 已读次数
@property (nonatomic,strong) NSString *commentNum;  /// 评论次数
@property (nonatomic,strong) NSString *likeNum;     /// 点赞次数
@property (nonatomic,strong) NSString *createTime;  
@property (nonatomic,strong) NSString *createUser;
@property (nonatomic,strong) NSString *refinement;    /// 0-普通帖子  1-加精贴
@property (nonatomic,strong) NSString *headUrl;  /// 头像
@property (nonatomic,strong) NSString *typeId;  /// 1高考政策,2填报问题,3生涯规划,4大学专业,5志愿讲堂,6产品专区
@property (nonatomic,strong) NSString *isClick; /// 是否点赞 0否 1是
@property (nonatomic,strong) NSString *username; /// 发帖人
@end

@interface HUZFriendListDataModel : HUZListModel

@property (nonatomic,strong) NSArray<HUZFriendListDataListModel *> *list;
@end

@interface HUZFriendListModel : HUZModel

@property (nonatomic,strong) HUZFriendListDataModel *data;

@end

NS_ASSUME_NONNULL_END
