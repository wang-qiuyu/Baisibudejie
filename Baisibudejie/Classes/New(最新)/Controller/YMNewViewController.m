//
//  YMNewViewController.m
//  ImitateBaisi
//
//  Created by 杨蒙 on 16/2/12.
//  Copyright © 2016年 hrscy. All rights reserved.
//

#import "YMNewViewController.h"

@implementation YMNewViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = YMGlobalBg;
    //设置导航栏内容
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    //导航栏左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(tagButtonClick)];
}

#pragma mark 导航栏左边的按钮点击
-(void)tagButtonClick {
    YMLog(@"%s",__func__);
}

@end
