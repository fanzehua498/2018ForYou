//
//  ZHRefreshComponet.h
//  BlueToothAbout
//
//  Created by 知合金服-Mini on 2018/7/26.
//  Copyright © 2018年 fanzehua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZHRefreshComponet : UIView

@property (nonatomic ,strong) UILabel *titleLabel;
@property (nonatomic ,strong) UIImageView *imageView;
@property (nonatomic ,strong) UIImageView *backgroundImageView;
@property (nonatomic ,strong) UIActivityIndicatorView *indicatorView;

/**
 刷新时调用
 */
@property(copy,nonatomic)void (^refreshHandler)(ZHRefreshComponet *refresh);



@end
