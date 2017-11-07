//
//  RTNetworkUtil.h
//
//  Created by yintengxiang on 14-7-01.
//  Copyright (c) 2014年 BG. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "AIFNetworkUtil.h"

@implementation AIFNetworkUtil

+ (void)initAFNetworkReachabilityManager
{
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable:{
                NSLog(@"无网络");
                break;
            }
            case AFNetworkReachabilityStatusReachableViaWiFi:{
                NSLog(@"WiFi网络");
                 [[NSNotificationCenter defaultCenter] postNotificationName:KReachabilityStatusChange object:nil];
                break;
            }
            case AFNetworkReachabilityStatusReachableViaWWAN:{
                NSLog(@"蜂窝网");
                 [[NSNotificationCenter defaultCenter] postNotificationName:KReachabilityStatusChange object:nil];
                break;
            }
            default:
                break;
        }
       
    }];
}

+ (BOOL) connectedToNetwork
{
    if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus == AFNetworkReachabilityStatusNotReachable) {
        return NO;
    }
    return YES;
}

+ (AFNetworkReachabilityStatus)MBNetworkType
{
    AFNetworkReachabilityStatus status;
    
    switch ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus) {
        case AFNetworkReachabilityStatusUnknown:
            status = AFNetworkReachabilityStatusReachableViaWiFi;
            break;
        case AFNetworkReachabilityStatusNotReachable:
            status = AFNetworkReachabilityStatusNotReachable;
            break;
        case AFNetworkReachabilityStatusReachableViaWWAN:
            status = AFNetworkReachabilityStatusReachableViaWWAN;
            break;
        case AFNetworkReachabilityStatusReachableViaWiFi:
            status = AFNetworkReachabilityStatusReachableViaWiFi;
            break;
        default:
            break;
    }
    return status;
}


@end
