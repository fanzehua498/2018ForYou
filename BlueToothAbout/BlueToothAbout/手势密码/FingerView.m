//
//  FingerView.m
//  BlueToothAbout
//
//  Created by 知合金服-Mini on 2018/6/20.
//  Copyright © 2018年 知合金服-Mini. All rights reserved.
//

#import "FingerView.h"


#define kBtnWidth (ScreenWidth - 40 * 4)/3

@interface FingerView ()

@property (nonatomic ,strong) NSMutableArray *fingerFrameArr;
@property (nonatomic ,strong) NSMutableArray *circleViews;

@property (nonatomic ,strong) NSString *fingerPwd;

/** 最后一个点 用于连接*/
@property (assign, nonatomic) CGPoint curlastPoint;
@end

@implementation FingerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.fingerFrameArr = [NSMutableArray array];
        self.circleViews = [NSMutableArray array];
        CGFloat padding = 40;
//        CGFloat width = (ScreenWidth - padding * 4)/3;
        for (int i = 0; i < 3; i++) {
            for (int j = 0; j < 3; j++) {
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                btn.frame = CGRectMake(j*kBtnWidth + padding*(j + 1), i*kBtnWidth + padding*(i + 1), kBtnWidth, kBtnWidth);
                [self addSubview:btn];
                [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
                btn.userInteractionEnabled = NO;
                [btn setTitle:[NSString stringWithFormat:@"%d",(j+1)+i*3] forState:UIControlStateNormal];
//                [btn setTitle:@"选中" forState:UIControlStateSelected];
                btn.layer.cornerRadius = kBtnWidth/2;
                btn.backgroundColor = [UIColor yellowColor];
                [self.fingerFrameArr addObject:btn];
            }
        }
    }
    return self;
}


- (CGPoint)touchPoint:(NSSet*)touches{
    UITouch* touch = [touches anyObject];
    return [touch locationInView:touch.view];
}

- (UIButton*)circleViewInPoint:(CGPoint)point
{
    for (UIButton* view in self.subviews) {
        if (CGRectContainsPoint(view.frame, point)) {
            return view;
        }
    }
    return nil;
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    self.curlastPoint = CGPointMake(-10.0f, -10.0f);
    CGPoint point = [self touchPoint:touches];
    UIButton* circleView = [self circleViewInPoint:point];
    if (circleView) {
        if (![circleView isSelected]) {
            [circleView setSelected:YES];
            [self.circleViews addObject:circleView];
        }
    }
    
//    [self.fingerFrameArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        //        NSLog(@"obj:%@ idx:%lu",obj,idx);
//        UIButton *button = obj;
//        if (touchPoint.x > button.frame.origin.x && touchPoint.x<button.frame.origin.x + kBtnWidth && touchPoint.y > button.frame.origin.y && touchPoint.y < button.frame.origin.y + kBtnWidth) {
//
//            for (int i = 0 ; i < self.circleViews.count; i ++) {
//                NSNumber *number = self.circleViews[i];
//                if (number.unsignedIntegerValue == idx + 1) {
//                    self.curlastPoint = touchPoint;
//                    return ;
//                }
//            }
//            [self.circleViews addObject:[NSNumber numberWithUnsignedInteger:(idx + 1)]];
//
//        }
//    }];
    [self setNeedsDisplay];
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];

    CGPoint touchPoint = [self touchPoint:touches];
    UIButton* circleView = [self circleViewInPoint:touchPoint];
    
    if (circleView && ![circleView isSelected]) {
        [circleView setSelected:YES];
        [self.circleViews addObject:circleView];
        self.curlastPoint = touchPoint;
    }else{
        self.curlastPoint = touchPoint;
    }
    [self setNeedsDisplay];
//    [self.fingerFrameArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
////        NSLog(@"obj:%@ idx:%lu",obj,idx);
//        UIButton *button = obj;
//        if (touchPoint.x > button.frame.origin.x && touchPoint.x<button.frame.origin.x + kBtnWidth && touchPoint.y > button.frame.origin.y && touchPoint.y < button.frame.origin.y + kBtnWidth) {
//
//            for (int i = 0 ; i < self.circleViews.count; i ++) {
//                NSNumber *number = self.circleViews[i];
//                if (number.unsignedIntegerValue == idx + 1) {
//                    self.curlastPoint = touchPoint;
//                    return ;
//                }
//            }
//            [self.circleViews addObject:[NSNumber numberWithUnsignedInteger:(idx + 1)]];
//
//        }
//    }];
    
   
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.fingerPwd = [NSString string];
    [self setNeedsDisplay];
    for (UIButton *button in self.circleViews) {
        self.fingerPwd = [self.fingerPwd stringByAppendingString:[NSString stringWithFormat:@"%@",button.currentTitle]];
    }
    [self.circleViews removeAllObjects];
    NSLog(@"密码为:%@",self.fingerPwd);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (void)drawRect:(CGRect)rect
{
//    [super drawRect:rect];
//
////    划线
//
    if (self.circleViews.count>0) {
        UIBezierPath *path = [UIBezierPath new];
        UIButton *btn = self.circleViews.firstObject;

//        [path moveToPoint:[btn center]];
        [path moveToPoint:[self convertPoint:btn.center fromView:self]];
        for (NSUInteger i = 1; i < self.circleViews.count; i++) {
            UIButton *NewPointBtn = [self.circleViews objectAtIndex:i];

//            [path moveToPoint:NewPointBtn.center];
            [path addLineToPoint:[self convertPoint:NewPointBtn.center fromView:self]];
        }

        if (NO == CGPointEqualToPoint(self.curlastPoint, CGPointMake(-10.0f, -10.0f))) {
            [path addLineToPoint:self.curlastPoint];
        }

        path.lineWidth = 8;
        path.lineJoinStyle = kCGLineJoinRound;
        [[UIColor colorWithRed:32/255.0 green:210/255.0 blue:254/255.0 alpha:0.5] set];
        [path stroke];
    }
}

@end
