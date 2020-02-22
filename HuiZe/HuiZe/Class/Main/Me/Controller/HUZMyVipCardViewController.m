//
//  HUZMyVipCardViewController.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/28.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZMyVipCardViewController.h"
#import "SDCycleScrollView.h"
#import "HUZActivateVipCardViewController.h"
#import "HUZPayView.h"
#import "HUZMyVipCardViewImageCell.h"
#import "HUZMyVipCardPriceModel.h"
#import "HUZMyVipCardViewTypeCollCell.h"
#import "HUZPayManager.h"
#import "HUZUser.h"
#define kITEMSIZEW ((HUZSCREEN_WIDTH - 45) / 2.0)
#define kITEMSIZEH ((HUZSCREEN_WIDTH - 45) / 2.0) * (120 / 165.0)

@interface HUZMyVipCardViewController ()<SDCycleScrollViewDelegate,HUZMyVipCardViewTypeCollCellDelegate>

//@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIView *topView;
@property (nonatomic,strong) SDCycleScrollView *cycleScrollView;
@property (nonatomic,strong) UIView *bottomView;
@property (nonatomic,strong) UIImageView *ivContent;
@property (nonatomic,strong) UIView *payView;
@property (nonatomic,strong) UILabel *labPrice;
@property (nonatomic,strong) UIButton *btnPay;

@property (nonatomic,strong) HUZPayView *payAlertView;

//@property (nonatomic, copy) NSArray * bigImageArr;

@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) UIImage * bgImage;

@property (nonatomic, strong) NSMutableArray * priceTypeArr;

@property (nonatomic, strong) HUZMyVipCardPriceModel * priceModel;
@property (nonatomic,strong) HUZUser *userModel;
@end

@implementation HUZMyVipCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的VIP卡";
#warning mark -- 测试
//    HUZUserCenterManager.userModel.vip = @"3";
//    [[NSNotificationCenter defaultCenter] postNotificationName:HUZVIPUpdate_State_Noti_Key object:HUZUserCenterManager.userModel.vip];
    
    UIAlertController *alterCV = [UIAlertController alertControllerWithTitle:@"" message:@"一、适用对象：普通类文理科考生（提前批次、国家/地方专项计划、自主招生及艺术体育类考生暂不适用）。\n二、适用地区：全国29省市（上海、西藏、香港、澳门、台湾地区暂不适用）。\n三、使用时效：有效期为开通会员之日起至用户选择高考年份的9月1日止。" preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *okBtn = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alterCV addAction:okBtn];
    [self presentViewController:alterCV animated:YES completion:nil];
    
}

- (void)rightButtonTouch{
    HUZActivateVipCardViewController *activateVipCardVC = [HUZActivateVipCardViewController new];
    [self.navigationController pushViewController:activateVipCardVC animated:YES];
}

- (void)configComponents{
    self.userModel = HUZUserCenterManager.userModel;
    self.style = UITableViewStyleGrouped;
    [super configComponents];
//    self.bigImageArr = @[@"vip_grade_info_1_icon",@"vip_grade_info_2_icon",@"vip_grade_info_3_icon"];
    
    self.tableView.backgroundColor = ColorS(COLOR_BG_F6F6F6);
    
    self.topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, HUZSCREEN_WIDTH, (196 / 375.0)*HUZSCREEN_WIDTH)];
    self.topView.backgroundColor = COLOR_BG_WHITE;
    
    [self.tableView setTableHeaderView:self.topView];
    
    _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(AutoDistance(44), AutoDistance(18), HUZSCREEN_WIDTH-88, (158 / 287.0) * (HUZSCREEN_WIDTH-88))
                                                          delegate:self
                                                  placeholderImage:ImageNamed(@"")];
    _cycleScrollView.center = CGPointMake(HUZSCREEN_WIDTH/2.0, (196 / 375.0)*HUZSCREEN_WIDTH/2.0);
    
    if([self.userModel.vip integerValue] == 0) {
        _cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
    }else{
        _cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleNone;
    }
    
//    _cycleScrollView.autoScrollTimeInterval = 5; // 自动滚动时间间隔
    /** 是否无限循环,默认Yes */
    _cycleScrollView.infiniteLoop = NO;
    /** 是否自动滚动,默认Yes */
    _cycleScrollView.autoScroll = NO;
    
    _cycleScrollView.titleLabelBackgroundColor = [UIColor clearColor]; // 图片对应的标题的 背景色。（因为没有设标题）
    [self.topView addSubview:_cycleScrollView];
    ViewRadius(_cycleScrollView, AutoDistance(12));

    self.payView = [[UIView alloc] initWithFrame:CGRectMake(0, HUZSCREEN_HEIGHT-HUZSTATUS_BAR_NAVIGATION_BAR_HEIGHT-AutoDistance(49), HUZSCREEN_WIDTH, AutoDistance(49))];
    self.payView.backgroundColor = ColorS(COLOR_BG_F19147);
    if ([self.userModel.vip integerValue] == 3) {
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self.view);
            make.bottom.mas_equalTo(0);
        }];
    }else{
        [self.view addSubview:self.payView];
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self.view);
            make.bottom.mas_equalTo(AutoDistance(-49));
        }];
    }
    
    
    self.labPrice = [[UILabel alloc] initWithTextColor:ColorS(COLOR_ffffff) autoTextFont:FontS(FONT_17)];
    self.labPrice.frame = CGRectMake(AutoDistance(44), AutoDistance(8), AutoDistance(150), AutoDistance(33));
    self.labPrice.text = @"¥00.00";
    [self.payView addSubview:self.labPrice];
    
    self.btnPay = [[UIButton alloc] initWithTitle:@"点击开通" textColor:ColorS(COLOR_F19147) autoTextFont:FontS(FONT_15)];
    self.btnPay.backgroundColor = COLOR_BG_WHITE;
    self.btnPay.frame = CGRectMake(HUZSCREEN_WIDTH-AutoDistance(140), AutoDistance(9), AutoDistance(96), AutoDistance(32));
    ViewRadius(self.btnPay, AutoDistance(4));
    
    [self.btnPay addTarget:self action:@selector(payClick) forControlEvents:UIControlEventTouchUpInside];
    

    [self.tableView dz_registerNibCell:[HUZMyVipCardViewImageCell class]];
    [self.tableView dz_registerCell:[HUZMyVipCardViewTypeCollCell class]];
    
    if ([self.userModel.vip integerValue] != 3) {
        [self.payView addSubview:self.btnPay];
        [self getPriceTypeData];
    }else{
        HUZMyVipCardPriceModel *model = [[HUZMyVipCardPriceModel alloc] init];
        model.upgradeType = [self.userModel.vip integerValue];
        [self.priceTypeArr addObject:model];
        
        NSMutableArray *headerArr = [NSMutableArray array];
        for (HUZMyVipCardPriceModel *model in self.priceTypeArr) {
            [headerArr addObject:model.headerIcon];
        }
        self.cycleScrollView.localizationImageNamesGroup = headerArr.copy;
        
        self.index = 0;
    }
    
}

-(void)getPriceTypeData{
    [self displayOverFlowActivityView];
    [HUZNetWorkTool huz_GET:kUrl_new_order_pay_getVipPrice parameters:nil success:^(id  _Nonnull responseObject) {
        [self removeOverFlowActivityView];
        NSString *code = [responseObject valueForKey:@"code"];
        if ([code integerValue] == 0) {
            [self removeOverFlowActivityView];
            [self.priceTypeArr removeAllObjects];
            NSArray *arr = [NSArray modelArrayWithClass:[HUZMyVipCardPriceModel class] json:responseObject[@"data"]];
            for (HUZMyVipCardPriceModel *priceModel in arr) {
                if (priceModel.upgradeType != 1) {
                    [self.priceTypeArr addObject:priceModel];
                }
            }

            HUZMyVipCardPriceModel *model = self.priceTypeArr.firstObject;
            self.priceModel = model;
            model.selection = YES;
            
            NSMutableArray *headerArr = [NSMutableArray array];
            for (HUZMyVipCardPriceModel *model in self.priceTypeArr) {
                [headerArr addObject:model.headerIcon];
            }
            
            self.cycleScrollView.localizationImageNamesGroup = headerArr.copy;
            self.index = 0;
            [self.tableView reloadData];
        }else{
            NSString *msg = responseObject[@"msg"];
            [self presentErrorSheet:msg];
        }
    } failure:^(NSUInteger statusCode, NSString * _Nonnull error) {
        [self removeOverFlowActivityView];
        [self presentErrorSheet:error];
    }];
    

//    [HUZNetWorkTool huz_GET:kUrl_new_order_pay_getVipPrice parameters:nil success:^(id  _Nonnull responseObject) {
//
//    } failure:^(NSUInteger statusCode, NSString * _Nonnull error) {
//
//    }];
    
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if ([self.userModel.vip integerValue] == 3) {
        return 1;
    }else{
        return 2;
    }
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if (indexPath.section == 0 && [self.userModel.vip integerValue] != 3) {
        HUZMyVipCardViewTypeCollCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HUZMyVipCardViewTypeCollCell"];
        cell.delegate = self;
        cell.dataArr = self.priceTypeArr;
        return cell;
    }else{
        HUZMyVipCardViewImageCell *imageCell = [tableView dequeueReusableCellWithIdentifier:@"HUZMyVipCardViewImageCell"];
        imageCell.imageView.image = self.bgImage;
        return imageCell;
    }

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0 && [self.userModel.vip integerValue] != 3) {
        NSInteger section = 0;
        NSInteger totale = self.priceTypeArr.count;
        if (totale % 2 == 0) {
            section = totale / 2;
        }else{
            section = totale / 2 + 1;
        }
        return kITEMSIZEH*section + 15 + 16 + 33;
    }else{
        CGSize size = self.bgImage.size;
        CGFloat imageH = size.height;
        return imageH + 48;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 12;
    }
    return 0.001;
}
#pragma mark - UITableViewDelegate, UITableViewDataSource end

/// 点击开通
- (void)payClick{
    [self.payAlertView showWithPrice:[NSString stringWithFormat:@"¥%@",self.priceModel.upgradePrice]];
    HUZWEAK_SELF
    self.payAlertView.payBlock = ^(NSString * _Nonnull payway) {
        [weakSelf goToPayType:payway];
    };
}
//HUZPayManager
-(void)goToPayType:(NSString *)payway {
    NSString *url = [@"wechat" isEqualToString:payway] ? kUrl_pay_wechatpay : kUrl_pay_alipay;
    NSMutableDictionary *par = [NSMutableDictionary dictionary];
    par[@"body"] = @(self.priceModel.upgradeType);
    par[@"payChannel"] = [@"wechat" isEqualToString:payway] ? @"WEPAY" : @"ALIPAY";
    par[@"subject"] = self.priceModel.title;
    par[@"transactionMount"] = self.priceModel.upgradePrice;
    par[@"userUid"] = HUZUserCenterManager.userModel.userId;
    [self displayOverFlowActivityView];
    [HUZNetWorkTool huz_POST:url parameters:par success:^(id  _Nonnull responseObject) {
        NSString *codeStr = responseObject[@"code"];
        
        if ([codeStr integerValue] == 0) {
            HUZPayManager *manager = [HUZPayManager sharedManager];
            if ([@"wechat" isEqualToString:payway]) {
                NSDictionary *dict = responseObject[@"data"][@"data"][@"wxpay_url"];
                [manager wxPayWithPayDict:dict success:^{
                    [self presentErrorSheet:@"支付成功"];
                    [self getUserInfoData];
                } failure:^(NSInteger code) {
                    switch (code) {
                        case 1003:
                            [self presentErrorSheet:@"未安装微信"];
                            break;
                        case 1004:
                            [self presentErrorSheet:@"支付失败"];
                            break;
                        case 1005:
                            [self presentErrorSheet:@"支付取消"];
                            break;
                        default:
                            [self presentErrorSheet:@"支付失败"];
                            break;
                    }
                    
                }];
            }else{
                NSString *alipay_url = responseObject[@"data"][@"data"][@"alipay_url"];
                [manager alipayWithPayParam:alipay_url success:^{
                    [self presentErrorSheet:@"支付成功"];
                    [self getUserInfoData];
                } failure:^(NSInteger code) {
                    switch (code) {
                        case 1102:
                            [self presentErrorSheet:@"支付错误"];
                            break;
                        case 1103:
                            [self presentErrorSheet:@"支付取消"];
                            break;
                        default:
                            [self presentErrorSheet:@"支付失败"];
                            break;
                    }
                }];
            }
        }else{
            NSString *msg = responseObject[@"msg"];
            [self presentErrorSheet:msg];
        }
        [self removeOverFlowActivityView];
    } failure:^(NSUInteger statusCode, NSString * _Nonnull error) {
        [self removeOverFlowActivityView];
        [self presentErrorSheet:error];
    }];
}

#pragma mark - SDCycleScrollViewDelegate
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{}

/** 图片滚动回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index{
    self.index = index;
    HUZMyVipCardViewTypeCollCell *cell = (HUZMyVipCardViewTypeCollCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
    [self.priceTypeArr enumerateObjectsUsingBlock:^(HUZMyVipCardPriceModel  *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (index == idx) {
            self.priceModel = obj;
            obj.selection = YES;
        }else{
            obj.selection = NO;
        }
    }];
    cell.dataArr = self.priceTypeArr;
}
-(void)setIndex:(NSInteger)index {
    _index = index;
    HUZMyVipCardPriceModel *priceModel = nil;
    if (index < self.priceTypeArr.count) {
        priceModel = self.priceTypeArr[index];
    }
    self.bgImage = [UIImage imageNamed:priceModel.bigIcon];
    [self.tableView reloadData];

}
-(void)setPriceModel:(HUZMyVipCardPriceModel *)priceModel {
    _priceModel = priceModel;
    self.labPrice.text = [NSString stringWithFormat:@"¥%@",priceModel.upgradePrice];//@"¥700.00";
}
#pragma mark - Lazy
- (HUZPayView *)payAlertView{
    if (!_payAlertView) {
        _payAlertView = [[HUZPayView alloc] init];
    }
    return _payAlertView;
}

-(NSMutableArray *)priceTypeArr {
    if (!_priceTypeArr) {
        _priceTypeArr = [NSMutableArray array];
    }
    return _priceTypeArr;
}
#pragma mark - Lazy
#pragma mark -- HUZMyVipCardViewTypeCollCellDelegate
-(void)selectPriceIndex:(NSInteger)index {
    HUZMyVipCardPriceModel *priceModel = self.priceTypeArr[index];
    self.priceModel = priceModel;
    self.index = index;
    [self.cycleScrollView makeScrollViewScrollToIndex:self.index-1];
}
#pragma mark -- HUZMyVipCardViewTypeCollCellDelegate end

//更新本地缓存
-(void)getUserInfoData {
    [HUZNetWorkTool huz_POST:kUrl_query_userInfo parameters:nil success:^(id  _Nonnull responseObject) {
        HUZWEAK_SELF;
        NSString *code = responseObject[@"code"];
        if ([code integerValue] == 0) {
            //            model.data.userEntity.token = model.data.token;
            HUZUser *model = [HUZUser modelWithJSON:responseObject[@"data"]];
            HUZUserCenterManager.userModel = model;
            [HUZUserCenterManager saveToCache];
            self.userModel = HUZUserCenterManager.userModel;
            
            if ([self.userModel.vip integerValue] != 3) {
                [self getPriceTypeData];
            }else{
                HUZMyVipCardPriceModel *model = [[HUZMyVipCardPriceModel alloc] init];
                model.upgradeType = [self.userModel.vip integerValue];
                [weakSelf.priceTypeArr addObject:model];
                
                NSMutableArray *headerArr = [NSMutableArray array];
                for (HUZMyVipCardPriceModel *model in self.priceTypeArr) {
                    [headerArr addObject:model.headerIcon];
                }
                weakSelf.cycleScrollView.localizationImageNamesGroup = headerArr.copy;
                self.cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleNone;
                self.index = 0;
                [weakSelf updataTableFrame];
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:HUZVIPUpdate_State_Noti_Key object:HUZUserCenterManager.userModel.vip];
        } else {
        }
    } failure:^(NSUInteger statusCode, NSString *error) {
        
    }];
}

-(void)updataTableFrame {
    self.payView.hidden = YES;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.mas_equalTo(0);
    }];
}
@end
