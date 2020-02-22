//
//  HUZCommonSenseModel.h
//  HuiZe
//
//  Created by  YIQI on 2019/5/10.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZModel.h"
#import "HUZListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HUZCommonSenseDataListModel : NSObject

@property (nonatomic,strong) NSString *Id;
@property (nonatomic,strong) NSString *title;  /// 标题
@property (nonatomic,strong) NSString *content; /// 内容

@end

@interface HUZCommonSenseDataModel : HUZListModel

@property (nonatomic,strong) NSArray<HUZCommonSenseDataListModel *> *list;

@end

@interface HUZCommonSenseModel : HUZModel

@property (nonatomic,strong) HUZCommonSenseDataModel *data;

@end

NS_ASSUME_NONNULL_END
