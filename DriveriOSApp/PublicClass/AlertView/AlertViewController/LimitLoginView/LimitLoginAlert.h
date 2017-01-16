//
//  LimitLoginView.h
//  DriveriOSApp
//
//  Created by lixin on 17/1/9.
//  Copyright © 2017年 陆遗坤. All rights reserved.
//

#import "ViewController.h"

@protocol LimitLoginAlertDelegate <NSObject>

@optional
/** 关闭alertView */
-(void)closeAlertView;
@end

@interface LimitLoginAlert : UIViewController

@property (nonatomic, weak) id <LimitLoginAlertDelegate> delegate;

@end
