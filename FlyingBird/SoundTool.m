//
//  SoundTool.m
//  FlyingBird
//
//  Created by apple on 16/5/13.
//  Copyright © 2016年 何万牡. All rights reserved.
//

#import "SoundTool.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

@interface SoundTool ()

//音乐播放器
@property (nonatomic,strong)AVAudioPlayer * musicPlayer;

//使用数据字典来维护音效ID
@property (nonatomic,strong)NSDictionary * soundDict;

@end

@implementation SoundTool

#pragma mark - 加载音效

-(SystemSoundID)loadSoundIdWithBundleName:(NSBundle *)bundle name:(NSString *)name
{
    SystemSoundID soundId;
    NSString * path = [bundle pathForResource:name ofType:@"mp3"];
    NSURL * url = [NSURL fileURLWithPath:path];
    AudioServicesCreateSystemSoundID((__bridge  CFURLRef)(url), &soundId);
    return soundId;
}
#pragma mark - 加载声音文件到数据字典
-(NSDictionary *)loadSoundsWithBundle:(NSBundle *)bundle
{
    NSMutableDictionary * dictM = [[NSMutableDictionary alloc] init];
    //数组中存放所有声音的文件名
    NSArray * array = @[@"pipe",@"punch"];
    //遍历数据 创建声音ID 添加到字典
    for (NSString * name in array) {
        SystemSoundID soundId = [self loadSoundIdWithBundleName:bundle name:name];
        //使用文件名作为键值添加到字典
        [dictM setObject:@(soundId) forKey:name];
    }
    return dictM;
    
}
#pragma mark - 实例化方法
-(id)init
{
    self = [super init];
    if (self) {
        //实例化音乐播放器，作为背景音乐
        NSString * bundlePath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"sounds.bundle"];
        NSBundle * bundle = [NSBundle bundleWithPath:bundlePath];
        //音效
        self.soundDict = [self loadSoundsWithBundle:bundle];
    }
    return self;
}
#pragma mark - 使用文件名播放音效
-(void)playSoundByFileName:(NSString *)fileName
{
    SystemSoundID  soundId = [self.soundDict[fileName] unsignedIntValue];
    //播放音效
    AudioServicesPlaySystemSound(soundId);
}
@end
