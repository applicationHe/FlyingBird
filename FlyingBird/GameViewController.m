//
//  GameViewController.m
//  FlyingBird
//
//  Created by apple on 16/5/13.
//  Copyright © 2016年 何万牡. All rights reserved.
//

#import "GameViewController.h"
#import "MainViewController.h"

#import "Common.h"
#import "SoundTool.h"
#import "DataTool.h"
#import "GameOverView.h"

@interface GameViewController ()<GameOverViewDelegate>
{
    UIImageView * roadImageView;
    NSTimer * timer;
    BOOL isTap;
    UIImageView * birdImageView;
    NSInteger number;
    NSInteger columnNumber;
    UIImageView *topPipeImageView;
    UIImageView * bottomPipewImageVIew;
    CGRect topPipeFrame;
    UILabel * columnLabel;
    GameOverView *overView;
    
}

@property (nonatomic,strong)SoundTool * soundTool;

@end

@implementation GameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

#pragma mark - Event Method
-(void)onTimer
{
    //底部移动动画
    CGRect frame = roadImageView.frame;
    if (frame.origin.x == -15) {
        frame.origin.x = 0;
    }
    frame.origin.x--;
    roadImageView.frame = frame;
    
    //小鸟上升动画
    if (isTap == NO) {
        CGRect frame = birdImageView.frame;
        frame.origin.y -= 3;
        number +=3;
        birdImageView.frame = frame;
        if (number >=60) {
            isTap = YES;
        }
    }
    
    //小鸟下降动画
    if (isTap == YES && birdImageView.frame.origin.y<370) {
        CGRect frame = birdImageView.frame;
        frame.origin.y++;
        number -=2;
        birdImageView.frame = frame;
        number = 0;
    }
    
    //柱子移动
    topPipeFrame = topPipeImageView.frame;
    CGRect bottomPipeFrame = bottomPipewImageVIew.frame;
    topPipeFrame.origin.x--;
    bottomPipeFrame.origin.x--;
    topPipeImageView.frame = topPipeFrame;
    bottomPipewImageVIew.frame = bottomPipeFrame;
    if (topPipeFrame.origin.x<-70) {
        [self pipe];
    }
    
    //碰撞检测(交集)
    bool topRet = CGRectIntersectsRect(birdImageView.frame, topPipeFrame);
    bool bottomRet = CGRectIntersectsRect(birdImageView.frame, bottomPipeFrame);
    if (topRet == true || bottomRet == true) {
        [self.soundTool playSoundByFileName:@"punch"];
        [self onStop];
    }
    if (topPipeFrame.origin.x==(100+30-70)) {
        [self.soundTool playSoundByFileName:@"pipe"];
        [self columnLabelClick];
    }
}
/**
 *  点击屏幕
 */
-(void)onTap
{
    isTap = NO;
}
#pragma mark - GameOverDelegate
/**
 *  重新开始
 */
-(void)restartAction
{
    NSArray * viewArr = [self.view subviews];
    for (UIView * view in viewArr) {
        [view removeFromSuperview];
    }
    [self setupUI];
}
/**
 *  回主菜单
 */
-(void)mainMenuAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - Help Handle
/**
 *  初始化UI
 */
-(void)setupUI
{
    //底图
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    imageView.image = [UIImage imageNamed:@"night"];
    [self.view addSubview:imageView];
    
    //底部图片
    roadImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, kScreenHeight-112, kScreenWidth + 50, 112)];
    roadImageView.image = [UIImage imageNamed:@"road"];
    [self.view addSubview:roadImageView];
    
    //小鸟动画
    NSMutableArray *birds = [[NSMutableArray alloc]init];
    for (NSInteger i = 1; i <= 3; i++) {
        NSString *name = [NSString stringWithFormat:@"bird%ld", i];
        UIImage *bird = [UIImage imageNamed:name];
        [birds addObject:bird];
    }
    birdImageView = [[UIImageView alloc]initWithFrame:CGRectMake(100, 180, 39, 30)];
    birdImageView.animationDuration = 1;
    birdImageView.animationImages = birds;
    birdImageView.animationRepeatCount = 0;
    [birdImageView startAnimating];
    [self.view addSubview:birdImageView];
    
    isTap = NO;
    
    //添加柱子
    [self pipe];
    
    //添加点击手势
    UIImageView * tapImageView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    tapImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer * tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap)];
    [tapImageView addGestureRecognizer:tgr];
    [self.view addSubview:tapImageView];
    
    //物理重力系数
    number = 0;
    
    //计时器
    timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(onTimer) userInfo:nil repeats:YES];
    
    columnNumber = 0;
    
    //已过柱子计数法及显示
    columnLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, kScreenWidth-40, kScreenHeight-100)];
    columnLabel.text = [NSString stringWithFormat:@"%ld",columnNumber];
    columnLabel.textAlignment = NSTextAlignmentCenter;
    columnLabel.font = [UIFont fontWithName:@"Marker Felt" size:150];
    columnLabel.textColor = [UIColor colorWithRed:0.6 green:0.5 blue:0.5 alpha:0.5];
    [self.view addSubview:columnLabel];
    [self.view insertSubview:columnLabel atIndex:2];
    
    self.soundTool = [[SoundTool alloc] init];
}
/**
 *  添加柱子
 */
-(void)pipe
{
    //通道高度
    NSInteger tunnelHeight = 0;
    //根据游戏难度设定通道高度
    if([[DataTool stringForKey:kRateKey] isEqualToString:@"ordinary"]) {
        tunnelHeight = 100;
    }else if([[DataTool stringForKey:kRateKey] isEqualToString:@"general"]) {
        tunnelHeight = 90;
    }else if([[DataTool stringForKey:kRateKey] isEqualToString:@"difficult"]) {
        tunnelHeight = 80;
    }else if([[DataTool stringForKey:kRateKey] isEqualToString:@"hard"]) {
        tunnelHeight = 75;
    } else if([[DataTool stringForKey:kRateKey] isEqualToString:@"crazy"]) {
        tunnelHeight = 70;
    }
    //柱子图像
    NSInteger tall = arc4random()%200 + 40;
    
    topPipeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(320, -20, 70, tall)];
    topPipeImageView.image = [UIImage imageNamed:@"pipe"];
    topPipeImageView.contentMode = UIViewContentModeScaleToFill;
    [self.view addSubview:topPipeImageView];
    
    bottomPipewImageVIew = [[UIImageView alloc] initWithFrame:CGRectMake(320, tall+tunnelHeight, 70, 400)];
    bottomPipewImageVIew.image = [UIImage imageNamed:@"pipe"];
    bottomPipewImageVIew.contentMode = UIViewContentModeScaleToFill;
    [self.view addSubview:bottomPipewImageVIew];
    
    //把底部图片放在柱子图上面
    [self.view insertSubview:roadImageView aboveSubview:bottomPipewImageVIew];
}
/**
 *  游戏停止
 */
-(void)onStop
{
    //更新分数
    [self updateScore];
    //停止定时器
    [timer setFireDate:[NSDate distantFuture]];
    //弹出游戏结束操作界面
    [self pullGameOver];
}
/**
 *  更新分数
 */
-(void)updateScore
{
    //更新最佳成绩
    if (columnNumber>[DataTool integerForKey:kBestScoreKey]) {
        [DataTool setInteger:columnNumber forKey:kBestScoreKey];
    }
    
    //更新本局分数
    [DataTool setInteger:columnNumber forKey:kCurrentScoreKey];

    //更新排行榜
    NSArray * ranks = (NSArray *)[DataTool objectForKey:kRankKey];
    NSMutableArray * newRanksM = [NSMutableArray array];
    NSInteger count = ranks.count;
    BOOL isupdate = NO;
    for (int i=0; i<count; i++) {
        NSString * scoreStr = ranks[i];
        NSInteger  score = [scoreStr integerValue];
        if (score <columnNumber && isupdate == NO) {
            scoreStr = [NSString stringWithFormat:@"%ld",columnNumber];
            [newRanksM addObject:scoreStr];
            isupdate = YES;
            i--;
        }else
        {
            scoreStr = [NSString stringWithFormat:@"%ld",score];
            [newRanksM addObject:scoreStr];
        }
    }
    if (newRanksM.count>count) {
        [newRanksM removeLastObject];
    }
    [DataTool setObject:newRanksM forKey:kRankKey];
}
/**
 *  弹出游戏结束操作界面
 */
-(void)pullGameOver
{
    overView = [[GameOverView alloc] initWithFrame:CGRectMake(20, 160, 280, 300)];
    overView.delegate = self;
    [self.view addSubview:overView];
}
/**
 *  更新分数
 */
-(void)columnLabelClick
{
    if (topPipeFrame.origin.x == (100 +30 -70)) {
        columnNumber++;
        columnLabel.text = [NSString stringWithFormat:@"%ld",columnNumber];
    }
}
@end
