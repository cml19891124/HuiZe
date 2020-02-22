//
//  HUZBannerModel.h
//  HuiZe
//
//  Created by  YIQI on 2019/5/10.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HUZBannerDataModel : NSObject

@property (nonatomic,strong) NSString *id;
@property (nonatomic,strong) NSString *imgUrl;    /// 图片
@property (nonatomic,strong) NSString *jumpUrl;   /// 链接
@property (nonatomic,strong) NSString *type;      /// 类型：0首页 1查大学 2查专业 3报考指南 4招录数据

@end

@interface HUZBannerModel : HUZModel

@property (nonatomic,strong) NSArray<HUZBannerDataModel *> *data;

@end

NS_ASSUME_NONNULL_END
