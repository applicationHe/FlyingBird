//
//  MainViewController.m
//  FlyingBird
//
//  Created by apple on 16/5/13.
//  Copyright © 2016年 何万牡. All rights reserved.
//

#import "MainViewController.h"
#import "Common.h"
#import "DataTool.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化数据
    [self dataSourceInit];
    //初始化UI
    [self setupUI];
}

#pragma mark - Event Method
/**
 *  点击了速度
 */
-(void)onRateButtonClick{
    NSLog(@"点击了速度");
}

/**
 *  点击了开始
 */
-(void)onStartButtonClick{
   NSLog(@"点击了开始");
}

/**
 *  点击了排行榜
 */
-(void)onRankButtonClick{
    NSLog(@"点击了排行榜");
}

#pragma mark - Help Handle
/**
 *  初始化数据
 */
-(void)dataSourceInit
{
    if ([DataTool stringForKey:kRateKey] == nil) {
        [DataTool setObject:@"general" forKey:kRateKey];
    }
    if ([DataTool objectForKey:kRankKey] == nil) {
        NSArray * ranks = [NSArray arrayWithObjects:@"0",@"0",@"0",@"0",@"0", nil];
        [DataTool setObject:ranks forKey:kRankKey];
    }
}
/**
 *  初始化UI
 */
-(void)setupUI
{
    //背景图
    UIImageView * bgImageView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    bgImageView.image = [UIImage imageNamed:@"bg"];
    [self.view addSubview:bgImageView];
    
    //标题
    CGFloat titleX = (kScreenWidth - kMainTitleW)/2;
    UIImageView * titleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(titleX, 80, kMainTitleW, kMainTitleH)];
    titleImageView.image = [UIImage imageNamed:@"main"];
    [self.view addSubview:titleImageView];
    
    //显示分数
    CGFloat scoreViewX = (kScreenWidth-kScoreViewW)/2;
    UIImageView * scoreImageView = [[UIImageView alloc] initWithFrame:CGRectMake(scoreViewX, 205, kScoreViewW, kScoreViewH)];
    scoreImageView.image = [UIImage imageNamed:@"score"];
    [self.view addSubview:scoreImageView];
    
    //显示分数
    CGFloat bestX = 200;
    CGFloat bestY = 285;
    CGFloat bestW = 40;
    CGFloat bestH = 20;
    UILabel * bestScoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(bestX, bestY, bestW, bestH)];
    bestScoreLabel.text = [NSString stringWithFormat:@"%zi",[DataTool integerForKey:kBestScoreKey]];
    bestScoreLabel.font = [UIFont fontWithName:@"Marker Felt" size:16];
    bestScoreLabel.textAlignment = NSTextAlignmentRight;
    bestScoreLabel.textColor = [UIColor orangeColor];
    [self.view addSubview:bestScoreLabel];
    
    CGFloat scoreX = 200;
    CGFloat scoreY = 240;
    CGFloat scoreW = 40;
    CGFloat scoreH = 20;
    UILabel * scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(scoreX, scoreY, scoreW, scoreH)];
    scoreLabel.text = [NSString stringWithFormat:@"%zi",[DataTool integerForKey:kCurrentScoreKey]];
    scoreLabel.font = [UIFont fontWithName:@"Marker Felt" size:16];
    scoreLabel.textAlignment = NSTextAlignmentRight;
    scoreLabel.textColor = [UIColor orangeColor];
    [self.view addSubview:scoreLabel];
    
    //bird动画
    NSMutableArray * birds = [[NSMutableArray alloc] init];
    UIImageView * birdImageView = [[UIImageView alloc] initWithFrame:CGRectMake(140, 155, 40, 32)];
    for (int i=0; i<3; i++) {
        UIImage * birdImage = [UIImage imageNamed:[NSString stringWithFormat:@"bird%d",i+1]];
        [birds addObject:birdImage];
    }
    birdImageView.animationImages = birds;
    birdImageView.animationDuration = 1;
    birdImageView.animationRepeatCount = 0;
    [birdImageView startAnimating];
    [self.view addSubview:birdImageView];
    
    //创建速度按钮
    UIButton *rateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat rateX = (kScreenWidth - kRateButtonW) / 2;
    rateButton.frame = CGRectMake(rateX, 355, kRateButtonW, kRateButtonH);
    [rateButton setImage:[UIImage imageNamed:@"rate"] forState:UIControlStateNormal];
    [self.view addSubview:rateButton];
    
    //创建开始按钮
    UIButton *startButton = [UIButton buttonWithType:UIButtonTypeCustom];
    startButton.frame = CGRectMake(50, 430, kStartButtonW, kStartButtonH);
    [startButton setImage:[UIImage imageNamed:@"start"] forState:UIControlStateNormal];
    [self.view addSubview:startButton];
    
    //创建排行榜按钮
    UIButton *rankButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rankButton.frame = CGRectMake(170, 430, kRankButtonW, kRankButtonH);
    [rankButton setImage:[UIImage imageNamed:@"rank"] forState:UIControlStateNormal];
    [self.view addSubview:rankButton];
    
    //点击事件
    [startButton addTarget:self action:@selector(onStartButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [rankButton addTarget:self action:@selector(onRankButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [rateButton addTarget:self action:@selector(onRateButtonClick) forControlEvents:UIControlEventTouchUpInside];
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
