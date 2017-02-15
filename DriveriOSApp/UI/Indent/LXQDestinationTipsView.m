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

/** 提示文字背景 */
@property (nonatomic, weak) UIView *tipsLabelBg;

/** 提示文字 */
@property (nonatomic, weak) UILabel *tipsLabel;

/** 等待倒计时背景 */
@property (nonatomic, weak) UIView *waitLabelBg;

/** 等待文字 */
@property (nonatomic, weak) UILabel *waitLabel;

/** 倒计时文字 */
@property (nonatomic, weak) UILabel *countLabel;

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
    UIImageView* tipsIMG = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tips"]];
    tipsIMG.center = CGPointMake(MATCHSIZE(30), MATCHSIZE(35));
    tipsIMG.bounds = CGRectMake(0, 0, MATCHSIZE(32), MATCHSIZE(32));
    [self addSubview:tipsIMG];
    self.tipsIMG = tipsIMG;
    
    UIView* tipsLabelBg = [[UIView alloc] initWithFrame:CGRectMake(MATCHSIZE(60), MATCHSIZE(10), MATCHSIZE(660), MATCHSIZE(65))];
    tipsLabelBg.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:tipsLabelBg];
    self.tipsLabelBg = tipsLabelBg;
    
    UILabel* tipsLabel = [[UILabel alloc] init];
    tipsLabel.text = @"正在开车服务，请系好安全带，谨慎驾驶";
    tipsLabel.numberOfLines = 0;
    tipsLabel.textAlignment = NSTextAlignmentCenter;
    tipsLabel.font = [UIFont systemFontOfSize:14];
    [tipsLabelBg addSubview:tipsLabel];
    self.tipsLabel = tipsLabel;
    
    UIView* waitLabelBg = [[UIView alloc] initWithFrame:CGRectMake(MATCHSIZE(60), MATCHSIZE(10)*2 + MATCHSIZE(65), MATCHSIZE(250), MATCHSIZE(135))];
    waitLabelBg.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:waitLabelBg];
    self.waitLabelBg = waitLabelBg;
    
    UILabel* waitLabel = [[UILabel alloc] initWithFrame:CGRectMake(MATCHSIZE(10), MATCHSIZE(0), MATCHSIZE(250) - 2 * MATCHSIZE(10), MATCHSIZE(135))];
    waitLabel.text = @"行程2公里，还剩3公里，共计08.32元";
    waitLabel.font = [UIFont systemFontOfSize:14];
    waitLabel.numberOfLines = 0;
    waitLabel.preferredMaxLayoutWidth = MATCHSIZE(250) - 2 * MATCHSIZE(10);
    [self.waitLabelBg addSubview:waitLabel];
    self.waitLabel = waitLabel;
    
    UILabel* countLabel = [[UILabel alloc] init];
    countLabel.font = [UIFont systemFontOfSize:14];
    [waitLabelBg addSubview:countLabel];
    self.countLabel = countLabel;
    
//  [self.countTimer fire];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(MATCHSIZE(0));
        make.right.offset(MATCHSIZE(20));
        make.top.centerY.offset(0);
      //make.width.offset(MATCHSIZE(620));
    }];
    
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.waitLabel.mas_centerX);
        make.top.equalTo(self.waitLabel.mas_bottom).offset(MATCHSIZE(10));
        make.width.offset(MATCHSIZE(120));
    }];
}

@end
