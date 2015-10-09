//
//  ViewController.m
//  LZIOSAnimationPro01
//
//  Created by comst on 15/10/9.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "ViewController.h"
#import "LZCircle.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *progressLable;
@property (weak, nonatomic) IBOutlet UISlider *progressSlider;
@property (nonatomic, strong) LZCircle *circleView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    CGRect circleFrame ;
    CGFloat circleW = 300;
    CGFloat circleH = 300;
    CGFloat circleX = ([UIScreen mainScreen].bounds.size.width - circleW ) * 0.5 ;
    CGFloat circleY = ([UIScreen mainScreen].bounds.size.height - circleH) * 0.5;
    
    circleFrame = CGRectMake(circleX, circleY, circleW, circleH);
    

    
    
    LZCircle *circleView = [[LZCircle alloc] initWithFrame:circleFrame];
    
    //circleView.backgroundColor = [UIColor grayColor];
    
    self.circleView = circleView;
    
    [self.view addSubview:circleView];
    
}


- (IBAction)progressChanged:(UISlider *)sender {
    
    self.progressLable.text = [NSString stringWithFormat:@"%lf", self.progressSlider.value];
    self.circleView.circleLayer.progress = sender.value;
}

@end
