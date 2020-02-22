//
//  HUZVolProfessionalSelectView.m
//  HuiZe
//
//  Created by mac on 2019/4/28.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZVolProfessionalSelectView.h"
#import "HUZVolMajorSelectCell.h"
#import "HUZVolunteerService.h"
#import "HUZVoluntaryModel.h"
#import "HUZVoluntPriorityModel.h"
#define kCellHeight 108
#define kHeadHeight 50
#define kTotalHeight 466

@interface HUZVolProfessionalSelectView ()<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) UILabel *headLab;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataSources;
@property (strong, nonatomic) NSMutableArray *selectArr; // 选中结果
@property (strong, nonatomic) UIView *sdview;

@end

@implementation HUZVolProfessionalSelectView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self == [super initWithFrame:frame]) {
        self.dataSources = [NSMutableArray array];
        self.selectArr = [NSMutableArray array];
        [self initview];
        [self configHeadView];
        [self configTableView];
    }
    return self;
}
-(void)setVoluntPriorityModel:(HUZVoluntPriority *)voluntPriorityModel {
    _voluntPriorityModel = voluntPriorityModel;
}
- (void)setModel:(HUZVoluntaryModel *)model {
    self.dataSources = [model.data mutableCopy];
    [self.tableView reloadData];
}

- (void)setSchoolName:(NSString *)schoolName {
    _schoolName = schoolName;
}

- (void)setID:(NSString *)ID
{
    _ID = ID;
}

- (void)setHeadTitle:(NSString *)headTitle
{
    _headTitle = headTitle;
    self.headLab.text = headTitle;
}

- (void)initview {
    
    self.frame = CGRectMake(0, 0, HUZSCREEN_WIDTH, HUZSCREEN_HEIGHT);
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissView)]];
    if (self.sdview == nil) {
        self.sdview = [[UIView alloc]initWithFrame:CGRectMake(0, HUZSCREEN_HEIGHT, HUZSCREEN_WIDTH, HUZSCREEN_HEIGHT)];
        self.sdview.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.sdview];
        //得到view的遮罩路径
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.sdview.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(12,12)];
        //创建 layer
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = self.sdview.bounds;
        //赋值
        maskLayer.path = maskPath.CGPath;
        self.sdview.layer.mask = maskLayer;
    }
    
}
/// 配置标题
- (void)configHeadView {
    UIImageView *image = [[UIImageView alloc]initWithImage:ImageNamed(@"ic_rectangle")];
    image.frame = CGRectMake(AutoDistance(15), AutoDistance(18), AutoDistance(4), AutoDistance(14));
    [self.sdview addSubview:image];
    UILabel *label = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_15)];
    label.frame = CGRectMake(AutoDistance(27), AutoDistance(15), AutoDistance(200), AutoDistance(21));
    self.headLab = label;
    [self.sdview addSubview:label];
    UIButton *btn = [[UIButton alloc]initWithTitle:@"完成" textColor:ColorS(COLOR_2E86FF) autoTextFont:FontS(FONT_15)]; // COLOR_C8C8C8
    btn.frame = CGRectMake(HUZSCREEN_WIDTH - AutoDistance(41) - AutoDistance(15), AutoDistance(10), AutoDistance(41), AutoDistance(31));
    [btn setTitleColor:ColorS(COLOR_2E86FF) forState:UIControlStateSelected];
    btn.backgroundColor = COLOR_BG_WHITE;
    [btn addTarget:self action:@selector(doneClick) forControlEvents:UIControlEventTouchUpInside];
    self.btnDone = btn;
    [self.sdview addSubview:btn];
}

/// 配置UIPickerView
- (void)configTableView {
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.headLab.frame) + 10, self.frame.size.width, kTotalHeight - kHeadHeight)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorColor = ColorS(COLOR_BG_F6F6F6);
    self.tableView.backgroundColor = ColorS(COLOR_BG_F6F6F6);
//    self.tableView.rowHeight = AutoDistance(kCellHeight);
    [self.tableView dz_registerCell:[HUZVolMajorSelectCell class]];
    [self.sdview addSubview:self.tableView];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSources.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HUZVolMajorSelectCell *cell = [HUZVolMajorSelectCell cellWithTableView:tableView];
    cell.model = self.dataSources[indexPath.row];
    if (cell.model.alternative) {
        if (![self.selectArr containsObject:indexPath]) {
            [self.selectArr addObject:indexPath];
        }
    }
    else {
        if ([self.selectArr containsObject:indexPath]) {
            [self.selectArr removeObject:indexPath];
        }
    }
    HUZWEAK_SELF
    __weak typeof(cell) weakCell = cell;
    cell.addMajor = ^(BOOL isSelected) {
        //NSLog(@"已选备选 %ld", indexPath.row);
        //NSLog(@"%@------%zd",self.selectArr,self.selectArr.count);
//        if (self.selectArr.count < 6) {
//        if(self.)
        if ([self.voluntPriorityModel.province isEqualToString:@"13"] && self.selectArr.count > 4) {
            weakCell.btnAdd.selected = NO;
            [weakCell.btnAdd setBackgroundColor:weakCell.btnAdd.selected ? ColorS(COLOR_F19147) : ColorS(COLOR_2E86FF)];
            [MBProgressHUD showError:@"河南省添加专业不能超过5个" toView:self.tableView];
        }else{
            [weakSelf addMajorWithSelected:isSelected indexPath:indexPath];
        }
//        }else{
//            weakCell.btnAdd.selected = NO;
//            [weakCell.btnAdd setBackgroundColor:weakCell.btnAdd.selected ? ColorS(COLOR_F19147) : ColorS(COLOR_2E86FF)];
//            [MBProgressHUD showError:@"专业不能超过6个" toView:self.tableView];
//        }
        
    };
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView fd_heightForCellWithIdentifier:@"HUZVolMajorSelectCell" configuration:^(HUZVolMajorSelectCell *cell) {
        cell.model = self.dataSources[indexPath.row];
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return AutoDistance(33.0);
    }
    return 0.001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = self.tableView.backgroundColor;
    UILabel *lab = [[UILabel alloc]initWithTextColor:ColorS(COLOR_989898) autoTextFont:FontS(FONT_12) frame:CGRectMake(AutoDistance(15), AutoDistance(8), AutoDistance(250), AutoDistance(17))];
    lab.text = self.schoolName;
    lab.backgroundColor = [UIColor clearColor];
    [view addSubview:lab];
    return view;
}

- (void)showInView{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [[UIApplication sharedApplication].keyWindow addSubview:self.sdview];
    [self.sdview setFrame:CGRectMake(0, HUZSCREEN_HEIGHT, HUZSCREEN_WIDTH, AutoDistance(kTotalHeight))];
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1.0;
        [self.sdview setFrame:CGRectMake(0, HUZSCREEN_HEIGHT - AutoDistance(kTotalHeight), HUZSCREEN_WIDTH, AutoDistance(kTotalHeight))];
    } completion:nil];
}

- (void)dismissView{
    [self.sdview setFrame:CGRectMake(0, HUZSCREEN_HEIGHT - AutoDistance(kTotalHeight), HUZSCREEN_WIDTH, AutoDistance(kTotalHeight))];
    [UIView animateWithDuration:0.3f
                     animations:^{
                         self.alpha = 0.0;
                         [self.sdview setFrame:CGRectMake(0, HUZSCREEN_HEIGHT, HUZSCREEN_WIDTH, AutoDistance(kTotalHeight))];
                     }
                     completion:^(BOOL finished){
                         [self removeFromSuperview];
                         [self.sdview removeFromSuperview];
                     }];
}

- (void)show {
    [self showInView];
}

- (void)addMajorWithSelected:(BOOL)selected indexPath:(NSIndexPath*)indexPath {
    HUZVoluntaryListModel *dataModel = self.dataSources[indexPath.row];
    dataModel.select = !dataModel.isSelect;
    if (selected) {
        if (![self.selectArr containsObject:indexPath]) {
            [self.selectArr addObject:indexPath];
        }
        dataModel.alternative = YES;
    }
    else {
        if ([self.selectArr containsObject:indexPath]) {
            [self.selectArr removeObject:indexPath];
        }
        dataModel.alternative = NO;
    }
    HUZLOG(@"selectArr: %@", self.selectArr);
    [self.tableView reloadData];
}

- (void)doneClick {
    // 添加到备选专业
    HUZVoluntaryListModel *voluntaryList = self.dataSources.firstObject;
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    [postDic setValue:self.voluntPriorityModel.schoolId forKey:@"schoolId"]; // 大学id
    [postDic setValue:@(self.alternativeType) forKey:@"alternativeType"]; // 来源：0智能填报，1院校优先填报，2专业优先填报，3手动填报 ,
    [postDic setValue:voluntaryList.batch forKey:@"batch"]; // 批次
    NSString *majorAllIds = [NSString string];
    NSString *admissionMajorIds = [NSString string];

    NSString *resultMajorAllIds;
    NSString *resultAdmissionMajorIds;
    for (NSIndexPath *indexPath in self.selectArr) {
        HUZVoluntaryListModel *voluntary = self.dataSources[indexPath.row];

        if (self.selectArr.count == 1) {
            majorAllIds = voluntary.majorAllId;
            admissionMajorIds = voluntary.id;
            resultMajorAllIds = [NSString stringWithFormat:@"%@,",voluntary.majorAllId];
            resultAdmissionMajorIds = @",";
            
        }else{

            if (majorAllIds) {
                majorAllIds = [majorAllIds stringByAppendingFormat:@",%@",voluntary.majorAllId];
                resultMajorAllIds = [majorAllIds substringFromIndex:1];
            }
            
            if (admissionMajorIds) {
                admissionMajorIds = [admissionMajorIds stringByAppendingFormat:@",%@",voluntary.id];
                resultAdmissionMajorIds = [admissionMajorIds substringFromIndex:1];
            }

        }
    }
    [postDic setValue:resultAdmissionMajorIds forKey:@"admissionMajorId"]; // 专业id
    [postDic setValue:_ID forKey:@"admissionDetailsId"];
    [postDic setValue:resultMajorAllIds forKey:@"majorAllIds"];

    HUZLOG(@"添加到备选专业: %@", postDic);
    HUZViewController *huzVC = (HUZViewController *)[UIViewController currentViewController];
    [huzVC displayOverFlowActivityView];
    
    [HUZVolunteerService saveAlternativeWithParamters:postDic success:^(NSString * _Nonnull success) {
        [huzVC removeOverFlowActivityView];
        HUZLOG(@"添加备选专业成功:%@", success);
        if (self.delegate && [self.delegate respondsToSelector:@selector(professionalSelectViewDelegateWith:selectArr:)]) {
            [self.delegate professionalSelectViewDelegateWith:self selectArr:self.selectArr];
        }
        [self dismissView];
    } failure:^(NSUInteger code, NSString * _Nonnull errorStr) {
        [huzVC removeOverFlowActivityView];
        [huzVC presentErrorSheet:errorStr];
    }];
}

@end
