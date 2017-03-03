//
//  IndentSucceedAlert.m
//  DriveriOSApp
//
//  Created by lixin on 17/1/20.
//  Copyright © 2017年 陆遗坤. All rights reserved.
//

#import "IndentSucceedAlert.h"

@interface IndentSucceedAlert ()

@end

@implementation IndentSucceedAlert

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatUI];
}
-(void)creatUI{
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.titleIMG = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"smile_"]];
    [self.view addSubview:self.titleIMG];
    [self.titleIMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(MATCHSIZE(34));
        make.centerX.offset(0);
        make.height.offset(MATCHSIZE(80));
        make.width.offset(MATCHSIZE(80));
    }];
    
    self.titleLab = [FactoryClass labelWithText:@"接单成功!正在拨打乘客的电话,请检查车上服务用品,尽快前往上车点。" fontSize:MATCHSIZE(28) textColor:UIColorFromRGB(@"#333333") numberOfLine:3 textAlignment:NSTextAlignmentCenter backGroundColor:[UIColor clearColor]];
    [self.view addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleIMG.mas_bottom).offset(MATCHSIZE(34));
        make.bottom.equalTo(self.view).offset(MATCHSIZE(-47));
        make.left.equalTo(self.view).offset(MATCHSIZE(46));
        make.right.equalTo(self.view).offset(MATCHSIZE(-46));
    }];
    
}


@end
