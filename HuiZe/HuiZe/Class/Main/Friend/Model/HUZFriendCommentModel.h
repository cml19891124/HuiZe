//
//  HUZFriendCommentModel.h
//  HuiZe
//
//  Created by  YIQI on 2019/5/8.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZModel.h"
#import "HUZListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HUZFriendCommentDataEvosListModel : NSObject

@property (nonatomic,strong) NSString *id;
@property (nonatomic,strong) NSString *userId;
@property (nonatomic,strong) NSString *content;
@property (nonatomic,strong) NSString *picContentId;
@property (nonatomic,strong) NSString *createTime;
@property (nonatomic,strong) NSString *createUser;
@property (nonatomic,strong) NSString *username;
@property (nonatomic,strong) NSString *headUrl;
@property (nonatomic,strong) NSString *contentPicTitle;

@end



@interface HUZFriendCommentDataModel : HUZListModel
@property (nonatomic,strong) NSArray<HUZFriendCommentDataEvosListModel *> *list;


@end

@interface HUZFriendCommentModel : HUZModel

@property (nonatomic,strong) HUZFriendCommentDataModel *data;

@end

NS_ASSUME_NONNULL_END
