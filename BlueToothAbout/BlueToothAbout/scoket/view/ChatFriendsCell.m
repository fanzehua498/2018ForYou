//
//  ChatFriendsCell.m
//  BlueToothAbout
//
//  Created by 知合金服-Mini on 2018/5/30.
//  Copyright © 2018年 知合金服-Mini. All rights reserved.
//

#import "ChatFriendsCell.h"

@interface ChatFriendsCell ()
@property(strong,nonatomic)UIImageView *headImageView;

@end


@implementation ChatFriendsCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
        self.headImageView.image = [UIImage imageNamed:@"head"];
        [self.contentView addSubview:self.headImageView];
        self.contentLabel = [UILabel new];
        [self.contentView addSubview:self.contentLabel];
        
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headImageView.mas_right).offset(10);
            make.top.equalTo(self.headImageView.mas_top).offset(0);
            make.right.equalTo(self.contentView.mas_right).offset(-10);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
        }];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor darkGrayColor];
        
        self.chatImageView = [UIImageView new];
        [self.contentView addSubview:self.chatImageView];
        [self.chatImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headImageView.mas_right).offset(10);
            make.top.equalTo(self.headImageView.mas_top).offset(0);
            make.right.equalTo(self.contentView.mas_right).offset(-10);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
        }];
        
        
    }
    return self;
}


- (void)configDataWithModel:(ChatModel *)dataModel
{
    if ([dataModel.type isEqualToString:@"txt"]) {
        self.chatImageView.hidden = YES;
        self.contentLabel.hidden = NO;
        self.contentLabel.text = dataModel.content;
    }
    if ([dataModel.type isEqualToString:@"img"]) {
        self.chatImageView.hidden = NO;
        self.contentLabel.hidden = YES;
        NSData *data =[[NSData alloc]initWithBase64EncodedString:dataModel.content options:(NSDataBase64DecodingIgnoreUnknownCharacters)];;
        self.chatImageView.image = [UIImage imageWithData:data];
    }
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
