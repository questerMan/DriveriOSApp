//
//  LXQReservationIndentTips.m
//  DriveriOSApp
//
//  Created by mac on 17/2/8.
//  Copyright © 2017年 陆遗坤. All rights reserved.
//

#import "LXQReservationIndentTips.h"

@interface LXQReservationIndentTips()

/** 提示图标 */
@property (nonatomic, weak) UIImageView *tipsIMG;

/** 提示文字背景 */
@property (nonatomic, weak) UIView *tipsLabelBg;

/** 提示文字 */
@property (nonatomic, weak) UILabel *tipsLabel;

@end

@implementation LXQReservationIndentTips

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self creatUI];
    }
    return self;
}

- (void)creatUI{
    UIImageView* tipsIMG = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tips"]];
    tipsIMG.center = CGPointMake(MATCHSIZE(30), MATCHSIZE(35));
    tipsIMG.bounds = CGRectMake(0, 0, MATCHSIZE(32), MATCHSIZE(32));
    [self addSubview:tipsIMG];
    self.tipsIMG = tipsIMG;
    
    UIView* tipsLabelBg = [[UIView alloc] initWithFrame:CGRectMake(MATCHSIZE(60), MATCHSIZE(10), MATCHSIZE(660), MATCHSIZE(65) / 2)];
    tipsLabelBg.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:tipsLabelBg];
    self.tipsLabelBg = tipsLabelBg;
    
    UILabel* tipsLabel = [[UILabel alloc] init];
    tipsLabel.text = @"您有个预约单将在两小时后开始，请您记得准时到达目的地";
    tipsLabel.numberOfLines = 0;
    tipsLabel.font = [UIFont systemFontOfSize:14];
    [tipsLabelBg addSubview:tipsLabel];
    self.tipsLabel = tipsLabel;
}

@end
