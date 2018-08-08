//
//  ZHPhoneTextField.m
//  Finance
//
//  Created by 知合金服-Mini on 2018/5/23.
//  Copyright © 2018年 知合金服. All rights reserved.
//

#import "ZHPhoneTextField.h"

@interface ZHPhoneTextField ()
{
    NSInteger lastIndex;
}

@end

@implementation ZHPhoneTextField


-(instancetype)initWithFrame:(CGRect)frame
{
    if (!self) {
        self = [super initWithFrame:frame];
        self.delegate = self;
        [self addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        lastIndex = 0;
    }
    return self;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (string.length == 0) return YES;//输入长度限定 11位
    
    NSInteger existedLength = textField.text.length;
    NSInteger selectedLength = range.length;
    NSInteger replaceLength = string.length;
    if (existedLength - selectedLength + replaceLength > 14) {
        return NO;
    }
    return YES;
}


- (void)textFieldDidChange:(UITextField *)textField
{
    if (textField.text.length >= lastIndex) {
        
        if (textField.text.length == 3) {
            textField.text = [textField.text stringByAppendingString:@" "];
        }
        
        if (textField.text.length == 8) {
            textField.text = [textField.text stringByAppendingString:@" "];
        }
        
    }
    
    if (textField.text.length < lastIndex) {
        if (textField.text.length == 4) {
            textField.text = [textField.text substringWithRange:NSMakeRange(0, 3)];
        }
        if (textField.text.length == 9) {
            textField.text = [textField.text substringWithRange:NSMakeRange(0, 8)];
        }
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
