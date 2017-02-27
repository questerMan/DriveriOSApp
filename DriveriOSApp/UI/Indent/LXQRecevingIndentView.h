//
//  LXQRecevingIndentView.h
//  DriveriOSApp
//
//  Created by mac on 17/1/18.
//  Copyright © 2017年 陆遗坤. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IndentData.h"

@interface LXQRecevingIndentView : UIView

/** 名字 */
@property (nonatomic, strong) UILabel *titleLabel;
/** 头像图标 */
@property (nonatomic, strong) UIImageView *headIMG;
/** 名字 */
@property (nonatomic, strong) UILabel *name;
/** 电话 */
@property (nonatomic, strong) UILabel *number;
/** 上车图标 */
@property (nonatomic, strong) UIImageView *tCarIMG;
/** 下车图标 */
@property (nonatomic, strong) UIImageView *bCarIMG;
/** 预约时间图标 */
@property (nonatomic, strong) UIImageView *timeIMG;
/** 上车点 */
@property (nonatomic, strong) UILabel *tCarLab;
/** 下车点 */
@property (nonatomic, strong) UILabel *bCarLab;
/** 预约时间 */
@property (nonatomic, strong) UILabel *timeLab;
/** 上车点文本 */
@property (nonatomic, strong) UILabel *tCarText;
/** 下车点文本 */
@property (nonatomic, strong) UILabel *bCarText;
/** 预约时间文本 */
@property (nonatomic, strong) UILabel *timeText;
/** 打电话按钮 */
@property (nonatomic, strong) UIButton *callBtn;
/** 订单状态标签 */
@property (nonatomic, strong) UILabel *satus;

@property (nonatomic, strong) IndentData *model;

/** 该派单按钮 */
@property (nonatomic, strong) UIButton *sendBtn;

@property (nonatomic, weak) UIButton* scalingBtn;

/** 出发地背景 */
@property (nonatomic, strong) UIView *tCarView;
/** 目的地背景 */
@property (nonatomic, strong) UIView *bCarView;
/** 伸缩背景 */
@property (nonatomic, strong) UIView *scalingView;
/** 伸缩背景 */
@property (nonatomic, strong) UIView *hidenView;

- (void)scalingBtnClick:(UIButton *)sender;

@end
