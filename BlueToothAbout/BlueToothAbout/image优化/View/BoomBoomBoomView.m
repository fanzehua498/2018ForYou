//
//  BoomBoomBoomView.m
//  BlueToothAbout
//
//  Created by 知合金服-Mini on 2018/7/11.
//  Copyright © 2018年 fanzehua. All rights reserved.
//

#import "BoomBoomBoomView.h"

@interface BoomBoomBoomView ()
{
    NSTimer *_timer;//定时器
    BOOL isStart;
}
@property(strong,nonatomic)CAShapeLayer *shapeLayer;


@property (nonatomic ,strong) CALayer *animationLayer;


@end



@implementation BoomBoomBoomView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        CGFloat radius = MIN(self.bounds.size.width * 0.25, self.bounds.size.height * 0.5) - 10;
        
        UIBezierPath *circlePath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2) radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
        [circlePath addClip];
        [circlePath setLineWidth:1];
        [circlePath setLineCapStyle:kCGLineCapRound];
        [[UIColor clearColor] setStroke];
        [circlePath stroke];
        
        self.shapeLayer = [CAShapeLayer new];
        //设置shapeLayer的尺寸和位置
        self.shapeLayer.frame = CGRectMake(0, 0, self.bounds.size.width/2, self.bounds.size.height/2);
        //设置颜色
        self.shapeLayer.fillColor = [UIColor grayColor].CGColor;
        //可 设置线条宽度 yanse啊
//        self.shapeLayer.lineWidth = 1;
//        self.shapeLayer.strokeColor = [UIColor redColor].CGColor;
        //关联
        self.shapeLayer.path = circlePath.CGPath;
        [self.layer addSublayer:self.shapeLayer];
    
    }
    return self;
}

- (void)reDraw:(NSTimer*)t
{

    [self.animationLayer removeFromSuperlayer];
    [self setNeedsDisplay];
}


-(void)drawRect:(CGRect)rect
{
    [[UIColor clearColor] setFill];
    UIRectFill(rect);
    
    NSInteger maxCount = 2;
    double animationDuration = 3;
    
    CALayer *animationLayer = [CALayer new];
    self.animationLayer = animationLayer;
 
    for (int i = 0; i < maxCount; i ++) {
        
        CGFloat radius = MIN(self.bounds.size.width * 0.4, self.bounds.size.height * 0.5) ;
        
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2) radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
        [path addClip];
        [path setLineWidth:1];
        [path setLineCapStyle:kCGLineCapRound];
        // 设置描边色
        [[UIColor clearColor] setStroke];
        // 设置填充色
        //            [[UIColor colorWithHex:0XFE6969] setFill];
        [path stroke];
        
        CAShapeLayer *shaperLayer = [CAShapeLayer layer];
        shaperLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);//设置shapeLayer的尺寸和位置
        
        shaperLayer.fillColor = [[UIColor grayColor] colorWithAlphaComponent:1].CGColor;//填充颜色为ClearColor
        //设置线条的宽度和颜色
        //    self.shapeLayer.lineWidth = 1.0f;
        shaperLayer.strokeColor = [UIColor clearColor].CGColor;
        //让贝塞尔曲线与CAShapeLayer产生联系
        shaperLayer.path = path.CGPath;
        CAMediaTimingFunction * defaultCurve = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        
        CAAnimationGroup * animationGroup = [[CAAnimationGroup alloc]init];
        animationGroup.fillMode = kCAFillModeBoth;
        //因为雷达中每个圈圈的大小不一致，故需要他们在一定的相位差的时刻开始运行。
        animationGroup.beginTime = CACurrentMediaTime() + (double)i * animationDuration/(double)maxCount;
        animationGroup.duration = animationDuration;//每个圈圈从生成到消失使用时常，也即动画组每轮动画持续时常
        animationGroup.repeatCount = HUGE_VAL;//表示动画组持续时间为无限大，也即动画无限循环。
        animationGroup.timingFunction = defaultCurve;
        
        //雷达圆圈初始大小以及最终大小比率。
        CABasicAnimation * scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        scaleAnimation.autoreverses = NO;
        scaleAnimation.fromValue = [NSNumber numberWithDouble:0.35];
        scaleAnimation.toValue = [NSNumber numberWithDouble:0.75];
        
        //雷达圆圈在n个运行阶段的透明度，n为数组长度。
        CAKeyframeAnimation * opacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
        //雷达运行四个阶段不同的透明度。
        opacityAnimation.values = @[[NSNumber numberWithDouble:1.0],[NSNumber numberWithDouble:0.5],[NSNumber numberWithDouble:0.3],[NSNumber numberWithDouble:0.0]];
        //雷达运行的不同的四个阶段，为0.0表示刚运行，0.5表示运行了一半，1.0表示运行结束。
        opacityAnimation.keyTimes = @[[NSNumber numberWithDouble:0.0],[NSNumber numberWithDouble:0.25],[NSNumber numberWithDouble:0.5],[NSNumber numberWithDouble:1.0]];
        //将两组动画（大小比率变化动画，透明度渐变动画）组合到一个动画组。
        animationGroup.animations = @[scaleAnimation,opacityAnimation];
        
        [shaperLayer addAnimation:animationGroup forKey:@"pulsing"];
        [animationLayer addSublayer:shaperLayer];
    }
    [self.layer addSublayer:self.animationLayer];
    //以下部分为雷达中心的图。雷达圈圈也是从该图中心发出。
    CALayer * thumbnailLayer = [[CALayer alloc]init];
    thumbnailLayer.backgroundColor = [UIColor whiteColor].CGColor;
    CGRect thumbnailRect = CGRectMake(0, 0, 0, 0);
    thumbnailLayer.frame = thumbnailRect;
    thumbnailLayer.masksToBounds = YES;
    thumbnailLayer.borderColor = [UIColor whiteColor].CGColor;
    [self.layer addSublayer:thumbnailLayer];
}

- (void)animate:(BOOL)animate
{
//    isStart = animate;
//    if (animate) {
//        if (!_timer) {
//            _timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(reDraw:) userInfo:nil repeats:NO] ;
//        }else{
//            [_timer invalidate];
//            _timer = nil;
//            [self.animationLayer removeFromSuperlayer];
//            _timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(reDraw:) userInfo:nil repeats:NO] ;
//        }
//    }else{
//        [_timer invalidate];
//        _timer = nil;
//        [self.animationLayer removeFromSuperlayer];
//
//    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
