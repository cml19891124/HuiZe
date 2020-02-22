//
//  YQBaseImageBrowserVC.m
//  Collectibles
//
//  Created by tbb on 2019/10/13.
//  Copyright © 2019 TBB. All rights reserved.
//

#import "YQBaseImageBrowserVC.h"
#import "YBIBImageData.h"
@interface YQBaseImageBrowserVC ()<YBImageBrowserDataSource>

@property (nonatomic, strong) NSMutableArray * browserDataArr;

@property (nonatomic, weak) id sourceObject;
@end

@implementation YQBaseImageBrowserVC


- (instancetype)initImageArrUrl:(NSArray *)urls currentIndex:(NSUInteger)currentIndex sourceObject:(id)sourceObject{
    self = [super init];
    if (self) {
        self.dataSource = self;
//        self.currentPage = currentIndex;
        //self.sourceObject = sourceObject;
//        [self.imageArrUrls addObjectsFromArray:urls];
        [self.browserDataArr removeAllObjects];
        for (NSString *iamgeUrlStr in urls) {
            
            if ([[NSString stringWithFormat:@"%@",iamgeUrlStr] isEqualToString:@"<null>"] || iamgeUrlStr.length == 0 ) {
                continue;
            }
            if ([iamgeUrlStr hasPrefix:@"http"]){
                // Type 3 : 网络图片 / Network image
                YBIBImageData *data = [YBIBImageData new];
                data.imageURL = [NSURL URLWithString:iamgeUrlStr];
                data.projectiveView = self.sourceObject;
                [self.browserDataArr addObject:data];
                NSLog(@"");
            }
            
        }
        
    }
    return self;
}

- (NSMutableArray *)browserDataArr {
    if (!_browserDataArr) {
        _browserDataArr = [NSMutableArray array];
    }
    return _browserDataArr;
}

/**
 返回数据源数量

 @param imageBrowser 图片浏览器
 @return 数量
 */
- (NSInteger)yb_numberOfCellsInImageBrowser:(YBImageBrowser *)imageBrowser {
    return self.browserDataArr.count;
}

/**
 返回当前下标对应的数据

 @param imageBrowser 图片浏览器
 @param index 当前下标
 @return 数据
 */
- (id<YBIBDataProtocol>)yb_imageBrowser:(YBImageBrowser *)imageBrowser dataForCellAtIndex:(NSInteger)index {
    YBIBImageData *data = nil;
    if (index < self.browserDataArr.count) {
        data = self.browserDataArr[index];
    }
    return data;
}
@end
