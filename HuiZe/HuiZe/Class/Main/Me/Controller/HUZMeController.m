//
//  HUZMeController.m
//  HuiZe
//
//  Created by ZXS Coder on 2019/3/27.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZMeController.h"

#import "HUZMessageListViewController.h"
#import "HUZMyGkInfoViewController.h"
#import "HUZMyFocusViewController.h"
#import "HUZEditProfileViewController.h"
#import "HUZAboutUsViewController.h"
#import "HUZSettingViewController.h"
#import "HUZMyVipCardViewController.h"
#import "HUZActivateVipCardViewController.h"
#import "HUZMineService.h"
#import "HUZMineVolunteerListController.h"
#import "HUZShareHelper.h"

@interface HUZMeController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *labName;
@property (weak, nonatomic) IBOutlet UIButton *btnSchool;
@property (weak, nonatomic) IBOutlet UIButton *btnVip;
@property (weak, nonatomic) IBOutlet UILabel *labGkInfo;
@property (weak, nonatomic) IBOutlet UILabel *labVolunteerNum;
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *iconImageWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintsHeigh;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *adViewHeight;
@property (weak, nonatomic) IBOutlet UILabel *showText;
@property (weak, nonatomic) IBOutlet UIView *showVipTextBgView;

@end

@implementation HUZMeController

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    return [[UIStoryboard storyboardWithName:@"HUZMeController" bundle:nil] instantiateInitialViewController];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"";
    
    HUZWEAK_SELF;
    self.tableView.backgroundColor = ColorS(COLOR_BG_F6F6F6);
    HUZUser *user = HUZUserCenterManager.userModel;
    NSString *headUrl = user.headUrl;
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:headUrl] placeholderImage:ImageNamed(@"ic_mine_head")];
    [self.iconImage jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [weakSelf editSchool];
    }];
    self.labName.text = user.username;
    NSString *school = [NSString stringWithFormat:@"%@ %@", DRStringIsEmpty(user.school) ? @"" : user.school, DRStringIsEmpty(user.gredes) ? @"" : user.gredes];
    [self.btnSchool setTitle:school forState:UIControlStateNormal];
    [self.btnSchool setImage:ImageNamed(@"icons／search bar／search／gray(1)") forState:UIControlStateNormal];
    [self.btnSchool LeftTitleRightImageWithSpace:AutoDistance(3)];
    NSString *imageVip = @"bg_vip_nor";
    // vip：0普通，1铂金，2钻石，3专家一对一
    if ([user.vip integerValue] == 1) {
        imageVip = @"ic_vip_bojin";
    }
    else if ([user.vip integerValue] == 2) {
        imageVip = @"ic_vip_zuan";
    }
    else if ([user.vip integerValue] == 3) {
        imageVip = @"ic_vip_zhuanjia";
    }
    [self.btnVip setImage:ImageNamed(imageVip) forState:UIControlStateNormal];
    self.labGkInfo.text = HUZUserCenterManager.gkInfo;
    self.labVolunteerNum.text = user.volunteerNum;
    self.constraintsHeigh.constant =  HUZISFULLSCREEN ? AutoDistance(53): AutoDistance(33);
    self.adViewHeight.constant = AutoDistance(31);
    self.iconImageWidth.constant = AutoDistance(68);
    ViewRadius(self.iconImage, AutoDistance(68/2));
    [self.btnVip addTarget:self action:@selector(openVip) forControlEvents:UIControlEventTouchUpInside];
    [self.btnSchool addTarget:self action:@selector(editSchool) forControlEvents:UIControlEventTouchUpInside];
    
    [self.showVipTextBgView addTapAction:^(id  _Nonnull sender) {
        [weakSelf openVip];
    }];


}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadData];
}

- (void)loadData {
//    [self displayOverFlowActivityView];
    HUZWEAK_SELF;
    [HUZMineService getUserMsgInfoWithSuccess:^(HUZMyUser * _Nonnull object) {
        
        weakSelf.labGkInfo.text = HUZUserCenterManager.gkInfo;
        weakSelf.labVolunteerNum.text = object.data.volunteerNum;
//        [weakSelf removeOverFlowActivityView];
        [weakSelf.tableView reloadData];
    } failure:^(NSUInteger code, NSString * _Nonnull errorStr) {
//        [weakSelf removeOverFlowActivityView];
        [weakSelf presentErrorSheet:errorStr];
    }];
}

#pragma mark - event
/// 开通VIP
- (void)openVip {
        
    HUZMyVipCardViewController *myVipCardVC = [HUZMyVipCardViewController new];
    [self.navigationController pushViewController:myVipCardVC animated:YES];
}

/// 编辑资料
- (void)editSchool {
    [self.navigationController pushViewController:[[HUZEditProfileViewController alloc]initWithStyle:UITableViewStylePlain] animated:YES];
}

/// 消息列表
- (IBAction)messageClick:(id)sender {
    HUZMessageListViewController *messageListVC = [HUZMessageListViewController new];
    [self.navigationController pushViewController:messageListVC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {
        return AutoDistance(214);
    }
    else if (indexPath.section == 0 && indexPath.row == 1) {
        return AutoDistance(55);
    }
    return AutoDistance(58);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    }
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = self.tableView.backgroundColor;
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HUZViewController *VC = nil;
    
    if (indexPath.section == 0) {
        if (indexPath.row == 1) { // 开通钻石
        }
        else if (indexPath.row == 2) { // 我的高考信息
            HUZMyGkInfoViewController *myGkInfoVC = [HUZMyGkInfoViewController new];
            VC = myGkInfoVC;
        }
        else if (indexPath.row == 3) { // 我的关注
            HUZMyFocusViewController *myFocusVC = [HUZMyFocusViewController new];
            VC = myFocusVC;
        }
        else if (indexPath.row == 4) { // 我的志愿表
            HUZMineVolunteerListController *volVC = [HUZMineVolunteerListController new];
            VC = volVC;
        }
    }
    else if (indexPath.section == 1) {
        
        if (indexPath.row == 0) { // 我的VIP
            [self openVip];
        }
        else if (indexPath.row == 1) { // 兑换入口
            HUZActivateVipCardViewController *activateVipCardVC = [HUZActivateVipCardViewController new];
            VC = activateVipCardVC;
        }
    }
    else if (indexPath.section == 2) {
        
        if (indexPath.row == 0) { // 分享给好友
            HUZShareView *shareView = [HUZShareView new];
            [shareView show];
            shareView.block = ^(NSString * _Nonnull platform) {
                [HUZShareHelper shareWithTitle:@"用智慧择大学，志愿填报更精准" weiboTitle:@"分享" content:@"高考志愿填报利器，AI算法、大数据，精准推荐院校和专业，力争1分不浪费" image:ImageNamed(@"ic_mine_head") imgUrl:@"" siteUrl:@"http://api.hz985211.com/test/html/download.html" viewController:self platform:platform];
            };
        }
        else if (indexPath.row == 1) { // 联系客服
            [HUZTools huzCallPhone:@"4006-111-985"];
        }
        else if (indexPath.row == 2) { // 关于我们
            HUZAboutUsViewController *aboutUsVC = [HUZAboutUsViewController new];
            VC = aboutUsVC;
        }
        else if (indexPath.row == 3) { // 设置
            HUZSettingViewController *setVC = [HUZSettingViewController new];
            VC = setVC;
        }
    }
    
    if (VC != nil) {
        [self.navigationController pushViewController:VC animated:YES];
    }
}

#pragma mark - 取消下拉  允许上拉
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint offset = self.tableView.contentOffset;
    if (offset.y <= 0) {
        offset.y = 0;
    }
    self.tableView.contentOffset = offset;
}
@end

//            ZJAnimationPopView *popView = [[ZJAnimationPopView alloc] initWithPopStyle:ZJAnimationPopStyleShake dismissStyle:ZJAnimationDismissStyleNO];
//            [popView popAwaitAlertWithTitle:@"立即拨打9900909" cancel:@"取消" confirm:@"确定"];
//            popView.confirmClick = ^{
//            };
