//
//  YMTabBar.m
//  ImitateBaisi
//
//  Created by hrscy on 16/2/12.
//  Copyright © 2016年 hrscy. All rights reserved.
//

#import "YMTabBar.h"
#import "YMPublishView.h"

@interface YMTabBar ()

@property (nonatomic, weak) UIButton *publishButton;

@end

@implementation YMTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundImage = [UIImage imageNamed:@"tabbar-light"];
        //设置发布按钮
        UIButton *publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateSelected];
        [publishButton addTarget:self action:@selector(publishButtonClick) forControlEvents:UIControlEventTouchUpInside];
        publishButton.size = publishButton.currentBackgroundImage.size;
        [self addSubview:publishButton];
        self.publishButton = publishButton;
    }
    return self;
}

-(void)publishButtonClick {
    [YMPublishView show];
}

-(void)layoutSubviews {
    [super layoutSubviews];

    CGFloat width = self.width;
    CGFloat height = self.height;
    //设置发布按钮frame
    self.publishButton.center = CGPointMake(width * 0.5, height * 0.5);
    
    //设置其他按钮的frame
    CGFloat buttonY = 0;
    CGFloat buttonW = width / 5;
    CGFloat buttonH = height;
    NSInteger index = 0;
    for (UIView *button in self.subviews) {
        //如果是系统的按钮，继续执行
        if (![button isKindOfClass:NSClassFromString(@"UITabBarButton")]) continue;
//        if (!button isKindOfClass:[UIControl class] || self.publishButton) continue;
        CGFloat buttonX = buttonW * ((index > 1) ? (index + 1) : index);
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        //索引+1
        index ++;
    }
}

@end
