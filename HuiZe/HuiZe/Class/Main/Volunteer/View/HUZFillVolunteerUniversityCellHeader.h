//
//  HUZFillVolunteerUniversityCellHeader.h
//  HuiZe
//
//  Created by tbb on 2019/10/29.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HUZFillVolunteerUniversityCellHeader : UITableViewHeaderFooterView
@property (weak, nonatomic) IBOutlet UILabel *numLb;
@property (weak, nonatomic) IBOutlet UIImageView *logoIcon;
@property (weak, nonatomic) IBOutlet UILabel *nameLb;
@property (weak, nonatomic) IBOutlet UILabel *cityLb;

@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
@end

NS_ASSUME_NONNULL_END

