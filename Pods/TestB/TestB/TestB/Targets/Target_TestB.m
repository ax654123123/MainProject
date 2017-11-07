//
//  Target_TestB.m
//  TestB
//
//  Created by 尹腾翔 on 2017/11/7.
//  Copyright © 2017年 尹腾翔. All rights reserved.
//

#import "Target_TestB.h"

#import "TestBViewController.h"

@implementation Target_TestB

- (void)Action_tsetBShowAlert:(NSDictionary *)params
{
    
    TestBViewController *controller = [[TestBViewController alloc] init];
    [controller testShow];
    
}

- (UIViewController *)Action_viewController:(NSDictionary *)params
{
    TestBViewController *controller = [[TestBViewController alloc] init];
    return controller;
}

@end
