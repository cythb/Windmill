//
//  MyView.m
//  Test
//
//  Created by 汤 海波 on 8/13/13.
//  Copyright (c) 2013 汤 海波. All rights reserved.
//

#import "MyView.h"
#import <QuartzCore/QuartzCore.h>

@implementation MyView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (nil != self) {
        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

- (void)drawLeafWithIndex:(NSInteger)index translate:(CGPoint)translate trigleSize:(CGSize)trigleSize{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
	CGContextSetFillColorWithColor(context, [UIColor orangeColor].CGColor);
    
//    CGSize trigleSize = CGSizeMake(52, 30);
    
    CGContextSaveGState(context);
    
    CGContextTranslateCTM(context, translate.x, translate.y);
    CGContextRotateCTM(context, M_PI_2 * index);
    
    CGContextMoveToPoint(context, 0, 0);
    CGFloat r = 10;
    CGContextAddLineToPoint(context, trigleSize.width-r, 0);
    CGContextAddArc(context, trigleSize.width-r, r, r, -M_PI_2, 0, 0);
    CGContextAddLineToPoint(context, trigleSize.width, trigleSize.height);
    CGContextClosePath(context);
    
    //CGContextFillPath(context);
    CGColorSpaceRef rgb =  CGColorSpaceCreateDeviceRGB();
    CGFloat colors[] =
    {
        204.0 / 255.0, 224.0 / 255.0, 244.0 / 255.0, 1.00,
		29.0 / 255.0, 156.0 / 255.0, 215.0 / 255.0, 1.00,
		0.0 / 255.0,  50.0 / 255.0, 126.0 / 255.0, 1.00,
    };
    CGGradientRef gradient = CGGradientCreateWithColorComponents(rgb,
                                                                 colors,
                                                                 NULL,
                                                                 sizeof(colors)/(sizeof(colors[0])* 4) );
    CGColorSpaceRelease(rgb);
    CGContextSaveGState(context);
    CGContextClip(context);
    CGContextDrawLinearGradient(context,
                                gradient,
                                CGPointMake(3, 3),
                                CGPointMake(100, 100),
                                kCGGradientDrawsAfterEndLocation);
    CGGradientRelease(gradient);
    CGContextRestoreGState(context);
    
    
    r = 6;
    CGContextMoveToPoint(context, trigleSize.width+(trigleSize.height - r)/2,
                         (trigleSize.height - r)/2 + r);
    CGContextAddLineToPoint(context, trigleSize.width - 1, trigleSize.height);
    CGContextAddLineToPoint(context, trigleSize.width - 1, r);
    CGContextClosePath(context);
    
    CGContextFillPath(context);
    
    CGContextRestoreGState(context);
}

- (void)drawRect:(CGRect)rect{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
	CGContextSetFillColorWithColor(context, [UIColor orangeColor].CGColor);
    
    CGPoint center = self.center;
    CGSize trigleSize = CGSizeMake(50, 50);
    
    // 0
    [self drawLeafWithIndex:0 translate:CGPointMake(center.x-trigleSize.width,
                                                    center.y-trigleSize.height)
                 trigleSize:trigleSize];
    
    // 1
    [self drawLeafWithIndex:1 translate:CGPointMake(center.x+trigleSize.height, center.y-trigleSize.width)
                 trigleSize:trigleSize];
    
    // 2
    [self drawLeafWithIndex:2 translate:CGPointMake(center.x+trigleSize.width, center.y+trigleSize.height)
                 trigleSize:trigleSize];
    
    // 3
    [self drawLeafWithIndex:3 translate:CGPointMake(center.x-trigleSize.height, center.y+trigleSize.width)
                 trigleSize:trigleSize];
}

- (void)startAnimate:(BOOL)isAnimated{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.fromValue         = @0;
    animation.toValue           = @(2 * M_PI);
    animation.duration          = 3.0;
    animation.removedOnCompletion = NO;
    animation.fillMode          = kCAFillModeForwards;
    animation.autoreverses      = NO;
    animation.repeatCount = FLT_MAX;
    [self.layer addAnimation:animation forKey:@"rotate"];
}

@end
