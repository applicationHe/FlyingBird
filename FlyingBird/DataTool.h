//
//  DataTool.h
//  FlyingBird
//
//  Created by apple on 16/5/13.
//  Copyright © 2016年 何万牡. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataTool : NSObject

/**
 *  根据指定key获取整形值
 *
 *  @param defaultName key值
 *
 *  @return 与key值想对应的整形值
 */
+(NSInteger)integerForKey:(NSString *)defaultName;

/**
 *  设置相应的整型键值对
 *
 *  @param value       值
 *  @param defaultName 键
 */
+(void)setInteger:(NSInteger)value forKey:(NSString *)defaultName;

/**
 *  获取指定key的字符串
 *
 *  @param defaultName key值
 *
 *  @return 与key值相对应的字符串
 */
+(NSString *)stringForKey:(NSString *)defaultName;

/**
 *  获取指定key的对象值
 *
 *  @param defaultName key值
 *
 *  @return 与key值对应的对象
 */
+(instancetype)objectForKey:(NSString *)defaultName;

/**
 *  设置指定key的键值对
 *
 *  @param value       值
 *  @param defaultName 键
 */
+(void)setObject:(id)value forKey:(NSString *)defaultName;

@end
