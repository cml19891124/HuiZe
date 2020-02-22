//
//  HUZEnrollmentRegulationViewController.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/26.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZEnrollmentRegulationViewController.h"
#import "HUZUniMajorHeaderView.h"

@interface HUZEnrollmentRegulationViewController ()

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) HUZUniMajorHeaderView *enrollmentRegulationHeaderView;
@property (nonatomic,strong) UILabel *labTitle;
@property (nonatomic,strong) UILabel *labContent;

@end

@implementation HUZEnrollmentRegulationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"招生简章";
}

- (void)configComponents{
    [super configComponents];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, HUZSCREEN_WIDTH, HUZSCREEN_HEIGHT - HUZSTATUS_BAR_NAVIGATION_BAR_HEIGHT)];
    self.scrollView.backgroundColor = COLOR_BG_WHITE;
    [self.view addSubview:self.scrollView];
    
    CGFloat H = HUZSCREEN_WIDTH >= 414 ? 105 : 90;
    self.enrollmentRegulationHeaderView = [[HUZUniMajorHeaderView alloc]  initWithFrame:CGRectMake(0, 0, HUZSCREEN_WIDTH, H)];
    [self.scrollView addSubview:self.enrollmentRegulationHeaderView];
    
    self.labTitle = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_15)];
    self.labTitle.text = @"北京大学18年本科招生简章";
    self.labTitle.frame = CGRectMake(AutoDistance(15), self.enrollmentRegulationHeaderView.huz_y + self.enrollmentRegulationHeaderView.huz_height + AutoDistance(15), HUZSCREEN_WIDTH - AutoDistance(30), AutoDistance(21));
    [self.scrollView addSubview:self.labTitle];
    
    self.labContent = [[UILabel alloc] initWithTextColor:ColorS(COLOR_848484) autoTextFont:FontS(FONT_14) numberOfLines:0];
    NSString *str =@"我是选大学的内容我是选大学的内容我是选大学的内容我是选大学的内容我是选大学的内容我是选大学的内容我是选大学的内容我是选大学的内容我是选大学的内容我是选大学的内容我是选大学的内容我是选大学的内容我是选大学的内容我是选大学的内容我是选大学的内容我是选大学的内容我是选大学的内容我是选大学的内容我是选大学的内容我是选大学的内容我是选大学的内容我是选大学的内容我是选大学的内容我是选大学的内容我是选大学的内容我是选大学的内容我是选大学的内容我是选大学的内容我是选大学的内容我是选大学的内容我是选大学的内容我是选大学的内容我是选大学的内容我是选大学的内容我是选大学的内容我是选大学的内容我是选大学的内容我是选大学的内容我是选大学的内容我是选大学的内容我是选大学的内容我是选大学的内容我是选大学的内容我是选大学的内容我是选大学的内容我是选大学的内容我是选大学的内容我是选大学的内容我是选大学的内容我是选大学的内容我是选大学的内容我是选大学的内容我是选大学的内容我是选大学的内容我是选大学的内容我是选大学的内容我是选大学的内容我是选大学的内容我是选大学的内容我是选大学的内容我是选大学的内容我是选大学的内容我是选大学的内容我是选大学的内容我是选大学的内容我是选大学的内容我是选大学的内容我是选大学的内容我是选大学的内容我是选大学的内容我是选大学的内容我是选大学的内容我是选大学的内容我是选大学的内容我是选大学的内容我是选大学的内容我是选大学的内容我是选大学的内容我是选大学的内容我是选大学的内容我是选大学的内容我是选大学的内容我是选大学的内容我是选大学的内容";
    self.labContent.text = str;
    [self.labContent changeSpacewithLineSpace:AutoDistance(2) WordSpace:0];
    CGFloat strH = [str jk_heightWithFont:FontS(FONT_14) constrainedToWidth:HUZSCREEN_WIDTH-AutoDistance(30)];
    
    self.labContent.frame = CGRectMake(AutoDistance(15), self.labTitle.huz_y + self.labTitle.huz_height + AutoDistance(23), HUZSCREEN_WIDTH-AutoDistance(30), strH);
    [self.scrollView addSubview:self.labContent];
    
    self.scrollView.contentSize = CGSizeMake(HUZSCREEN_WIDTH, H + AutoDistance(60) + strH + AutoDistance(30));
    
}


@end

