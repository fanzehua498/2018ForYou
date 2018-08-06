//
//  ImageCell.h
//  BlueToothAbout
//
//  Created by 知合金服-Mini on 2018/6/13.
//  Copyright © 2018年 知合金服-Mini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageCell : UITableViewCell

@property(strong,nonatomic)UIImageView *cellImageView;
- (void)configImageWithUrl:(NSString *)url;
@end
