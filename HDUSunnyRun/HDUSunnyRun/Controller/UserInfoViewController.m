//
//  UserInfoViewController.m
//  HduSunnyRunAppIos
//
//  Created by tyw on 15/12/8.
//  Copyright © 2015年 tyw. All rights reserved.
//

#import "UserInfoViewController.h"
#import "common.h"
#import "Tools.h"
#import "UIViewExt.h"


@interface UserInfoViewController () {
    NSString *bgImgName;
    CGFloat transparentBackViewOffY;
    UILabel *stuNameLabel;
    UILabel *stuNumLabel;
}

@end

@implementation UserInfoViewController


- (void)viewDidLoad {
    [self initParams];
    [self addBgView];
    [self addBackBtn];
    [self addUserInfo];
}

- (void)initParams {
    if (IS_IPHONE_4()) {
        bgImgName = @"4_home_background";
        transparentBackViewOffY = 40;
    } else if (IS_IPHONE_5()) {
        bgImgName = @"5_home_background";
        transparentBackViewOffY = 60;
    } else if (IS_IPHONE_6_47()) {
        bgImgName = @"6_home_background";
        transparentBackViewOffY = 80;
    } else {
        bgImgName = @"6P_home_background";
        transparentBackViewOffY = 100;
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

// 个人信息
- (void)addUserInfo {
    // 个人信息字样
    UILabel *userInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 80, fontSize()*4+30, 20)];
    userInfoLabel.text = @"个人信息";
    userInfoLabel.textAlignment = NSTextAlignmentLeft;
    userInfoLabel.font = [UIFont systemFontOfSize:fontSize()];
    [self.view addSubview:userInfoLabel];
    
    
    // 透明背景
    CGFloat transparentBackViewHeight = kScreenWidth-40;
    UIView *transparentBackView = [[UIView alloc] initWithFrame:CGRectMake(20, userInfoLabel.bottom+transparentBackViewOffY, transparentBackViewHeight, transparentBackViewHeight)];
    transparentBackView.backgroundColor = kTransparentBackgroundColor;
    transparentBackView.layer.cornerRadius = 15.0;
    [self.view addSubview:transparentBackView];
    
    
    
    // 学生姓名
    UILabel *stuName = [[UILabel alloc] initWithFrame:CGRectMake(transparentBackView.left, transparentBackView.top+transparentBackViewHeight/3.0, fontSize()*4+30, fontSize()+5)];
    stuName.text = @"学生姓名";
    stuName.textAlignment = NSTextAlignmentCenter;
    stuName.font = [UIFont systemFontOfSize:fontSize()];
    [self.view addSubview:stuName];
    
    stuNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(stuName.right+20, stuName.top, transparentBackViewHeight-fontSize()*4-30-40, stuName.size.height)];
    stuNameLabel.text = _stuInfoDic[@"name"];
    stuNameLabel.textAlignment = NSTextAlignmentLeft;
    stuNameLabel.font = [UIFont systemFontOfSize:fontSize()];
    [self.view addSubview:stuNameLabel];
    
    UIView *stuNameLine = [[UIView alloc] initWithFrame:CGRectMake(stuNameLabel.left-3, stuNameLabel.bottom, stuNameLabel.width+6, 1)];
    stuNameLine.backgroundColor = [UIColor grayColor];
    [self.view addSubview:stuNameLine];
    
    
    // 学生学号
    UILabel *stuNum = [[UILabel alloc] initWithFrame:CGRectMake(transparentBackView.left, transparentBackView.bottom-transparentBackViewHeight/3.0-stuName.size.height, stuName.size.width, stuName.size.height)];
    stuNum.text = @"学生学号";
    stuNum.textAlignment = NSTextAlignmentCenter;
    stuNum.font = [UIFont systemFontOfSize:fontSize()];
    [self.view addSubview:stuNum];
    
    stuNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(stuNum.right+20, stuNum.top, stuNameLabel.size.width, stuNum.size.height)];
    NSNumber *code = _stuInfoDic[@"code"];
    stuNumLabel.text = [NSString stringWithFormat:@"%li", [code integerValue]];
    stuNumLabel.textAlignment = NSTextAlignmentLeft;
    stuNumLabel.font = [UIFont systemFontOfSize:fontSize()];
    [self.view addSubview:stuNumLabel];
    
    UIView *stuNumLine = [[UIView alloc] initWithFrame:CGRectMake(stuNumLabel.left-3, stuNumLabel.bottom, stuNumLabel.width+6, 1)];
    stuNumLine.backgroundColor = [UIColor grayColor];
    [self.view addSubview:stuNumLine];
}


@end
