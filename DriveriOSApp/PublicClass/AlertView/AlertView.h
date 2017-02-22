//
//  AlertView.h
//  AlertViewDemo
//
//  Created by lixin on 16/10/20.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface AlertView : UIView

typedef enum {
    AlertViewTypeCenterAlertInfo,
    AlertViewTypePhoneAlert,
    AlertViewTypeCodeAlert,
    AlertViewTypeLoadAlert,
    AlertViewTypeIndentAlert,
    AlertViewTypeLoginAlert,
    AlertViewTypeDeleteIndentAlert,
    AlertViewTypeLimitLoginAlert,
    AlertViewTypeInstantIndentCommingAlert,
    AlertViewTypeIndentSucceedAlert,
    AlertViewTypeEmergencyRescueAlert,
    AlertViewTypeLoadingAlert
}AlertViewType;

@property (nonatomic, assign) AlertViewType addAlertViewType;

-(instancetype)initWithFrame:(CGRect)frame AndAddAlertViewType:(AlertViewType)alertViewType;

-(void)alertViewShow;

-(void)alertViewCloseWithBlock:(void (^) ())block;

/** 只显示文字 */
-(void)alertViewShowTitle:(NSString *)title
                textColor:(UIColor *)textColor;

@end
