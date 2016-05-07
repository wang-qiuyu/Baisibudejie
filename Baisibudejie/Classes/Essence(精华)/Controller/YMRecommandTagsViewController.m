//
//  YMRecommandTagsViewController.m
//  ImitateBaisi
//
//  Created by 杨蒙 on 16/2/13.
//  Copyright © 2016年 hrscy. All rights reserved.
//

#import "YMRecommandTagsViewController.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import "MJExtension.h"
#import "YMRecommandCategory.h"
#import "YMRecommandTag.h"
#import "YMRecommandTagCell.h"

@interface YMRecommandTagsViewController ()

/**
 *  标签数据
 */
@property (nonatomic, strong) NSArray *tags;

@end

static NSString *const tagID = @"recommandTag";

@implementation YMRecommandTagsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置表格
    [self setupTableView];
    //加载数据
    [self loadTags];
}

#pragma mark 设置表格
-(void)setupTableView {
    self.navigationItem.title = @"推荐标签";
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([YMRecommandTagCell class]) bundle:nil] forCellReuseIdentifier:tagID];
    self.tableView.rowHeight = 70;
    self.tableView.backgroundColor = YMGlobalBg;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark 加载数据
-(void)loadTags {
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"tag_recommend";
    params[@"c"] = @"topic";
    params[@"action"] = @"sub";
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        self.tags = [YMRecommandTag mj_objectArrayWithKeyValuesArray:responseObject];
        //刷新表格
        [self.tableView reloadData];
        //隐藏指示器
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        //显示失败信息
        [SVProgressHUD showErrorWithStatus:@"加载标签数据失败!"];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tags.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YMRecommandTagCell *tagCell = [tableView dequeueReusableCellWithIdentifier:tagID];
    tagCell.recommandTag = self.tags[indexPath.row];
    return tagCell;
}

@end
