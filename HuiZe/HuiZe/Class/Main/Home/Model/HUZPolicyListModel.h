//
//  HUZPolicyListModel.h
//  HuiZe
//
//  Created by  YIQI on 2019/5/10.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZModel.h"
#import "HUZListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HUZPolicylistdataListModel : NSObject

@property (nonatomic,strong) NSString *content;
@property (nonatomic,strong) NSString *Id;
@property (nonatomic,strong) NSString *title;
@property (nonatomic, copy) NSString * createTime;
@property (nonatomic, copy) NSString * createUser;
@property (nonatomic, copy) NSString * createUserId;
@property (nonatomic, copy) NSString * jumpUrl;
@property (nonatomic, copy) NSString * province;
@property (nonatomic, copy) NSString * picOne;
@property (nonatomic, copy) NSString * provinceName;
@property (nonatomic, copy) NSString * type;
@property (nonatomic, copy) NSString * userName;
@end

@interface HUZPolicyListDataModel : HUZListModel

@property (nonatomic,strong) NSArray<HUZPolicylistdataListModel *> *list;

@end

@interface HUZPolicyListModel : HUZModel

@property (nonatomic,strong) HUZPolicyListDataModel *data;

@end

NS_ASSUME_NONNULL_END
