//
//  AchievementsTableView.m
//  HduSunnyRunAppIos
//
//  Created by tyw on 15/12/16.
//  Copyright © 2015年 tyw. All rights reserved.
//

#import "AchievementsTableView.h"
#import "AchievementsTableViewCell.h"
#import "common.h"
#import "UIViewExt.h"

@interface AchievementsTableView ()

@end

@implementation AchievementsTableView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.delegate = self;
        self.dataSource = self;
        
        [self resetTableHeaderView];
        self.allowsSelection = NO;
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

- (void)setAchievementsDataArray:(NSArray *)achievementsDataArray {
    if (!achievementsDataArray || !achievementsDataArray.count) return;
    _achievementsDataArray = [achievementsDataArray copy];
    [self reloadData];
}

- (void)resetTableHeaderView {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, fontSize())];
    
    CGFloat width  = self.frame.size.width/12.0;
    CGFloat height = fontSize();
    
    // No.
    UILabel *noLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    noLabel.text = @"No.";
    noLabel.layer.borderColor = [UIColor blackColor].CGColor;
    noLabel.layer.borderWidth = 0.5;
    noLabel.textAlignment = NSTextAlignmentCenter;
    noLabel.font = [UIFont systemFontOfSize:fontSize()-4];
    [headerView addSubview:noLabel];
    
    // 时间
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(noLabel.right, 0, width*5, height)];
    timeLabel.text = @"时间";
    timeLabel.layer.borderColor = [UIColor blackColor].CGColor;
    timeLabel.layer.borderWidth = 0.5;
    timeLabel.textAlignment = NSTextAlignmentCenter;
    timeLabel.font = [UIFont systemFontOfSize:fontSize()-4];
    [headerView addSubview:timeLabel];
    
    // 里程
    UILabel *distanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(timeLabel.right, 0, width*2, height)];
    distanceLabel.text = @"里程";
    distanceLabel.layer.borderColor = [UIColor blackColor].CGColor;
    distanceLabel.layer.borderWidth = 0.5;
    distanceLabel.textAlignment = NSTextAlignmentCenter;
    distanceLabel.font = [UIFont systemFontOfSize:fontSize()-4];
    [headerView addSubview:distanceLabel];
    
    
    // 速度
    UILabel *speedLabel = [[UILabel alloc] initWithFrame:CGRectMake(distanceLabel.right, 0, width*2, height)];
    speedLabel.text = @"速度";
    speedLabel.layer.borderColor = [UIColor blackColor].CGColor;
    speedLabel.layer.borderWidth = 0.5;
    speedLabel.textAlignment = NSTextAlignmentCenter;
    speedLabel.font = [UIFont systemFontOfSize:fontSize()-4];
    [headerView addSubview:speedLabel];
    
    
    // 有效
    UILabel *validLabel = [[UILabel alloc] initWithFrame:CGRectMake(speedLabel.right, 0, width*2, height)];
    validLabel.text = @"有效";
    validLabel.layer.borderColor = [UIColor blackColor].CGColor;
    validLabel.layer.borderWidth = 0.5;
    validLabel.textAlignment = NSTextAlignmentCenter;
    validLabel.font = [UIFont systemFontOfSize:fontSize()-4];
    [headerView addSubview:validLabel];
    
    
    self.tableHeaderView = headerView;
}


#pragma mark - tableView Delegate DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _achievementsDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AchievementsTableViewCell *cell = [[AchievementsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil uintWidth:self.frame.size.width/12.0];
    
    cell.num = indexPath.section;
    cell.achievementsDataDic = _achievementsDataArray[indexPath.section];
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 1)];
    line.backgroundColor = [UIColor blackColor];
    return line;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return fontSize();
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.5;
}



@end
