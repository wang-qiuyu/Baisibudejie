//
//  YMMeViewController.m
//  ImitateBaisi
//
//  Created by 杨蒙 on 16/2/12.
//  Copyright © 2016年 hrscy. All rights reserved.
//

#import "YMMeViewController.h"

@implementation YMMeViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = YMGlobalBg;
    //设置导航栏内容
    self.navigationItem.title = @"我的";
    //导航栏左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"nav_coin_icon" highImage:@"nav_coin_icon_click" target:self action:@selector(coinButtonClick)];
    
    //导航栏右边的按钮
    self.navigationItem.rightBarButtonItems = @[
        [UIBarButtonItem itemWithImage:@"mine-setting-icon" highImage:@"mine-setting-icon-click" target:self action:@selector(settingButtonClick)],
        [UIBarButtonItem itemWithImage:@"mine-moon-icon" highImage:@"mine-moon-icon-click" target:self action:@selector(moonButtonClick)]
    ];
}

#pragma mark 导航栏左边的按钮点击
-(void)coinButtonClick {
    YMLogFunc;
}

#pragma mark 导航栏夜间模式按钮点击
-(void)moonButtonClick {
    YMLogFunc;
}

#pragma mark 导航栏右边设置的按钮点击
-(void)settingButtonClick {
    YMLogFunc;
}

@end
