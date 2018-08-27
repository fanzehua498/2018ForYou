//
//  UIView+CornerRadius.m
//  BlueToothAbout
//
//  Created by fanzehua on 2018/8/27.
//  Copyright © 2018年 fanzehua. All rights reserved.
//

#import "UIView+CornerRadius.h"
#import <objc/message.h>
@interface UIView ()

@property (nonatomic, assign) BOOL addRound;

@end

@implementation UIView (CornerRadius)

-(void)ZH_AddCornerRadius:(CGFloat)radius bounds:(CGRect)rect
{

    NSAssert(!(radius <= 0 || rect.size.width <= 0 || rect.size.height <= 0), @"圆角或者size不能小于0");
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius];
    CAShapeLayer *zhLayer = [[CAShapeLayer alloc] init];
    zhLayer.frame = rect;
    zhLayer.path = path.CGPath;
    self.layer.mask = zhLayer;
}


-(void)setAddRound:(BOOL)addRound
{
    objc_setAssociatedObject(self, @selector(addRound), @(addRound), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(BOOL)addRound
{
    
    return  [objc_getAssociatedObject(self, _cmd) unsignedIntegerValue];
}


@end
