//
//  YMPushGuide.m
//  ImitateBaisi
//
//  Created by 杨蒙 on 16/2/14.
//  Copyright © 2016年 hrscy. All rights reserved.
//

#import "YMPushGuide.h"

@implementation YMPushGuide

+(instancetype)pushGuideView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}

+(void)show {
    NSString *key = @"CFBundleShortVersionString";
    //获得当前软件版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    //沙盒中版本号
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] stringForKey:key];
    
    if (![currentVersion isEqualToString:lastVersion]) {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        YMPushGuide *pushGuide = [YMPushGuide pushGuideView];
        pushGuide.frame = window.bounds;
        [window addSubview:pushGuide];
        //存储版本号
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (IBAction)closeBtn:(UIButton *)sender {
    [self removeFromSuperview];
}

@end
