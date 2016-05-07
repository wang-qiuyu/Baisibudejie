//
//  YMVideoView.m
//  ImitateBaisi
//
//  Created by 杨蒙 on 16/3/8.
//  Copyright © 2016年 hrscy. All rights reserved.
//

#import "YMVideoView.h"
#import "YMTopic.h"
#import "UIImageView+WebCache.h"
#import "YMShowPictureViewController.h"

@interface YMVideoView ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UILabel *videotimeLabel;

@property (weak, nonatomic) IBOutlet UILabel *playcountLabel;

@end

@implementation YMVideoView

-(void)setTopic:(YMTopic *)topic {
    _topic = topic;
    //图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
    //播放次数
    self.playcountLabel.text = [NSString stringWithFormat:@"%zd播放", topic.playcount];
    //时长
    NSInteger minute = topic.videotime / 60;
    NSInteger second = topic.videotime % 60;
    self.videotimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd", minute, second];
    
}

+(instancetype)videoView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}

-(void)awakeFromNib {
    
    //如果发现控件的位置和尺寸不是自己设置的，那么有可能是自动伸缩属性导致
    self.autoresizingMask = UIViewAutoresizingNone;
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPicture)]];
}

-(void)showPicture {
    YMShowPictureViewController *showPictureVC = [[YMShowPictureViewController alloc] init];
    showPictureVC.topic = self.topic;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:showPictureVC animated:YES completion:nil];
}

@end
