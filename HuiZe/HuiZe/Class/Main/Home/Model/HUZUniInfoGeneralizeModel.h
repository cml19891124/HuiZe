//
//  HUZUniInfoGeneralizeModel.h
//  HuiZe
//
//  Created by  YIQI on 2019/5/20.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZModel.h"
#import "HUZUniInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HUZUniInfoGeneralizeSchoolpicVosModel : HUZModel
@property (nonatomic, copy) NSString * schoolPic;
@end

@interface HUZUniInfoGeneralizeMajorModel : NSObject
@property (nonatomic,strong) NSString *majorAllId; /// 专业id
@property (nonatomic,strong) NSString *majorId; /// 专业id
@property (nonatomic,strong) NSString *majorName; /// 专业id

@property (nonatomic,strong) NSString *category;  /// 专业
@property (nonatomic, copy) NSString * admissionNum;//录取人数
@property (nonatomic, copy) NSString * alternativeMajorId;//备选志愿专业ID
@property (nonatomic, copy) NSString * average;//录取平均分数
@property (nonatomic, copy) NSString * minRanking;//录取最低排名
@property (nonatomic, copy) NSString * minScore;//录取最低分数
@property (nonatomic, copy) NSString * year;//录取最低分数
@property (nonatomic, copy) NSString * Id;
@property (nonatomic, copy) NSString * parentId;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, copy) NSString * ranking;

@property (nonatomic, copy) NSString * majIntroduce;

@property (nonatomic, copy) NSString * showMajIntroduce;
@property (nonatomic, strong) NSAttributedString * showMajIntroduceAttributed;
@property (nonatomic, assign) CGFloat showMajIntroduceAttributedH;

@property (nonatomic, copy) NSString * batchName;
@property (nonatomic, copy) NSString * planNum;
@property (nonatomic, copy) NSString * recruitAddress;
@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) NSString * schoolId;
@property (nonatomic, copy) NSString * province;
@property (nonatomic, copy) NSString * maxScore;
//@property (nonatomic, copy) NSString * alternative;
@property (nonatomic, copy) NSString * schoolYear;
@property (nonatomic, copy) NSString * schoolName;
@property (nonatomic, copy) NSString * admissionMajorId;
@property (nonatomic, copy) NSString * batch;
@property (nonatomic, copy) NSString * subjectId;
@property (nonatomic, copy) NSString * planType;
@property (nonatomic, copy) NSString * grade;
@property (nonatomic, copy) NSString * admission_details_id;
@property (nonatomic, copy) NSString * cost;
@property (nonatomic, copy) NSString * deliveryNum;
@property (nonatomic, copy) NSString * provinceScore;
@property (nonatomic, assign) BOOL alternative;
@end

@interface HUZUniInfoGeneralizeDataModel : NSObject
@property (nonatomic, assign) NSInteger category;  //办学层次:0本科 , 1专科
@property (nonatomic,strong) NSString *categoryName;

@property (nonatomic, assign) NSInteger schoolPrivate;//学校性质: 0 公办 1民办
//学校类型：0综合，1工科，2师范，3农业，4医药，5军事，6林业，7语言，8财经，9体育，10艺术，11政法，12民族
@property (nonatomic, copy) NSString * schoolPrivateName;
@property (nonatomic, copy) NSString * schoolTypeName;
@property (nonatomic, assign) BOOL pkSchool;//是否加入Pk 0:未加入 1已加入
@property (nonatomic, assign) NSInteger schoolType;
@property (nonatomic,strong) NSString *schoolId;   /// 学校id
@property (nonatomic,strong) NSString *schoolName; /// 学校名称
@property (nonatomic,strong) NSString *keyOne;
@property (nonatomic,strong) NSString *keyTwo;
@property (nonatomic,strong) NSString *logoUrl;  /// logo
@property (nonatomic,strong) NSString *provinceName;
@property (nonatomic,strong) NSString *uniCity;/// 城市名
@property (nonatomic,strong) NSString *admissionNum; /// 录取人数
@property (nonatomic,strong) NSString *schoolBoy; /// 男生比例
@property (nonatomic,strong) NSString *schoolGirl; /// 女生比例
@property (nonatomic,strong) NSString *schoolVideoUrl;  /// 视频链接
@property (nonatomic,strong) NSArray<NSString *> *schoolPictures;  /// 校园风光图片
@property (nonatomic,strong) NSString *introduce;  /// 校园简介
@property (nonatomic,strong) NSString *opinions; /// 报考意见
@property (nonatomic,strong) NSString *websiteUrl; /// 学校网站
@property (nonatomic,strong) NSString *recrPhone;  /// 学校电话
@property (nonatomic,strong) NSString *abroadRatio;  /// 出国比例
@property (nonatomic,strong) NSString *studyRatio;  /// 读研比例

@property (nonatomic, strong) NSArray <HUZUniInfoGeneralizeSchoolpicVosModel *> * schoolpicVos;

@property (nonatomic,strong) NSArray<HUZUniInfoGeneralizeMajorModel *> *majorAllHomeVoList;

@property (nonatomic, copy) NSString * schoolVidverUrl;//学校视频封面
@end

@interface HUZUniInfoGeneralizeModel : HUZModel

@property (nonatomic,strong) HUZUniInfoGeneralizeDataModel *data;

@end


NS_ASSUME_NONNULL_END
