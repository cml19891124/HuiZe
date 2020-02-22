//
//  HUZUniEnrollmentDataChartModel.h
//  HuiZe
//
//  Created by tbb on 2019/9/5.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HUZUniEnrollmentDataChartScoreModel : NSObject
@property (nonatomic, copy) NSString * year;
@property (nonatomic, copy) NSString * score;
@end

@interface HUZUniEnrollmentDataChartModel : NSObject
@property (nonatomic, strong) NSArray <HUZUniEnrollmentDataChartScoreModel *> * provinceScore;
@property (nonatomic, strong) NSArray <HUZUniEnrollmentDataChartScoreModel *> * admissionScore;
@end

NS_ASSUME_NONNULL_END
