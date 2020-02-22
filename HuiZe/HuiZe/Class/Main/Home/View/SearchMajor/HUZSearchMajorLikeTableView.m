//
//  HUZSearchMajorLikeTableView.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/26.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZSearchMajorLikeTableView.h"
#import "HUZSearchMajorLikeCell.h"
#import "HUZMajorInfoViewController.h"
#import "UITableView+FDTemplateLayoutCell.h"
@interface HUZSearchMajorLikeTableView ()

@property (nonatomic,strong) NSMutableArray *dataUlike;
@property (nonatomic,strong) NSMutableArray *dataHot;

@end

@implementation HUZSearchMajorLikeTableView

- (instancetype)init {
    if (self = [super init]) {
//        self.rowHeight = AutoDistance(108);
        [self dz_registerCell:[HUZSearchMajorLikeCell class]];
        
        
        self.dataUlike = [NSMutableArray new];
        self.dataHot = [NSMutableArray new];
        
        HUZWEAK_SELF
        self.mj_footer = [HUZRefreshFooter footerWithRefreshingBlock:^{
            HUZSTRONG_SELF
            strongSelf.page ++;
            if (strongSelf.type == HUZSearchMajorUlike) {
                [strongSelf loadUlikeData];
            }else{
                [strongSelf loadHotData];
            }
        }];
    }
    return self;
}

- (void)setType:(HUZSearchMajorType)type{
    _type = type;
    if (self.type == HUZSearchMajorUlike) {
        [self loadUlikeData];
    }else{
        [self loadHotData];
    }
}

#pragma mark NETWork
/// 猜你喜欢
- (void)loadUlikeData{
    HUZWEAK_SELF
    [self displayOverFlowActivityView];
    [HUZHomeService getULikeList:@{@"pageNow":@(self.page),@"pageSize":@(self.size)} success:^(HUZUlikeMajorModel * _Nonnull model) {
        HUZSTRONG_SELF
        [strongSelf removeOverFlowActivityView];
        [strongSelf.dataUlike addObjectsFromArray:model.data.list];
        [strongSelf configEmptyViewWithError:EMPTYDATA];
        [strongSelf.mj_footer endRefreshing];
        strongSelf.datas = strongSelf.dataUlike;
        if (strongSelf.page >= model.data.totalPage) {
            [strongSelf.mj_footer endRefreshingWithNoMoreData];
        }
    } failure:^(NSUInteger code, NSString * _Nonnull errorStr) {
        HUZSTRONG_SELF
        [strongSelf removeOverFlowActivityView];
        [strongSelf configEmptyViewWithError:errorStr];
        [strongSelf.mj_footer endRefreshing];
        [strongSelf reloadData];
    }];
}

/// 名企热招
- (void)loadHotData{
    HUZWEAK_SELF
    [self displayOverFlowActivityView];
    [HUZHomeService getHotList:@{@"pageNow":@(self.page),@"pageSize":@(self.size)} success:^(HUZUlikeMajorModel * _Nonnull model) {
        HUZSTRONG_SELF
        [strongSelf removeOverFlowActivityView];
        [strongSelf.dataHot addObjectsFromArray:model.data.list];
        [strongSelf configEmptyViewWithError:EMPTYDATA];
        [strongSelf.mj_footer endRefreshing];
        strongSelf.datas = strongSelf.dataHot;
        if (strongSelf.page >= model.data.totalPage) {
            [strongSelf.mj_footer endRefreshingWithNoMoreData];
        }
    } failure:^(NSUInteger code, NSString * _Nonnull errorStr) {
        HUZSTRONG_SELF
        [strongSelf removeOverFlowActivityView];
        [strongSelf configEmptyViewWithError:errorStr];
        [strongSelf.mj_footer endRefreshing];
        [strongSelf reloadData];
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HUZSearchMajorLikeCell *cell = [HUZSearchMajorLikeCell cellWithTableView:tableView];
    if (self.type == HUZSearchMajorUlike) {
        [cell reloadData:self.dataUlike[indexPath.row]];
    }else{
        [cell reloadData:self.dataHot[indexPath.row]];
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView fd_heightForCellWithIdentifier:@"HUZSearchMajorLikeCell" configuration:^(HUZSearchMajorLikeCell *cell) {
        [cell reloadData:self.dataUlike[indexPath.row]];
    }];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HUZUlikeMajorDataListModel *model = nil;
    if (indexPath.row < self.dataUlike.count) {
        model = self.dataUlike[indexPath.row];
    }
    
    
    HUZMajorInfoViewController *VC = [[HUZMajorInfoViewController alloc] init];
    VC.majorId = model.majorAllId;
    [self.YQViewController.navigationController pushViewController:VC animated:true];
}
@end
