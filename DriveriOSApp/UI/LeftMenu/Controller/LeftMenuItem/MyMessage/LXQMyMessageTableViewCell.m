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

@property(nonatomic, weak)UIView* downLine1;

@property(nonatomic, weak)UIView* downLine2;

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
    
    UIView* downLine1 = [[UIView alloc] init];
    downLine1.backgroundColor = UIColorFromRGB(@"#cccccc");
    [self.contentView addSubview:downLine1];
    self.downLine1 = downLine1;
    
    UIView* downLine2 = [[UIView alloc] init];
    downLine2.backgroundColor = UIColorFromRGB(@"#cccccc");
    [self.contentView addSubview:downLine2];
    self.downLine2 = downLine2;
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
    
    if (item.isLastCell == YES) {
        self.downLine2.hidden = NO;
        self.downLine1.hidden = YES;
    }else{
        self.downLine1.hidden = NO;
        self.downLine2.hidden = YES;
    }
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
    
    [self.downLine1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(MATCHSIZE(26));
        make.right.offset(0);
        make.bottom.offset(0);
        make.height.offset(MATCHSIZE(1));
    }];
    
    [self.downLine2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(MATCHSIZE(0));
        make.right.offset(0);
        make.bottom.offset(0);
        make.height.offset(MATCHSIZE(1));
    }];
}


@end
