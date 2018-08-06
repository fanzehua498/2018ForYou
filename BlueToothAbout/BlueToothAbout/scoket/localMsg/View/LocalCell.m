//
//  LocalCell.m
//  BlueToothAbout
//
//  Created by 知合金服-Mini on 2018/8/6.
//  Copyright © 2018年 fanzehua. All rights reserved.
//

#import "LocalCell.h"

@interface LocalCell ()
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *personLabel;
@property (weak, nonatomic) IBOutlet UITextView *contentLabel;

@end

@implementation LocalCell

-(void)localMsgModelData:(LocalMsgModel *)mdoel
{
    self.timeLabel.text = mdoel.time;
    self.personLabel.text = mdoel.Person;
    self.contentLabel.text = mdoel.Msg;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];


    // Configure the view for the selected state
}

@end
