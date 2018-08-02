//
//  lineView.m
//  BlueToothAbout
//
//  Created by 知合金服-Mini on 2018/7/27.
//  Copyright © 2018年 fanzehua. All rights reserved.
//

#import "lineView.h"

@implementation lineView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        CGFloat lineWidth = 240;
//        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 8, lineWidth, self.frame.size.height)];
//        //    lineView.backgroundColor = [UIColor redColor];
//        [self addSubview:lineView];
//        lineView.backgroundColor = [UIColor whiteColor];
//        UIColor *color = [UIColor redColor];
//        [color set];
//        UIBezierPath *bezier = [UIBezierPath bezierPath];
//        [bezier moveToPoint:CGPointMake(0,  4)];
//        [bezier addArcWithCenter:CGPointMake(0 + 240 / 10, self.frame.size.height /2) radius:2 startAngle:0 endAngle:2*M_PI clockwise:NO];
////        for (int i = 0; i < 9; i ++) {
////            [bezier addArcWithCenter:CGPointMake(0 + i * 240 / 10, self.frame.size.height /2) radius:2 startAngle:0 endAngle:2*M_PI clockwise:NO];
////        }
//        bezier.lineCapStyle = kCGLineCapRound; //线条拐角
//        bezier.lineJoinStyle = kCGLineJoinRound; //终点处理
//
//        [bezier stroke];
        
//        CAShapeLayer *lineSha = [CAShapeLayer layer];
//        lineSha.path = bezier.CGPath;
//        lineSha.lineWidth = 2;
//        lineView.backgroundColor = [UIColor whiteColor];
//        [lineView.layer addSublayer:lineSha];
        
        
        
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    UIColor *color = [UIColor redColor];
    [color set]; //设置线条颜色
    
//    UIBezierPath *path = [UIBezierPath bezierPath];
////    [path addArcWithCenter:CGPointMake(40, 40) radius:24 startAngle:4 / 3*M_PI endAngle:5 / 3 * M_PI clockwise:YES];
//    CGFloat start = 2 * M_PI / 3;
//    CGFloat end = M_PI / 3;
//
//    CGFloat start1 = 4 * M_PI /3;
//    CGFloat end2 = 5 * M_PI / 3;
//
//    [path addArcWithCenter:CGPointMake(40, 40) radius:24 startAngle:start endAngle:end clockwise:NO];
//    [path addArcWithCenter:CGPointMake(40 + 12, 64 + 12 * sqrt(3)) radius:24 startAngle:start1 endAngle:end2 clockwise:YES];
//    [path addArcWithCenter:CGPointMake(40 + 12 + 12, 40 ) radius:24 startAngle:start1 endAngle:end2 clockwise:NO];
//    path.lineWidth = 2.0;
//    path.lineCapStyle = kCGLineCapRound; //线条拐角
//    path.lineJoinStyle = kCGLineJoinRound; //终点处理
//
//    [path stroke];
    UIBezierPath *bezier = [UIBezierPath bezierPath];
    
    CGFloat startPointY = rect.size.height / 2;
    
    CGFloat radius = rect.size.width / 9 / 2;
    
    CGFloat topPointX = radius / 2;
    CGFloat topPointY = startPointY - sqrt(3) * radius / 2;
    
    CGFloat bottomPointY = startPointY + sqrt(3) * radius / 2;
    
//    for (int i = 0; i < 9; i ++) {
//        if (i % 2 == 0) {
//            [bezier addArcWithCenter:CGPointMake(topPointX + i * radius, topPointY) radius:radius startAngle:2 * M_PI / 3 endAngle:M_PI / 3 clockwise:NO];
//        }else{
//            [bezier addArcWithCenter:CGPointMake(topPointX + i * radius, bottomPointY) radius:radius startAngle:4 * M_PI / 3 endAngle:5 * M_PI / 3 clockwise:YES];
//        }
//    }
    [bezier addArcWithCenter:CGPointMake(topPointX , topPointY) radius:radius startAngle:2 * M_PI / 3 endAngle:M_PI / 3 clockwise:NO];
    [bezier addArcWithCenter:CGPointMake(topPointX + radius, bottomPointY) radius:radius startAngle:4 * M_PI / 3 endAngle:5 * M_PI / 3 clockwise:YES];
    bezier.lineWidth = 1.0f;
    bezier.lineCapStyle = kCGLineCapRound;
    bezier.lineJoinStyle = kCGLineJoinRound;
    [bezier stroke];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
