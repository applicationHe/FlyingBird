//
//  RankViewController.m
//  FlyingBird
//
//  Created by apple on 16/5/13.
//  Copyright © 2016年 何万牡. All rights reserved.
//

#import "RankViewController.h"
#import "Common.h"
#import "DataTool.h"

@interface RankViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)NSArray * titles;

@property (nonatomic,strong)NSArray * ranks;

@end

@implementation RankViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _titles = [NSArray arrayWithObjects:@"Top 1",@"Top 2",@"Top 3",@"Top 4",@"Top 5", nil];

    _ranks = (NSArray *)[DataTool objectForKey:kRankKey];
    
    [self setupUI];
    
    [self setupTableView];
}
#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titles.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"myCellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
    }
    
    cell.textLabel.textColor = [UIColor orangeColor];
    cell.textLabel.font = [UIFont fontWithName:@"Marker Felt" size:20];
    cell.textLabel.text = _titles[indexPath.row];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone; //设置表格选择样式,不显示选中的样式
    cell.detailTextLabel.text = _ranks[indexPath.row];
    cell.detailTextLabel.font = [UIFont fontWithName:@"Marker Felt" size:20];
    
    return cell;
}

#pragma mark - Event Method
-(void)onBackButtonClick {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Help Handle
/**
 *  初始化UI
 */
-(void)setupUI
{
    //背景图
    UIImageView * bgImageView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    bgImageView.image = [UIImage imageNamed:@"light"];
    [self.view addSubview:bgImageView];
    
    //标题
    CGFloat titleX = (kScreenWidth - kMainTitleW)/2;
    UIImageView * titleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(titleX, 80, kMainTitleW, kMainTitleH)];
    titleImageView.image =[UIImage imageNamed:@"main"];
    [self.view addSubview:titleImageView];
    
    //返回按钮
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(40, kScreenHeight-100, 60, 40);
    [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [self.view addSubview:backButton];
    [backButton addTarget:self action:@selector(onBackButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    
}
/**
 *  初始化TableView
 */
-(void)setupTableView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(60, 160, kScreenWidth-120, kScreenHeight - 260) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.scrollEnabled = NO; //设置tableview 不能滚动
    [self.view addSubview:tableView];
    tableView.backgroundColor = [UIColor clearColor];
}
/**
 *  隐藏状态栏
 *
 *  @return <#return value description#>
 */
-(BOOL)prefersStatusBarHidden{
    return YES;
}
@end
