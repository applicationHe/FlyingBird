//
//  RateViewController.m
//  FlyingBird
//
//  Created by apple on 16/5/13.
//  Copyright © 2016年 何万牡. All rights reserved.
//

#import "RateViewController.h"
#import "Common.h"
#import "DataTool.h"

@interface RateViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)NSArray * rates;

@end

@implementation RateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _rates = [NSArray arrayWithObjects:@"crazy", @"hard", @"difficult", @"general", @"ordinary", nil];

    [self setupUI];
    
    [self setupTableView];
    
}
#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _rates.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellId = @"myCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.text = _rates[indexPath.row];
    cell.textLabel.font = [UIFont fontWithName:@"Marker Felt" size:18];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if ([cell.textLabel.text isEqualToString:[DataTool stringForKey:kRateKey]]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        cell.textLabel.textColor = [UIColor redColor];
    }else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.textLabel.textColor = [UIColor orangeColor];
    }
    return cell;
}
#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [DataTool setObject:_rates[indexPath.row] forKey:kRateKey];

    [tableView reloadData];
}
#pragma mark - Event Method
-(void)goback
{
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
    CGFloat titleX = (kScreenWidth-kMainTitleW)/2;
    UIImageView * titleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(titleX, 80, kMainTitleW, kMainTitleH)];
    titleImageView.image = [UIImage imageNamed:@"main"];
    [self.view addSubview:titleImageView];
    
    //提示语
    CGFloat tipsW = 280;
    CGFloat tipsH = 40;
    CGFloat tipsX = (kScreenWidth - tipsW)/2;
    UILabel * tipsLabel = [[UILabel alloc] initWithFrame:CGRectMake(tipsX, 150, tipsW, tipsH)];
    tipsLabel.text = @"The game difficulty";
    tipsLabel.font = [UIFont fontWithName:@"Marker Felt" size:30];
    tipsLabel.textAlignment = NSTextAlignmentCenter;
    tipsLabel.textColor = [UIColor orangeColor];
    [self.view addSubview:tipsLabel];
    
    //返回键
    UIButton * backBtn = [[UIButton alloc] initWithFrame:CGRectMake(40, kScreenHeight-100, 60, 40)];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(goback) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    [self.view bringSubviewToFront:backBtn];
    
}

/**
 *  初始化TableView
 */
-(void)setupTableView
{
    CGFloat x = 80;
    UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(x, 190, kScreenWidth-2*x, kScreenHeight-330) style:UITableViewStyleGrouped];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.scrollEnabled = NO;
    [self.view addSubview:tableView];
    
}
/**
 *  隐藏状态栏
 *
 *  @return <#return value description#>
 */
-(BOOL)prefersStatusBarHidden
{
    return YES;
}
@end
