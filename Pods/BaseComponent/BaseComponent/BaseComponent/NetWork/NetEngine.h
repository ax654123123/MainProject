//
//  NetEngine.h
//  LLProjectNetBase
//
//  Created by yintengxiang on 15/6/24.
//  Copyright (c) 2015年 LLProjectNetBase. All rights reserved.
//

#import "AFHTTPSessionManager.h"
#import "NetRequestGroup.h"

@interface NetEngine : AFHTTPSessionManager

@property (nonatomic, readonly) NetRequestGroup* requestGroup;

+ (instancetype)sharedBikeEngine;
@end
