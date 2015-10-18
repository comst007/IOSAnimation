//
//  LZMenuButton.m
//  LZIOSAnimationPro02
//
//  Created by comst on 15/10/17.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZMenuButton.h"

@implementation LZMenuButton

- (instancetype)initWithTitle:(NSString *)title{
    self = [super init];
    if (self) {
        self.buttonTitle = title;
        self.buttonColor = [UIColor colorWithRed:0 green:0.722 blue:1 alpha:1];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    __weak typeof(self) weakSelf = self;
    if (touch.tapCount == 1) {
        self.buttonHandle(weakSelf);
    }
}

- (void)drawRect:(CGRect)rect{
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
//    CGContextSaveGState(ctx);
//    [self.buttonColor set];
//    CGContextFillRect(ctx, rect);
//    CGContextRestoreGState(ctx);
    
    CGContextSaveGState(ctx);
    
   
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGRect roundRect = CGRectInset(rect, 2, 2);
    
    CGPathAddRoundedRect(path, nil, roundRect, roundRect.size.height * 0.5 , roundRect.size.height * 0.5);
    
    CGContextAddPath(ctx, path);
    
    CGContextSetLineWidth(ctx, 2);
    [[UIColor whiteColor] set];
    [self.buttonColor setFill];
    CGContextDrawPath(ctx, kCGPathFillStroke);
    
    
    
    CGPathRelease(path);
    CGContextRestoreGState(ctx);
    
    NSMutableParagraphStyle *paragrapStyle = [[NSMutableParagraphStyle alloc] init];
    
    paragrapStyle.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attrDict = @{NSFontAttributeName:[UIFont systemFontOfSize:24], NSForegroundColorAttributeName:[UIColor whiteColor], NSParagraphStyleAttributeName:paragrapStyle};
    
     CGSize textSize =  [self.buttonTitle sizeWithAttributes:attrDict];
    
    [self.buttonTitle drawInRect:CGRectMake(0, (rect.size.height - textSize.height) * 0.5, rect.size.width, textSize.height) withAttributes:attrDict];
    
    
   
    
    
    
}
@end
