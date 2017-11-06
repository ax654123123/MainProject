//
//  TestAViewController.m
//  TestA
//
//  Created by 尹腾翔 on 2017/11/6.
//  Copyright © 2017年 尹腾翔. All rights reserved.
//

#import "TestAViewController.h"

@interface TestAViewController ()

@end

@implementation TestAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *button = [UIButton buttonWithType:0];
    button.backgroundColor = [UIColor blackColor];
    button.frame = CGRectMake(0, 0, 100, 100);
    [button addTarget:self action:@selector(goBock) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
    UIButton *button1 = [UIButton buttonWithType:0];
    button1.backgroundColor = [UIColor blackColor];
    button1.frame = CGRectMake(0, 200, 100, 100);
    [button1 addTarget:self action:@selector(goBock1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)goBock
{
    [self dismissViewControllerAnimated:YES completion:^{}];
}

- (void)goBock1
{
    
}

- (void)testShow
{
    UIAlertView *ale = [[UIAlertView alloc] initWithTitle:@"tsetAShowAlert" message:@"" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [ale show];
}

@end
