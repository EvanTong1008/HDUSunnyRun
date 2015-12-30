//
//  UIViewController+Progress.m
//  HduSunnyRunAppIos
//
//  Created by tyw on 15/12/17.
//  Copyright © 2015年 tyw. All rights reserved.
//

#import "UIViewController+Progress.h"

@interface UIViewController ()

@end

@implementation UIViewController (Progress)

#pragma mark - show
//显示菊花
- (void)showHUD:(NSString*)title {
    MBProgressHUD *hud = (MBProgressHUD *)[self.view viewWithTag:10086];
    if (!hud) {
        hud = [[MBProgressHUD alloc] initWithView:self.view];
        hud.tag = 10086;
        [self.view addSubview:hud];
    }
    
    [hud hide:NO];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = title;
    [hud showWhileExecuting:@selector(show) onTarget:self withObject:nil animated:YES];
    
    //灰色的背景盖住其他视图
    //    hud.dimBackground = YES;
}

- (void)show {
    sleep(30);
}


#pragma mark - complete
//已完成
- (void)completeHUD:(NSString *)title {
    MBProgressHUD *hud = (MBProgressHUD *)[self.view viewWithTag:10086];
    
    //    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark"]];
    
    //    hud.mode = MBProgressHUDModeCustomView;
    hud.mode = MBProgressHUDModeText;
    hud.labelText = title;
    
    [hud hide:YES afterDelay:1];
}

#pragma mark - fail
//失败
- (void)failHUD:(NSString *)title {
    MBProgressHUD *hud = (MBProgressHUD *)[self.view viewWithTag:10086];
    
    hud.mode = MBProgressHUDModeText;
    hud.labelText = title;
    
    [hud hide:YES afterDelay:1];
}



@end
