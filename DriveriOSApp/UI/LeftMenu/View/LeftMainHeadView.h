//
//  LYKLeftMainHeadView.h
//  DriveriOSApp
//
//  Created by lixin on 16/11/27.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^LeftMainHeadViewBlock) (void);

@interface LeftMainHeadView : UITableViewCell

@property (nonatomic, copy) LeftMainHeadViewBlock block;
/** 用户头像 */
@property (nonatomic, strong) UIButton *userIMG;

@property (nonatomic, strong) UILabel *userName;

@property (nonatomic, strong) UIImageView *starsIMG;

@property (nonatomic, strong) UILabel *starsCount;

@property (nonatomic, strong) UILabel *carType;

@property (nonatomic, strong) UILabel *carModel;

@property (nonatomic, strong) UILabel *carNumber;

-(void)userIMGWithBlock:(LeftMainHeadViewBlock)block;

/**获取数据*/
-(void)getData;
@end
