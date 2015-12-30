//
//  UIViewController+Progress.h
//  HduSunnyRunAppIos
//
//  Created by tyw on 15/12/17.
//  Copyright © 2015年 tyw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface UIViewController (Progress)

//显示菊花
- (void)showHUD:(NSString*)title;
//- (void)hideHUD;    //隐藏菊花
//加载结束时
- (void)completeHUD:(NSString*)title;
//加载失败时
- (void)failHUD:(NSString*)title;


@end
