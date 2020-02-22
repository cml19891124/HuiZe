//
//  HUZUniInfoGeneralizeModel.m
//  HuiZe
//
//  Created by  YIQI on 2019/5/20.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZUniInfoGeneralizeModel.h"

@implementation HUZUniInfoGeneralizeSchoolpicVosModel

@end

@implementation HUZUniInfoGeneralizeMajorModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"Id"  : @"id"};
}
-(void)setShowMajIntroduce:(NSString *)showMajIntroduce {
    _showMajIntroduce = showMajIntroduce;
    _showMajIntroduceAttributed = nil;
    _showMajIntroduceAttributedH = 0.0;
}
-(NSAttributedString *)showMajIntroduceAttributed {
    if (!_showMajIntroduceAttributed && self.showMajIntroduce) {
        //    textview 改变字体的行间距
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = 4;// 字体的行间距
        NSDictionary *attributes = @{
                                     
                                     NSFontAttributeName:[UIFont systemFontOfSize:12 weight:(UIFontWeightMedium)],
                                     
                                     NSParagraphStyleAttributeName:paragraphStyle,
                                     
                                     NSForegroundColorAttributeName:ColorS(COLOR_989898)
                                     
                                     };
        _showMajIntroduceAttributed =  [[NSAttributedString alloc] initWithString:self.showMajIntroduce attributes:attributes];
    }
    return _showMajIntroduceAttributed;
}

-(CGFloat)showMajIntroduceAttributedH {
    if (_showMajIntroduceAttributedH == 0.0 && self.showMajIntroduceAttributed) {
        CGSize size = [self.showMajIntroduceAttributed boundingRectWithSize:CGSizeMake(HUZSCREEN_WIDTH - 71, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size;
        _showMajIntroduceAttributedH = ceilf(size.height) + 2;
    }
    return _showMajIntroduceAttributedH + 8;//上下边距
}

@end

@implementation HUZUniInfoGeneralizeDataModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"majorAllHomeVoList":[HUZUniInfoGeneralizeMajorModel class],@"schoolpicVos":[HUZUniInfoGeneralizeSchoolpicVosModel class]};
}
-(NSString *)schoolTypeName {
    if (!_schoolTypeName || _schoolTypeName.length == 0) {
        switch (self.schoolType) {
            case 0:
                _schoolTypeName = @"综合";
                break;
            case 1:
                _schoolTypeName = @"工科";
                break;
            case 2:
                _schoolTypeName = @"师范";
                break;
            case 3:
                _schoolTypeName = @"农业";
                break;
            case 4:
                _schoolTypeName = @"医药";
                break;
            case 5:
                _schoolTypeName = @"军事";
                break;
            case 6:
                _schoolTypeName = @"林业";
                break;
            case 7:
                _schoolTypeName = @"语言";
                break;
            case 8:
                _schoolTypeName = @"财经";
                break;
            case 9:
                _schoolTypeName = @"体育";
                break;
            case 10:
                _schoolTypeName = @"艺术";
                break;
            case 11:
                _schoolTypeName = @"政法";
                break;
            case 12:
                _schoolTypeName = @"民族 ";
                break;
                
            default:
                break;
        }
    }
    return _schoolTypeName;
}
@end

@implementation HUZUniInfoGeneralizeModel

@end


