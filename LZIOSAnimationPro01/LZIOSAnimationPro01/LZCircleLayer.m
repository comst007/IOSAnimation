//
//  LZCircleLayer.m
//  LZIOSAnimationPro01
//
//  Created by comst on 15/10/9.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZCircleLayer.h"
#import <UIKit/UIKit.h>
#define kRectW 90 
#define h (kRectW * 0.5 * 0.552)

typedef NS_ENUM(NSUInteger, LZMovePoint){
    kPointB,
    kPointD
};

@interface LZCircleLayer ()

@property (nonatomic, assign) CGRect outsideRectSize;
@property (nonatomic, assign) LZMovePoint movePoint;

@end


@implementation LZCircleLayer

- (void)drawInContext:(CGContextRef)ctx{
    
    CGFloat centerX = self.outsideRectSize.origin.x + kRectW * 0.5;
    CGFloat centerY = self.outsideRectSize.origin.y + kRectW * 0.5;
    
    CGPoint pointOrign = self.outsideRectSize.origin;
    
    CGFloat moveOffset = fabs(self.progress - 0.5) * 2 * self.outsideRectSize.size.width / 6;
    
    
    CGPoint pointA = CGPointMake(centerX, pointOrign.y + moveOffset);
    
    CGFloat pointB_X = self.movePoint == kPointD ? CGRectGetMaxX(self.outsideRectSize): CGRectGetMaxX(self.outsideRectSize) + moveOffset;
    CGPoint pointB = CGPointMake(pointB_X, centerY) ;
    
    
    CGPoint pointC = CGPointMake(centerX, CGRectGetMaxY(self.outsideRectSize) - moveOffset);
    
    
    CGFloat pointD_x = self.movePoint == kPointB ? pointOrign.x : pointOrign.x - moveOffset;
    CGPoint pointD = CGPointMake(pointD_x, centerY) ;
    
    CGPoint pointC1 = CGPointMake(pointA.x + h, pointA.y);
    
    CGFloat pointC2_y = self.movePoint == kPointD ? pointB.y - h : pointB.y - h + moveOffset;
    CGPoint pointC2 = CGPointMake(pointB_X, pointC2_y);
    
    CGFloat pointC3_y = self.movePoint == kPointD ? pointB.y + h : pointB.y + h - moveOffset;
    CGPoint pointC3 = CGPointMake(pointB_X, pointC3_y);
    
    CGPoint pointC4 = CGPointMake(pointC.x + h, pointC.y);
    CGPoint pointC5 = CGPointMake(pointC.x - h, pointC.y);
    
    CGFloat pointC6_y = self.movePoint == kPointB ? pointD.y + h : pointD.y + h - moveOffset;
    CGPoint pointC6 = CGPointMake(pointD.x, pointC6_y);
    
    CGFloat pointC7_y = self.movePoint == kPointB ? pointD.y - h : pointD.y - h + moveOffset;
    CGPoint pointC7 = CGPointMake(pointD.x, pointC7_y);
    
    CGPoint pointC8 = CGPointMake(pointA.x - h, pointA.y);
    
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:pointA];
    [path addCurveToPoint:pointB controlPoint1:pointC1 controlPoint2:pointC2];
    [path addCurveToPoint:pointC controlPoint1:pointC3 controlPoint2:pointC4];
    [path addCurveToPoint:pointD controlPoint1:pointC5 controlPoint2:pointC6];
    [path addCurveToPoint:pointA controlPoint1:pointC7 controlPoint2:pointC8];
    [path closePath];
    path.lineWidth = 3;
    
    CGContextSetStrokeColorWithColor(ctx, [UIColor purpleColor].CGColor);
    CGContextSetFillColorWithColor(ctx, [UIColor redColor].CGColor);
    CGContextAddPath(ctx, path.CGPath);
    //CGContextStrokePath(ctx);
    CGContextDrawPath(ctx, kCGPathFillStroke);
    
    //
    UIBezierPath *rectPath = [UIBezierPath bezierPathWithRect:self.outsideRectSize];
    rectPath.lineWidth = 3;
    CGContextAddPath(ctx, rectPath.CGPath);
    CGContextSetStrokeColorWithColor(ctx, [UIColor blackColor].CGColor);
    CGFloat dash[] = {4, 2};
    CGContextSetLineDash(ctx, 0, dash, 2);
    CGContextStrokePath(ctx);
    
    UIBezierPath *linePath = [[UIBezierPath alloc] init];
    [linePath moveToPoint:pointA];
    [linePath addLineToPoint:pointC1];
    [linePath addLineToPoint:pointC2];
    [linePath addLineToPoint:pointB];
    [linePath addLineToPoint:pointC3];
    [linePath addLineToPoint:pointC4];
    [linePath addLineToPoint:pointC];
    [linePath addLineToPoint:pointC5];
    [linePath addLineToPoint:pointC6];
    [linePath addLineToPoint:pointD];
    [linePath addLineToPoint:pointC7];
    [linePath addLineToPoint:pointC8];
    [linePath addLineToPoint:pointA];
    CGContextSetStrokeColorWithColor(ctx, [UIColor purpleColor].CGColor);
    CGContextAddPath(ctx, linePath.CGPath);
    CGContextStrokePath(ctx);
    


    
    
}

- (LZMovePoint)movePoint{
    if (self.progress >= 0.5) {
        return kPointD;
    }else{
        return kPointB;
    }
}

- (void)setProgress:(CGFloat)progress{
    
    //NSLog(@"frame: %@", NSStringFromCGRect(self.frame));
    CGFloat rectW = kRectW;
    CGFloat rectH = kRectW;
    CGFloat rectY = (self.frame.size.height - kRectW ) * 0.5;
    CGFloat rectX = (self.frame.size.width - kRectW) * 0.5 + (progress - 0.5) * (self.frame.size.width - kRectW) ;
    self.outsideRectSize = CGRectMake(rectX, rectY, rectW, rectH);
    
    
    _progress = progress;
    
    [self setNeedsDisplay];
    
}
@end
