//
//  LXQRobIndentAlertViewController.h
//  DriveriOSApp
//
//  Created by mac on 17/3/2.
//  Copyright © 2017年 陆遗坤. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LXQRobIndentAlertViewController : UIViewController

@property (nonatomic, strong) IndentData *model;

@property (nonatomic, copy) void(^robIndentBtnClick)(void);

@property (nonatomic, copy) void(^robIndentTimerEnd)(void);

@property(nonatomic, weak)NSTimer* robIndentTimer;

@property(nonatomic, assign)NSTimeInterval count;

@end
