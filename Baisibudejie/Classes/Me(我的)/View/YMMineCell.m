//
//  YMMineCell.m
//  Baisibudejie
//
//  Created by 北京龙链科技有限公司 on 16/5/9.
//  Copyright © 2016年 hrscy. All rights reserved.
//

#import "YMMineCell.h"

@implementation YMMineCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        UIImageView *bgView = [[UIImageView alloc] init];
        bgView.image = [UIImage imageNamed:@"mainCellBackground"];
        self.backgroundView = bgView;
        self.textLabel.textColor = [UIColor lightGrayColor];
        self.textLabel.font = [UIFont systemFontOfSize:16];
    }
    
    return self;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    if (self.imageView.image == nil) return;
    
    self.imageView.width = 30;
    self.imageView.height = self.imageView.width;
    self.imageView.centerY = self.contentView.height * 0.5;
    
    self.textLabel.x = CGRectGetMaxX(self.imageView.frame) + YMTopicCellMargin;
}

//-(void)setFrame:(CGRect)frame {
//    frame.origin.y -= (35 - YMTopicCellMargin);
//    [super setFrame:frame];
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
