//
//  HUZPushUpWindow.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/22.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZPushUpWindow.h"
#import "HUZPushUpWindowCell.h"

static float anmiateT = 0.3;

@interface HUZPushUpWindow ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UIView *ivLayer;
@property (nonatomic,strong) UIView *ivBg;
@property (nonatomic,strong) UIView *ivBlue;
@property (nonatomic,strong) UILabel *labTitle;
@property (nonatomic,strong) UITableView *tableView;

@end

@implementation HUZPushUpWindow

- (void)initView{
    self.userInteractionEnabled = YES;
    
    self.ivLayer = [UIView new];
    self.ivLayer.backgroundColor = ColorS(COLOR_000000);
    self.ivLayer.alpha = 0.4;
    self.ivLayer.frame = CGRectMake(0, 0, HUZSCREEN_WIDTH, HUZSCREEN_HEIGHT);
    self.ivLayer.userInteractionEnabled = YES;
    
    self.ivBg = [[UIView alloc] initWithFrame:CGRectMake(0, HUZSCREEN_HEIGHT, HUZSCREEN_WIDTH, AutoDistance(360))];
    self.ivBg.backgroundColor = COLOR_BG_WHITE;
    [UIView huz_bezierPathWithRoundedRect:self.ivBg];
    
    self.ivBlue = [[UIView alloc] initWithFrame:CGRectMake(AutoDistance(15), AutoDistance(18), AutoDistance(4), AutoDistance(14))];
    self.ivBlue.backgroundColor = ColorS(COLOR_BG_2E86FF);
    
    self.labTitle = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_15)];
    self.labTitle.frame = CGRectMake(AutoDistance(27), AutoDistance(15), AutoDistance(150), AutoDistance(21));
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.backgroundColor = COLOR_BG_WHITE;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = AutoDistance(44);
    [self.tableView dz_registerCell:[HUZPushUpWindowCell class]];
    [self addSubview:self.tableView];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, HUZSCREEN_WIDTH, AutoDistance(6))];
    headerView.backgroundColor = ColorS(COLOR_BG_F6F6F6);
    self.tableView.tableHeaderView = headerView;
    self.tableView.frame = CGRectMake(0, AutoDistance(50), HUZSCREEN_WIDTH, AutoDistance(310));

    [self addSubview:self.ivLayer];
    [self addSubview:self.ivBg];
    [self.ivBg addSubview:self.ivBlue];
    [self.ivBg addSubview:self.labTitle];
    [self.ivBg addSubview:self.tableView];
    
    

    [self.ivLayer addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss)]];
}

#pragma mark - tableview
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HUZPushUpWindowCell *cell = [HUZPushUpWindowCell cellWithTableView:tableView];
    [cell reloadData:self.datas[indexPath.row]];
    if (self.type == HUZPushUpWindowProvince) {
        cell.ivSelect.hidden = [cell.labContent.text isEqualToString:self.province] ? NO : YES;
    }else{
        cell.ivSelect.hidden = [cell.labContent.text isEqualToString:self.year] ? NO : YES;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.type == HUZPushUpWindowProvince) {
        self.province = self.datas[indexPath.row];
        self.pushUpWindowBlock(self.province);
    }else{
        self.year = self.datas[indexPath.row];
        self.pushUpWindowBlock(self.year);
    }
    [self.tableView reloadData];
    [self dismiss];
}


/// show
- (void)showPushUpWindowType:(HUZPushUpWindowType)type withData:(NSArray *)data selectStr:(nonnull NSString *)selectStr{
    self.type = type;
    self.datas = data;
    
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
    [self setFrame:CGRectMake(0, 0, HUZSCREEN_WIDTH, HUZSCREEN_HEIGHT)];
    /// 省份
    if (type == HUZPushUpWindowProvince) {
        self.labTitle.text = @"选中您所在的省份";
        self.province = DRStringIsNotEmpty(selectStr) ? selectStr : self.datas[0];
        [UIView animateWithDuration:anmiateT animations:^{
            [self showProvinceFrame];
        }];
    }
    
    /// 年份
    else{
        self.labTitle.text = @"请选择高考年份";
        self.year = DRStringIsNotEmpty(selectStr) ? selectStr : @"";
        [UIView animateWithDuration:anmiateT animations:^{
            [self showYearFrame];
        }];
    }
    
    [self.tableView reloadData];
}

- (void)dismiss{
    if (self.type == HUZPushUpWindowProvince) {
        [UIView animateWithDuration:anmiateT animations:^{
            [self dismissProvinceFrame];
        } completion:^(BOOL finished) {
            if (finished) {
                [self removeFromSuperview];
            }
        }];
    }else{
        [UIView animateWithDuration:anmiateT animations:^{
            [self dismissYearFrame];
        } completion:^(BOOL finished) {
            if (finished) {
                [self removeFromSuperview];
            }
        }];
    }
}


/// 省份
- (void)showProvinceFrame{
    [self.ivBg setFrame:CGRectMake(0, HUZSCREEN_HEIGHT-AutoDistance(360), HUZSCREEN_WIDTH, AutoDistance(360))];
    self.tableView.frame = CGRectMake(0, AutoDistance(50), HUZSCREEN_WIDTH, AutoDistance(310));
}

- (void)dismissProvinceFrame{
    [self.ivBg setFrame:CGRectMake(0, HUZSCREEN_HEIGHT, HUZSCREEN_WIDTH, AutoDistance(360))];
}

/// 年份
- (void)showYearFrame{
    [self.ivBg setFrame:CGRectMake(0, HUZSCREEN_HEIGHT-AutoDistance(192), HUZSCREEN_WIDTH, AutoDistance(192))];
    self.tableView.frame = CGRectMake(0, AutoDistance(50), HUZSCREEN_WIDTH, AutoDistance(142));
}

- (void)dismissYearFrame{
    [self.ivBg setFrame:CGRectMake(0, HUZSCREEN_HEIGHT, HUZSCREEN_WIDTH, AutoDistance(142))];
}

@end
