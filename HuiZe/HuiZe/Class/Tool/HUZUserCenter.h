//
//  HUZUserCenter.h
//  HuiZe
//
//  Created by  YIQI on 2019/4/20.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HUZUser.h"

NS_ASSUME_NONNULL_BEGIN

@interface HUZUserCenter : NSObject

/// 搜索记录
@property (nonatomic,strong) NSMutableArray *searchHistory;

+ (instancetype)shareUserCenter;

- (void)saveToCache;
- (BOOL)isLogin;
- (void)logout;

@property (nonatomic,copy)NSString *gkInfo; // 高考信息
@property (nonatomic,copy)NSString *mobile; // 手机号
@property (nonatomic,readwrite,retain) HUZUser *userModel;


@end

NS_ASSUME_NONNULL_END
