//
//  LXQTableViewCell.m
//  DriveriOSApp
//
//  Created by mac on 17/1/13.
//  Copyright © 2017年 陆遗坤. All rights reserved.
//

#import "LXQTableViewCell.h"
#import "LXQRefuseIndentItem.h"

@interface LXQTableViewCell ()

@property (nonatomic, weak) UILabel* titleLabel;

@property (nonatomic, weak) UIView* separatorLine;

@end

@implementation LXQTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UILabel* label = [[UILabel alloc] init];
        [self.contentView addSubview:label];
        self.titleLabel = label;
        
        UIView* separatorLine = [[UIView alloc] init];
        separatorLine.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:separatorLine];
        self.separatorLine = separatorLine;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.centerY.offset(0);
    }];
    
    [self.separatorLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.right.offset(0);
        make.height.offset(1);
        make.bottom.offset(0);
    }];
}

- (void)setItem:(LXQRefuseIndentItem *)item
{
    _item = item;
    self.titleLabel.text = item.title;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
