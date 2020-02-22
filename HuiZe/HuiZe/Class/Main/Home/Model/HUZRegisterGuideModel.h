//
//  HUZRegisterGuideModel.h
//  HuiZe
//
//  Created by  YIQI on 2019/5/10.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HUZRegisterGuideDataModel : NSObject

@property (nonatomic,copy) NSString *Id;
@property (nonatomic,copy) NSString *type;
@property (nonatomic,copy) NSString *title;   /// 标题
@property (nonatomic,copy) NSString *content; ///

@end

@interface HUZRegisterGuideModel : HUZModel

@property (nonatomic,strong) NSArray<HUZRegisterGuideDataModel *> *data;

@end

NS_ASSUME_NONNULL_END
