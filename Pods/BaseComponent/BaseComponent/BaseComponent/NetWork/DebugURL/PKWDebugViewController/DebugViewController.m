//
//  PKWDebugViewController.m
//  PKW
//
//  Created by peikua on 16/5/31.
//  Copyright © 2016年 peikua. All rights reserved.
//

#import "DebugViewController.h"
#import "DebugURL.h"

@interface DebugViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation DebugViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)clickBtn:(id)sender {
    UIButton *button = (UIButton *)sender;
    [DebugURL ChangeURLDomainName:button.tag];
    
}
- (IBAction)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (IBAction)clickOK:(id)sender {
    if (self.textField.text.length > 0) {
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"http://%@/api/",self.textField.text] forKey:@"DEBUG_SERVER_HOST_BIKE"];
        [[NSUserDefaults standardUserDefaults] setObject:@"-dev" forKey:@"Web-url"];
        [[NSUserDefaults standardUserDefaults]  synchronize];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            exit(0);
        });
    }else {

    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
