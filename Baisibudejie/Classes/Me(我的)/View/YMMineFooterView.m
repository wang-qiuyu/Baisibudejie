//
//  YMMineFooterView.m
//  Baisibudejie
//
//  Created by 杨蒙 on 16/5/9.
//  Copyright © 2016年 hrscy. All rights reserved.
//

#import "YMMineFooterView.h"
#import "AFNetworking.h"

@implementation YMMineFooterView

-(instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self.height = 100;
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(void)drawRect:(CGRect)rect {
    [[UIImage imageNamed:@"mainCellBackground"] drawInRect:rect];
}

-(void)loadNewData {
    //请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"square";
    params[@"c"] = @"topic";
    // 发送请求给服务器
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

@end
