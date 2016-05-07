//
//  YMRecommandUserCell.m
//  ImitateBaisi
//
//  Created by 杨蒙 on 16/2/13.
//  Copyright © 2016年 hrscy. All rights reserved.
//

#import "YMRecommandUserCell.h"
#import "YMRecommandUser.h"
#import "UIImageView+WebCache.h"
#import "UIImage+YJExtension.h"

@interface YMRecommandUserCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;

@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *fansCountLabel;

@end

@implementation YMRecommandUserCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setUser:(YMRecommandUser *)user {
    
    _user = user;
    
    self.screenNameLabel.text = user.screen_name;
    if (user.fans_count < 10000) {
        self.fansCountLabel.text = [NSString stringWithFormat:@"%zd人关注",user.fans_count];
    } else {
        self.fansCountLabel.text = [NSString stringWithFormat:@"%.1f万人关注",user.fans_count / 10000.0];
    }
    
    [self.headerImageView setCircleHeader:user.header];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
