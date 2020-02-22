//
//  NSString+Extensional.m
//  MuYing
//
//  Created by tbb on 2019/7/23.
//  Copyright © 2019 TBB. All rights reserved.
//

#import "NSString+Extensional.h"

@implementation NSString (Extensional)
+(NSString *)classToClassNameStr:(Class)aclass {
    NSString *str = NSStringFromClass(aclass);
    NSArray *arr = [str componentsSeparatedByString:@"."];
    if (arr.count > 1) {
        str = arr.lastObject;
    }
    return str;
}

- (NSString *)removeStringSpace

{
    
    NSString *temp = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    return temp;
    
}


//是否为4位且全大写邀请码
- (BOOL)isValidateInvitationCode
{
    NSString *phoneRegex = @"[A-Z]{4}";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:self];
}
//是否为6位数的手机验证码
- (BOOL)isMobileCode {
    NSString *phoneRegex = @"[0-9]{6}";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:self];
}

//是否符密码规则
-(BOOL)yq_isPassdword {
//    NSString *phoneRegex = @"^[a-zA-Z0-9]\\w{8,20}$";
//    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
//    return [phoneTest evaluateWithObject:self];
    if (self.length < 21 && self.length > 7) {
        return YES;
    }
    return NO;
}

/**
 校验身份证号码是否正确 返回BOOL值
 
 @param idCardString 身份证号码
 @return 返回BOOL值 YES or NO
 */
+ (BOOL)yq_verifyIDCardString:(NSString *)idCardString {
    NSString *regex = @"^[1-9]\\d{5}(18|19|([23]\\d))\\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\\d{3}[0-9Xx]$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    BOOL isRe = [predicate evaluateWithObject:idCardString];
    if (!isRe) {
        //身份证号码格式不对
        return NO;
    }
    //加权因子 7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2
    NSArray *weightingArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
    //校验码 1, 0, 10, 9, 8, 7, 6, 5, 4, 3, 2
    NSArray *verificationArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
    
    NSInteger sum = 0;//保存前17位各自乖以加权因子后的总和
    for (int i = 0; i < weightingArray.count; i++) {//将前17位数字和加权因子相乘的结果相加
        NSString *subStr = [idCardString substringWithRange:NSMakeRange(i, 1)];
        sum += [subStr integerValue] * [weightingArray[i] integerValue];
    }
    
    NSInteger modNum = sum % 11;//总和除以11取余
    NSString *idCardMod = verificationArray[modNum]; //根据余数取出校验码
    NSString *idCardLast = [idCardString.uppercaseString substringFromIndex:17]; //获取身份证最后一位
    
    if (modNum == 2) {//等于2时 idCardMod为10  身份证最后一位用X表示10
        idCardMod = @"X";
    }
    if ([idCardLast isEqualToString:idCardMod]) { //身份证号码验证成功
        return YES;
    } else { //身份证号码验证失败
        return NO;
    }
}
@end
