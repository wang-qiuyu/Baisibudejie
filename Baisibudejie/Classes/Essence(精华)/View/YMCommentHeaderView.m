//
//  YMCommentHeaderView.m
//  ImitateBaisi
//
//  Created by 杨蒙 on 16/3/19.
//  Copyright © 2016年 hrscy. All rights reserved.
//

#import "YMCommentHeaderView.h"

@interface YMCommentHeaderView ()

/** 文字*/
@property (nonatomic, weak) UILabel *label;

@end

@implementation YMCommentHeaderView

+(instancetype)headerViewTableView:(UITableView *)tableView {
    static NSString *ID = @"header";
    YMCommentHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    if (header == nil) {
        header = [[self alloc] initWithReuseIdentifier:ID];
        
    }
    return header;
}

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = YMGlobalBg;
        UILabel *label = [[UILabel alloc] init];
        label.x = YMTopicCellMargin;
        label.width = 200;
        label.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        label.textColor = YMColor(67, 67, 67);
        [self.contentView addSubview:label];
        self.label = label;
    }
    return self;
}

-(void)setTitle:(NSString *)title {
    _title = title;
    self.label.text = title;
}

@end
