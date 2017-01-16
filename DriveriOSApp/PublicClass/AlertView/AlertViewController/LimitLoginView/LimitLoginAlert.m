//
//  LimitLoginView.m
//  DriveriOSApp
//
//  Created by lixin on 17/1/9.
//  Copyright © 2017年 陆遗坤. All rights reserved.
//

#import "LimitLoginAlert.h"

@interface LimitLoginAlert ()


@end

@implementation LimitLoginAlert

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatUI];

}

-(void)creatUI{
    self.view.backgroundColor = COLOR(201, 201, 201, 1);
    
    UIImageView *headIMG = [FactoryClass imageViewWithFrame:CGRectMake((SCREEN_W - MATCHSIZE(335))/2, MATCHSIZE(50), MATCHSIZE(75), MATCHSIZE(75)) Image:[UIImage imageNamed:@"limitLogin"]];
    [self.view addSubview:headIMG];
    
    UILabel *titileLable = [FactoryClass labelWithText:@"对不起，你已被禁止登录" fontSize:MATCHSIZE(30) textColor:[UIColor blackColor] numberOfLine:0 textAlignment: NSTextAlignmentCenter backGroundColor:[UIColor clearColor]];
    titileLable.frame = CGRectMake((SCREEN_W - MATCHSIZE(480))/2, MATCHSIZE(145), MATCHSIZE(220), MATCHSIZE(100));
    [self.view addSubview:titileLable];
    
    UIButton *closeBtn = [FactoryClass buttonWithFrame:CGRectMake((SCREEN_W - MATCHSIZE(480))/2, MATCHSIZE(265), MATCHSIZE(220), MATCHSIZE(90)) Title:@"关闭" backGround:[UIColor whiteColor] tintColor:[UIColor blackColor] cornerRadius:MATCHSIZE(8)];
    [closeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:closeBtn];
    
    //关闭按钮的点击事件
    [[closeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
                
        if ([_delegate respondsToSelector:@selector(closeAlertView)]) {
            [_delegate closeAlertView];
        }
        
    }];
    
}
@end
