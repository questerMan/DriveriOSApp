//
//  LXQFeedbackViewController.m
//  DriveriOSApp
//
//  Created by mac on 17/3/16.
//  Copyright © 2017年 陆遗坤. All rights reserved.
//

#import "LXQFeedbackViewController.h"

@interface LXQFeedbackViewController ()<UITextViewDelegate>

@property(nonatomic,strong)UIView *textViewBg;

@property(nonatomic,strong)UIView *textViewBgLine;

@property(nonatomic,strong)UITextView *textView;

@property(nonatomic,strong)UILabel *placeHolderLabel;

@property(nonatomic,strong)UILabel *residueLabel;// 输入文本时剩余字数

@property(nonatomic,strong)UIButton *confirmBtn;

@end

@implementation LXQFeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"意见反馈";
    self.view.backgroundColor = UIColorFromRGB(@"#f0f0f0");
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"return_"] style:0 target:self action:@selector(leftBtnClick)];
    self.navigationItem.leftBarButtonItem.tintColor = COLOR(154, 151, 151, 1);
    
    [self changeNavigation];
    
    [self creatUI];
}

- (void)leftBtnClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)creatUI{
    //底部视图
    UIView *textViewBg= [[UIView alloc] init];
    textViewBg.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:textViewBg];
    self.textViewBg = textViewBg;
    
    UIView *textViewBgLine = [[UIView alloc] init];
    textViewBgLine.backgroundColor = UIColorFromRGB(@"#cccccc");
    [self.view addSubview:textViewBgLine];
    self.textViewBgLine = textViewBgLine;
    
    //先创建个方便多行输入的textView
    self.textView =[ [UITextView alloc]init];
    self.textView.delegate = self;
    self.textView.tintColor = UIColorFromRGB(@"#ff6d00");
    self.textView.font = [UIFont systemFontOfSize:MATCHSIZE(28)];
    self.textView.textColor = UIColorFromRGB(@"#666666");
    [self.textViewBg addSubview: self.textView];

    //再创建个可以放置默认字的lable
    self.placeHolderLabel = [[UILabel alloc]init];
    self.placeHolderLabel.numberOfLines = 0;
    self.placeHolderLabel.text = @"您的宝贵意见是我们努力奋斗的目标，感谢您的支持";
    self.placeHolderLabel.font = [UIFont systemFontOfSize:MATCHSIZE(24)];
    self.placeHolderLabel.textColor = UIColorFromRGB(@"#d9d9d9");
    self.placeHolderLabel.backgroundColor =[UIColor clearColor];
    [self.textViewBg addSubview:self.placeHolderLabel];
    
    //多余的一步不需要的可以不写  计算textview的输入字数
    self.residueLabel = [[UILabel alloc] init];
    self.residueLabel.backgroundColor = [UIColor clearColor];
    self.residueLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
    self.residueLabel.text =[NSString stringWithFormat:@"140/140"];
    self.residueLabel.textColor = [[UIColor grayColor]colorWithAlphaComponent:0.5];
    [self.textViewBg addSubview:self.residueLabel];
    
    UIButton *confirmBtn = [UIButton buttonWithType:0];
    [confirmBtn setAttributedTitle:[[NSAttributedString alloc] initWithString:@"提交" attributes:@{NSForegroundColorAttributeName : [UIColor whiteColor],NSFontAttributeName : [UIFont systemFontOfSize:MATCHSIZE(32)]}] forState:0];
    confirmBtn.backgroundColor = UIColorFromRGB(@"#e5e5e5");
    confirmBtn.layer.cornerRadius = MATCHSIZE(18);
    confirmBtn.layer.masksToBounds = YES;
    [self.view addSubview:confirmBtn];
    self.confirmBtn = confirmBtn;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    [self.textViewBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(MATCHSIZE(26));
        make.top.offset(MATCHSIZE(20));
        make.width.offset(MATCHSIZE(698));
        make.height.offset(MATCHSIZE(328));
    }];
    
    [self.textViewBgLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textViewBg.mas_bottom);
        make.left.equalTo(self.textViewBg.mas_left);
        make.right.equalTo(self.textViewBg.mas_right);
        make.height.offset(MATCHSIZE(1));
    }];
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(MATCHSIZE(20));
        make.top.offset(MATCHSIZE(20));
        make.right.offset(MATCHSIZE(-20));
        make.bottom.offset(MATCHSIZE(-20));
    }];
    
    [self.placeHolderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(MATCHSIZE(40));
        make.top.offset(MATCHSIZE(37));
    }];
    
    [self.residueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(MATCHSIZE(-20));
        make.bottom.offset(MATCHSIZE(-20));
    }];
    
    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textViewBgLine.mas_bottom).offset(MATCHSIZE(154));
        make.centerX.offset(0);
        make.width.offset(MATCHSIZE(548));
        make.height.offset(MATCHSIZE(80));
    }];
}

//接下来通过textView的代理方法实现textfield的点击置空默认自负效果

- (void)textViewDidChange:(UITextView*)textView

{
    
    if([textView.text length] == 0){
        
        self.placeHolderLabel.text = @"您的宝贵意见是我们努力奋斗的目标，感谢您的支持";
        self.confirmBtn.backgroundColor = UIColorFromRGB(@"#e5e5e5");
    }else{
        
        self.placeHolderLabel.text = @"";//这里给空
        self.confirmBtn.backgroundColor = UIColorFromRGB(@"#ff6d00");
    }
    
    //计算剩余字数   不需要的也可不写
    
    NSUInteger existTextNum = textView.text.length;
    
    NSUInteger remainTextNum = 140 - existTextNum;
    
    self.residueLabel.text = [NSString stringWithFormat:@"%lu/140",remainTextNum];
    
}

//设置超出最大字数（140字）即不可输入 也是textview的代理方法

-(BOOL)textView:(UITextView*)textView shouldChangeTextInRange:(NSRange)range

replacementText:(NSString*)text

{
    
    if ([text isEqualToString:@"\n"]) {     //这里"\n"对应的是键盘的 return 回收键盘之用
        
        [textView resignFirstResponder];
        
        return YES;
        
        }
        
        if (range.location >= 140)
            
        {
            return NO;
            
        }
        else
        {
            
            return YES;
            
        }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.textView resignFirstResponder];
}

@end
