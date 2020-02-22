//
//  HUZVolunteerModel.h
//  HuiZe
//
//  Created by mac on 2019/5/10.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZModel.h"
#import "HUZListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HUZVolunteer : NSObject

@property (nonatomic,copy) NSString *Id;          /// 帖子id
@property (nonatomic,strong) NSString *batch;     /// 批次：0本科批， 1本科一批，2本科二批，3本科三批，4专科批，5平行录取一段，6平行录取二段，7平行录取三段，8本科提前批 ，9国家专项计划本科批 ,
@property (nonatomic,copy) NSString * createTime;
@property (nonatomic,strong) NSString *editTime;
@property (nonatomic,strong) NSString *reasonable;
@property (nonatomic,strong) NSString *userId;
@property (nonatomic,strong) NSString *volunteerName;

/**
 0 智能 1院校优先填报 2专业 3手动填写
 */
@property (nonatomic,strong) NSString *volunteerType;
@end

@interface HUZVolunteerListModel : HUZListModel
@property (nonatomic,strong) NSArray<HUZVolunteer *> *list;

@end

@interface HUZVolunteerModel : HUZModel
@property (nonatomic,strong) HUZVolunteerListModel *data;
@end

NS_ASSUME_NONNULL_END
