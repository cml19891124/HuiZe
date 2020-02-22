//
//  HUZGradeDetailProfessView.h
//  HuiZe
//
//  Created by mac on 2019/4/26.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZView.h"
#import "HUZGradeAnalyzeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HUZGradeDetailProfessView : HUZView <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,strong) UILabel *labTop;
@property (nonatomic,strong) UITableView *ptableview;
@property (nonatomic,strong) NSMutableArray *datas;

@property (nonatomic,strong) HUZGradeAnalyzeModel *model;

@end

NS_ASSUME_NONNULL_END
