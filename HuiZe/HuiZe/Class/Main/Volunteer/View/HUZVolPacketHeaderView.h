//
//  HUZVolPacketHeaderView.h
//  HuiZe
//
//  Created by mac on 2019/4/28.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HUZPacketVolListModel;

NS_ASSUME_NONNULL_BEGIN

@protocol HUZVolPacketHeaderViewDeletage <NSObject>

-(void)deleteActionSection:(NSInteger)section;

@end

typedef void(^SelectBlock)(BOOL isSelected);
@interface HUZVolPacketHeaderView : UITableViewHeaderFooterView
@property (nonatomic,strong) UIButton *ivBtn;
@property (nonatomic,strong) UIImageView *ivLogo;
@property (nonatomic,strong) UILabel *labSchool;
@property (nonatomic,strong) UILabel *labCity;
@property (nonatomic,strong) UILabel *labDes1;
@property (nonatomic,strong) UILabel *labDes2;
@property (nonatomic,strong) UILabel *labDes3;
@property (nonatomic,strong) UILabel *labDes4;
@property (nonatomic,copy) SelectBlock selectBlock;
@property (nonatomic,assign) BOOL isSelected;

@property (nonatomic, strong) UIButton * deleteBtn;

@property (nonatomic,strong) HUZPacketVolListModel *model;
@property(nonatomic, weak) id  <HUZVolPacketHeaderViewDeletage> deletage;
@property (nonatomic, assign) NSInteger section;
@end

NS_ASSUME_NONNULL_END
