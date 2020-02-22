//
//  HUZMessageListModel.h
//  HuiZe
//
//  Created by caominglei on 2019/5/22.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZModel.h"

@class HUZMessageListDataModel,HUZMessageModel;
NS_ASSUME_NONNULL_BEGIN

@interface HUZMessageListModel : HUZModel

@property (strong, nonatomic) HUZMessageListDataModel *data;
@end

@interface HUZMessageListDataModel : HUZModel

@property (strong, nonatomic) NSArray <HUZMessageModel *> *list;
@end

@interface HUZMessageModel : HUZModel

@property (nonatomic, copy) NSString * creationTime;

@property (nonatomic, copy) NSString *headUrl;

@property (nonatomic, copy) NSString * Id;
/**
 1 已读 2 未读
 */
@property (nonatomic, copy) NSString *mesState;


@property (nonatomic, copy) NSString *mesTitle;

@property (nonatomic, assign) NSInteger mesType;

@property (nonatomic, copy) NSString *username;

@end
NS_ASSUME_NONNULL_END
