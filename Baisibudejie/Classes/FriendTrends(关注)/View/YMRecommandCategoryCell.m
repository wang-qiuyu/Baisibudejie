//
//  YMRecommandCategoryCell.m
//  ImitateBaisi
//
//  Created by 杨蒙 on 16/2/13.
//  Copyright © 2016年 hrscy. All rights reserved.
//

#import "YMRecommandCategoryCell.h"
#import "YMRecommandCategory.h"

@interface YMRecommandCategoryCell ()

/**
 *  选中时显示的指示器View
 */
@property (weak, nonatomic) IBOutlet UIView *selectedIndicater;

@end

@implementation YMRecommandCategoryCell

-(void)awakeFromNib {
    self.backgroundColor = YMColor(244, 244, 244);
    self.selectedIndicater.backgroundColor = YMColor(219, 21, 26);
}

-(void)setCategory:(YMRecommandCategory *)category {
    _category = category;
    self.textLabel.text = category.name;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    //重新调整内部textLabel的frame
    self.textLabel.y = 2;
    self.textLabel.height = self.contentView.height -2 * self.textLabel.y;
}

-(void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.selectedIndicater.hidden = !selected;
//    self.textLabel.textColor = selected ? YMColor(219, 21, 26) : YMColor(78, 78, 78);
    self.textLabel.textColor = selected ?  self.selectedIndicater.backgroundColor: YMColor(78, 78, 78);
}

@end
