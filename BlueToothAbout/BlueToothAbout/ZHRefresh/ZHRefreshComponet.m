//
//  ZHRefreshComponet.m
//  BlueToothAbout
//
//  Created by 知合金服-Mini on 2018/7/26.
//  Copyright © 2018年 fanzehua. All rights reserved.
//

#import "ZHRefreshComponet.h"

@interface ZHRefreshLabel :UILabel<CAAnimationDelegate>

//刷新完成提示lanel
- (void)startAnimating;

@end

@implementation ZHRefreshLabel
{
    CAGradientLayer *gradientLayer;
}

-(instancetype)init
{
    self = [super init];
    if (self) {
        gradientLayer = [CAGradientLayer new];
        gradientLayer.locations = @[@0.2,@0.5,@0.8];
        gradientLayer.startPoint = CGPointMake(0, 0.5);
        gradientLayer.endPoint = CGPointMake(1, 0.5);
        self.layer.masksToBounds = YES;
        [self.layer addSublayer:gradientLayer];
    }
    return self;
}

-(void)layoutSubviews
{
    gradientLayer.frame = CGRectMake(0, 0, 0, CGRectGetHeight(self.frame));
    gradientLayer.position = CGPointMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
}

-(void)startAnimating
{
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.alpha = 1.0;
    }];
    
    gradientLayer.colors = @[(id)[[UIColor redColor] colorWithAlphaComponent:0.2].CGColor,(id)[[UIColor blueColor] colorWithAlphaComponent:0.2].CGColor,(id)[[UIColor orangeColor] colorWithAlphaComponent:0.2].CGColor];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"bounds.size.width"];
    //动画起始值
    animation.fromValue = @(10);
    //动画终点值
    animation.toValue = @(375);
    //动画type 线性变换
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.fillMode = kCAFillModeForwards;
    animation.repeatCount = 100;
    //动画持续时间
    animation.duration = 0.3;
    //完成后是否移除动画
    animation.removedOnCompletion = NO;
    //设置代理
    animation.delegate = self;
    //layer添加动画
    [gradientLayer addAnimation:animation forKey:animation.keyPath];
    
}

- (void)stopAnimation
{
    __weak typeof(self) weakSelf = self;
    
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.alpha = 0;
    }];
    [gradientLayer removeAllAnimations];
}

@end

@interface ZHRefreshComponet()
@property (nonatomic ,strong) ZHRefreshLabel *alertLabel;

@end


@implementation ZHRefreshComponet

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
//        self.alpha = 0.;
        [self addSubview:self.alertLabel];
    }
    return self;
}

- (void)addlabel{
    [self bringSubviewToFront:self.alertLabel];
    self.alertLabel.text = @"aaaaaaaaaaqaqaaaaa";
    [self.alertLabel startAnimating];
}

- (void)endLabel{
    [self.alertLabel stopAnimation];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
//    self.height_Mu = (self.height_Mu < 44.) ? MURefreshHeight  : self.height_Mu;
    self.frame = CGRectMake(100,100, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    self.alertLabel.frame = self.bounds;
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
     [self bringSubviewToFront:self.alertLabel];
    [self.alertLabel startAnimating];
}

- (ZHRefreshLabel *)alertLabel{
    if (!_alertLabel) {
        _alertLabel = [ZHRefreshLabel new];
        _alertLabel.textAlignment = NSTextAlignmentCenter;
        _alertLabel.font =  [UIFont fontWithName:@"Helvetica" size:15.f];
        _alertLabel.textColor = [UIColor blackColor];
        _alertLabel.alpha = 0.0;
        _alertLabel.backgroundColor = [UIColor whiteColor];
    }
    return _alertLabel;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
