//
//  YMUser.h
//  ImitateBaisi
//
//  Created by 杨蒙 on 16/3/9.
//  Copyright © 2016年 hrscy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YMUser : NSObject

/** 用户名*/
@property (nonatomic, copy) NSString *username;
/** 性别*/
@property (nonatomic, copy) NSString *sex;
/** 头像*/
@property (nonatomic, copy) NSString *profile_image;

@end
