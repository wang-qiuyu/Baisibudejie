//
//  YMComment.m
//  ImitateBaisi
//
//  Created by 杨蒙 on 16/3/9.
//  Copyright © 2016年 hrscy. All rights reserved.
//

#import "YMComment.h"
#import "MJExtension.h"

@implementation YMComment

+(NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"ID" : @"id",
             };
}

@end
