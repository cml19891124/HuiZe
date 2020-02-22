//
//  HUZHomeServiceCell.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/18.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZHomeServiceCell.h"

#define WIDTH  (HUZSCREEN_WIDTH - 45)/2.0
#define HEIGHT WIDTH * 0.455

@implementation HUZHomeServiceCell

+ (instancetype)cellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style{
    static NSString *ID = @"HUZHomeServiceCell";
    HUZHomeServiceCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[self alloc] initWithStyle:style reuseIdentifier:ID];
    }
    return cell;
}

+ (CGFloat)calculateHeightWithEntity:(id)entity{
    return HEIGHT + 32;
}

- (void)initView{
    
    _serviceView1 = [[HUZServiceView alloc] initWithFrame:CGRectZero];
    _serviceView1.ivBg.image = ImageNamed(@"iv_service1");
    _serviceView1.labContent.text = @"新高考";
    _serviceView1.labDes.text = @"新高考选课";
    _serviceView1.ivLogo.image = ImageNamed(@"ic_new_gk");
    
    _serviceView2 = [[HUZServiceView alloc] initWithFrame:CGRectZero];
    _serviceView2.ivBg.image = ImageNamed(@"iv_service2");
    _serviceView2.labContent.text = @"服务";
    _serviceView2.labDes.text = @"专家一对一";
    _serviceView2.ivLogo.image = ImageNamed(@"ic_service_oto");
    
    _serviceView3 = [[HUZServiceView alloc] initWithFrame:CGRectZero];
    _serviceView3.ivBg.image = ImageNamed(@"iv_service1");
    _serviceView3.labTitle.text = @"高考来袭!";
    
    _serviceView4 = [[HUZServiceView alloc] initWithFrame:CGRectZero];
    _serviceView4.ivBg.image = ImageNamed(@"iv_service2");
    _serviceView4.labTitle.text = @"高考来袭!";
    
    [self.contentView addSubview:_serviceView1];
    [self.contentView addSubview:_serviceView2];
    [self.contentView addSubview:_serviceView3];
    [self.contentView addSubview:_serviceView4];
    
    [_serviceView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.left.mas_offset(15);
        make.size.mas_equalTo(CGSizeMake(WIDTH, HEIGHT));
    }];
    
    [_serviceView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.right.mas_offset(-15);
        make.size.mas_equalTo(CGSizeMake(WIDTH, HEIGHT));
    }];
    
    [_serviceView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.left.mas_offset(15);
        make.size.mas_equalTo(CGSizeMake(WIDTH, HEIGHT));
    }];
    
    [_serviceView4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.right.mas_offset(-15);
        make.size.mas_equalTo(CGSizeMake(WIDTH, HEIGHT));
    }];
}

- (void)setType:(HUZHomeServiceCellType)type{
    if (type == HUZHomeServiceFunctionType) {
        _serviceView1.hidden = NO;
        _serviceView2.hidden = NO;
        _serviceView3.hidden = YES;
        _serviceView4.hidden = YES;
    }else{
        _serviceView1.hidden = YES;
        _serviceView2.hidden = YES;
        _serviceView3.hidden = NO;
        _serviceView4.hidden = NO;
    }
}

@end
