//
//  YMCommentHeaderView.h
//  ImitateBaisi
//
//  Created by 杨蒙 on 16/3/19.
//  Copyright © 2016年 hrscy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YMCommentHeaderView : UITableViewHeaderFooterView

/** 文字数据*/
@property (nonatomic, copy) NSString *title;

+(instancetype)headerViewTableView:(UITableView *)tableView;

@end
