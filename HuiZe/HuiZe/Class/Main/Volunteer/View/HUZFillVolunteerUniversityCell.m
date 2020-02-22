//
//  HUZFillVolunteerUniversityCell.m
//  HuiZe
//
//  Created by tbb on 2019/10/29.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZFillVolunteerUniversityCell.h"
#import "YQBaseTableView.h"
#import "HUZFillVolunteerUniversityCellHeader.h"
#import "HUZFillVolunteerUniversityCellFooter.h"
#import "HUZFillVolunteerUniversityMajorCell.h"
#import "HUZSchoolListDataModel.h"
@interface HUZFillVolunteerUniversityCell ()<UITableViewDelegate ,UITableViewDataSource>

@property (nonatomic, strong) YQBaseTableView * listTableView;

@property (nonatomic, copy) NSArray * headerTitleArr;

@property (nonatomic, strong) HUZFillVolunteerUniversityCellFooter * footerView;
@property (nonatomic, strong) HUZFillVolunteerUniversityCellHeader * headerView;

@end

@implementation HUZFillVolunteerUniversityCell
-(void)setSchoolModel:(HUZSchoolModel *)schoolModel {
    _schoolModel = schoolModel;
    [self.listTableView reloadData];
}
-(void)layoutSubviews {
    [super layoutSubviews];
    self.contentView.backgroundColor = UIColor.whiteColor;
    self.backgroundColor = UIColor.whiteColor;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView addSubview:self.listTableView];
    [self.listTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];

}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.headerTitleArr = @[@"A.",@"B.",@"C.",@"D.",@"E.",@"F.",@"G.",@"H.",
        @"I.",@"J.",@"K.",@"L.",@"M.",@"N.",@"O.",@"P.",
        @"Q.",@"R.",@"S.",@"T.",@"U.",@"V.",@"W.",@"X.",
        @"Y.",@"Z."];
    }
    return self;
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.schoolModel.major.count;
}
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    HUZUniInfoGeneralizeMajorModel *majorModel = nil;
    if (indexPath.row < self.schoolModel.major.count) {
        majorModel = self.schoolModel.major[indexPath.row];
    }
    
    
    HUZFillVolunteerUniversityMajorCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HUZFillVolunteerUniversityMajorCell"];
    //cell.contentView.backgroundColor = UIColor.yellowColor;
    cell.majorModel = majorModel;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    HUZUniInfoGeneralizeMajorModel *majorModel = nil;
    if (indexPath.row < self.schoolModel.major.count) {
        majorModel = self.schoolModel.major[indexPath.row];
    }
    return majorModel.showMajIntroduceAttributedH;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    HUZFillVolunteerUniversityCellFooter *footer = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"HUZFillVolunteerUniversityCellFooter"];
    [footer.addBtn addTarget:self action:@selector(addMajorAction:) forControlEvents:(UIControlEventTouchUpInside)];
    self.footerView = footer;
    return footer;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    HUZFillVolunteerUniversityCellHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"HUZFillVolunteerUniversityCellHeader"];
    
    if (self.headerTitleArr.count > section) {
        header.numLb.text = self.headerTitleArr[self.indexPath.row-1];
    }
    
    header.nameLb.text = self.schoolModel.schoolName;
    header.cityLb.text = self.schoolModel.uniCity;
    [header.logoIcon sd_setImageWithURL:[NSURL URLWithString:self.schoolModel.logoUrl]];
    [header.deleteBtn addTarget:self action:@selector(deleteSchoolAction:) forControlEvents:(UIControlEventTouchUpInside)];
    self.headerView = header;
    return header;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 45.0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 60.0;
}
#pragma mark - UITableViewDelegate, UITableViewDataSource end
-(void)addMajorAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(addMajorCurrentIndexPath:)]) {
        [self.delegate addMajorCurrentIndexPath:self.indexPath];
    }
}
-(void)deleteSchoolAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(deleteMajorCurrentIndexPath:)]) {
        [self.delegate deleteMajorCurrentIndexPath:self.indexPath];
    }
}
#pragma lazy --mark
-(YQBaseTableView *)listTableView {
    if (!_listTableView) {
        _listTableView.backgroundColor = UIColor.yellowColor;
        _listTableView = [[YQBaseTableView alloc] initWithFrame:self.bounds style:UITableViewStyleGrouped];
        _listTableView.backgroundColor = UIColor.whiteColor;
        _listTableView.dataSource = self;
        _listTableView.delegate = self;
//        _listTableView.userInteractionEnabled = NO;
        [_listTableView registerNib:[UINib nibWithNibName:@"HUZFillVolunteerUniversityCellHeader" bundle:nil] forHeaderFooterViewReuseIdentifier:@"HUZFillVolunteerUniversityCellHeader"];
        [_listTableView registerNib:[UINib nibWithNibName:@"HUZFillVolunteerUniversityCellFooter" bundle:nil] forHeaderFooterViewReuseIdentifier:@"HUZFillVolunteerUniversityCellFooter"];
        [_listTableView registerNib:[UINib nibWithNibName:@"HUZFillVolunteerUniversityMajorCell" bundle:nil] forCellReuseIdentifier:@"HUZFillVolunteerUniversityMajorCell"];
    }
    return _listTableView;
}
#pragma lazy --mark end
/*
 override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
     let view = super.hitTest(point, with: event);
     
     if view == nil {
         let tempPoint = self.screenTableView.convert(point, from: self);
         if self.screenTableView.bounds.contains(tempPoint) {
             return self.screenTableView;
         }
         
     }
     return view;
 }
 */
//事件冲突处理
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view = [super hitTest:point withEvent:event];
    if (view) {
//        CGPoint deletePoint = [self.headerView.deleteBtn convertPoint:point toView:self];
//        CGPoint addPoint = [self.footerView.addBtn convertPoint:point toView:self];
        if([NSStringFromClass([view class])isEqual:@"UIButton"]){
            return view;
         }
        return self;
    }
    return view;
}
/*
-(BOOL)gestureRecognizer:(UIGestureRecognizer*)gestureRecognizer shouldReceiveTouch:(UITouch*)touch {
    
  if([NSStringFromClass([touch.view class])isEqual:@"UITableViewCellContentView"]){

      return YES;

   }

   return YES;

}
*/
@end


