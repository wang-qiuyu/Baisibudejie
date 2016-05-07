//
//  YMLoginRegisterController.m
//  ImitateBaisi
//
//  Created by 杨蒙 on 16/2/14.
//  Copyright © 2016年 hrscy. All rights reserved.
//

#import "YMLoginRegisterController.h"

@interface YMLoginRegisterController ()
/** 登录框距离控制器view左边的距离*/
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginViewLeftMargin;

@property (weak, nonatomic) IBOutlet UIImageView *bgView;

@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@property (weak, nonatomic) IBOutlet UITextField *phoneField;

@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@end

@implementation YMLoginRegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view insertSubview:self.bgView atIndex:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 当前控制器的状态栏为白色
-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (IBAction)showLoginOrRegister:(UIButton *)sender {
    //退出键盘
    [self.view endEditing:YES];
    
    if (self.loginViewLeftMargin.constant == 0) { //显示注册界面
        self.loginViewLeftMargin.constant = -self.view.width;
        sender.selected = YES;
    } else {
        self.loginViewLeftMargin.constant = 0;
        sender.selected = NO;
    }
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutSubviews];
    }];
}

- (IBAction)exitButton:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
