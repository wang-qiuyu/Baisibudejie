//
//  YMMineFooterView.m
//  Baisibudejie
//
//  Created by 杨蒙 on 16/5/9.
//  Copyright © 2016年 hrscy. All rights reserved.
//

#import "YMMineFooterView.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "YMSquare.h"
#import "UIButton+WebCache.h"
#import "YMSquareButton.h"
#import "YMWebViewController.h"

@implementation YMMineFooterView

-(instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        // 参数
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"a"] = @"square";
        params[@"c"] = @"topic";
        
        // 发送请求
        [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSArray *squares = [YMSquare mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
            
            // 创建方块
            [self createSquares:squares];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        }];
        
    }
    return self;
}

#pragma mark 创建方块YMSquareButton
-(void)createSquares:(NSArray *)squares {
    //一行最多 4 列
    int maxCols = 4;
    
    CGFloat buttonW = SCREENW / maxCols;
    CGFloat buttonH = buttonW;
    
    for (int i = 0; i < squares.count; i++) {
        
        YMSquareButton *button = [YMSquareButton buttonWithType:UIButtonTypeCustom];
        button.square = squares[i];
        [button addTarget:self action:@selector(buttonCLick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        int col = i % maxCols;
        int row = i / maxCols;
        
        button.x = col * buttonW;
        button.y = row * buttonH;
        button.width = buttonW;
        button.height = buttonH;
    }
    NSUInteger rows = (squares.count + maxCols - 1) / maxCols;
    //计算 footer 的长度
    self.height = rows * buttonH;
    // 重绘
    [self setNeedsDisplay];
}

-(void)buttonCLick:(YMSquareButton *)button {
    if (![button.square.url  hasPrefix:@"http"]) return;
    
    YMWebViewController *webVC = [[YMWebViewController alloc] init];
    webVC.title = button.square.name;
    
    //取出当前导航控制器
    UITabBarController *tabBarVC = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    UINavigationController *nav = (UINavigationController *)tabBarVC.selectedViewController;
    [nav pushViewController:webVC animated:YES];
}

@end
