//
//  UIViewController+HUD.h
//  LiXinDriverTest
//
//  Created by lixin on 16/11/8.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (HUD)

- (void)showHudInView:(UIView *)view hint:(NSString *)hint;

- (void)hideHud;

- (void)showHint:(NSString *)hint;

// 从默认(showHint:)显示的位置再往上(下)yOffset
- (void)showHint:(NSString *)hint yOffset:(float)yOffset;
//显示或者隐藏下滑黑线 YES:显示 NO:隐藏
-(void)useMethodToFindBlackLineAndHindWithFlag:(BOOL)flag;
//改变状态了颜色 YES:黑色  NO:白色
-(void)changeStatusBarStyleWithFlag:(BOOL)flag;
@end
