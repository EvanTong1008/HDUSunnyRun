//
//  SunnyRunDataService.h
//  HduSunnyRunAppIos
//
//  Created by tyw on 15/12/16.
//  Copyright © 2015年 tyw. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^BlockType)(id result);

@interface SunnyRunDataService : NSObject

/**
 *  通用型的网络接口
 *
 *  @param urlStr url
 *  @param method POST/GET
 *  @param params 请求参数
 *  @param datas  可能需要上传的数据
 *  @param block  网络请求回调
 */
+ (void)sunnyRunRequestUrl:(NSString*)urlStr
                httpMethod:(NSString*)method
                    params:(NSMutableDictionary*)params
                     datas:(NSMutableDictionary*)datas
                     block:(BlockType)block;


/**
 *  学生信息
 *
 *  @param stuNum 学生学号
 *  @param block  网络请求回调
 */
+ (void)sunnyRunRequestStuInfoWithStuNum:(NSString *)stuNum
                                   block:(BlockType)block;



/**
 *  成绩信息
 *
 *  @param stuNum 学生学号
 *  @param block  网络请求回调
 */
+ (void)sunnyRunRequestAchievementsInfoWithStuNum:(NSString *)stuNum
                                            block:(BlockType)block;


/**
 *  分组信息
 *
 *  @param stuNum 学生学号
 *  @param block  网络请求回调
 */
+ (void)sunnyRunRequestStuGroupInfoWithStuNum:(NSString *)stuNum
                                        block:(BlockType)block;



/**
 *  密码验证
 *
 *  @param stuNum   学生学号
 *  @param password 登录密码
 *  @param block  网络请求回调
 */
+ (void)sunnyRunRequestPasswordTestWithStuNum:(NSString *)stuNum
                                     password:(NSString *)password
                                        block:(BlockType)block;


/**
 *  公告信息
 *  @param block  网络请求回调
 */
+ (void)sunnyRunRequestAnnouncementBlock:(BlockType)block;


@end
