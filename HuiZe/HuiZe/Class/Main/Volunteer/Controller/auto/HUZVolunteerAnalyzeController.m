//
//  HUZVolunteerAnalyzeController.m
//  HuiZe
//
//  Created by mac on 2019/5/5.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZVolunteerAnalyzeController.h"
#import "HUZVolAnalyHeaderView.h"
#import "HUZVolAnalyCell.h"

@interface HUZVolunteerAnalyzeController ()
{
    NSArray *arr;
    NSArray<NSNumber*> *typeArr;
    NSArray *topArr;
    NSArray<NSNumber*> *hihArr;

}
@property (strong, nonatomic) HUZVolAnalyHeaderView *headView;

@end

@implementation HUZVolunteerAnalyzeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)setReasonable:(NSInteger)reasonable {
    _reasonable = reasonable;
    if (reasonable == 0) {
        self.headView.bgView.backgroundColor = ColorS(COLOR_BG_FF2E4A);
    }else if (reasonable == 1) {
        self.headView.bgView.backgroundColor = ColorS(COLOR_BG_F8C301);
    }else if (reasonable == 2) {
        self.headView.bgView.backgroundColor = ColorS(COLOR_BG_1ACD38);
    }
}

-(void)setVolunteerId:(NSString *)volunteerId {
    _volunteerId = [volunteerId copy];
    HUZWEAK_SELF;
    [self displayOverFlowActivityView];
    [HUZNetWorkTool huz_GET:@"/api/volunteer/query/reasonable" parameters:@{@"id":self.volunteerId} success:^(id  _Nonnull responseObject) {
        NSString *codeStr = responseObject[@"code"];
        if ([codeStr integerValue] == 0) {
            HUZIntelligenceFormDataModel *model = [HUZIntelligenceFormDataModel modelWithJSON:responseObject];
            weakSelf.formModel = model;
            [weakSelf.tableView reloadData];
        }else{
            [weakSelf presentErrorSheet:responseObject[@"msg"]];
        }
        [weakSelf removeOverFlowActivityView];
    } failure:^(NSUInteger statusCode, NSString * _Nonnull error) {
        [weakSelf removeOverFlowActivityView];
        [weakSelf presentErrorSheet:error];
    }];
}

-(void)setFormModel:(HUZIntelligenceFormDataModel *)formModel {
    _formModel = formModel;
    if(formModel){
        arr = @[self.formModel.data.completenessList,self.formModel.data.rationalityList,self.formModel.data.major,self.formModel.data.rationalityList];
        HUZRationalityNumber *reasonOpinion = self.formModel.data.rationalityNumber.firstObject;
        HUZOptimizationNumberModel *reasonModify = self.formModel.data.optimizationNumber.firstObject;
        
        self.headView.rlab.text = reasonOpinion.opinion;
        self.headView.nlab.text = [NSString stringWithFormat:@"此志愿表还有:%ld处可进行合理优化",reasonModify.modify];
    }

//    bgView
//    if (formModel.) {
//        <#statements#>
//    }
    
}

- (void)configComponents {
    [super configComponents];

//    arr = @[@[@"学校填报梯度合理、按录取概率从低到高填报", @"存在可保底的学校(录取概率 ≥ 98%)", @"存在可保底的学校(录取概率 50% - 80%)"], @[@"本科第一批学校全部填满", @"已填报志愿专业全部填满"], @[@"专业全部服从调剂"], @[@"所有填报学校符合你的意向", @"所有填报专业符合你的意向"]];
    typeArr = @[@(VolAnalyTypeThree), @(VolAnalyTypeTwo), @(VolAnalyTypeOne), @(VolAnalyTypeTwo)];
    topArr = @[@"志愿表梯度合理性", @"志愿表完整度", @"专业设置合理性", @"符合个人意愿"];
    hihArr = @[@(36 + 92), @(36 + 121), @(36 + 63), @(36 + 121)];
    self.shouldMultiSections = YES;
    self.dataSource = @[@[@"1"], @[@"1"], @[@"1"], @[@"1"]].mutableCopy;
    self.cellHeight = AutoDistance(157);
    self.tableView.backgroundColor = ColorS(COLOR_BG_F6F6F6);
    [self.tableView dz_registerCell:[HUZVolAnalyCell class]];
    self.tableView.tableHeaderView = self.headView;
}

- (HUZVolAnalyHeaderView *)headView {
    if (!_headView) {
        _headView = [[HUZVolAnalyHeaderView alloc]initWithFrame:CGRectMake(0, 0, HUZSCREEN_WIDTH, AutoDistance(148 + 87))];
        [_headView.bBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _headView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [hihArr[indexPath.section] integerValue];
}

/// dequeueReusableCell
- (UITableViewCell *)tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath {
    HUZVolAnalyCell *cell = [HUZVolAnalyCell cellWithTableView:tableView];
    [cell setVolAnalyTpyeWith:[typeArr[indexPath.section] integerValue] andTitle:topArr[indexPath.section] andArray:arr[indexPath.section]];
    return cell;
}

/// configure cell data
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(id)object {
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return AutoDistance(8.0);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = self.tableView.backgroundColor;
    return view;
}

- (void)backClick {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
