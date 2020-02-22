//
//  HUZVolPacketCell.h
//  HuiZe
//
//  Created by mac on 2019/4/28.
//  Copyright © 2019 yiqi. All rights reserved.
//  填报cell

#import "HUZTableViewCell.h"
@class HUZSubjectVoListModel;
NS_ASSUME_NONNULL_BEGIN

@protocol HUZVolPacketCellDelegate <NSObject>

-(void)deleteMajorIndexPath:(NSIndexPath *)indexPath;

@end

typedef void(^SelectBlock)(BOOL isSelected);
@interface HUZVolPacketCell : HUZTableViewCell
@property (nonatomic,strong) UIButton *ivBtn;
@property (nonatomic,strong) UILabel *labMajor;
@property (nonatomic,strong) UILabel *labDes1;
@property (nonatomic,strong) UILabel *labDes2;
@property (nonatomic,strong) UILabel *labDes3;
@property (nonatomic,copy) SelectBlock selectBlock;
@property (nonatomic,strong) HUZSubjectVoListModel *model;
@property (nonatomic,strong) UIButton *deleteBtn;

@property(nonatomic, weak) id<HUZVolPacketCellDelegate> delegate;
@property (nonatomic, strong) NSIndexPath * indexPath;
@end

NS_ASSUME_NONNULL_END
