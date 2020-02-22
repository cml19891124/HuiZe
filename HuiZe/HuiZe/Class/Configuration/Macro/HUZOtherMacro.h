//
//  HUZOtherMacro.h
//  HuiZe
//
//  Created by ZXS Coder on 2019/3/28.
//  Copyright © 2019 yiqi. All rights reserved.
//

#ifndef HUZOtherMacro_h
#define HUZOtherMacro_h

// 其他
#define HUZWEAK_SELF __weak typeof(self) weakSelf = self;
#define HUZSTRONG_SELF __strong typeof(weakSelf) strongSelf = weakSelf;

//单例化一个类
#define SINGLETON_FOR_HEADER(className) \
\
+ (className *)shared##className;

#define SINGLETON_FOR_CLASS(className) \
\
+ (className *)shared##className { \
static className *shared##className = nil; \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
shared##className = [[self alloc] init]; \
}); \
return shared##className; \
}

//发送通知
#define KPostNotification(name,obj) [[NSNotificationCenter defaultCenter] postNotificationName:name object:obj];
#define KNotificationCenter [NSNotificationCenter defaultCenter]

/// 通知key
#define LikeSuccess @"likeSuccess"


#endif /* HUZOtherMacro_h */
