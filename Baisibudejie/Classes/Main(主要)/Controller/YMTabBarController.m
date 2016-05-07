//
//  YMTabBarController.m
//  ImitateBaisi
//
//  Created by 杨蒙 on 16/2/12.
//  Copyright © 2016年 hrscy. All rights reserved.
//

#import "YMTabBarController.h"
#import "YMNavigationController.h"
#import "YMEssenceViewController.h"
#import "YMNewViewController.h"
#import "YMFriendTrendsViewController.h"
#import "YMMeViewController.h"
#import "YMTabBar.h"

@implementation YMTabBarController

+(void)initialize {
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    
    //通过appearance统一设置tabbarItem的样式
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}

-(void)viewDidLoad {
    [super viewDidLoad];
    
    //添加子控制器
    [self setChildController:[[YMEssenceViewController alloc] init] title:@"精华" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];
    
    [self setChildController:[[YMNewViewController alloc] init] title:@"新帖" image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon"];
    
    [self setChildController:[[YMFriendTrendsViewController alloc] init] title:@"关注" image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];
    
    [self setChildController:[[YMMeViewController alloc] init] title:@"我" image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon"];
    //设置tabBar
    [self setValue:[[YMTabBar alloc] init] forKey:@"tabBar"];
}

/**
 *  初始化子控制器
 *
 *  @param vc            控制器
 *  @param title         名称
 *  @param image         默认图片
 *  @param selectedImage 选中图片
 */
-(void)setChildController:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage {
    //设置文字和图片
    vc.navigationItem.title = title;
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    //包装一个导航控制器，添加导航控制器为tabbarController的子控制器
    YMNavigationController *nav = [[YMNavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
}

@end
