//
//  TestAViewController.m
//  TestA
//
//  Created by 尹腾翔 on 2017/11/6.
//  Copyright © 2017年 尹腾翔. All rights reserved.
//

#import "TestAViewController.h"

#import <TestB_Category/CTMediator+TestB.h>

@interface TestAViewController ()

@end

@implementation TestAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"A"; 
    
    self.view.backgroundColor = [UIColor redColor];

    
    UIButton *button = [UIButton buttonWithType:0];
    button.backgroundColor = [UIColor blackColor];
    button.frame = CGRectMake(0, 0, 100, 100);
    [button addTarget:self action:@selector(goBock) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
    UIButton *button1 = [UIButton buttonWithType:0];
    button1.backgroundColor = [UIColor blackColor];
    button1.frame = CGRectMake(0, 200, 100, 100);
    [button1 addTarget:self action:@selector(goBViewController) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)goBock
{
    if (![self isMemberOfClass:[UIViewController class]])
    {
        if (self.parentViewController.childViewControllers.count>1) {
            [self.navigationController popViewControllerAnimated:YES];
        }
        else{
            if (self.presentingViewController) {
                [self dismissViewControllerAnimated:YES completion:nil];
            }
        }
    }
}

- (void)goBViewController
{
   UIViewController *controller =  [[CTMediator sharedInstance] viewControllerTestB];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)testShow
{
    UIAlertView *ale = [[UIAlertView alloc] initWithTitle:@"tsetAShowAlert" message:@"AAAAAA" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [ale show];
}

@end
