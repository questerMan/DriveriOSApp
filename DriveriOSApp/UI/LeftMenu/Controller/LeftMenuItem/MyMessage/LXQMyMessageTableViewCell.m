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

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self creatUI];
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self creatUI];
        self.selectionStyle = 0;
    }
    return self;
}

-(void)creatUI{
    UILabel* titleLabel = [FactoryClass labelWithTextColor:UIColorFromRGB(@"#b2b2b2") fontSize:MATCHSIZE(28)];
    [self.contentView addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    UILabel* contentLabel = [FactoryClass labelWithTextColor:UIColorFromRGB(@"#333333") fontSize:MATCHSIZE(32)];
    [self.contentView addSubview:contentLabel];
    self.contentLabel = contentLabel;
    
    UIButton* arrowBtn = [UIButton buttonWithType:0];
    [arrowBtn setImage:[UIImage imageNamed:@"arrows"] forState:0];
    [arrowBtn addTarget:self action:@selector(arrowBtnClick:) forControlEvents:1<<6];
    [self.contentView addSubview:arrowBtn];
    self.arrowBtn = arrowBtn;
}

- (void)arrowBtnClick:(UIButton*)sender{
    if (_arrowBtnClick) {
        _arrowBtnClick();
    }
}

-(void)setItem:(LXQMyMessageItem *)item{
    _item = item;
    
    self.titleLabel.text = item.titleLabel;
    
    self.contentLabel.text = item.contentLabel;
    
    self.arrowBtnClick = item.arrowBtnClick;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(MATCHSIZE(26));
        make.centerY.offset(0);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.centerY.offset(0);
    }];
    
    [self.arrowBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(MATCHSIZE(-26));
        make.centerY.offset(0);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
