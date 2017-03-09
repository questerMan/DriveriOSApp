//
//  LXQMyMessageTableViewCell.m
//  DriveriOSApp
//
//  Created by mac on 17/3/9.
//  Copyright © 2017年 陆遗坤. All rights reserved.
//

#import "LXQMyMessageTableViewCell.h"

@interface LXQMyMessageTableViewCell()

@property(nonatomic, weak)UILabel* titleLabel;

@property(nonatomic, weak)UILabel* contentLabel;

@property(nonatomic, weak)UIButton* arrowBtn;

@end

@implementation LXQMyMessageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
