//
//  ShapeView.m
//  Finance
//
//  Created by lp on 16/11/25.
//  Copyright © 2016年 guest. All rights reserved.
//

#import "ShapeView.h"

@implementation ShapeView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+ (Class)layerClass
{
    return [CAShapeLayer class];
}

- (CAShapeLayer *)shapeLayer
{
    return (CAShapeLayer *)self.layer;
}
@end
