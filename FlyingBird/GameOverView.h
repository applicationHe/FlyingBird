//
//  GameOverView.h
//  FlyingBird
//
//  Created by apple on 16/5/13.
//  Copyright © 2016年 何万牡. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GameOverViewDelegate <NSObject>

@required

/**
 *  重新开始
 */
-(void)restartAction;

/**
 *  回主菜单
 */
-(void)mainMenuAction;

@end

@interface GameOverView : UIView

@property(nonatomic,assign) id <GameOverViewDelegate>delegate;

@end
