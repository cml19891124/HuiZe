//
//  HUZUniFillCell.h
//  HuiZe
//
//  Created by mac on 2019/4/29.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZTableViewCell.h"

#import "HUZSchoolListDataModel.h"

#import "HUZPacketVolModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^AddBlock)(NSIndexPath *indexPath);

typedef void(^DeleteBlock)(void);

@interface HUZUniFillCell : HUZTableViewCell
@property (nonatomic,strong) UILabel *iLab;
@property (nonatomic,strong) UIImageView *ivLogo;
@property (nonatomic,strong) UILabel *labSchool;
@property (nonatomic,strong) UILabel *labCity;

@property (strong, nonatomic) UIView *majorView;

@property (nonatomic,strong) UILabel *labDes1;
@property (nonatomic,strong) UILabel *labDes2;
@property (nonatomic,strong) UILabel *labDes3;
@property (nonatomic,strong) UILabel *labDes4;
@property (nonatomic,strong) UILabel *labDes5;
@property (nonatomic,strong) UILabel *labDes6;
@property (nonatomic,strong) UIButton *dBtn;
@property (nonatomic,strong) UIButton *btnContinue;
@property (nonatomic,strong) UIButton *btnAdd;
@property (nonatomic,copy) AddBlock addBlock;

@property (nonatomic,copy) DeleteBlock deleteBlock;

@property (strong, nonatomic) HUZSchoolModel *model;

@property (strong, nonatomic) HUZSubjectVoListModel *majorModel;

@property (nonatomic, strong) NSIndexPath * indexPath;
@end

NS_ASSUME_NONNULL_END
