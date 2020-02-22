//
//  HUZGkInfoModel.h
//  HuiZe
//
//  Created by  YIQI on 2019/5/9.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZModel.h"
#import "HUZListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HUZGkInfoDataListModel : NSObject
@property (nonatomic, copy) NSString * content;
@property (nonatomic,strong) NSString *Id;        /// id
@property (nonatomic,strong) NSString *type;      /// "热门推荐", "独家解析", "资讯头条", "报考指南", "备考经验", "高考政策" ,依次从0开始
@property (nonatomic,strong) NSString *title;     /// 标题
@property (nonatomic,strong) NSString *picOne;    /// 图片
@property (nonatomic,strong) NSString *createTime;  /// 时间

@property (nonatomic, copy) NSString * createUser;
@property (nonatomic, copy) NSString * createUserId;
@property (nonatomic, copy) NSString * jumpUrl;
@property (nonatomic, copy) NSString * province;
@property (nonatomic, copy) NSString * provinceName;
@property (nonatomic, copy) NSString * userName;
@end

@interface HUZGkInfoDataModel : HUZListModel

@property (nonatomic,strong) NSArray<HUZGkInfoDataListModel *> *list;

@end

@interface HUZGkInfoModel : HUZModel

@property (nonatomic,strong) HUZGkInfoDataModel *data;

@end

NS_ASSUME_NONNULL_END
