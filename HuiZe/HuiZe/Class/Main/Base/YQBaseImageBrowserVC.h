//
//  YQBaseImageBrowserVC.h
//  Collectibles
//
//  Created by tbb on 2019/10/13.
//  Copyright © 2019 TBB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YBImageBrowser.h"
NS_ASSUME_NONNULL_BEGIN

@interface YQBaseImageBrowserVC : YBImageBrowser
- (instancetype)initImageArrUrl:(NSArray *)urls currentIndex:(NSUInteger)currentIndex sourceObject:(id)sourceObject;

@end

NS_ASSUME_NONNULL_END
