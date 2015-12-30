//
//  AchievementsTableViewCell.m
//  HduSunnyRunAppIos
//
//  Created by tyw on 15/12/16.
//  Copyright © 2015年 tyw. All rights reserved.
//

#import "AchievementsTableViewCell.h"
#import "UIViewExt.h"
#import "common.h"

@interface AchievementsTableViewCell ()

@property (nonatomic, strong) UILabel *noLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *distanceLabel;
@property (nonatomic, strong) UILabel *speedLabel;
@property (nonatomic, strong) UILabel *validLabel;


@end

@implementation AchievementsTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier
                    uintWidth:(CGFloat)uintWidth {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        
        CGFloat height = fontSize();
        
        // No.
        _noLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, uintWidth, height)];
        _noLabel.layer.borderColor = [UIColor blackColor].CGColor;
        _noLabel.layer.borderWidth = 0.5;
        _noLabel.textAlignment = NSTextAlignmentCenter;
        _noLabel.font = [UIFont systemFontOfSize:fontSize()-4];
        [self.contentView addSubview:_noLabel];
        
        // 时间
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(_noLabel.right, 0, uintWidth*5, height)];
        _timeLabel.layer.borderColor = [UIColor blackColor].CGColor;
        _timeLabel.layer.borderWidth = 0.5;
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        _timeLabel.font = [UIFont systemFontOfSize:fontSize()-4];
        [self.contentView addSubview:_timeLabel];
        
        // 里程
        _distanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(_timeLabel.right, 0, uintWidth*2, height)];
        _distanceLabel.layer.borderColor = [UIColor blackColor].CGColor;
        _distanceLabel.layer.borderWidth = 0.5;
        _distanceLabel.textAlignment = NSTextAlignmentCenter;
        _distanceLabel.font = [UIFont systemFontOfSize:fontSize()-4];
        [self.contentView addSubview:_distanceLabel];
        
        
        // 速度
        _speedLabel = [[UILabel alloc] initWithFrame:CGRectMake(_distanceLabel.right, 0, uintWidth*2, height)];
        _speedLabel.layer.borderColor = [UIColor blackColor].CGColor;
        _speedLabel.layer.borderWidth = 0.5;
        _speedLabel.textAlignment = NSTextAlignmentCenter;
        _speedLabel.font = [UIFont systemFontOfSize:fontSize()-4];
        [self.contentView addSubview:_speedLabel];
        
        
        // 有效
        _validLabel = [[UILabel alloc] initWithFrame:CGRectMake(_speedLabel.right, 0, uintWidth*2, height)];
        _validLabel.layer.borderColor = [UIColor blackColor].CGColor;
        _validLabel.layer.borderWidth = 0.5;
        _validLabel.textAlignment = NSTextAlignmentCenter;
        _validLabel.font = [UIFont systemFontOfSize:fontSize()-4];
        [self.contentView addSubview:_validLabel];
        
    }
    
    return self;
}

- (void)setAchievementsDataDic:(NSDictionary *)achievementsDataDic {
    _achievementsDataDic = [achievementsDataDic copy];
    
    [self setNeedsLayout];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // No.
    _noLabel.text = [NSString stringWithFormat:@"%li", _num+1];
    
    // 时间
    _timeLabel.text = _achievementsDataDic[@"date"];
    
    // 里程
    _distanceLabel.text = _achievementsDataDic[@"mileage"];
    
    // 速度
    _speedLabel.text = _achievementsDataDic[@"speed"];
    
    // 有效
    NSString *validStr = _achievementsDataDic[@"isValid"];
    _validLabel.text = [validStr isEqualToString:@"true"] ? @"有效" : @"无效";
}

@end
