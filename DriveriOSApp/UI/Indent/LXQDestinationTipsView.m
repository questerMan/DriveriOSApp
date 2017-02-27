//
//  LXQDestinationTipsView.m
//  DriveriOSApp
//
//  Created by mac on 17/2/13.
//  Copyright © 2017年 陆遗坤. All rights reserved.
//

#import "LXQDestinationTipsView.h"

@interface LXQDestinationTipsView ()

/** 提示图标 */
@property (nonatomic, weak) UIImageView *tipsIMG;

/** 聊天气泡 */
@property (nonatomic, weak) UIImageView *chatAir;

/** 提示文字背景 */
@property (nonatomic, weak) UIView *tipsLabelBg;

/** 提示文字 */
@property (nonatomic, weak) UILabel *tipsLabel;

/** 计费文字 */
@property (nonatomic, weak) UILabel *priceLabel;

@end

@implementation LXQDestinationTipsView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self creatUI];
    }
    return self;
}

-(void)creatUI{
    UIImageView* tipsIMG = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"reminder"]];
    //    tipsIMG.center = CGPointMake(MATCHSIZE(30), MATCHSIZE(35));
    //    tipsIMG.bounds = CGRectMake(0, 0, MATCHSIZE(32), MATCHSIZE(32));
    [self addSubview:tipsIMG];
    self.tipsIMG = tipsIMG;
    
    //    UIView* tipsLabelBg = [[UIView alloc] initWithFrame:CGRectMake(MATCHSIZE(60), MATCHSIZE(10), MATCHSIZE(660), MATCHSIZE(65))];
    //    tipsLabelBg.backgroundColor = [UIColor lightGrayColor];
    //    [self addSubview:tipsLabelBg];
    //    self.tipsLabelBg = tipsLabelBg;
    UIImageView* chatAir = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"prompt-box"]];
    [self addSubview:chatAir];
    self.chatAir = chatAir;
    
    UILabel* tipsLabel = [[UILabel alloc] init];
    tipsLabel.text = @"您有个预约单将在两小时后开始，请您记得准时到达目的地。";
    tipsLabel.textColor = UIColorFromRGB(@"#737373");
    tipsLabel.numberOfLines = 0;
    tipsLabel.font = [UIFont systemFontOfSize:MATCHSIZE(20)];
    [chatAir addSubview:tipsLabel];
    self.tipsLabel = tipsLabel;
    
    UIView* tipsLabelBg = [[UIView alloc] init];
    tipsLabelBg.backgroundColor = [UIColor whiteColor];
    tipsLabelBg.layer.cornerRadius = MATCHSIZE(6);
    tipsLabelBg.layer.borderColor = [COLOR(204, 204, 204, 1) CGColor];
    tipsLabelBg.layer.borderWidth = MATCHSIZE(1);
    [self addSubview:tipsLabelBg];
    self.tipsLabelBg = tipsLabelBg;
    
    UILabel* priceLabel = [[UILabel alloc] init];
    NSMutableAttributedString* str = [[NSMutableAttributedString alloc] initWithString:@"已行驶2公里，还剩1.5公里，计费10.12元"];
    [str addAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:MATCHSIZE(20)],NSForegroundColorAttributeName : UIColorFromRGB(@"#333333")} range:NSMakeRange(0, 23)];
    [str addAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:MATCHSIZE(20)],NSForegroundColorAttributeName : UIColorFromRGB(@"#ff6d00")} range:NSMakeRange(3, 1)];
    [str addAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:MATCHSIZE(20)],NSForegroundColorAttributeName : UIColorFromRGB(@"#ff6d00")} range:NSMakeRange(9, 3)];
    [str addAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:MATCHSIZE(20)],NSForegroundColorAttributeName : UIColorFromRGB(@"#ff6d00")} range:NSMakeRange(17, 5)];
    priceLabel.attributedText = str;
    priceLabel.numberOfLines = 0;
    [tipsLabelBg addSubview:priceLabel];
    self.priceLabel = priceLabel;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.tipsIMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(MATCHSIZE(26));
        make.centerY.equalTo(self.chatAir.mas_centerY);
    }];
    
    [self.chatAir mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.tipsIMG.mas_right).offset(MATCHSIZE(10));
        make.top.offset(MATCHSIZE(5));
    }];
    
    [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(MATCHSIZE(25));
        //        make.right.offset(MATCHSIZE(-12));
        make.width.offset(MATCHSIZE(480));
        make.centerY.offset(0);
        make.height.offset(MATCHSIZE(50));
    }];
    
    [self.tipsLabelBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(MATCHSIZE(64));
        make.top.equalTo(self.chatAir.mas_bottom).offset(MATCHSIZE(5));
        make.width.offset(MATCHSIZE(160));
        make.height.offset(MATCHSIZE(95));
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(MATCHSIZE(12));
        make.width.offset(MATCHSIZE(140));
        make.centerX.offset(0);
    }];
}

@end
