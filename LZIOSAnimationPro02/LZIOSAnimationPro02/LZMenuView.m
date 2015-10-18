//
//  LZMenuView.m
//  LZIOSAnimationPro02
//
//  Created by comst on 15/10/17.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZMenuView.h"
#import "MBProgressHUD.h"
#import "AppDelegate.h"
#define  kExtraArea   30
#define  kMenuButtonHeight  40
#define  kVerticalPadding 30
@interface LZMenuView  ()

@property (nonatomic, strong) UIView *sliderView;
@property (nonatomic, strong) UIView *centerView;
@property (nonatomic, strong) UIVisualEffectView *blurView;
@property (nonatomic, weak) UIWindow *keywindow;
@property (nonatomic, assign) BOOL triggered;
@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, assign) NSInteger animationCount;
@property (nonatomic, assign) CGFloat diff;
@end

@implementation LZMenuView

- (instancetype)initWithTitles:(NSArray *)titles{
    self = [super init];
    if (self) {
        self.keywindow = [[[UIApplication sharedApplication] delegate] window];
        self.sliderView = [[UIView alloc] init];
        self.sliderView.hidden = YES;
        self.sliderView.backgroundColor = [UIColor redColor];
        self.sliderView.frame = CGRectMake(-40, 0, 40, 40);
        [self.keywindow addSubview:self.sliderView];
        
        self.centerView = [[UIView alloc] init];
        self.centerView.frame = CGRectMake(-40, self.keywindow.frame.size.height * 0.5 - 20, 40, 40);
        self.centerView.hidden = YES;
        self.centerView.backgroundColor = [UIColor greenColor];
        [self.keywindow addSubview:self.centerView];
        
        self.frame = CGRectMake(-(self.keywindow.bounds.size.width * 0.5 + kExtraArea), 0, self.keywindow.bounds.size.width * 0.5 + kExtraArea, self.keywindow.bounds.size.height);
        self.backgroundColor = [UIColor clearColor];
        
        [self.keywindow insertSubview:self belowSubview:self.sliderView];
        
        UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        self.blurView = [[UIVisualEffectView alloc] initWithEffect:effect];
        self.blurView.frame = self.keywindow.frame;
        self.blurView.alpha = 0;
        
        UITapGestureRecognizer *tapgesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(trigger)];
        [self.blurView addGestureRecognizer:tapgesture];
        [self.keywindow insertSubview:self.blurView belowSubview:self];
        
        self.menuColor = [UIColor colorWithRed:0 green:0.722 blue:1 alpha:1];
        
        __weak typeof(self) weakSelf = self;
        self.buttonHandle = ^(LZMenuButton *btn){
            
            MBProgressHUD *alert = [[MBProgressHUD alloc] initWithView:weakSelf.keywindow];
            
            alert.mode = MBProgressHUDModeText;
            alert.labelText = btn.buttonTitle;
            alert.minShowTime = 1;
            alert.removeFromSuperViewOnHide = YES;
            
            [weakSelf.keywindow addSubview:alert];
            
            [alert show:YES];
            
            [alert hide:YES afterDelay:1];
            
        };
        
        [self addMenuButtons:titles];
        
        
        
    }
    return self;
}

- (void)addMenuButtons:(NSArray *)titles{
    CGFloat buttonW = self.keywindow.frame.size.width * 0.5 - 20 * 2;
    CGFloat buttonH = kMenuButtonHeight;
    CGFloat buttonX = 20;
    NSInteger buttonCount = titles.count;
    CGFloat startY = (self.keywindow.frame.size.height - buttonCount * buttonH - (buttonCount - 1) * kVerticalPadding) * 0.5;
    CGFloat buttonY;
    for (NSInteger index = 0; index < buttonCount; index ++) {
        
        buttonY = startY + index * (buttonH + kVerticalPadding);
        
        LZMenuButton *buttonItem = [[LZMenuButton alloc] initWithTitle:titles[index]];
        buttonItem.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        buttonItem.buttonHandle = self.buttonHandle;
        buttonItem.buttonColor = self.menuColor;
        [self addSubview:buttonItem];
        
    }
    
    
}

- (void)trigger{
    if (self.triggered == NO) {
        self.triggered = YES;
        [self MenuShow];
    }else{
        self.triggered = NO;
        [self menuHide];
    }
}

- (void)MenuShow{
    
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = self.bounds;
    }];
    [UIView animateWithDuration:1 animations:^{
        self.blurView.alpha = 1.0;
    }];
    [self beginAniation];
    [UIView animateWithDuration:0.7 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.9 options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionBeginFromCurrentState animations:^{
        
        self.sliderView.center = CGPointMake(self.keywindow.frame.size.width * 0.5, self.sliderView.frame.size.height * 0.5);
    } completion:^(BOOL finished) {
        [self endAnimation];
    }];
    
    [self beginAniation];
    [UIView animateWithDuration:0.7 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:2.0 options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionBeginFromCurrentState animations:^{
        
        self.centerView.center = self.keywindow.center;
        
    } completion:^(BOOL finished) {
        [self endAnimation];
    }];
    [self buttonsShow];

}

- (void)buttonsShow{
    NSArray *array = self.subviews;
    NSInteger i = 0;
    for (LZMenuButton *menuButton in array) {
        menuButton.transform = CGAffineTransformTranslate(menuButton.transform, -90, 0);
        
        [UIView animateWithDuration:0.7 delay:i*(0.3/self.subviews.count) usingSpringWithDamping:0.6f initialSpringVelocity:0.0f options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionAllowUserInteraction animations:^{
            
            menuButton.transform =  CGAffineTransformIdentity;
            
        } completion:NULL];
        
        i ++;
    }
}

- (void)menuHide{
    
    [UIView animateWithDuration:0.3 animations:^{
        
         self.transform = CGAffineTransformTranslate(self.transform, - (self.keywindow.frame.size.width * 0.5 + kExtraArea), 0);
        
    }];
    
    [UIView animateWithDuration:1 animations:^{
        self.blurView.alpha = 0.0;
    }];
    
    [self beginAniation];
    [UIView animateWithDuration:0.7 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0.9 options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionBeginFromCurrentState animations:^{
        
        self.sliderView.center = CGPointMake(-20, 20);
    } completion:^(BOOL finished) {
        [self endAnimation];
    }];
    
    [self beginAniation];
    [UIView animateWithDuration:0.7 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:2.0 options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionBeginFromCurrentState animations:^{
        
        self.centerView.center = CGPointMake(-20, self.keywindow.frame.size.height * 0.5);
        
    } completion:^(BOOL finished) {
        [self endAnimation];
    }];

    
    [self buttonsHide];
    
    
}

- (void)buttonsHide{
    
}


- (void)beginAniation{
    if (self.displayLink == nil) {
        self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(displaylinkAction:)];
        [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        
    }
    self.animationCount  = self.animationCount + 1;
}

- (void)endAnimation{
    self.animationCount = self.animationCount - 1;
    if (self.animationCount == 0) {
        [self.displayLink removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        self.displayLink = nil;
    }
}

- (void)displaylinkAction:(CADisplayLink *)displaylink{
    CALayer *sliderviewLayer = self.sliderView.layer.presentationLayer;
    CALayer *centerviewLayer = self.centerView.layer.presentationLayer;
    
    CGFloat deltX = sliderviewLayer.frame.origin.x - centerviewLayer.frame.origin.x;
    self.diff = deltX;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect{
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(self.keywindow.frame.size.width * 0.5, 0)];
    [path addQuadCurveToPoint:CGPointMake(self.keywindow.frame.size.width * 0.5, self.keywindow.frame.size.height) controlPoint:CGPointMake(self.keywindow.center.x + self.diff, self.keywindow.center.y)];
    [path addLineToPoint:CGPointMake(0, self.keywindow.frame.size.height)];
    [path closePath];
    
    [self.menuColor set];
    [path fill];
}
@end
