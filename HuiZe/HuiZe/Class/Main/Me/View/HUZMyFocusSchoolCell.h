//
//  HUZMyFocusSchoolCell.h
//  HuiZe
//
//  Created by  YIQI on 2019/5/5.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "KSSideslipCell.h"
#import "HUZFocusSchoolModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HUZMyFocusSchoolCell : KSSideslipCell

+ (instancetype)cellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style;


@property (strong, nonatomic) HUZFocusSchoolDataListModel *model;

@end

NS_ASSUME_NONNULL_END
