//
//  LXQConfirmPhoneNumViewController.h
//  DriveriOSApp
//
//  Created by mac on 17/3/14.
//  Copyright © 2017年 陆遗坤. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LXQConfirmPhoneNumViewController : UIViewController

@property(nonatomic, copy)void(^cancelBtnClick)(void);

@property(nonatomic, copy)void(^confirmBtnClick)(void);

@end
