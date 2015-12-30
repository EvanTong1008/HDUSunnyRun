//
//  LoginViewController.m
//  HduSunnyRunAppIos
//
//  Created by tyw on 15/12/8.
//  Copyright © 2015年 tyw. All rights reserved.
//

#import "LoginViewController.h"
#import "common.h"
#import "Tools.h"
#import "UIViewExt.h"
#import "HomeViewController.h"
#import "UIViewController+Progress.h"
#import "SunnyRunDataService.h"

@interface LoginViewController () {
    UIButton *keyboardDownButton;
    CGFloat keyBoardHeight;
    UIImage *keyboardDownImg;
    UITextField *numberField;
    UITextField *passwordField;
    
    NSString *bgImgName;
    CGFloat transparentBackViewOffY;
}

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //监听键盘事件
    //键盘将要显示
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShowAction:) name:UIKeyboardWillShowNotification object:nil];
    //键盘将要隐藏
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHideAction:) name:UIKeyboardWillHideNotification object:nil];
    
    [self initParams];
    [self addBgView];
    [self addLoginView];
    [self addKeyboardDownButton];
}

- (void)initParams {
    if (IS_IPHONE_4()) {
        bgImgName = @"4_login_background";
        transparentBackViewOffY = 100.0;
    } else if (IS_IPHONE_5()) {
        bgImgName = @"5_login_background";
        transparentBackViewOffY = 120.0;
    } else if (IS_IPHONE_6_47()) {
        bgImgName = @"6_login_background";
        transparentBackViewOffY = 140.0;
    } else {
        bgImgName = @"6P_login_background";
        transparentBackViewOffY = 180.0;
    }
}

#pragma mark - addSubviews
- (void)addBgView {
    UIImageView *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    UIImage *bgImg = [UIImage imageNamed:bgImgName];
    bgView.image = bgImg;
    [self.view addSubview:bgView];
}

- (void)addLoginView {
    // 登陆界面模糊方块背景
    CGFloat loginViewWidth  = kScreenWidth-40;
    UIView *loginView = [[UIView alloc] initWithFrame:CGRectMake(20, transparentBackViewOffY, loginViewWidth, loginViewWidth)];
    loginView.layer.cornerRadius = 15.0;
    loginView.backgroundColor = kTransparentBackgroundColor;
    [self.view addSubview:loginView];
    
    
    // 学号
    UILabel *numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(loginView.left, loginView.top+loginViewWidth/3.0-fontSize()-10, loginViewWidth*0.4, fontSize()+10)];
    numberLabel.text = @"学 号";
    numberLabel.numberOfLines = 1;
    numberLabel.textAlignment = NSTextAlignmentCenter;
    numberLabel.font = [UIFont systemFontOfSize:fontSize()];
    [self.view addSubview:numberLabel];
    
    numberField = [[UITextField alloc] initWithFrame:CGRectMake(numberLabel.right, numberLabel.top, loginView.size.width - numberLabel.size.width, numberLabel.size.height)];
    numberField.placeholder = @"请输入学号";
    numberField.borderStyle = UITextBorderStyleNone;
    numberField.keyboardType = UIKeyboardTypeNumberPad;
    numberField.font = [UIFont systemFontOfSize:fontSize()];
    [self.view addSubview:numberField];
    
    UIView *numberLine = [[UIView alloc] initWithFrame:CGRectMake(numberField.left+1, numberField.bottom, numberField.width-2, 1)];
    numberLine.backgroundColor = [UIColor grayColor];
    [self.view addSubview:numberLine];
    
    
    // 密码
    UILabel *passwordLabel = [[UILabel alloc] initWithFrame:CGRectMake(numberLabel.left, numberLabel.bottom+loginViewWidth/5.0, numberLabel.size.width, numberLabel.size.height)];
    passwordLabel.text = @"密 码";
    passwordLabel.numberOfLines = 1;
    passwordLabel.textAlignment = NSTextAlignmentCenter;
    passwordLabel.font = [UIFont systemFontOfSize:fontSize()];
    [self.view addSubview:passwordLabel];
    
    passwordField = [[UITextField alloc] initWithFrame:CGRectMake(passwordLabel.right, passwordLabel.top, numberField.size.width, numberField.size.height)];
    passwordField.placeholder = @"请输入密码";
    passwordField.borderStyle = UITextBorderStyleNone;
    passwordField.secureTextEntry = YES;
    passwordField.font = [UIFont systemFontOfSize:fontSize()];
    [self.view addSubview:passwordField];
    
    UIView *passwordLine = [[UIView alloc] initWithFrame:CGRectMake(passwordField.left+1, passwordField.bottom, passwordField.width-2, 1)];
    passwordLine.backgroundColor = [UIColor grayColor];
    [self.view addSubview:passwordLine];
    
    // 登陆
    UIImage *loginImg = [UIImage imageNamed:@"button_login"];
    CGFloat loginImgWidth  = loginImg.size.width;
    CGFloat loginImgHeight = loginImg.size.height;
    CGFloat passwordIsSaveLabelHeight = loginImgHeight/loginImgWidth*(loginViewWidth*0.6-40);
    UIButton *loginButton = [[UIButton alloc] initWithFrame:CGRectMake(passwordField.left+20, passwordLabel.bottom+40, loginViewWidth*0.6-40, passwordIsSaveLabelHeight)];
    CGFloat y = loginButton.center.y;
    [loginButton setCenter:CGPointMake(kScreenWidth/2.0, y)];
    [loginButton setBackgroundImage:loginImg forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(loginBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
    
    
    // 记住密码
    //    UILabel *passwordIsSaveLabel = [[UILabel alloc] initWithFrame:CGRectMake(passwordLabel.left+40, passwordLabel.bottom+40, loginViewWidth*0.4-20, passwordIsSaveLabelHeight)];
    //    passwordIsSaveLabel.text = @"记住密码";
    //    passwordIsSaveLabel.numberOfLines = 1;
    //    passwordIsSaveLabel.textAlignment = NSTextAlignmentCenter;
    //    passwordIsSaveLabel.font = [UIFont systemFontOfSize:fontSize()];
    //    [self.view addSubview:passwordIsSaveLabel];
}

- (void)loginBtnAction:(UIButton *)button {
    [self showHUD:@"正在验证"];
    
    [SunnyRunDataService sunnyRunRequestPasswordTestWithStuNum:numberField.text password:passwordField.text block:^(id result) {
        sleep(1);
        if ([result isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dic = result;
            NSString *state = dic[@"state"];
            if ([state isEqualToString:@"true"]) {
                [self completeHUD:@"验证成功"];
                [self performSelector:@selector(presentToHomeVC) withObject:nil afterDelay:1.2];
            } else {
                [self failHUD:@"学号或密码错误"];
            }
        } else {
            [self failHUD:@"学号或密码错误"];
        }
    }];
}

- (void)presentToHomeVC {
    HomeViewController *homeVc = [[HomeViewController alloc] init];
    [self presentViewController:homeVc animated:NO completion:nil];
}

#pragma mark - keyboardButton
- (void)addKeyboardDownButton {
    keyboardDownImg = [UIImage imageNamed:@"button_keyboard_down"];
    keyboardDownButton = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - keyboardDownImg.size.width*0.6, kScreenHeight, keyboardDownImg.size.width*0.6, keyboardDownImg.size.height*0.6)];
    [keyboardDownButton setBackgroundImage:keyboardDownImg forState:UIControlStateNormal];
    [keyboardDownButton addTarget:self action:@selector(keyboardDownButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:keyboardDownButton];
}

- (void)keyboardDownButtonAction:(id)sender {
    [numberField resignFirstResponder];
    [passwordField resignFirstResponder];
}

#pragma mark - keyboardDelegate
/**  键盘userInfo的信息
 UIKeyboardAnimationCurveUserInfoKey = 7;
 UIKeyboardAnimationDurationUserInfoKey = "0.4";
 UIKeyboardBoundsUserInfoKey = "NSRect: {{0, 0}, {375, 216}}";
 UIKeyboardCenterBeginUserInfoKey = "NSPoint: {187.5, 775}";
 UIKeyboardCenterEndUserInfoKey = "NSPoint: {187.5, 559}";
 UIKeyboardFrameBeginUserInfoKey = "NSRect: {{0, 667}, {375, 216}}";
 UIKeyboardFrameEndUserInfoKey = "NSRect: {{0, 451}, {375, 216}}";
 */
//键盘将要显示时调用
- (void)keyBoardWillShowAction:(NSNotification*)notification {
    //计算键盘高度
    NSDictionary* info = [notification userInfo];
    CGFloat animationDuration = [info[@"UIKeyboardAnimationDurationUserInfoKey"] floatValue];   //弹出动画时长
    CGRect frame = [info[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];               //弹出结束时的frame
    keyBoardHeight = frame.size.height;
    
    [UIView animateWithDuration:animationDuration animations:^{
        keyboardDownButton.transform = CGAffineTransformMakeTranslation(0, -keyBoardHeight-36);
    }];
}
//键盘将要隐藏时调用
- (void)keyBoardWillHideAction:(NSNotification*)notification {
    NSDictionary* info = [notification userInfo];
    CGFloat animationDuration = [info[@"UIKeyboardAnimationDurationUserInfoKey"] floatValue];   //弹出动画时长
    
    [UIView animateWithDuration:animationDuration animations:^{
        keyboardDownButton.transform = CGAffineTransformMakeTranslation(0, keyBoardHeight+36);
    }];
}


@end
