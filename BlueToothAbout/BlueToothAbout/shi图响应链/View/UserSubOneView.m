//
//  UserSubOneView.m
//  BlueToothAbout
//
//  Created by 知合金服-Mini on 2018/8/2.
//  Copyright © 2018年 fanzehua. All rights reserved.
//

#import "UserSubOneView.h"
#import "UserHitView.h"
@implementation UserSubOneView

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    if (CGRectContainsPoint(self.bounds, point)) {
        NSLog(@"我在自己身上");
        return [UserHitView new];
    }else{
        NSLog(@"我在qaq");
        return self;
    }
}

//-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
//{
//    NSLog(@"%s",__func__);
//    return [super hitTest:point withEvent:event];
//}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    NSLog(@"%s",__func__);
    return YES;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%s",__func__);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
