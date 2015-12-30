//
//  AchievementsTableViewCell.h
//  HduSunnyRunAppIos
//
//  Created by tyw on 15/12/16.
//  Copyright © 2015年 tyw. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kAchievementsTableViewCellId @"kAchievementsTableViewCellId"

@interface AchievementsTableViewCell : UITableViewCell

/**
 *  初始化
 *
 *  @param style           风格
 *  @param reuseIdentifier 复用码
 *  @param width           表格的单位宽度
 *
 *  @return 实例
 */
- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier
                    uintWidth:(CGFloat)uintWidth;

@property (nonatomic, assign) NSInteger num;
@property (nonatomic, copy  ) NSDictionary *achievementsDataDic;

@end
