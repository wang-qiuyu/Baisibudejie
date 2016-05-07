//
//  YMCommentCell.m
//  ImitateBaisi
//
//  Created by 杨蒙 on 16/3/21.
//  Copyright © 2016年 hrscy. All rights reserved.
//

#import "YMCommentCell.h"
#import "YMComment.h"
#import "YMUser.h"
#import "UIImageView+WebCache.h"
#import "UIImage+YJExtension.h"

@interface YMCommentCell ()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UIImageView *sexView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *voiceButton;
@end

@implementation YMCommentCell

- (void)awakeFromNib {
    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgView;
//    self.profileImageView.layer.cornerRadius = self.profileImageView.width * 0.5;
//    self.profileImageView.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setComment:(YMComment *)comment {
    _comment = comment;
    
    [self.profileImageView setCircleHeader:comment.user.profile_image];
    self.sexView.image = [comment.user.sex isEqualToString:YMUserSexMale] ? [UIImage imageNamed:@"Profile_manIcon"] : [UIImage imageNamed:@"Profile_womanIcon"];
    self.contentLabel.text = comment.content;
    self.usernameLabel.text = comment.user.username;
    self.likeCountLabel.text = [NSString stringWithFormat:@"%zd", comment.like_count];
    if (comment.voiceuri.length) {
        self.voiceButton.hidden = NO;
        [self.voiceButton setTitle:[NSString stringWithFormat:@"%zd", comment.voicetime] forState:UIControlStateNormal];
    } else {
        self.voiceButton.hidden = YES;
    }
}

-(void)setFrame:(CGRect)frame {
    frame.origin.x = YMTopicCellMargin;
    frame.size.width -= 2 * YMTopicCellMargin;
    [super setFrame:frame];
}

@end
