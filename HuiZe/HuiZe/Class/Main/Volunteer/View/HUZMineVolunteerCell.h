//
//  HUZMineVolunteerCell.h
//  HuiZe
//
//  Created by mac on 2019/4/29.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "KSSideslipCell.h"
@class HUZVolunteer;

NS_ASSUME_NONNULL_BEGIN

@interface HUZMineVolunteerCell : KSSideslipCell
@property (nonatomic,strong) UIImageView *ivLogo;
@property (nonatomic,strong) UILabel *labTitle;
@property (nonatomic,strong) UILabel *labSubj;
@property (nonatomic,strong) UILabel *labType;
@property (nonatomic,strong) UILabel *labDate;
@property (nonatomic,strong) HUZVolunteer *model;
+ (instancetype)cellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style;
@end

NS_ASSUME_NONNULL_END
