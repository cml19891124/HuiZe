//
//  HUZFriendReleaseTypeModel.h
//  HuiZe
//
//  Created by  YIQI on 2019/5/7.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HUZFriendReleaseTypeListModel : NSObject

@property (nonatomic,strong) NSString *id;
@property (nonatomic,strong) NSString *typeName;  /// 名称
@property (nonatomic,strong) NSString *banner;    /// 图片
@property (nonatomic,strong) NSString *releaseSum;  /// 帖子数量
@property (nonatomic,strong) NSString *heat;      /// 热度
@property (nonatomic,strong) NSString *headContent; ///内容
@end

@interface HUZFriendReleaseTypeModel : HUZModel

@property (nonatomic,strong) NSArray<HUZFriendReleaseTypeListModel *> *data;

@end


NS_ASSUME_NONNULL_END
