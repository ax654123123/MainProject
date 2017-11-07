//
//  DebugURL.h
//  BanggoPhone
//
//  Created by yintengxiang on 15/9/1.
//  Copyright (c) 2015年 BG. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    URLType1 = 0,// 外网开发环境
    URLType2,// 开发环境
    URLType3,// 预发布环境
    URLType4,// 给测试组
    URLType5,// 正式环境
} URLType;

@interface DebugURL : NSObject
//在debug状态下优先设置一个默认的网络请求域名
+ (void)setDefaultUrl;

//切换环境
+ (void)ChangeURLDomainName:(URLType)type;
@end
