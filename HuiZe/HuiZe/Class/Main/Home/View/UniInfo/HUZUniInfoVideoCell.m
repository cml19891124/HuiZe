//
//  HUZUniInfoVideoCell.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/24.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZUniInfoVideoCell.h"
#import <MediaPlayer/MediaPlayer.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
@interface HUZUniInfoVideoCell ()

@property (nonatomic,strong) UIImageView *ivVideo;
@property (nonatomic,strong) UIButton *btnVideo;

@end

@implementation HUZUniInfoVideoCell

+ (instancetype)cellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style{
    static NSString *ID = @"HUZUniInfoVideoCell";
    HUZUniInfoVideoCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[self alloc] initWithStyle:style reuseIdentifier:ID];
    }
    return cell;
}

+ (CGFloat)calculateHeightWithEntity:(id)entity{
    return (HUZSCREEN_WIDTH-AutoDistance(30)) * 0.498 + AutoDistance(28);
}

- (void)initView{
    
    _ivVideo = [[UIImageView alloc] initWithFrame:CGRectMake(AutoDistance(15), 0, HUZSCREEN_WIDTH-AutoDistance(30), (HUZSCREEN_WIDTH-AutoDistance(30)) * 0.498)];
    _ivVideo.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:_ivVideo];
    ViewRadius(_ivVideo, AutoDistance(12));
    
    _btnVideo = [[UIButton alloc] initWithImage:ImageNamed(@"btn_video_play")];
    [self.contentView addSubview:_btnVideo];
    [_btnVideo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(AutoDistance(48), AutoDistance(48)));
    }];
    [self.btnVideo addTarget:self action:@selector(playAction:) forControlEvents:(UIControlEventTouchUpInside)];
}

- (void)setUniInfoModel:(HUZUniInfoGeneralizeDataModel *)uniInfoModel{
    _uniInfoModel = uniInfoModel;
    [_ivVideo sd_setImageWithURL:[NSURL URLWithString:uniInfoModel.schoolVidverUrl] placeholderImage:ImageNamed(DEFAULT_IMAGE)];
    
}
-(void)playAction:(UIButton *)sender {
    //1.先自定义一个全局的MPMoviePlayerViewController 对象
//    AVPlayerViewController *mPMoviePlayerViewController;
    //2.把下面的代码放到跳转播放的按钮方法里面
//    mPMoviePlayerViewController = [[AVPlayerViewController alloc] initWithContentURL:[NSURL URLWithString:self.uniInfoModel.schoolVideoUrl]];
//    mPMoviePlayerViewController.view.frame = CGRectMake(0, 100, 414, 300);
//    [self.YQViewController presentViewController:mPMoviePlayerViewController animated:YES completion:nil];
    
    AVPlayer *avPlayer= [AVPlayer playerWithURL:[NSURL URLWithString:self.uniInfoModel.schoolVideoUrl]];
    // player的控制器对象
    AVPlayerViewController *playerViewController = [[AVPlayerViewController alloc] init];
       // 控制器的player播放器
    playerViewController.player = avPlayer;
    // 试图的填充模式
    playerViewController.videoGravity = AVLayerVideoGravityResizeAspect;
       // 是否显示播放控制条
    playerViewController.showsPlaybackControls = YES;
       // 设置显示的Frame
    playerViewController.view.frame = self.YQViewController.view.bounds;
       // 将播放器控制器添加到当前页面控制器中
    [self.YQViewController addChildViewController:playerViewController];
       // view一定要添加，否则将不显示
    [self.YQViewController.view addSubview:playerViewController.view];
       // 播放
    [playerViewController.player play];
}
@end
