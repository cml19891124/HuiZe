//
//  HUZUserCenter.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/20.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZUserCenter.h"
#import "YYCache.h"

static NSString *seachHistory = @"searchHistory";
static NSString *user = @"user";
static NSString *mobile = @"mobile";

@implementation HUZUserCenter

+ (instancetype)shareUserCenter{
    static HUZUserCenter *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
        NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *path = [documentPath stringByAppendingPathComponent:@"UserInfo"];
        YYCache *yyCache = [YYCache cacheWithPath:path];
        
        instance.searchHistory = (NSMutableArray *)[yyCache objectForKey:seachHistory];
        instance.userModel = (HUZUser *)[yyCache objectForKey:user];
        instance.mobile = (NSString*)[yyCache objectForKey:mobile];

        NSString *gradeStr = @"理科"; // 文理科：0文教，1理科 ,
        if ([instance.userModel.grade integerValue] == 0) {
            gradeStr = @"文科";
        }
        NSString *proviceName = DRStringIsNotEmpty(instance.userModel.provinceName)?[NSString stringWithFormat:@"%@",instance.userModel.provinceName]:@"";
        NSString *estimateScore = DRStringIsNotEmpty(instance.userModel.estimateScore)?instance.userModel.estimateScore:@"";
        instance.gkInfo = [NSString stringWithFormat:@"%@、%@、%@分", proviceName, gradeStr, estimateScore];
    });
    return instance;
}

- (BOOL)isLogin{
    return DRStringIsEmpty(HUZUserCenterManager.userModel.token) ? NO : YES;
}

- (void)logout{
    _userModel = nil;
    [self saveToCache];
}

- (void)saveToCache{
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [documentPath stringByAppendingPathComponent:@"UserInfo"];
    YYCache *yyCache = [YYCache cacheWithPath:path];
    
    [yyCache setObject:_searchHistory forKey:seachHistory];
    [yyCache setObject:_userModel forKey:user];
    [yyCache setObject:_mobile forKey:mobile];

}

- (NSMutableArray *)searchHistory{
    if (!_searchHistory) {
        _searchHistory = [NSMutableArray new];
    }
    return _searchHistory;
}

@end
