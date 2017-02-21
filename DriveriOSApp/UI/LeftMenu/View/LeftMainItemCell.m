//
//  LeftMainItemCell.m
//  DriveriOSApp
//
//  Created by lixin on 17/2/21.
//  Copyright © 2017年 陆遗坤. All rights reserved.
//

#import "LeftMainItemCell.h"

@implementation LeftMainItemCell





- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self creatUI];
        
    }
    return self;
}

-(void)creatUI{
    
    self.itemIMG = [[UIImageView alloc] init];
    [self addSubview:self.itemIMG];
    
    [self.itemIMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(MATCHSIZE(24));
        make.top.equalTo(self).offset(MATCHSIZE(0));
        make.bottom.equalTo(self).offset(MATCHSIZE(-60));
        make.width.offset(MATCHSIZE(30));
    }];
    
    self.itemTitle = [FactoryClass labelWithText:@"" fontSize:MATCHSIZE(28) textColor:UIColorFromRGB(@"#8c8c8c") numberOfLine:1 textAlignment:NSTextAlignmentLeft backGroundColor:[UIColor clearColor]];
    [self addSubview:self.itemTitle];
    [self.itemIMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.itemIMG.mas_right).offset(MATCHSIZE(20));
        make.top.equalTo(self).offset(MATCHSIZE(0));
        make.bottom.equalTo(self).offset(MATCHSIZE(-60));
        make.width.offset(MATCHSIZE(30));
    }];
    
    self.itemCount = [FactoryClass labelWithText:@"" fontSize:MATCHSIZE(28) textColor:UIColorFromRGB(@"#ffffff") numberOfLine:1 textAlignment:NSTextAlignmentLeft backGroundColor:UIColorFromRGB(@"#ff6d00")];
    self.itemCount.layer.cornerRadius = MATCHSIZE(9);
    self.itemCount.layer.masksToBounds = YES;
    [self addSubview:self.itemCount];
    [self.itemCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.itemIMG.mas_right).offset(MATCHSIZE(-84));
        make.top.equalTo(self).offset(MATCHSIZE(6));
        make.bottom.equalTo(self).offset(MATCHSIZE(-66));
        make.width.offset(MATCHSIZE(18));
    }];
    
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
