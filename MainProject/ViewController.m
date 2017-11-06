//
//  ViewController.m
//  MainProject
//
//  Created by 尹腾翔 on 2017/9/20.
//  Copyright © 2017年 尹腾翔. All rights reserved.
//

#import "ViewController.h"

//#import <BaseComponent/OBikeSeversHeader.h>

#import <TestA_Category/CTMediator+TestA.h>

#import <TestB_Category/CTMediator+TestB.h>

#import <CTMediator/CTMediator.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    [OBikeSevers refreshTokenWithRefreshToken:@"" success:^(id objModel) {
//
//    } Failure:^(NSError *error) {
//
//    }];
    
}

- (IBAction)clickTestA:(id)sender {

    
    UIViewController *viewController = [[CTMediator sharedInstance] viewControllerTestA];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:viewController];
    [self presentViewController:nav animated:YES completion:nil];
    
//    [[CTMediator sharedInstance] tsetAShowAlert];

}
- (IBAction)clickTestB:(id)sender {
    
//    [[CTMediator sharedInstance] tsetBShowAlert];
//    
//    return;
    
    UIViewController *viewController = [[CTMediator sharedInstance] viewControllerTestB];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:viewController];
    [self presentViewController:nav animated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
