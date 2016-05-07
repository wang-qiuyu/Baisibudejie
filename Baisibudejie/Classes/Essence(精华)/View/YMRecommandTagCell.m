//
//  YMRecommandTagCell.m
//  ImitateBaisi
//
//  Created by 杨蒙 on 16/2/13.
//  Copyright © 2016年 hrscy. All rights reserved.
//

#import "YMRecommandTagCell.h"
#import "YMRecommandTag.h"
#import "UIImageView+WebCache.h"
#import "UIImage+YJExtension.h"


@interface YMRecommandTagCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageListImageView;

@property (weak, nonatomic) IBOutlet UILabel *themeNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *subNameLabel;

@end

@implementation YMRecommandTagCell

- (void)awakeFromNib {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setFrame:(CGRect)frame {
    frame.origin.x = 5;
    frame.size.width -= 2 * frame.origin.x;
    frame.size.height -= 1;
    [super setFrame:frame];
}

-(void)setRecommandTag:(YMRecommandTag *)recommandTag {
    _recommandTag = recommandTag;
    
    [self.imageListImageView setCircleHeader:recommandTag.image_list];
    self.themeNameLabel.text = recommandTag.theme_name;
    NSString *fansCount = nil;
    if (recommandTag.sub_number < 10000) {
        fansCount = [NSString stringWithFormat:@"%zd人订阅",recommandTag.sub_number];
    } else {//>= 10000
        fansCount = [NSString stringWithFormat:@"%.1f万人订阅",recommandTag.sub_number / 10000.0];
    }
    self.subNameLabel.text = fansCount;
}

@end
