//
//  LZMenuView.h
//  LZIOSAnimationPro02
//
//  Created by comst on 15/10/17.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LZMenuButton.h"
@interface LZMenuView : UIView

@property (nonatomic, copy) buttonClickBlock buttonHandle;

@property (nonatomic, copy) UIColor *menuColor;

- (instancetype)initWithTitles:(NSArray*)titles;


- (void)trigger;
@end
