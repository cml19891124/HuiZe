//
//  HUZInsureValidate.h
//  HuiZe
//
//  Created by mac on 2019/5/7.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HUZInsureValidate : NSObject
// 获取高考日期
+ (NSString *)getGkTimeStamp;

//距离当前时间戳
+ (NSString *)timestamp:(NSString *)time1;

//当前时间戳
+ (NSString *)getNowTimeTimestamp;

//当前时间 -- 年月日
+ (NSString*)getCurrentTimes;

//当前时间 -- 年月日时分
+ (NSString*)getCurrentDetailTimes;

//验证身份证的长度字符以及出生日期的合法性
+ (NSString *)validateCertificate:(NSString *)certificateNo;

//根据身份证号获取生日
+ (NSString *)getBirthdayFromCertificate:(NSString *)certificateNo;

//验证邮箱是否合法
+ (BOOL) validateEmail:(NSString *)email;

//验证手机号码的合法性
+ (BOOL) validateMobile:(NSString *)mobile;

//用户名
+ (BOOL) validateUserName:(NSString *)name;

//验证姓名为2-10汉字
+ (BOOL)validateChinese:(NSString *)name;

//验证密码 同时包含6~8位数字和大小写字母，不包含特殊字符的判断方法
+ (BOOL)validatePassWordLegal:(NSString *)pass;

//从今天起往后推month个月day天
+ (NSDate *)todayAfterSeveralMonths:(NSInteger)months andDays:(NSInteger)days;

//从今天往后推day天
+ (NSDate *)todayAfterSeveralDays:(NSInteger)days;

//根据时间戳获取距离现在的状态(刚刚,分钟前,今天,昨天)
+ (NSString *)distanceTimeWithBeforeTime:(double)beTime;

//校验输入的是正数（包含小数）
+ (BOOL)vlidateNumber:(NSString *)number;

//textfield输入字符串加入空格
+ (NSString *)addWhiteSpaceInStr:(NSString *)text responString:(NSString *)string range:(NSRange)range index:(int)index;
+ (NSString *)addWhiteSpaceInStr:(NSString *)text responString:(NSString *)string range:(NSRange)range index:(int)index index1:(int)index1;

//时间转换
+ (NSString *)timeInStr:(NSString *)string;
+ (NSString *)timeOutStr:(NSString *)string;
//10分钟前
+ (NSString *)timeTenStr:(NSString *)string;
//比较两个日期的大小
+ (NSString *)compareDate:(NSString*)aDate withDate:(NSString*)bDate;

//去除字符串空白部分
+ (NSString *)deleteWhiteSpaceInStr:(NSString *)string;

//校验正整数
+ (BOOL)validateUnsignInteger:(NSString *)number;

//校验正整数
+ (BOOL)validateInteger:(NSString *)number;

//手机号隐位处理
+ (NSString *)phonenum:(NSString *)phone;

//邮箱隐位处理
+ (NSString *)email:(NSString *)email;

//身份证隐位处理
+ (NSString *)idCard:(NSString *)idCard;

//姓名隐位处理
+ (NSString *)name:(NSString *)name;

//手机号码加空格
+ (NSString *)addWhiteSpaceInStrForPhoneNumber:(NSString *)phoneNumer;

//去除特殊字符（去除加号）
+ (NSString *)deleteSpecialStr:(NSString *)string;

//去除特殊字符（去除分割杠）
+ (NSString *)deleteSpecialStr1:(NSString *)string;

//手机通讯录过滤
+ (NSString *)checkMobilePhoneWithStr:(NSString *)phoneStr;

//获取钥匙串设备号
//需要用到SFHFkeychainUtils第三方
//+ (NSString *)keychainDevice;

+ (BOOL)validateZipCode:(NSString *)zipCode;

//身份证验证
+ (BOOL)validateIDCardNumber:(NSString *)value;


+ (NSString*)getCurrentTimesTwo;
@end

NS_ASSUME_NONNULL_END
