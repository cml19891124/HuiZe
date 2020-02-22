//
//  HUZMajorInfoModel.h
//  HuiZe
//
//  Created by tbb on 2019/9/6.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HUZMajorInfoModel : NSObject

@property (nonatomic, assign) CGFloat boyProportion;
@property (nonatomic, assign) CGFloat girlProportion;
@property (nonatomic, assign) CGFloat liberalProportion;
@property (nonatomic, assign) CGFloat scienceProportion;
@property (nonatomic, copy) NSString * category;
@property (nonatomic, copy) NSString * majorAllId;
@property (nonatomic, copy) NSString * thisCategory;
@property (nonatomic, copy) NSString * onCategory;
@property (nonatomic, copy) NSString * oneCategory;
@property (nonatomic, copy) NSString * twoCategory;
@property (nonatomic, copy) NSString * majorIntroduce;

@property (nonatomic, copy) NSString * parentId;
@property (nonatomic, copy) NSString * parentName;
@property (nonatomic, copy) NSString * alternative;

@property (nonatomic, assign) BOOL attention;

@property (nonatomic, copy) NSString * specialty;
@property (nonatomic, copy) NSString * subjectNum;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, copy) NSString * undergraduate;
@end

NS_ASSUME_NONNULL_END

