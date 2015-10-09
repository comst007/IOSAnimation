//
//  LZCircle.m
//  LZIOSAnimationPro01
//
//  Created by comst on 15/10/9.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZCircle.h"

@implementation LZCircle

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.circleLayer = [[LZCircleLayer alloc] init];
        self.circleLayer.contentsScale = [UIScreen mainScreen].scale;
        self.circleLayer.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
        [self.layer addSublayer:self.circleLayer];
        self.circleLayer.progress = 0.5;
        
    }
    
    return self;
}

@end
