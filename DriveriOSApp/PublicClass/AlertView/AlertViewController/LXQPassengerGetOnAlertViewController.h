//
//  LXQPassengerGetOnAlertViewController.h
//  DriveriOSApp
//
//  Created by mac on 17/2/24.
//  Copyright © 2017年 陆遗坤. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LXQPassengerGetOnAlertViewController : UIViewController

@property(nonatomic, copy)void(^okBtnClick)(void);

@property(nonatomic, copy)void(^cancelBtnClick)(void);

@end
