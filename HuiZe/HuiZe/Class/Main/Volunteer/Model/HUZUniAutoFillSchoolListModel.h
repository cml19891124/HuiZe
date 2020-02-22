//
//  HUZUniAutoFillSchoolListModel.h
//  HuiZe
//
//  Created by tbb on 2019/11/21.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HUZUniAutoFillSchoolMajorListModel : NSObject
@property (nonatomic, copy) NSString * batch;
@property (nonatomic, copy) NSString * Id;
@property (nonatomic, copy) NSString * majIntroduce;
@property (nonatomic, copy) NSString * majorAllId;
@property (nonatomic, copy) NSString * schoolName;
@property (nonatomic, copy) NSString * schoolId;
@property (nonatomic, copy) NSString * year;
@property (nonatomic, copy) NSString * subjectId;
@property (nonatomic, copy) NSString * schoolYear;
@end

@interface HUZUniAutoFillSchoolListModel : NSObject
@property (nonatomic, copy) NSString * admissionOdds;
@property (nonatomic, copy) NSString * Id;
@property (nonatomic, copy) NSString * logoUrl;
@property (nonatomic, copy) NSString * minRanking;
@property (nonatomic, copy) NSString * minScore;
@property (nonatomic, copy) NSString * planNum;
@property (nonatomic, copy) NSString * provinceScore;
@property (nonatomic, copy) NSString * schoolId;
@property (nonatomic, copy) NSString * uniCity;
@property (nonatomic, copy) NSString * yuanxiaomingcheng;

@property (nonatomic, strong) NSArray <HUZUniAutoFillSchoolMajorListModel *> * majorList;
@end

NS_ASSUME_NONNULL_END
