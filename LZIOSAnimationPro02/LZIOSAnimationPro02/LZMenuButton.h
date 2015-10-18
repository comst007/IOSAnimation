//
//  LZMenuButton.h
//  LZIOSAnimationPro02
//
//  Created by comst on 15/10/17.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LZMenuButton;

typedef void (^buttonClickBlock)(LZMenuButton *button);

@interface LZMenuButton : UIView


@property (nonatomic, strong) UIColor *buttonColor;

@property (nonatomic, strong) NSString *buttonTitle;

@property (nonatomic, copy) buttonClickBlock buttonHandle;

- (instancetype)initWithTitle:(NSString *)title;
@end
