//
//  PopItemView.m
//  BlueToothAbout
//
//  Created by 知合金服-Mini on 2018/7/10.
//  Copyright © 2018年 fanzehua. All rights reserved.
//

#import "PopItemView.h"

#define kbTag 10086

#define Radius 80

@interface PopItemView ()
@property (nonatomic, assign) NSInteger number;

@end


@implementation PopItemView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        if (self.number <=0) {
            self.number = 3;
        }
        
        CGFloat width = 40;
        for (int i = 0; i < self.number; i ++) {
            UIButton * popB = [UIButton buttonWithType:UIButtonTypeCustom];
            popB.frame = CGRectMake(frame.size.width/2-20 , frame.size.width/2 , width, width);
            NSString *imageName = [NSString stringWithFormat:@"%d",i];
            [popB setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
            popB.layer.cornerRadius = 20;
            popB.layer.masksToBounds = YES;
            popB.tag = 10086 + i;
            [self addSubview:popB];
        }
        
        UIButton *centerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        centerButton.frame = CGRectMake(frame.size.width/2-40, frame.size.height/2-40, 80, 80);
        [centerButton setImage:[UIImage imageNamed:@"kobe1"] forState:UIControlStateNormal];
        centerButton.layer.cornerRadius = 40;
        centerButton.layer.masksToBounds = YES;
        [centerButton addTarget:self action:@selector(popThepopB:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:centerButton];
        
    }
    return self;
}

- (void)popThepopB:(UIButton *)sender
{
    sender.enabled = NO;
    sender.selected = !sender.isSelected;
    
    if (sender.selected) {
        [self pop:sender];
        
    }else{
        [self hide:sender];
        
    }
}


- (void)pop:(UIButton *)sender{
    
    CGFloat padding = Radius * 2 / (self.number - 1);
    
    for (int i = 0; i < self.number; i ++) {
        [UIView animateWithDuration:0.2 delay:0.2 * i   options:UIViewAnimationOptionCurveLinear animations:^{
            
            UIButton * popB = [self viewWithTag:kbTag + i];
            
            CGFloat centerPointX = 0;
            CGFloat centerPointY = 0;
            centerPointX = self.frame.size.width/2 - Radius + padding * i;
            centerPointY = self.frame.size.height/2 - sqrt(fabs(Radius * Radius - (Radius - padding * i) * (Radius - padding * i)));
            
            popB.center = CGPointMake(centerPointX, centerPointY);
            
        } completion:^(BOOL finished) {
            if (finished && i == self.number-1) {
                sender.enabled = YES;
            }
            
        }];
    }
    

    
}

- (void)hide:(UIButton *)sender{
   
    for (long i = self.number - 1; i >= 0; i --) {
        [UIView animateWithDuration:0.2 delay:0.2 * (self.number - 1 - i)  options:UIViewAnimationOptionCurveLinear animations:^{
            
            UIButton * popB = [self viewWithTag:kbTag + i];
            
            CGFloat centerPointX = 0;
            CGFloat centerPointY = 0;
            centerPointX = self.frame.size.width/2 ;
            centerPointY = self.frame.size.width/2 + 20;
        
            popB.center = CGPointMake(centerPointX, centerPointY);
            
        } completion:^(BOOL finished) {
            if (finished && i == 0) {
                sender.enabled = YES;
            }
        }];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
