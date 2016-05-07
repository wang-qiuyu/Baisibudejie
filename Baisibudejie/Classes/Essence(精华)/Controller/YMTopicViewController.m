//
//  YMWordTableViewController.m
//  ImitateBaisi
//
//  Created by 杨蒙 on 16/2/15.
//  Copyright © 2016年 hrscy. All rights reserved.
//

#import "YMTopicViewController.h"
#import "AFHTTPSessionManager.h"
#import "UIImageView+WebCache.h"
#import "YMTopic.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "YMTopicCell.h"
#import "YMCommentViewController.h"
#import "UIView+YMExtension.h"

@interface YMTopicViewController ()

/** 帖子*/
@property (nonatomic, strong) NSMutableArray *topics;
/** 页码*/
@property (nonatomic, assign) NSInteger page;
/** 当加载下一页数据时需要这个参数*/
@property (nonatomic, copy) NSString *maxtime;

/** 上一次请求参数*/
@property (nonatomic, strong) NSDictionary *parmas;

/** 上一次选中 tabBar 的索引*/
@property (nonatomic, assign) NSInteger lastSelectedIndex;

@end

@implementation YMTopicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化表格
    [self setupTableView];
    
    //添加刷新控件
    [self setupRefresh];
}

static NSString *const YMTopicCellID = @"topic";

#pragma mark 初始化表格
-(void)setupTableView {
    //设置内边距
    CGFloat bottom = self.tabBarController.tabBar.height;
    CGFloat top = YMTitlesViewY + YMTitlesViewH;
    self.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    //设置滚动条的内边距
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    //注册
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([YMTopicCell class]) bundle:nil] forCellReuseIdentifier:YMTopicCellID];
    
    // 监听 tabBar 点击的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarSelected) name:YMTabBarDidSelectedNotification object:nil];
    
}

-(void)tabBarSelected {
    
    //如果是连点 2 次，并且 如果选中的是当前导航控制器，刷新
    if (self.lastSelectedIndex != self.tabBarController.selectedIndex && self.view.isShowingOnKeyWindow) {
        [self.tableView.mj_header beginRefreshing];
    };
    
    self.lastSelectedIndex = self.tabBarController.selectedIndex;
    
}

#pragma mark 添加刷新控件
-(void)setupRefresh {
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
}

#pragma mark 数据处理
-(void)loadNewTopics {
    //结束上拉
    [self.tableView.mj_footer endRefreshing];
    //请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    self.parmas = params;
    // 发送请求给服务器
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (self.parmas != params) return;
        //存储maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        self.topics = [YMTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.tableView reloadData];
        //结束刷新
        [self.tableView.mj_header endRefreshing];
        //清空页码
        self.page = 0;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //结束刷新
        [self.tableView.mj_header endRefreshing];
        //回复页码
        self.page--;
    }];
}

#pragma mark 加载更多数据
-(void)loadMoreTopics {
    //结束下拉
    [self.tableView.mj_header endRefreshing];
    
    self.page ++;
    //请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    params[@"page"] = @(self.page);
    params[@"maxtime"] = self.maxtime;
    self.parmas = params;
    // 发送请求给服务器
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (self.parmas != params) return;
        
        NSArray *newTopics = [YMTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.topics addObjectsFromArray:newTopics];
        //刷新表格
        [self.tableView reloadData];
        //结束刷新
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //结束刷新
        [self.tableView.mj_footer endRefreshing];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //取出帖子模型
    YMTopic *topic = self.topics[indexPath.row];
    //返回这个cell对应的高度
    return topic.cellHeight;
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    self.tableView.mj_footer.hidden = (self.topics.count == 0);
    return self.topics.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YMTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:YMTopicCellID];
    cell.topic = self.topics[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    YMCommentViewController *commetnVC = [[YMCommentViewController alloc] init];
    commetnVC.topic = self.topics[indexPath.row];
    [self.navigationController pushViewController:commetnVC animated:YES];
}

-(NSMutableArray *)topics{
    if (_topics == nil) {
        _topics = [[NSMutableArray alloc] init];
    }
    return _topics;
}

@end
