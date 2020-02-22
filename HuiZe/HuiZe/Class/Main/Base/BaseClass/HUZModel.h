//
//  HUZModel.h
//  HuiZe
//
//  Created by  YIQI on 2019/4/26.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HUZModel : NSObject

@property (nonatomic,assign) int code;
@property (nonatomic,strong) NSString *msg;

/// 请求成功
- (BOOL)isSuccess;
@end

NS_ASSUME_NONNULL_END
