//
//  HUZSearchKeywordModel.m
//  HuiZe
//
//  Created by  YIQI on 2019/5/11.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZSearchKeywordModel.h"

@implementation HUZSearchKeywordDataSubjectModel

@end

@implementation HUZSearchKeywordDataUniDetailModel

@end

@implementation HUZSearchKeywordDataUniModel

@end

@implementation HUZSearchKeywordDataModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"universityEntityList" : [HUZSearchKeywordDataUniModel class],@"subjectEntities":[HUZSearchKeywordDataSubjectModel class]};
}
@end

@implementation HUZSearchKeywordModel

@end
