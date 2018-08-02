//
//  UserHitView.m
//  BlueToothAbout
//
//  Created by 知合金服-Mini on 2018/8/2.
//  Copyright © 2018年 fanzehua. All rights reserved.
//

#import "UserHitView.h"
#import "UserSubOneView.h"

@interface UserHitView ()

@property(copy,nonatomic)UserSubOneView *subView;
@end

@implementation UserHitView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor grayColor];
        _subView = [[UserSubOneView alloc] initWithFrame:CGRectMake(- 2 * frame.size.width / 4, frame.size.height / 4, frame.size.width / 4, frame.size.height / 4)];
        _subView.backgroundColor = [UIColor purpleColor];
        [self addSubview:_subView];
    }
    return self;
}


-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    if (point.x < self.bounds.origin.x) {
        NSLog(@"我在subview");
        return self;
    }else{
        NSLog(@"我在mainView");
        return self.subView;
    }
//    if (CGRectContainsPoint(self.subView.bounds, point)) {
//        NSLog(@"我在subview");
//        return self;
//    }else{
//        NSLog(@"我在mainView");
//        return self.subView;
//    }
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
