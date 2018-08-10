//
//  ZAnimatianView.m
//  BlueToothAbout
//
//  Created by 知合金服-Mini on 2018/8/10.
//  Copyright © 2018年 fanzehua. All rights reserved.
//

#import "ZAnimatianView.h"

@interface ZAnimatianView ()<UIScrollViewDelegate>
@property (nonatomic ,strong) UIScrollView *scroll;

@property (nonatomic ,strong) UIImageView *leftImageV;
@property (nonatomic ,strong) UIImageView *centerImageV;
@property (nonatomic ,strong) UIImageView *rightImageV;
@end

@implementation ZAnimatianView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.scroll];
        self.scroll.contentSize = CGSizeMake(frame.size.width * 3, frame.size.height);
        self.scroll.contentOffset = CGPointMake(frame.size.width, 0);
        
        self.leftImageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.centerImageV = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width, 0, frame.size.width, frame.size.height)];
        self.rightImageV = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width * 2, 0, frame.size.width, frame.size.height)];
        
        [self.scroll addSubview:self.leftImageV];
        [self.scroll addSubview:self.centerImageV];
        [self.scroll addSubview:self.rightImageV];
    }
    return self;
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    
}


#pragma mark - 懒加载
- (UIScrollView *)scroll
{
    if (!_scroll) {
        _scroll = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scroll.delegate = self;
    }
    return _scroll;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
