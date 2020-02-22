//
//  HUZTools.m
//  HuiZe
//
//  Created by mac on 2019/5/7.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZTools.h"
#import "HUZNavigationController.h"

@implementation HUZTools

+ (void)gotologin {
    UIWindow *keyWin = [UIApplication sharedApplication].keyWindow;
    keyWin.rootViewController = [[HUZNavigationController alloc]initWithRootViewController:[[NSClassFromString(@"HUZLoginViewController") alloc] init]];
    // 转场动画
    CATransition *transtition = [CATransition animation];
    transtition.duration = 0.5;
    transtition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [[UIApplication sharedApplication].keyWindow.layer addAnimation:transtition forKey:@"animation"];

}
+ (void)gotohell {
    UIWindow *keyWin = [UIApplication sharedApplication].keyWindow;
    keyWin.rootViewController = [[NSClassFromString(@"HUZTabBarController") alloc] init];
    // 转场动画
    CATransition *transtition = [CATransition animation];
    transtition.duration = 0.5;
    transtition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [[UIApplication sharedApplication].keyWindow.layer addAnimation:transtition forKey:@"animation"];
}

+(void)huzCallPhone:(NSString*)phone {
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",phone];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}

/**
 手机号码验证
 
 @return bool
 */
+ (NSString *)isCheckPhone:(NSString *)phone;
{
    if (DRStringIsEmpty(phone)) {
        return @"请输入手机号码";
    }
    if (![HUZInsureValidate validateMobile:[HUZInsureValidate deleteWhiteSpaceInStr:phone]] || [HUZInsureValidate deleteWhiteSpaceInStr:phone].length != 11) {
        return @"请输入正确的手机号码";
    }
    return @"";
}

+ (NSString *)isCheckPassword:(NSString *)psw {
    if (DRStringIsEmpty(psw)) {
        return @"请输入密码";
    }
    if (![HUZInsureValidate validatePassWordLegal:[HUZInsureValidate deleteWhiteSpaceInStr:psw]]) {
        return @"请输入6-8位同时包含数字和大小写字母的密码";
    }
    return @"";
}
/**
 XXXX年XX月XX日 转 XXXX-XX-XX
 
 @return XXXX-XX-XX
 */
+ (NSString *)transformDate:(NSString *)date {
    date = [date stringByReplacingOccurrencesOfString:@"日" withString:@""];
    date = [date stringByReplacingOccurrencesOfString:@"月" withString:@"-"];
    date = [date stringByReplacingOccurrencesOfString:@"年" withString:@"-"];
    return date;
}

/**
 XXXX-XX-XX 转 XXXX年XX月XX日
 
 @return XXXX年XX月XX日
 */
+ (NSString *)conversionDate:(NSString *)date {
    date = [date stringByReplacingCharactersInRange:NSMakeRange(4, 1) withString:@"年"];
    date = [date stringByReplacingCharactersInRange:NSMakeRange(7, 1) withString:@"月"];
    //    date = [date stringByReplacingOccurrencesOfString:@"-" withString:@"年"];
    //    date = [date stringByReplacingOccurrencesOfString:@"-" withString:@"月"];
    date = [date stringByAppendingString:@"日"];
    return date;
}

#pragma mark - 将某个时间戳转化成 时间
+ (NSString *)timestampSwitchTime:(NSInteger)timestamp andFormatter:(NSString *)format{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:format]; // （@"YYYY-MM-dd hh:mm:ss"）----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timestamp];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    
    return confromTimespStr;
    
}
@end
