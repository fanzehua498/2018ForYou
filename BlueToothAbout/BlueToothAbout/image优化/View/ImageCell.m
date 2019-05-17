//
//  ImageCell.m
//  BlueToothAbout
//
//  Created by 知合金服-Mini on 2018/6/13.
//  Copyright © 2018年 知合金服-Mini. All rights reserved.
//

#import "ImageCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation ImageCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.cellImageView = [UIImageView new];
        [self.contentView addSubview:self.cellImageView];
        [self.cellImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(10);
            make.right.equalTo(self.contentView.mas_right).offset(10);
            make.top.equalTo(self.contentView.mas_top).offset(10);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(10);
        }];
        
    }
    return self;
}

- (void)configImageWithUrl:(NSString *)url
{
//    [self.imageView sd_setImageWithURL:[NSURL URLWithString:url] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
//        
//    }];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [[SDImageCache sharedImageCache] queryCacheOperationForKey:url done:^(UIImage * _Nullable image, NSData * _Nullable data, SDImageCacheType cacheType) {
            if (image) {
                self.imageView.image = image;
            }else{
//                self.imageView.image = [UIImage imageNamed:@"head"];
                [self.imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"head"] options:SDWebImageRefreshCached completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                    if (image) {
                        [[SDImageCache sharedImageCache] storeImage:image forKey:url toDisk:YES completion:^{

                        }];
                    }else{

                    }
                }];
            }
        }];

    });
//    [self.imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"head"] options:SDWebImageProgressiveDownload completed:nil];
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
