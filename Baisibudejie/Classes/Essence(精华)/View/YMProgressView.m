//
//  YMProgressView.m
//  ImitateBaisi
//
//  Created by 杨蒙 on 16/2/24.
//  Copyright © 2016年 hrscy. All rights reserved.
//

#import "YMProgressView.h"

@implementation YMProgressView

-(void)awakeFromNib {
    self.roundedCorners = 2;
    self.progressLabel.textColor = [UIColor whiteColor];
}

-(void)setProgress:(CGFloat)progress animated:(BOOL)animated {
    [super setProgress:progress animated:animated];
    NSString *text = [NSString stringWithFormat:@"%.0f%%", progress * 100];
    self.progressLabel.text = [text stringByReplacingOccurrencesOfString:@"-" withString:@""];
}

@end
