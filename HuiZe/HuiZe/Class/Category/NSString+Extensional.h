//
//  NSString+Extensional.h
//  MuYing
//
//  Created by tbb on 2019/7/23.
//  Copyright © 2019 TBB. All rights reserved.
//



NS_ASSUME_NONNULL_BEGIN

@interface NSString (Extensional)
+(NSString *)classToClassNameStr:(Class)aclass;

- (NSString *)removeStringSpace;


/**
 是否为4位且全大写邀请码
 @return bool
 */
//校验身份证
+ (BOOL)yq_verifyIDCardString:(NSString *)idCardString;
- (BOOL)isValidateInvitationCode;
//是否为6位数的手机验证码
- (BOOL)isMobileCode;
-(BOOL)yq_isPassdword;
@end

NS_ASSUME_NONNULL_END
