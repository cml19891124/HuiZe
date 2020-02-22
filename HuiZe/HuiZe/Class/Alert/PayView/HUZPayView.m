//
//  HUZPayView.m
//  HuiZe
//
//  Created by  YIQI on 2019/5/6.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZPayView.h"
#import "HUZPayViewCell.h"

static float anmiateT = 0.3;


@interface HUZPayView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UIView *ivLayer;
@property (nonatomic,strong) UIView *ivBg;
@property (nonatomic,strong) UIView *ivBlue;
@property (nonatomic,strong) UILabel *labTitle;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UILabel *labPrice;
@property (nonatomic,strong) UIButton *btnPay;

@property (nonatomic,strong) NSArray *datas;
@property (nonatomic,strong) NSIndexPath *indexPath;
@end

@implementation HUZPayView

- (void)initView{
    
    self.datas = @[@{@"icon":@"ic_wechat_pay",@"name":@"微信支付"},@{@"icon":@"ic_ali_pay",@"name":@"支付宝付款"}];
    self.indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    
    self.ivLayer = [UIView new];
    self.ivLayer.backgroundColor = ColorS(COLOR_000000);
    self.ivLayer.alpha = 0.4;
    self.ivLayer.frame = CGRectMake(0, 0, HUZSCREEN_WIDTH, HUZSCREEN_HEIGHT);
    self.ivLayer.userInteractionEnabled = YES;
    
    self.ivBg = [[UIView alloc] initWithFrame:CGRectMake(0, HUZSCREEN_HEIGHT, HUZSCREEN_WIDTH, AutoDistance(344))];
    self.ivBg.backgroundColor = COLOR_BG_WHITE;
    [UIView huz_bezierPathWithRoundedRect:self.ivBg];
    
    self.ivBlue = [[UIView alloc] initWithFrame:CGRectMake(AutoDistance(15), AutoDistance(18), AutoDistance(4), AutoDistance(14))];
    self.ivBlue.backgroundColor = ColorS(COLOR_BG_2E86FF);
    
    self.labTitle = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_15)];
    self.labTitle.frame = CGRectMake(AutoDistance(27), AutoDistance(15), AutoDistance(150), AutoDistance(21));
    self.labTitle.text = @"确认付款";
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, AutoDistance(50), HUZSCREEN_WIDTH, AutoDistance(294)) style:UITableViewStylePlain];
    self.tableView.backgroundColor = ColorS(COLOR_BG_F6F6F6);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = AutoDistance(44);
    self.tableView.bounces = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:self.tableView];
    [self.tableView dz_registerCell:[HUZPayViewCell class]];
    
    [self addSubview:self.ivLayer];
    [self addSubview:self.ivBg];
    [self.ivBg addSubview:self.ivBlue];
    [self.ivBg addSubview:self.labTitle];
    [self.ivBg addSubview:self.tableView];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, HUZSCREEN_WIDTH, AutoDistance(62))];
    self.labPrice = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_24) textAlignment:NSTextAlignmentCenter];
    self.labPrice.frame = CGRectMake((HUZSCREEN_WIDTH-AutoDistance(150))/2.0, AutoDistance(18), AutoDistance(150), AutoDistance(33));
    [headerView addSubview:self.labPrice];
    self.tableView.tableHeaderView = headerView;
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, HUZSCREEN_WIDTH, AutoDistance(140))];
    self.btnPay = [[UIButton alloc] initWithTitle:@"确认付款" textColor:ColorS(COLOR_ffffff) autoTextFont:FontS(FONT_17)];
    self.btnPay.backgroundColor = ColorS(COLOR_BG_2E86FF);
    self.btnPay.frame = CGRectMake(AutoDistance(15), AutoDistance(64), HUZSCREEN_WIDTH-AutoDistance(30), AutoDistance(44));
    ViewRadius(self.btnPay, AutoDistance(22));
    [footerView addSubview:self.btnPay];
    self.tableView.tableFooterView = footerView;
    
    [self.ivLayer addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss)]];

    [self.btnPay addTarget:self action:@selector(payClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)payClick{
    if (self.payBlock) {
        self.payBlock(self.indexPath.row == 0 ? @"wechat" : @"ali");
    }
    [self dismiss];
}

#pragma mark - tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HUZPayViewCell *cell = [HUZPayViewCell cellWithTableView:tableView];
    [cell reloadData:self.datas[indexPath.row]];
    cell.ivSelect.hidden = indexPath == self.indexPath ? NO : YES;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.indexPath = indexPath;
    [self.tableView reloadData];
    

}

- (void)showWithPrice:(NSString *)price{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
    [self setFrame:CGRectMake(0, 0, HUZSCREEN_WIDTH, HUZSCREEN_HEIGHT)];
    
    self.labPrice.text = price;
    [UIView animateWithDuration:anmiateT animations:^{
        [self.ivBg setFrame:CGRectMake(0, HUZSCREEN_HEIGHT-AutoDistance(344), HUZSCREEN_WIDTH, AutoDistance(344))];
    }];
}

- (void)dismiss{
    [UIView animateWithDuration:anmiateT animations:^{
        [self.ivBg setFrame:CGRectMake(0, HUZSCREEN_HEIGHT, HUZSCREEN_WIDTH, AutoDistance(344))];
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
}


@end
