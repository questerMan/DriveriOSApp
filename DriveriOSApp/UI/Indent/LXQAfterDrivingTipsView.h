//
//  LXQAfterDrivingTipsView.h
//  DriveriOSApp
//
//  Created by mac on 17/2/5.
//  Copyright © 2017年 陆遗坤. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LXQAfterDrivingTipsView : UIView

@property(nonatomic, copy)void(^showTipsView)(void);

@property(nonatomic, copy)void(^hideTipsView)(void);

@end
