//
//  ViewController.m
//  LZIOSAnimationPro02
//
//  Created by comst on 15/10/17.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "ViewController.h"
#import "LZMenuButton.h"
#import "MBProgressHUD.h"
#import "LZMenuView.h"
#import "AppDelegate.h"
@interface ViewController ()
@property (nonatomic, strong) LZMenuView *menuView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
   
    
    
    self.menuView = [[LZMenuView alloc] initWithTitles:@[@"首页",@"消息",@"发布",@"发现",@"个人",@"设置"]];
//    self.menuView.backgroundColor = [UIColor redColor];
    
    LZMenuButton *button = [[LZMenuButton alloc] initWithTitle:@"点我"];
    button.frame = CGRectMake(300, 400, 80, 40);
//    button.layer.cornerRadius = 20;
//    button.layer.masksToBounds = YES;
    button.buttonHandle = ^(LZMenuButton *btn){
        
//        MBProgressHUD *alert = [[MBProgressHUD alloc] initWithView:self.view];
//        
//        alert.mode = MBProgressHUDModeText;
//        alert.labelText = btn.buttonTitle;
//        alert.minShowTime = 1;
//        alert.removeFromSuperViewOnHide = YES;
//        
//        [self.view addSubview:alert];
//        
//        [alert show:YES];
//        
//        [alert hide:YES afterDelay:1];
        [self.menuView trigger];
        
    };
    [self.view addSubview:button];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
