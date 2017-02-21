//
//  InstantIndentCommingAlert.m
//  DriveriOSApp
//
//  Created by lixin on 17/1/20.
//  Copyright © 2017年 陆遗坤. All rights reserved.
//

#import "InstantIndentCommingAlert.h"

@interface InstantIndentCommingAlert ()

@end

@implementation InstantIndentCommingAlert

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  
    [self creatUI];
}
-(void)creatUI{
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.titleIMG = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fight"]];
    [self.view addSubview:self.titleIMG];
    [self.titleIMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(MATCHSIZE(25));
        make.centerX.offset(0);
        make.height.offset(MATCHSIZE(80));
        make.width.offset(MATCHSIZE(80));
    }];
    
    
   

    
    self.titleLab = [FactoryClass labelWithText:nil fontSize:MATCHSIZE(26) textColor:UIColorFromRGB(@"#333333") numberOfLine:2 textAlignment:NSTextAlignmentCenter backGroundColor:[UIColor clearColor]];
    [self.view addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleIMG.mas_bottom).offset(MATCHSIZE(25));
        make.bottom.equalTo(self.view).offset(MATCHSIZE(-50));
        make.left.equalTo(self.view).offset(MATCHSIZE(20));
        make.right.equalTo(self.view).offset(MATCHSIZE(-20));
    }];
    
    NSString *firstStr = @"您有个";
    NSString *indentName = @"即时单";
    NSString *strText = [NSString stringWithFormat:@"您有个%@，请立即查看，要赶紧去赚大款咯...",indentName];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:strText];
    
    [str addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(@"#ff6d00") range:NSMakeRange([firstStr length],[indentName length])];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:MATCHSIZE(26)] range:NSMakeRange([firstStr length],[indentName length])];
    self.titleLab.attributedText = str;
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
