//
//  common.h
//  HduSunnyRunAppIos
//
//  Created by tyw on 15/12/13.
//  Copyright © 2015年 tyw. All rights reserved.
//

#ifndef common_h
#define common_h


#define kScreenWidth  [UIApplication sharedApplication].keyWindow.bounds.size.width
#define kScreenHeight [UIApplication sharedApplication].keyWindow.bounds.size.height


#define DEVICE_IOS_VERSION  [[UIDevice currentDevice].systemVersion floatValue]
#define IS_IOSx_OR_LATER(X) (((double)(DEVICE_IOS_VERSION)-X) >= -((double)(DEVICE_IOS_VERSION)-X)*DBL_EPSILON)

#define IS_IOS7_OR_LATER    IS_IOSx_OR_LATER(7.0)
#define IS_IOS8_OR_LATER    IS_IOSx_OR_LATER(8.0)
#define IS_EARLIER_IOS8     (DEVICE_IOS_VERSION < 8.0)
#define IS_EARLIER_IOS7     (DEVICE_IOS_VERSION < 7.0)

// 圆润的透明背景，登录、公告、个人信息、成绩
#define kTransparentBackgroundColor ([UIColor colorWithRed:200.0/255 green:200.0/255 blue:200.0/255 alpha:0.3])

static inline BOOL IS_IPHONE()
{
    return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone);
}

static inline BOOL IS_IPHONE_5()
{
    return (IS_IPHONE() && fabs(([[UIScreen mainScreen] bounds].size.height - (double)568)) < DBL_EPSILON);
}

static inline BOOL IS_IPHONE_4()
{
    return (IS_IPHONE() && fabs(([[UIScreen mainScreen] bounds].size.height -(double)480)) < DBL_EPSILON);
}

static inline BOOL IS_IPHONE_6_47()
{
    return (IS_IPHONE() && fabs(([[UIScreen mainScreen] bounds].size.height - (double)667)) < DBL_EPSILON);
}

static inline BOOL IS_IPHONE_6_55()
{
    return (IS_IPHONE() && fabs(([[UIScreen mainScreen] bounds].size.height - (double)736)) < DBL_EPSILON);
}

static inline float status_height()
{
    return 20.f;
}

static inline float navigation_height()
{
    return 44.f;
}

static inline float tabbar_height()
{
    return 49.f;
}

//  字体大小
static inline float fontSize()
{
    if (IS_IPHONE_4()) {
        return 16.0;
    } else if (IS_IPHONE_5()) {
        return 16.0;
    } else if (IS_IPHONE_6_47()) {
        return 18.0;
    } else {
        return 22.0;
    }
}


#define SAFE_STRING(str) \
(((str)==NULL || (str) == nil ||(NSNull *)str == [NSNull null]) ? @"" : str)


#endif /* common_h */
