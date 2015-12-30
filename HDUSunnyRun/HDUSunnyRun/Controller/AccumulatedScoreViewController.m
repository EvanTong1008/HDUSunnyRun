//
//  AccumulatedScoreViewController.m
//  HduSunnyRunAppIos
//
//  Created by tyw on 15/12/8.
//  Copyright © 2015年 tyw. All rights reserved.
//

#import "AccumulatedScoreViewController.h"
#import "common.h"
#import "Tools.h"
#import "UIViewExt.h"

@interface AccumulatedScoreViewController () {
    NSString *bgImgName;                // 背景图片名
    CGFloat transparentBackViewOffY;    // 透明背景的竖向偏移
    CGFloat transparentBackViewHeight;  // 透明背景的高度
    
    UILabel *stuNameLabel;              // 学生姓名
    UILabel *runningMetersLabel;        // 长跑里程
    UILabel *averSpeedLabel;            // 平均速度
    UILabel *effectiveTimesLabel;       // 有效次数
}

@end


@implementation AccumulatedScoreViewController


- (void)viewDidLoad {
    [self initParams];
    [self addBgView];
    [self addBackBtn];
    [self addScoreInfo];
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

// 成绩信息
- (void)addScoreInfo {
    // 成绩信息字样
    UILabel *userInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 80, fontSize()*4+30, 20)];
    userInfoLabel.text = @"成绩信息";
    userInfoLabel.textAlignment = NSTextAlignmentLeft;
    userInfoLabel.font = [UIFont systemFontOfSize:fontSize()];
    [self.view addSubview:userInfoLabel];
    
    
    // 透明背景
    CGFloat transparentBackViewWidth = kScreenWidth-40;
    UIView *transparentBackView = [[UIView alloc] initWithFrame:CGRectMake(20, userInfoLabel.bottom+transparentBackViewOffY, transparentBackViewWidth, transparentBackViewHeight)];
    transparentBackView.backgroundColor = kTransparentBackgroundColor;
    transparentBackView.layer.cornerRadius = 15.0;
    [self.view addSubview:transparentBackView];
    
    
    
    // 学生姓名
    UILabel *stuName = [[UILabel alloc] initWithFrame:CGRectMake(transparentBackView.left, transparentBackView.top+transparentBackViewHeight*2.0/11.0, fontSize()*4+30, transparentBackViewHeight/11.0)];
    stuName.text = @"学生姓名";
    stuName.textAlignment = NSTextAlignmentCenter;
    stuName.font = [UIFont systemFontOfSize:fontSize()];
    [self.view addSubview:stuName];
    
    stuNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(stuName.right+20, stuName.top, transparentBackViewWidth-fontSize()*4-30-40, stuName.size.height)];
    stuNameLabel.text = _stuInfoDic[@"name"];
    stuNameLabel.textAlignment = NSTextAlignmentLeft;
    stuNameLabel.font = [UIFont systemFontOfSize:fontSize()];
    [self.view addSubview:stuNameLabel];
    
    UIView *stuNameLine = [[UIView alloc] initWithFrame:CGRectMake(stuNameLabel.left-3, stuNameLabel.bottom, stuNameLabel.width+6, 1)];
    stuNameLine.backgroundColor = [UIColor grayColor];
    [self.view addSubview:stuNameLine];
    
    
    // 长跑里程
    UILabel *runningMeters = [[UILabel alloc] initWithFrame:CGRectMake(stuName.left, stuName.bottom+transparentBackViewHeight/11.0, stuName.size.width, stuName.size.height)];
    runningMeters.text = @"长跑里程";
    runningMeters.textAlignment = NSTextAlignmentCenter;
    runningMeters.font = [UIFont systemFontOfSize:fontSize()];
    [self.view addSubview:runningMeters];
    
    runningMetersLabel = [[UILabel alloc] initWithFrame:CGRectMake(runningMeters.right+20, runningMeters.top, stuNameLabel.size.width, stuNameLabel.size.height)];
    NSNumber *mileAges = _stuInfoDic[@"mileages"];
    runningMetersLabel.text = [NSString stringWithFormat:@"%li米", [mileAges integerValue]];
    runningMetersLabel.textAlignment = NSTextAlignmentLeft;
    runningMetersLabel.font = [UIFont systemFontOfSize:fontSize()];
    [self.view addSubview:runningMetersLabel];
    
    UIView *runningMetersLine = [[UIView alloc] initWithFrame:CGRectMake(runningMetersLabel.left-3, runningMetersLabel.bottom, stuNameLine.size.width, 1)];
    runningMetersLine.backgroundColor = [UIColor grayColor];
    [self.view addSubview:runningMetersLine];
    
    
    // 平均速度
    UILabel *averSpeed = [[UILabel alloc] initWithFrame:CGRectMake(runningMeters.left, runningMeters.bottom+transparentBackViewHeight/11.0, runningMeters.size.width, runningMeters.size.height)];
    averSpeed.text = @"平均速度";
    averSpeed.textAlignment = NSTextAlignmentCenter;
    averSpeed.font = [UIFont systemFontOfSize:fontSize()];
    [self.view addSubview:averSpeed];
    
    averSpeedLabel = [[UILabel alloc] initWithFrame:CGRectMake(averSpeed.right+20, averSpeed.top, averSpeed.size.width, averSpeed.size.height)];
    averSpeedLabel.text = [NSString stringWithFormat:@"%@米/秒", _stuInfoDic[@"speed"]];
    averSpeedLabel.textAlignment = NSTextAlignmentLeft;
    averSpeedLabel.font = [UIFont systemFontOfSize:fontSize()];
    [self.view addSubview:averSpeedLabel];
    
    UIView *averSpeedLine = [[UIView alloc] initWithFrame:CGRectMake(averSpeedLabel.left-3, averSpeedLabel.bottom, stuNameLine.size.width, 1)];
    averSpeedLine.backgroundColor = [UIColor grayColor];
    [self.view addSubview:averSpeedLine];
    
    
    // 有效次数
    UILabel *effectiveTimes = [[UILabel alloc] initWithFrame:CGRectMake(averSpeed.left, averSpeed.bottom+transparentBackViewHeight/11.0, averSpeed.size.width, averSpeed.size.height)];
    effectiveTimes.text = @"有效次数";
    effectiveTimes.textAlignment = NSTextAlignmentCenter;
    effectiveTimes.font = [UIFont systemFontOfSize:fontSize()];
    [self.view addSubview:effectiveTimes];
    
    effectiveTimesLabel = [[UILabel alloc] initWithFrame:CGRectMake(effectiveTimes.right+20, effectiveTimes.top, averSpeedLabel.size.width, averSpeedLabel.size.height)];
    NSNumber *validTimes = _stuInfoDic[@"validTimes"];
    effectiveTimesLabel.text = [NSString stringWithFormat:@"%li次",  [validTimes integerValue]];
    effectiveTimesLabel.textAlignment = NSTextAlignmentLeft;
    effectiveTimesLabel.font = [UIFont systemFontOfSize:fontSize()];
    [self.view addSubview:effectiveTimesLabel];
    
    UIView *effectiveTimesLine = [[UIView alloc] initWithFrame:CGRectMake(effectiveTimesLabel.left-3, effectiveTimesLabel.bottom, stuNameLine.size.width, 1)];
    effectiveTimesLine.backgroundColor = [UIColor grayColor];
    [self.view addSubview:effectiveTimesLine];
}


@end
