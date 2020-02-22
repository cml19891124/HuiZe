//
//  HUZKernelDataItemView.h
//  HuiZe
//
//  Created by  YIQI on 2019/4/22.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZView.h"

typedef NS_ENUM(NSInteger,HUZKernelDataItemType){
    HUZKernelDataItemTypeOne = 1,
    HUZKernelDataItemTypeTwo,
};

NS_ASSUME_NONNULL_BEGIN

@interface HUZKernelDataItemView : HUZView

@property (nonatomic,strong) UIImageView *ivGk;
@property (nonatomic,strong) UILabel *labGkInfo;
@property (nonatomic,strong) UILabel *labScoreLine;
@property (nonatomic,strong) UILabel *labCenter;
@property (nonatomic,strong) UIButton *btnYear;
@property (nonatomic,strong) UILabel *labScore;
@property (nonatomic,strong) UILabel *labScoreDes;
@property (nonatomic,strong) UILabel *labNum;
@property (nonatomic,strong) UILabel *labNumDes;
@property (nonatomic,strong) UILabel *labTotalNum;
@property (nonatomic,strong) UILabel *labTotalNumDes;

@property (nonatomic,assign) HUZKernelDataItemType type;


@end

NS_ASSUME_NONNULL_END
