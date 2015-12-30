//
//  HomeViewController.m
//  HduSunnyRunAppIos
//
//  Created by tyw on 15/12/8.
//  Copyright © 2015年 tyw. All rights reserved.
//

#import "HomeViewController.h"
#import "Tools.h"
#import "UIViewExt.h"
#import "common.h"
#import "UserInfoViewController.h"
#import "RunningInfoViewController.h"
#import "AccumulatedScoreViewController.h"
#import "SunnyRunDataService.h"

@interface HomeViewController () {
    NSString *bgImgName;
    CGFloat noticeViewHeight;
    CGFloat buttonOffY;
}

@property (nonatomic, strong) NSDictionary* stuInfoDic;
@property (nonatomic, strong) NSArray *achievementsArray;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [self loadHttpData];    //  加载网络数据
    
    [self initParams];      //  初始化参数
    [self addBgView];       //  背景
    [self addNoticeBoard];  //  公告栏
    [self addButtons];      //  三个button
    
}

- (void)initParams {
    if (IS_IPHONE_4()) {
        bgImgName = @"4_home_background";
        noticeViewHeight = 240;
        buttonOffY = kScreenHeight-40-(kScreenWidth/3.0-30);
    } else if (IS_IPHONE_5()) {
        bgImgName = @"5_home_background";
        noticeViewHeight = 300;
        buttonOffY = kScreenHeight-60-(kScreenWidth/3.0-30);
    } else if (IS_IPHONE_6_47()) {
        bgImgName = @"6_home_background";
        noticeViewHeight = 320;
        buttonOffY = kScreenHeight-80-(kScreenWidth/3.0-30);
    } else {
        bgImgName = @"6P_home_background";
        noticeViewHeight = 350;
        buttonOffY = kScreenHeight-100-(kScreenWidth/3.0-30);
    }
}

- (void)loadHttpData {
    // 个人信息、成绩信息
    [SunnyRunDataService sunnyRunRequestStuInfoWithStuNum:@"15141517" block:^(id result) {
        if ([result isKindOfClass:[NSDictionary class]]) {
            _stuInfoDic = [result copy];
        }
    }];
    
    
    // 长跑信息
    [SunnyRunDataService sunnyRunRequestAchievementsInfoWithStuNum:@"15141517" block:^(id result) {
        if ([result isKindOfClass:[NSArray class]]) {
            _achievementsArray = [result copy];
        }
    }];
}

#pragma mark - addSubviews
- (void)addBgView {
    UIImageView *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    UIImage *bgImg = [UIImage imageNamed:bgImgName];
    bgView.image = bgImg;
    [self.view addSubview:bgView];
}

- (void)addNoticeBoard {
    // “公告”字样
    UILabel *noticeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 30, 100, fontSize()+10)];
    noticeLabel.text = @"公告";
    noticeLabel.font = [UIFont systemFontOfSize:fontSize()];
    [self.view addSubview:noticeLabel];
    
    
    // 公告透明背景
    CGFloat noticeViewWidth  = kScreenWidth-40;
    UIView *noticeView = [[UIView alloc] initWithFrame:CGRectMake(20, noticeLabel.bottom+20, noticeViewWidth, noticeViewHeight)];
    noticeView.layer.cornerRadius = 15.0;
    noticeView.backgroundColor = kTransparentBackgroundColor;
    [self.view addSubview:noticeView];
    
    
    // 滑动视图，公告内容
    UIScrollView *noticeScrollView = [[UIScrollView alloc] initWithFrame:noticeView.frame];
    [self.view addSubview:noticeScrollView];
    
    
    // label，公告内容
    NSArray *contentArray = @[@"公告", @"阳光长跑须知", @"一、参加跑步的同学应身着运动装及运动鞋。", @"二、清晨跑步前应喝一杯温开水或牛奶，喝水不仅能补充水分，而且能促进血液循环和新陈代谢。", @"三、跑步时身上不要佩戴金属徽章、别针、小刀和其他尖利或硬质物品。跑步行进中避免说笑、嬉戏打闹，精神要集中，并注重交通安全。", @"四、跑步中如遇到肚子痛、头晕、恶心等身体不适，应减速慢跑或改为慢走，多做深呼吸调整。如一段时间内症状得不到缓解，应尽早就医。", @"五、长跑结束后，应积极做好放松活动，包括拉伸、拍打放松等。", @"六、遇雾霾天气请不要进行长跑。", @"七、分组中的1组为体测耐力成绩大于前80%，2组为体测耐力项目后5%-15%，3组为体测耐力项目后5%。"];
    CGFloat allHeight = 0.0;
    for (int i = 0; i < contentArray.count; i++) {
        CGFloat height = [Tools contentSizeWithMaxWidth:noticeViewWidth text:contentArray[i] fontOfSize:fontSize()].height;
        allHeight += height;
    }
    noticeScrollView.contentSize = CGSizeMake(noticeScrollView.size.width, allHeight);
    
    CGFloat offY = 0.0;
    for (int i = 0; i < contentArray.count; i++) {
        CGFloat height = [Tools contentSizeWithMaxWidth:noticeViewWidth text:contentArray[i] fontOfSize:fontSize()].height;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, offY, noticeViewWidth, height)];
        label.font = [UIFont systemFontOfSize:fontSize()];
        label.numberOfLines = 0;
        label.text = contentArray[i];
        [noticeScrollView addSubview:label];
        offY += height;
    }
    
}

- (void)addButtons {
    NSArray *buttonNameArray = @[@"button_person_info", @"button_running_info", @"button_scores_info"];
    CGFloat width = kScreenWidth/3.0-30;
    CGFloat offX = 30.0;
    for (int i = 0; i < buttonNameArray.count; i++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(offX, buttonOffY, width, width)];
        button.tag = i+100;
        [button setBackgroundImage:[UIImage imageNamed:buttonNameArray[i]] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        offX += (width+15);
    }
}

- (void)buttonAction:(UIButton *)button {
    if (button.tag == 100) {
        UserInfoViewController *userInfoVc = [[UserInfoViewController alloc] init];
        userInfoVc.stuInfoDic = [_stuInfoDic copy];
        [self presentViewController:userInfoVc animated:NO completion:nil];
        
    } else if (button.tag == 101) {
        RunningInfoViewController *runningInfoVc = [[RunningInfoViewController alloc] init];
        runningInfoVc.achievementsArray = [_achievementsArray copy];
        [self presentViewController:runningInfoVc animated:NO completion:nil];
        
    } else if (button.tag == 102) {
        AccumulatedScoreViewController *accumulatedScoreVc = [[AccumulatedScoreViewController alloc] init];
        accumulatedScoreVc.stuInfoDic = [_stuInfoDic copy];
        [self presentViewController:accumulatedScoreVc animated:NO completion:nil];
    }
}


@end
