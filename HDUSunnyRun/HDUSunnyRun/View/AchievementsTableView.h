//
//  AchievementsTableView.h
//  HduSunnyRunAppIos
//
//  Created by tyw on 15/12/16.
//  Copyright © 2015年 tyw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AchievementsTableView : UITableView <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, copy) NSArray *achievementsDataArray;

@end
