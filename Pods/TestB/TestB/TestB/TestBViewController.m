//
//  TestBViewController.m
//  TestB
//
//  Created by 尹腾翔 on 2017/11/6.
//  Copyright © 2017年 尹腾翔. All rights reserved.
//

#import "TestBViewController.h"

@interface TestBViewController ()

@end

@implementation TestBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor blueColor];
    
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
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)goBock1
{
    
}

- (void)testShow
{
    UIAlertView *ale = [[UIAlertView alloc] initWithTitle:@"tsetBShowAlert" message:@"BBBBBB" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [ale show];
}

@end
