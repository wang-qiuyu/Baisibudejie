//
//  YMTopicCell.m
//  ImitateBaisi
//
//  Created by 杨蒙 on 16/2/16.
//  Copyright © 2016年 hrscy. All rights reserved.
//

#import "YMTopicCell.h"
#import "YMTopic.h"
#import "UIImageView+WebCache.h"
#import "YMTopicPictureView.h"
#import "YMVoiceView.h"
#import "YMVideoView.h"
#import "YMComment.h"
#import "YMUser.h"
#import "UIImage+YJExtension.h"

@interface YMTopicCell ()
/** 头像*/
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
/** 昵称*/
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/** 创建时间*/
@property (weak, nonatomic) IBOutlet UILabel *createTimeLabel;
/** 顶按钮*/
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
/** 踩按钮*/
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
/** 分享按钮*/
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
/** 评论按钮*/
@property (weak, nonatomic) IBOutlet UIButton *commentBuuton;
/** 新浪加v*/
@property (weak, nonatomic) IBOutlet UIImageView *sina_vImageView;
/** 帖子的文字内容*/
@property (weak, nonatomic) IBOutlet UILabel *text_label;

/** 图片帖子中间的内容*/
@property (nonatomic, weak) YMTopicPictureView *pictureView;
/** 声音帖子中间的内容*/
@property (nonatomic, weak) YMVoiceView *voiceView;
/** 视频帖子中间的内容*/
@property (nonatomic, weak) YMVideoView *videoView;
/** 最热评论的内容*/
@property (weak, nonatomic) IBOutlet UILabel *topCmtContentLabel;
/** 最热评论的整体*/
@property (weak, nonatomic) IBOutlet UIView *topCmtView;

@end

@implementation YMTopicCell

+(instancetype)cell {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}

- (void)awakeFromNib {
    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgView;
//    self.profileImageView.layer.cornerRadius = self.profileImageView.width * 0.5;
//    self.profileImageView.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(YMVideoView *)videoView{
    if (_videoView  == nil) {
        YMVideoView *videoView = [YMVideoView videoView];
        [self.contentView addSubview:videoView];
        _videoView = videoView;
    }
    return _videoView;
}

-(YMVoiceView *)voiceView{
    if (_voiceView == nil) {
        YMVoiceView *voiceView = [YMVoiceView voiceView];
        [self.contentView addSubview:voiceView];
        _voiceView = voiceView;
    }
    return _voiceView;
}

-(YMTopicPictureView *)pictureView{
    if (_pictureView == nil) {
        YMTopicPictureView *pictureView = [YMTopicPictureView pictureView];
        [self.contentView addSubview:pictureView];
        _pictureView = pictureView;
    }
    return _pictureView;
}

-(void)setTopic:(YMTopic *)topic {
    _topic = topic;
    //新浪加V
    self.sina_vImageView.hidden = !topic.sina_v;
    //设置头像
    [self.profileImageView setCircleHeader:topic.profile_image];
    //设置名字
    self.nameLabel.text = topic.name;
    //设置帖子的创建时间
    self.createTimeLabel.text = topic.create_time;
    //设置帖子的文字内容
    self.text_label.text = topic.text;
    
    //设置按钮的文字
    [self setupButtonTitle:self.dingButton count:topic.ding placeholder:@"顶"];
    [self setupButtonTitle:self.caiButton count:topic.cai placeholder:@"踩"];
    [self setupButtonTitle:self.shareButton count:topic.repost placeholder:@"分享"];
    [self setupButtonTitle:self.commentBuuton count:topic.comment placeholder:@"评论"];
    
    //根据模型类型（帖子类型）添加到对应的内容cell中间
    // 根据模型类型(帖子类型)添加对应的内容到cell的中间
    if (topic.type == YMTopicTypePicture) { // 图片帖子
        self.pictureView.hidden = NO;
        self.pictureView.topic = topic;
        self.pictureView.frame = topic.pictureF;
        
        self.voiceView.hidden = YES;
        self.videoView.hidden = YES;
    } else if (topic.type == YMTopicTypeVoice) { // 声音帖子
        self.voiceView.hidden = NO;
        self.voiceView.topic = topic;
        self.voiceView.frame = topic.voiceF;
        
        self.pictureView.hidden = YES;
        self.videoView.hidden = YES;
    } else if (topic.type == YMTopicTypeVideo) { // 视频帖子
        self.videoView.hidden = NO;
        self.videoView.topic = topic;
        self.videoView.frame = topic.videoF;
        
        self.voiceView.hidden = YES;
        self.pictureView.hidden = YES;
    } else { // 段子帖子
        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
        self.pictureView.hidden = YES;
    }
    //处理最热评论
    if (topic.top_cmt) {
        self.topCmtView.hidden = NO;
        self.topCmtContentLabel.text = [NSString stringWithFormat:@"%@:%@", topic.top_cmt.user.username, topic.top_cmt.content];
    } else {
        self.topCmtView.hidden = YES;
    }
}

-(void)setupButtonTitle:(UIButton *)button count:(NSInteger)count placeholder:(NSString *)placeholder {
    if (count > 10000) {
        placeholder = [NSString stringWithFormat:@"%.1f万", count / 10000.0];
    } else if (count > 0) {
        placeholder = [NSString stringWithFormat:@"%zd", count];
    }
    [button setTitle:placeholder forState:UIControlStateNormal];
}

-(void)setFrame:(CGRect)frame {
    
    frame.origin.x = YMTopicCellMargin;
    frame.size.width -= 2 * YMTopicCellMargin;
    frame.size.height = self.topic.cellHeight - YMTopicCellMargin;
    frame.origin.y += YMTopicCellMargin;
    
    [super setFrame:frame];
}

- (IBAction)more {
    
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"收藏", @"举报", nil];
    [sheet showInView:self.window];
}


@end
