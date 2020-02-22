//
//  HUZPPPSelectView.m
//  HuiZe
//
//  Created by mac on 2019/4/27.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZPPPSelectView.h"
#import "HUZPPPModel.h"
#import "HUZPPPSelectCell.h"

@interface HUZPPPSelectView ()<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) UILabel *headLab;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataSources;
@property (strong, nonatomic) NSMutableArray *selectArr; // 选中结果
@property (strong, nonatomic) UIView *sdview;
@property (assign, nonatomic)CGFloat pppHeight;

@end

#define kHUZPPPSelectViewCellID @"HUZPPPSelectViewCellID"

@implementation HUZPPPSelectView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self == [super initWithFrame:frame]) {
        self.dataSources = [NSMutableArray array];
        self.selectArr = [NSMutableArray array];
        [self initview];
        [self configHeadView];
    }
    return self;
}

- (void)setHeadTitle:(NSString *)headTitle
{
    _headTitle = headTitle;
    self.headLab.text = headTitle;
}

- (void)setDataArray:(NSMutableArray *)dataArray {
    _dataArray = dataArray;
    [self.dataSources removeAllObjects];
    [dataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        HUZPPPModel *model = [HUZPPPModel new];
        model.title = (NSString*)obj;
        model.isSelected = NO;
        [self.dataSources addObject:model];
    }];
    self.pppHeight = 60 + 44 *self.dataArray.count;
    if (self.pppHeight > HUZSCREEN_HEIGHT/2) {
        self.pppHeight = HUZSCREEN_HEIGHT/2;
    }
    [self configTableView];
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
    label.frame = CGRectMake(AutoDistance(27), AutoDistance(15), AutoDistance(150), AutoDistance(21));
    self.headLab = label;
    [self.sdview addSubview:label];
}

/// 配置UIPickerView
- (void)configTableView {
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.headLab.frame) + 10, self.frame.size.width, self.frame.size.height - (HUZSCREEN_HEIGHT - self.pppHeight) - CGRectGetMaxY(self.headLab.frame) - 10)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorColor = ColorS(COLOR_BG_F6F6F6);
    self.tableView.backgroundColor = ColorS(COLOR_BG_F6F6F6);
    [self.tableView registerClass:[HUZPPPSelectCell class] forCellReuseIdentifier:kHUZPPPSelectViewCellID];
    [self.sdview addSubview:self.tableView];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.dataSources enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        HUZPPPModel *model = (HUZPPPModel *)obj;
        model.isSelected = NO;
    }];
    HUZPPPModel *model = self.dataSources[indexPath.row];
    model.isSelected = !model.isSelected;
    [self.tableView reloadData];
    NSString *title = [NSString stringWithFormat:@"%@",model.title];
    if (self.delegate && [self.delegate respondsToSelector:@selector(pppSelectViewDelegateWith:result:)]) {
        [self.delegate pppSelectViewDelegateWith:self result:title];
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(pppSelectViewDelegateWith:indexPath:result:)]) {
        [self.delegate pppSelectViewDelegateWith:self indexPath:indexPath result:title];
    }
    [self dismissView];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSources.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HUZPPPSelectCell *cell = [tableView dequeueReusableCellWithIdentifier:kHUZPPPSelectViewCellID forIndexPath:indexPath];
    cell.model = self.dataSources[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return AutoDistance(8.0);
    }
    return 0.001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = self.tableView.backgroundColor;
    return view;
}

- (void)showInView{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [[UIApplication sharedApplication].keyWindow addSubview:self.sdview];
    HUZWEAK_SELF;
    [self.sdview setFrame:CGRectMake(0, HUZSCREEN_HEIGHT, HUZSCREEN_WIDTH, self.pppHeight)];
    [UIView animateWithDuration:0.3 animations:^{
        HUZSTRONG_SELF;
        self.alpha = 1.0;
        [self.sdview setFrame:CGRectMake(0, HUZSCREEN_HEIGHT - strongSelf.pppHeight, HUZSCREEN_WIDTH, strongSelf.pppHeight)];
    } completion:nil];
}

- (void)dismissView{
    [self.sdview setFrame:CGRectMake(0, HUZSCREEN_HEIGHT - self.pppHeight, HUZSCREEN_WIDTH, self.pppHeight)];
    HUZWEAK_SELF;
    [UIView animateWithDuration:0.3f
                     animations:^{
                         HUZSTRONG_SELF;
                         self.alpha = 0.0;
                         [self.sdview setFrame:CGRectMake(0, HUZSCREEN_HEIGHT, HUZSCREEN_WIDTH, strongSelf.pppHeight)];
                     }
                     completion:^(BOOL finished){
                         [self removeFromSuperview];
                         [self.sdview removeFromSuperview];
                     }];
}

- (void)show {
    [self showInView];
}
@end
