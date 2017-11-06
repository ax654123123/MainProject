//
//  CTMediator+TestA.m
//  TestA_Category
//
//  Created by 尹腾翔 on 2017/11/6.
//  Copyright © 2017年 尹腾翔. All rights reserved.
//

#import "CTMediator+TestA.h"

@implementation CTMediator (TestA)
- (void)tsetAShowAlert
{
    [self performTarget:@"TestA" action:@"tsetAShowAlert" params:nil shouldCacheTarget:NO];
}

- (UIViewController *)viewControllerTestA
{
  return [self performTarget:@"TestA" action:@"viewController" params:nil shouldCacheTarget:NO];
}

@end
