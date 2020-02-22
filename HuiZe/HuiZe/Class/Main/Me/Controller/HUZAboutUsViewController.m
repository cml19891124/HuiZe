//
//  HUZAboutUsViewController.m
//  HuiZe
//
//  Created by  YIQI on 2019/5/6.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZAboutUsViewController.h"
#import "HUZAboutUsCell.h"
#import "HUZAgreementViewController.h"
#import "HUZFeedbackViewController.h"

@interface HUZAboutUsViewController ()

@property (nonatomic,strong) UIView *headerView;
@property (nonatomic,strong) UIView *footerView;


@end

@implementation HUZAboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"关于我们";
}

- (void)configComponents{
    [super configComponents];
    
    self.dataSource = @[@"意见反馈",@"用户协议",@"隐私政策"].mutableCopy;
    
    self.cellHeight = AutoDistance(60);
    [self.tableView dz_registerCell:[HUZAboutUsCell class]];
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.tableFooterView = self.footerView;
}

#pragma mark - tableView
- (UITableViewCell *)tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath{
    return [HUZAboutUsCell cellWithTableView:tableView];
}

- (void)configureCell:(HUZAboutUsCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(id)object{
    [cell reloadData:object];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    /// 意见反馈
    if (indexPath.row == 0) {
        HUZFeedbackViewController *feedbackVC = [HUZFeedbackViewController new];
        [self.navigationController pushViewController:feedbackVC animated:YES];
    }

    /// 用户协议
    else if (indexPath.row == 1){
            HUZAgreementViewController *agreementVC = [[HUZAgreementViewController alloc] init];
            agreementVC.navTitle = @"用户协议";
        //    agreementVC.shouldDisableWebViewTitle = NO;
            agreementVC.url = @"http://m.hz985211.com/agreement.html";
            [self.navigationController pushViewController:agreementVC animated:true];
    }else{
            HUZAgreementViewController *agreementVC = [[HUZAgreementViewController alloc] init];
            agreementVC.navTitle = @"用户隐私保护政策";
        //    agreementVC.shouldDisableWebViewTitle = NO;
            agreementVC.url = @"http://m.hz985211.com/Privacyprotocol.html";
            [self.navigationController pushViewController:agreementVC animated:true];
    }
}

#pragma mark - Lazy
- (UIView *)headerView{
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, HUZSCREEN_WIDTH, AutoDistance(182))];
        _headerView.backgroundColor = ColorS(COLOR_BG_F6F6F6);
        UIImageView *ivApp = [[UIImageView alloc] initWithFrame:CGRectMake((HUZSCREEN_WIDTH-AutoDistance(97))/2.0, AutoDistance(33), AutoDistance(97), AutoDistance(97))];
        ivApp.image = ImageNamed(@"AppIcon_about");
        ViewRadius(ivApp, AutoDistance(12));
        [_headerView addSubview:ivApp];
        UILabel *labVersion = [[UILabel alloc] initWithTextColor:ColorS(COLOR_989898) autoTextFont:FontS(FONT_14) textAlignment:NSTextAlignmentCenter];
        labVersion.frame = CGRectMake((HUZSCREEN_WIDTH-AutoDistance(97))/2.0, AutoDistance(140), AutoDistance(97), AutoDistance(21));
        labVersion.text = [NSString stringWithFormat:@"v%@",HUZAPP_VERSION];
        [_headerView addSubview:labVersion];
    }
    return _headerView;
}

- (UIView *)footerView{
    if (!_footerView) {
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, HUZSCREEN_WIDTH, HUZSCREEN_HEIGHT - AutoDistance(182) - 3*AutoDistance(60) - HUZSTATUS_BAR_NAVIGATION_BAR_HEIGHT-HUZTAB_BAR_SAFE_BOTTOM_MARGIN-10)];
        //WithFrame:CGRectMake(0, 0, HUZSCREEN_WIDTH, AutoDistance(300))
        UILabel *labContent = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_14) numberOfLines:0];
        labContent.textAlignment = NSTextAlignmentCenter;
//        labContent.frame = CGRectMake(AutoDistance(15), AutoDistance(18), HUZSCREEN_WIDTH-AutoDistance(30), AutoDistance(280));
    
        labContent.text = @"Copyright © 2019 \n慧择（深圳）信息科技有限公司 版权所有";
//        [labContent changeSpacewithLineSpace:AutoDistance(8) WordSpace:0];
        [_footerView addSubview:labContent];
        [labContent mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(-(20-HUZTAB_BAR_SAFE_BOTTOM_MARGIN));
            make.centerX.mas_equalTo(0);
        }];
    }
    return _footerView;
}

@end
