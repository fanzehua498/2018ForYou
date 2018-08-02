//
//  DistanceUIAlertView.m
//  BlueToothAbout
//
//  Created by 知合金服-Mini on 2018/5/23.
//  Copyright © 2018年 知合金服-Mini. All rights reserved.
//

#import "DistanceUIAlertView.h"

@implementation DistanceUIAlertView

-(instancetype)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...
{
    if (!self) {
        self = [super initWithTitle:title message:message delegate:delegate cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles,nil];
        NSString *content = title;
        
        NSMutableDictionary *attDic = [NSMutableDictionary dictionary];
        [attDic setValue:[UIFont systemFontOfSize:16] forKey:NSFontAttributeName];      // 字体大小
        [attDic setValue:[UIColor redColor] forKey:NSForegroundColorAttributeName];     // 字体颜色
        [attDic setValue:@5 forKey:NSKernAttributeName];                                // 字间距
        [attDic setValue:[UIColor cyanColor] forKey:NSBackgroundColorAttributeName];    // 设置字体背景色
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:content attributes:attDic];
        
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        style.lineSpacing = 20;                                                          // 设置行之间的间距
        [attStr addAttribute:NSParagraphStyleAttributeName value:style range: NSMakeRange(0, content.length)];
        
        for (int i = 0; i < self.subviews.count; i ++) {
            NSLog(@"%@",self.subviews[i]);
        }
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
