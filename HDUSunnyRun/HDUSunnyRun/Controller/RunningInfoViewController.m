//
//  RunningInfoViewController.m
//  HduSunnyRunAppIos
//
//  Created by tyw on 15/12/8.
//  Copyright © 2015年 tyw. All rights reserved.
//

#import "RunningInfoViewController.h"
#import "common.h"
#import "Tools.h"
#import "UIViewExt.h"
#import "AchievementsTableView.h"

@interface RunningInfoViewController () {
    NSString *bgImgName;
    CGFloat transparentBackViewOffY;    // 透明背景的竖向偏移
    CGFloat transparentBackViewHeight;  // 透明背景的高度
}

@end


@implementation RunningInfoViewController


- (void)viewDidLoad {
    [self initParams];
    [self addBgView];
    [self addBackBtn];
    [self addRunningInfo];
}

- (void)initParams {
    if (IS_IPHONE_4()) {
        bgImgName = @"4_home_background";
        transparentBackViewOffY = 40;
        transparentBackViewHeight = 240;
    } else if (IS_IPHONE_5()) {
        bgImgName = @"5_home_background";
        transparentBackViewOffY = 60;
        transparentBackViewHeight = 280;
    } else if (IS_IPHONE_6_47()) {
        bgImgName = @"6_home_background";
        transparentBackViewOffY = 80;
        transparentBackViewHeight = 320;
    } else {
        bgImgName = @"6P_home_background";
        transparentBackViewOffY = 100;
        transparentBackViewHeight = 360;
    }
}

- (void)addBgView {
    UIImageView *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    UIImage *bgImg = [UIImage imageNamed:bgImgName];
    bgView.image = bgImg;
    [self.view addSubview:bgView];
}

// 返回按钮
- (void)addBackBtn {
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 25, fontSize()*2+5, 20)];
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [backBtn.titleLabel setFont:[UIFont systemFontOfSize:fontSize()]];
    [backBtn addTarget:self action:@selector(backBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
}

- (void)backBtnAction:(UIButton *)button {
    [self dismissViewControllerAnimated:NO completion:nil];
}

// 长跑信息
- (void)addRunningInfo {
    // 长跑信息字样
    UILabel *userInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 80, fontSize()*4+30, 20)];
    userInfoLabel.text = @"长跑信息";
    userInfoLabel.textAlignment = NSTextAlignmentLeft;
    userInfoLabel.font = [UIFont systemFontOfSize:fontSize()];
    [self.view addSubview:userInfoLabel];
    
    
    // 透明背景
    CGFloat transparentBackViewWidth = kScreenWidth-40;
    UIView *transparentBackView = [[UIView alloc] initWithFrame:CGRectMake(20, userInfoLabel.bottom+transparentBackViewOffY, transparentBackViewWidth, transparentBackViewHeight)];
    transparentBackView.backgroundColor = kTransparentBackgroundColor;
    transparentBackView.layer.cornerRadius = 15.0;
    [self.view addSubview:transparentBackView];
    
    
    // 长跑信息
    if (!_achievementsArray || !_achievementsArray.count) return;
    AchievementsTableView *achievementsTableView = [[AchievementsTableView alloc] initWithFrame:CGRectMake(transparentBackView.left, transparentBackView.top, transparentBackView.size.width, transparentBackViewHeight)];
    achievementsTableView.achievementsDataArray = _achievementsArray;
    [self.view addSubview:achievementsTableView];
}


@end
