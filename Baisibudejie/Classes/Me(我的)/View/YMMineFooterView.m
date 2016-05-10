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

@implementation YMMineFooterView

-(instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self.height = 100;
        self.backgroundColor = [UIColor whiteColor];
        
        //请求参数
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"a"] = @"square";
        params[@"c"] = @"topic";
        // 发送请求给服务器
        [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSArray *squares = [YMSquare mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
            //创建方块
            [self createSquare:squares];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
    }
    return self;
}

#pragma mark 创建方块YMSquareButton
-(void)createSquare:(NSArray *)squares {
    //一行最多 4 列
    int maxCols = 4;
    
    CGFloat buttonW = SCREENW / maxCols;
    CGFloat buttonH = buttonW + 30;
    
    for (int i = 0; i < squares.count; i++) {
        YMSquare *square = squares[i];
        
        YMSquareButton *button = [[YMSquareButton alloc] init];
        [button setTitle:square.name forState:UIControlStateNormal];
        [button sd_setImageWithURL:[NSURL URLWithString:square.url] forState:UIControlStateNormal];
        [self addSubview:button];
        
        int col = i % maxCols;
        int row = i / maxCols;
        
        button.x = col * buttonW;
        button.y = row * buttonH;
        button.width = buttonW;
        button.height = buttonH;
    }
    
}

-(void)drawRect:(CGRect)rect {
    [[UIImage imageNamed:@"mainCellBackground"] drawInRect:rect];
}

@end
