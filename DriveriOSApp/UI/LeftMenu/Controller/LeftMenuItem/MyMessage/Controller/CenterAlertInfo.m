//
//  CenterAlertInfo.m
//  DriveriOSApp
//
//  Created by lixin on 16/11/28.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//

#import "CenterAlertInfo.h"

@interface CenterAlertInfo ()


@end

@implementation CenterAlertInfo

-(UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [FactoryClass labelWithText:@"" fontSize:MATCHSIZE(30) textColor:[UIColor blackColor] numberOfLine:0 textAlignment:NSTextAlignmentLeft backGroundColor:[UIColor clearColor]];
        _contentLabel.font = [UIFont boldSystemFontOfSize:MATCHSIZE(36)];
    }
    return _contentLabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [self creatUI];
    
}

-(void)creatUI{
    
    [self.view addSubview:self.contentLabel];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(MATCHSIZE(35));
        make.right.equalTo(self.view).offset(MATCHSIZE(-35));
        make.top.equalTo(self.view).offset(MATCHSIZE(35));
        make.bottom.equalTo(self.view).offset(MATCHSIZE(-35));
    }];
    
}




-(void)viewDidDisappear:(BOOL)animated{
   

}
-(void)dealloc{
    
    
}

@end
