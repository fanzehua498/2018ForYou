//
//  CycleColloectionView.m
//  BlueToothAbout
//
//  Created by 知合金服-Mini on 2018/7/10.
//  Copyright © 2018年 fanzehua. All rights reserved.
//

#import "CycleColloectionView.h"

@interface CycleColloectionView ()<UICollectionViewDelegate,UICollectionViewDataSource>


@end

@implementation CycleColloectionView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UICollectionView *v = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:[UICollectionViewLayout new]];
        v.delegate = self;
        v.prefetchDataSource = self;
        [self addSubview:v];
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
