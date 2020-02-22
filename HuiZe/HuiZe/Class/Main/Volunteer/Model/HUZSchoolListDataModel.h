//
//  HUZSchoolListDataModel.h
//  HuiZe
//
//  Created by caominglei on 2019/6/4.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZModel.h"

@class HUZSchoolListModel,HUZSchoolModel,HUZMajorModel;

NS_ASSUME_NONNULL_BEGIN

@interface HUZSchoolListDataModel : HUZModel

@property (strong, nonatomic) HUZSchoolListModel *data;

@end


@interface HUZSchoolListModel : HUZModel

@property (strong, nonatomic) NSArray <HUZSchoolModel *>*list;

@end

@interface HUZSchoolModel : HUZModel

@property (nonatomic, copy) NSString *logoUrl;

@property (nonatomic, copy) NSString *uniCity;

@property (nonatomic, copy) NSString *batch;

@property (nonatomic, copy) NSString *schoolName;

@property (nonatomic, copy) NSString *schoolId;

@property (strong, nonatomic) NSArray <HUZUniInfoGeneralizeMajorModel *> *major;
@property (nonatomic, assign) CGFloat showMajorContentH;
@end

//@interface HUZInMajorModel : HUZModel
//
//@property (nonatomic, copy) NSString *batch;
//
///**
// 专业id
// */
//@property (nonatomic, copy) NSString *majorAllId;
//
//@property (nonatomic, copy) NSString *schoolId;
//
//@property (nonatomic, copy) NSString *volunteerFormId;
//
///**
// 专业名称
// */
//@property (nonatomic, copy) NSString *category;
//
//
//@end

NS_ASSUME_NONNULL_END
