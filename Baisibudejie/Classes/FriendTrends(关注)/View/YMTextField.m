//
//  YMTextField.m
//  ImitateBaisi
//
//  Created by 杨蒙 on 16/2/14.
//  Copyright © 2016年 hrscy. All rights reserved.
//

#import "YMTextField.h"

static NSString *const YMPlaceholderColorKeyPath = @"_placeholderLabel.textColor";

@implementation YMTextField

-(void)awakeFromNib {
    //修改占位符文字颜色
//    [self setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    //设置光标颜色和文字颜色一致
    self.tintColor = self.textColor;
    [self resignFirstResponder];
}

/**
 *  当前文本框聚焦时就会调用
 */
-(BOOL)becomeFirstResponder {
    //修改占位符文字颜色
    [self setValue:self.textColor forKeyPath:YMPlaceholderColorKeyPath];
   return [super becomeFirstResponder];
}

/**
 *  当前文本框失去焦点时就会调用
 */
-(BOOL)resignFirstResponder {
    //修改占位符文字颜色
    [self setValue:[UIColor grayColor] forKeyPath:YMPlaceholderColorKeyPath];
    return [super resignFirstResponder];
}

@end
