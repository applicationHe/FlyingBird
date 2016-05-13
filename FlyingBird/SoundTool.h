//
//  SoundTool.h
//  FlyingBird
//
//  Created by apple on 16/5/13.
//  Copyright © 2016年 何万牡. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SoundTool : NSObject

/**
 *  播放指定名称的音乐
 *
 *  @param fileName 音效文件名
 */
-(void)playSoundByFileName:(NSString *)fileName;

@end
