//
//  ChatFriendsCell.h
//  BlueToothAbout
//
//  Created by 知合金服-Mini on 2018/5/30.
//  Copyright © 2018年 知合金服-Mini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatModel.h"
@interface ChatFriendsCell : UITableViewCell
@property(strong,nonatomic)UILabel *contentLabel;
@property (nonatomic ,strong) UIImageView *chatImageView;


- (void)configDataWithModel:(ChatModel *)dataModel;
@end
