//
//  HUZSearchingCell.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/20.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZSearchingCell.h"
#import "HUZSearchKeywordModel.h"

@implementation HUZSearchingCell

+ (instancetype)cellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style{
    static NSString *ID = @"HUZSearchingCell";
    HUZSearchingCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[self alloc] initWithStyle:style reuseIdentifier:ID];
    }
    return cell;
}

- (void)initView{
    self.labContent = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_14)];
    self.labContent.frame = CGRectMake(AutoDistance(27), AutoDistance(6), HUZSCREEN_WIDTH-AutoDistance(60), AutoDistance(20));
    [self.contentView addSubview:self.labContent];
}

- (void)reloadData:(id)entity keyword:(nonnull NSString *)keyword{
    if ([entity isKindOfClass:[HUZSearchKeywordDataUniModel class]]) {
        HUZSearchKeywordDataUniModel *model = (HUZSearchKeywordDataUniModel *)entity;
        self.labContent.text = model.schoolName;
        NSRange range = [model.schoolName rangeOfString:keyword];
        [self.labContent addAttributestring:self.labContent.text font:FontS(FONT_14) color:ColorS(COLOR_2E86FF) range:range];
    }
    
    else if ([entity isKindOfClass:[HUZSearchKeywordDataSubjectModel class]]){
        HUZSearchKeywordDataSubjectModel *model = (HUZSearchKeywordDataSubjectModel *)entity;
        NSString *majorStr = [NSString stringWithFormat:@"%@-%@",model.schoolName,model.category];
        self.labContent.text = majorStr;
        NSRange range = [majorStr rangeOfString:keyword];
        [self.labContent addAttributestring:self.labContent.text font:FontS(FONT_14) color:ColorS(COLOR_2E86FF) range:range];
    }
}
@end
