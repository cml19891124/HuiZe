//
//  HUZListModel.h
//  HuiZe
//
//  Created by  YIQI on 2019/5/7.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HUZListModel : NSObject

@property (nonatomic,assign) int currPage;   /// 当前页面
@property (nonatomic,assign) int pageSize;   /// 每页条数
@property (nonatomic,assign) int totalCount; /// 总条数
@property (nonatomic,assign) int totalPage;  /// 总页码



@end

NS_ASSUME_NONNULL_END
