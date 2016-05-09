//
//  YMMeViewController.m
//  ImitateBaisi
//
//  Created by 杨蒙 on 16/2/12.
//  Copyright © 2016年 hrscy. All rights reserved.
//

#import "YMMeViewController.h"
#import "YMMineCell.h"
#import "YMMineFooterView.h"

@implementation YMMeViewController

static NSString *mineID = @"mine";

-(void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    
    [self setupTableView];
    
    
    
}

-(void)setupNav {
    self.view.backgroundColor = YMGlobalBg;
    //设置导航栏内容
    self.navigationItem.title = @"我的";
    //导航栏左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"nav_coin_icon" highImage:@"nav_coin_icon_click" target:self action:@selector(coinButtonClick)];
    
    //导航栏右边的按钮
    self.navigationItem.rightBarButtonItems = @[[UIBarButtonItem itemWithImage:@"mine-setting-icon" highImage:@"mine-setting-icon-click" target:self action:@selector(settingButtonClick)], [UIBarButtonItem itemWithImage:@"mine-moon-icon" highImage:@"mine-moon-icon-click" target:self action:@selector(moonButtonClick)]];
}

-(void)setupTableView {
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[YMMineCell class] forCellReuseIdentifier:mineID];
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = YMTopicCellMargin;
    //往上移动 25
    self.tableView.contentInset = UIEdgeInsetsMake(YMTopicCellMargin - 35, 0, 0, 0);
    //设置footerView
    self.tableView.tableFooterView = [[YMMineFooterView alloc] init];
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

#pragma mark -UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:mineID];
    if (indexPath.section == 0) {
        cell.imageView.image = [UIImage imageNamed:@"setup-head-default"];
        cell.textLabel.text = @"登录/注册";
    } else if (indexPath.section == 1) {
        cell.textLabel.text = @"离线下载";
    }
    
    return cell;
}

#pragma mark -UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


@end
