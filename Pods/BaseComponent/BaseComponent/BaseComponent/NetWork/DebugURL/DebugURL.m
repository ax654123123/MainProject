//
//  DebugURL.m
//  BanggoPhone
//
//  Created by yintengxiang on 15/9/1.
//  Copyright (c) 2015年 BG. All rights reserved.
//

#import "DebugURL.h"
#import "OBikeHttpURLs.h"

@implementation DebugURL


+ (void)setDefaultUrl{
#ifdef DEBUG
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"DEBUG_SERVER_HOST_BIKE"]) {
        
        [[NSUserDefaults standardUserDefaults] setObject:DEBUG_SERVER_HOST_BIKE forKey:@"DEBUG_SERVER_HOST_BIKE"];
        [[NSUserDefaults standardUserDefaults] setObject:DEBUG_H5_WEBURL forKey:@"Web-url"];

        [[NSUserDefaults standardUserDefaults]  synchronize];
    }
#else
#endif
}
//PayPalEnvironmentProduction
//PayPalEnvironmentSandbox
+ (void)ChangeURLDomainName:(URLType)type
{
    switch (type) {
        case URLType1:
            [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"DEBUG_SERVER_HOST_BIKE"];
            [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"Web-url"];
            [[NSUserDefaults standardUserDefaults]  synchronize];
            break;
        case URLType2:
            [[NSUserDefaults standardUserDefaults] setObject:@"https://mobile-dev.o.bike/api/" forKey:@"DEBUG_SERVER_HOST_BIKE"];
            [[NSUserDefaults standardUserDefaults] setObject:@"-dev" forKey:@"Web-url"];
            [[NSUserDefaults standardUserDefaults]  synchronize];
            break;
        case URLType3:
            [[NSUserDefaults standardUserDefaults] setObject:@"https://mobile-release.o.bike/api/" forKey:@"DEBUG_SERVER_HOST_BIKE"];
            [[NSUserDefaults standardUserDefaults] setObject:@"-release" forKey:@"Web-url"];
            [[NSUserDefaults standardUserDefaults]  synchronize];
            break;
        case URLType4:
            [[NSUserDefaults standardUserDefaults] setObject:@"https://mobile-test.o.bike/api/" forKey:@"DEBUG_SERVER_HOST_BIKE"];
            [[NSUserDefaults standardUserDefaults] setObject:@"-test" forKey:@"Web-url"];
            [[NSUserDefaults standardUserDefaults]  synchronize];
            break;
        case URLType5:
            [[NSUserDefaults standardUserDefaults] setObject:@"https://mobile.o.bike/api/" forKey:@"DEBUG_SERVER_HOST_BIKE"];
            [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"Web-url"];
            [[NSUserDefaults standardUserDefaults]  synchronize];
            break;
            
        default:
            break;
    }

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        exit(0);
    });
    
}
@end
