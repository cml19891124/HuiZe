//
//  HUZUniRankingListModel.h
//  HuiZe
//
//  Created by tbb on 2019/9/2.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HUZUniInfoGeneralizeModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface HUZUniRankingListModel : NSObject
@property (nonatomic, copy) NSString * Id;
@property (nonatomic, copy) NSString * schoolId;
@property (nonatomic, copy) NSString * schoolName;

@property (nonatomic, copy) NSString * qsRanking;
@property (nonatomic, copy) NSString * reasonRanking;
@property (nonatomic, copy) NSString * chinaRanking;
@property (nonatomic, copy) NSString * cultureRanking;
@property (nonatomic, copy) NSString * usRanking;
@property (nonatomic, copy) NSString * wslRanking;

@property (nonatomic, strong) HUZUniInfoGeneralizeDataModel * universityEntity;
@end

NS_ASSUME_NONNULL_END
