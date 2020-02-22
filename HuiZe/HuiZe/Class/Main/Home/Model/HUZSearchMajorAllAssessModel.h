//
//  HUZSearchMajorAllAssessModel.h
//  HuiZe
//
//  Created by tbb on 2019/11/13.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HUZSearchMajorAllAssessChildModel : NSObject
@property (nonatomic, copy) NSString *Id;
@property (nonatomic, copy) NSString *category;
@property (nonatomic, copy) NSString *parentId;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, assign) NSInteger xkcode;
@end

@interface HUZSearchMajorAllAssessModel : NSObject
@property (nonatomic, copy) NSString *Id;
@property (nonatomic, copy) NSString *category;
@property (nonatomic, copy) NSString *parentId;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, assign) NSInteger xkcode;

@property (nonatomic, strong) NSArray <HUZSearchMajorAllAssessChildModel *> *child;

@property (nonatomic, assign) BOOL isOpen;

@end
NS_ASSUME_NONNULL_END

