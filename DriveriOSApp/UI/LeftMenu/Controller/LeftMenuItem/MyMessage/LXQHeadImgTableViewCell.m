//
//  LXQHeadImgTableViewCell.m
//  DriveriOSApp
//
//  Created by mac on 17/3/9.
//  Copyright © 2017年 陆遗坤. All rights reserved.
//

#import "LXQHeadImgTableViewCell.h"

@interface LXQHeadImgTableViewCell()

/** 头像 */
@property (nonatomic, strong) UIButton *headIMGBtn;



@property(nonatomic, weak)UILabel* titleLabel;

@property(nonatomic, weak)UILabel* contentLabel;

@property(nonatomic, weak)UIButton* arrowBtn;

@end


@implementation LXQHeadImgTableViewCell



-(UIButton *)headIMGBtn{
    if (!_headIMGBtn) {
        _headIMGBtn = [FactoryClass buttonWithFrame:CGRectZero image:[UIImage imageNamed:@""]];
        _headIMGBtn.backgroundColor = [UIColor whiteColor];
    }
    return _headIMGBtn;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self creatUI];
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self creatUI];
        self.selectionStyle = 0;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(headIMGBtnGetIMG) name:@"HeadImg" object:nil];
    }
    return self;
}

-(void)creatUI{
    UILabel* titleLabel = [FactoryClass labelWithTextColor:UIColorFromRGB(@"#b2b2b2") fontSize:MATCHSIZE(28)];
    [self.contentView addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    UILabel* contentLabel = [FactoryClass labelWithTextColor:UIColorFromRGB(@"#333333") fontSize:MATCHSIZE(32)];
    [self.contentView addSubview:contentLabel];
    self.contentLabel = contentLabel;
    
    UIButton* arrowBtn = [UIButton buttonWithType:0];
    [arrowBtn setImage:[UIImage imageNamed:@"arrows"] forState:0];
    [self.contentView addSubview:arrowBtn];
    self.arrowBtn = arrowBtn;
    
    //获取头像
    NSData *headData = [CacheClass getAllDataFromYYCacheWithKey:HeadIMG_KEY];
    if (headData != nil) {
        UIImage *image = [UIImage imageWithData:headData];
        [self.headIMGBtn setImage:image forState:UIControlStateNormal];
    }
    [self.contentView addSubview:self.headIMGBtn];
    self.headIMGBtn.layer.cornerRadius = MATCHSIZE(40);
    self.headIMGBtn.layer.masksToBounds = YES;
    
}

- (void)setItem:(LXQMyMessageItem *)item{
    _item = item;
    
    self.titleLabel.text = item.titleLabel;
    
    self.contentLabel.text = item.contentLabel;
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(MATCHSIZE(26));
        make.centerY.offset(0);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.centerY.offset(0);
    }];
    
    [self.arrowBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(MATCHSIZE(-26));
        make.centerY.offset(0);
    }];
    
    [self.headIMGBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.right.equalTo(self.arrowBtn.mas_left).offset(MATCHSIZE(-30));
        make.width.offset(MATCHSIZE(80));
        make.height.offset(MATCHSIZE(80));
    }];
}

- (void)headIMGBtnGetIMG{
    //获取头像
    NSData *headData = [CacheClass getAllDataFromYYCacheWithKey:HeadIMG_KEY];
    if (headData != nil) {
        UIImage *image = [UIImage imageWithData:headData];
        [self.headIMGBtn setImage:image forState:UIControlStateNormal];
    }
}

//获取当前可视控制器
- (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
