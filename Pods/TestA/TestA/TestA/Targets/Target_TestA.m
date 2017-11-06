//
//  Targets_TestA.m
//  TestA
//
//  Created by 尹腾翔 on 2017/11/6.
//  Copyright © 2017年 尹腾翔. All rights reserved.
//

#import "Target_TestA.h"

#import "TestAViewController.h"

@implementation Target_TestA
- (void)Action_tsetAShowAlert:(NSDictionary *)params
{
    
    TestAViewController *controller = [[TestAViewController alloc] init];
    [controller testShow];
    
}

- (UIViewController *)Action_viewController:(NSDictionary *)params
{
    TestAViewController *controller = [[TestAViewController alloc] init];
    return controller;
}

@end
