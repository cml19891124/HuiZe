//
//  HUZSchoolListDataModel.m
//  HuiZe
//
//  Created by caominglei on 2019/6/4.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZSchoolListDataModel.h"

@implementation HUZSchoolListDataModel

@end

@implementation HUZSchoolListModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"list" : [HUZSchoolModel class]};
}



@end

@implementation HUZSchoolModel

//+ (NSDictionary *)modelContainerPropertyGenericClass {
//    return @{@"major" : [HUZInMajorModel class]};
//}
-(void)setMajor:(NSArray<HUZUniInfoGeneralizeMajorModel *> *)major {
    _major = major;
    CGFloat showMajorContentTotalH = 0.0;
    for (NSInteger i = 0; i < major.count; i++) {
        HUZUniInfoGeneralizeMajorModel *majorModel = major[i];
        NSString *showStr = [NSString stringWithFormat:@"%zd.%@",(i+1),majorModel.majIntroduce];
        majorModel.showMajIntroduce = showStr;
        showMajorContentTotalH += majorModel.showMajIntroduceAttributedH;
    }
    self.showMajorContentH = showMajorContentTotalH;

}

//-(CGFloat)showMajorContentH {
//    if (_showMajorContentH) {
//
//    }
//    return _showMajorContentH;
//}
@end

//@implementation HUZInMajorModel
//
//@end
