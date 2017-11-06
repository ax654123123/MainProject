//
//  CTMediator+TestB.m
//  TestB_Category
//
//  Created by 尹腾翔 on 2017/11/6.
//  Copyright © 2017年 尹腾翔. All rights reserved.
//

#import "CTMediator+TestB.h"

@implementation CTMediator (TestB)
- (void)tsetBShowAlert
{
    [self performTarget:@"TestB" action:@"tsetBShowAlert" params:nil shouldCacheTarget:NO];
}

- (UIViewController *)viewControllerTestB
{
    return [self performTarget:@"TestB" action:@"viewController" params:nil shouldCacheTarget:NO];
}
@end
