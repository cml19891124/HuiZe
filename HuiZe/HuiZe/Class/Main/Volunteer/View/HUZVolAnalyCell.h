//
//  HUZVolAnalyCell.h
//  HuiZe
//
//  Created by mac on 2019/5/5.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZTableViewCell.h"

#import "HUZIntelligenceFormDataModel.h"

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger, VolAnalyType) {
    VolAnalyTypeOne = 0,
    VolAnalyTypeTwo,
    VolAnalyTypeThree,
};

@interface HUZVolAnalyCell : HUZTableViewCell
@property (nonatomic,strong) UILabel  *tlab;
@property (nonatomic,strong) UIButton *fBtn;
@property (nonatomic,strong) UIButton *sBtn;
@property (nonatomic,strong) UIButton *tBtn;

- (void)setVolAnalyTpyeWith:(VolAnalyType)type andTitle:(NSString *)title andArray:(NSArray*)array;
@end

NS_ASSUME_NONNULL_END
