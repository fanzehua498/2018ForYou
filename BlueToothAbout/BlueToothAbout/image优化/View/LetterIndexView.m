//
//  LetterIndexView.m
//  BlueToothAbout
//
//  Created by 知合金服-Mini on 2018/7/9.
//  Copyright © 2018年 fanzehua. All rights reserved.
//

#import "LetterIndexView.h"

#define kTag 10001 //获取试图的tag
#define cornerR 80 //圆半径

@interface LetterIndexView ()
@property(strong,nonatomic)NSArray *letterIndexArr;

@end

@implementation LetterIndexView


#pragma mark - 初始化 构造函数
- (instancetype)initWithFrame:(CGRect)frame Count:(NSArray *)letterArr
{
    self = [super initWithFrame:frame];
    if (self) {
        self.letterIndexArr = [self indexText];
        CGFloat Height = frame.size.height/self.letterIndexArr.count;
        
        for (int i = 0; i < self.letterIndexArr.count; i ++) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, Height * i, frame.size.width, Height)];
            label.text = [NSString stringWithFormat:@"%@",self.letterIndexArr[i]];
            label.font = [UIFont systemFontOfSize:18];
            label.tag = kTag + i;
            label.textAlignment = NSTextAlignmentCenter;
            [self addSubview:label];
        }
    }
    return self;
}

#pragma mark - 触碰中
- (void)touchingWithTochs:(NSSet<UITouch *> *)touches
{
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    CGFloat height = self.frame.size.height/self.letterIndexArr.count;
    
    for (int i = 0; i < self.letterIndexArr.count; i ++) {
        UILabel *label = [self viewWithTag:kTag + i];
        
        if (fabs(label.center.y - touchPoint.y) <= cornerR ) {
            
            [UIView animateWithDuration:0.2 animations:^{
                //本质：点落在圆上 使用勾股定理计算x值 a^2 + b^2 = c^2; c ： 半径
                label.center = CGPointMake(label.frame.size.width/2 - sqrt(fabs(cornerR * cornerR - fabs((label.center.y - touchPoint.y)) * fabs((label.center.y - touchPoint.y)))), label.center.y);
                
                
            }];
        }else{
            [UIView animateWithDuration:0.2 animations:^{
               
                label.center = CGPointMake(self.frame.size.width/2, i *height +height/2);
                label.frame = CGRectMake(label.frame.origin.x, label.frame.origin.y, self.frame.size.width, self.frame.size.width);
            }];
        }
    }
}
// 触碰结束
- (void)touchFinash
{
    CGFloat labelHeight = self.frame.size.height/self.indexText.count;
    [UIView animateWithDuration:0.2 animations:^{
       
        for (int i = 0; i < self.letterIndexArr.count; i ++) {
            
            UILabel *label = [self viewWithTag:kTag + i];
            label.center = CGPointMake(self.frame.size.width / 2, labelHeight/2 + labelHeight * i);
            label.frame = CGRectMake(label.frame.origin.x, label.frame.origin.y, label.frame.size.width, label.frame.size.height);
        
        }
    }];
}

#pragma mark - touch
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self touchingWithTochs:touches];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self touchFinash];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self touchingWithTochs:touches];
}

-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self touchFinash];
}


//26个字母
- (NSArray *)indexText
{
    
    NSMutableArray *arr = [NSMutableArray array];
    for (NSInteger i = 0; i < 26; i ++) {
        unichar ch = 65 + i;
        NSString * str = [NSString stringWithUTF8String:(char *)&ch];
        [arr addObject:str];
    }
    return arr;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
