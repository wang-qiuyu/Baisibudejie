//
//  YMFriendTrendsViewController.m
//  ImitateBaisi
//
//  Created by 杨蒙 on 16/2/12.
//  Copyright © 2016年 hrscy. All rights reserved.
//

#import "YMFriendTrendsViewController.h"
#import "YMRecommandViewController.h"
#import "YMLoginRegisterController.h"

@implementation YMFriendTrendsViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = YMGlobalBg;
    //设置导航栏内容
    self.navigationItem.title = @"我的关注";
    //导航栏左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" highImage:@"friendsRecommentIcon-click" target:self action:@selector(friendsRecButtonClick)];
}

#pragma mark 导航栏左边的按钮点击
-(void)friendsRecButtonClick {
    YMRecommandViewController *recommandVC = [[YMRecommandViewController alloc] init];
    
    [self.navigationController pushViewController:recommandVC animated:YES];
}

- (IBAction)loginRegister:(UIButton *)sender {
    YMLoginRegisterController *login = [[YMLoginRegisterController alloc] init];
    [self presentViewController:login animated:YES completion:nil];
}


@end
