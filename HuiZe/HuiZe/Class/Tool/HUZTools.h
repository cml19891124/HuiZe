//
//  HUZTools.h
//  HuiZe
//
//  Created by mac on 2019/5/7.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HUZTools : NSObject

+ (void)gotologin;
+ (void)gotohell;
+(void)huzCallPhone:(NSString*)phone;
/**
 手机号码验证
 
 @return bool
 */
+ (NSString *)isCheckPhone:(NSString *)phone;

/**
 密码验证

 @return bool
 */
+ (NSString *)isCheckPassword:(NSString *)psw;
/**
 XXXX年XX月XX日 转 XXXX-XX-XX
 
 @return XXXX-XX-XX
 */
+ (NSString *)transformDate:(NSString *)date;

/**
 XXXX-XX-XX 转 XXXX年XX月XX日
 
 @return XXXX-XX-XX
 */
+ (NSString *)conversionDate:(NSString *)date;

#pragma mark - 将某个时间戳转化成 时间
+ (NSString *)timestampSwitchTime:(NSInteger)timestamp andFormatter:(NSString *)format;

@end

NS_ASSUME_NONNULL_END
