//
//  HUZFillVolunteerUniversityCell.h
//  HuiZe
//
//  Created by tbb on 2019/10/29.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HUZFillVolunteerUniversityCellDelegate <NSObject>

-(void)addMajorCurrentIndexPath:(NSIndexPath *_Nullable)indexPath;
-(void)deleteMajorCurrentIndexPath:(NSIndexPath *_Nullable)indexPath;

@end

NS_ASSUME_NONNULL_BEGIN
@class HUZSchoolModel;
@interface HUZFillVolunteerUniversityCell : UITableViewCell
@property (nonatomic, strong) NSIndexPath * indexPath;
@property (nonatomic, strong) HUZSchoolModel * schoolModel;
@property(nonatomic, weak) id <HUZFillVolunteerUniversityCellDelegate> delegate;
@end

NS_ASSUME_NONNULL_END


