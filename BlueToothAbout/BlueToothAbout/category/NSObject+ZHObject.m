//
//  NSObject+ZHObject.m
//  BlueToothAbout
//
//  Created by 知合金服-Mini on 2018/8/20.
//  Copyright © 2018年 fanzehua. All rights reserved.
//

#import "NSObject+ZHObject.h"
#import <objc/message.h>

@implementation NSObject (ZHObject)

- (void)getObjRang{
    NSLog(@"title:%@",self.title);
}

-(void)setTitle:(NSString *)title
{
    objc_setAssociatedObject(self, "titleGet", title, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(NSString *)title
{
    return objc_getAssociatedObject(self, "titleGet");
}

-(CGFloat)assPro
{
    NSNumber *number = objc_getAssociatedObject(self, "zh_assPro");
    return number.floatValue;
    return 100;
}
-(void)setAssPro:(CGFloat)assPro
{
    objc_setAssociatedObject(self, "zh_assPro", [NSNumber numberWithFloat:assPro], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//    self.assPro = assPro;
}

@end
