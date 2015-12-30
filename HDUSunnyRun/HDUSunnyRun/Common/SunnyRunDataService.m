//
//  SunnyRunDataService.m
//  HduSunnyRunAppIos
//
//  Created by tyw on 15/12/16.
//  Copyright © 2015年 tyw. All rights reserved.
//

#import "SunnyRunDataService.h"
#import "AFNetworking.h"
#import "Urls.h"

@implementation SunnyRunDataService

+ (void)sunnyRunRequestUrl:(NSString*)urlStr
                httpMethod:(NSString*)method
                    params:(NSMutableDictionary*)params
                     datas:(NSMutableDictionary*)datas
                     block:(BlockType)block {
    //01 构建url
    //02 构建参数
    
    //03 构建manager
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    
    //04 发送请求
    AFHTTPRequestOperation* operation;
    if ([method isEqualToString:@"GET"]) {
        operation = [manager GET:urlStr parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"get请求成功");
            block(responseObject);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"get请求失败  error%@", error);
            block(error);
        }];
        //05 监听下载进度
        //        [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        //            NSLog(@"共需下载:%lld, 已经下载:%lld", totalBytesExpectedToRead, totalBytesRead);
        //        }];
        
    } else if ([method isEqualToString:@"POST"]) {
        if (datas) {        //如果发微博带图片
            operation = [manager POST:urlStr parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                for (NSString* name in datas) {
                    NSData* data = [datas objectForKey:name];
                    [formData appendPartWithFileData:data name:name fileName:@"1.png" mimeType:@"image/jpeg"];
                }
            } success:^(AFHTTPRequestOperation *operation, id responseObject) {
                NSLog(@"带数据的POST请求成功");
                block(responseObject);
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"带数据的POST请求失败  error:%@", error);
                block(error);
            }];
        } else {            //如果微博不带图片
            operation = [manager POST:urlStr parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
                NSLog(@"不带数据的POST请求成功");
                block(responseObject);
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"不带数据的POST请求失败  error:%@", error);
                block(error);
            }];
        }
        
        //05 监听上传进度
        //        [operation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
        //            NSLog(@"共需上传:%lld, 已经上传:%lld", totalBytesExpectedToWrite, totalBytesWritten);
        //        }];
    }
}


+ (void)sunnyRunRequestStuInfoWithStuNum:(NSString *)stuNum block:(BlockType)block {
    NSString *urlStr = [NSString stringWithFormat:@"%@%@%@", SUNNY_RUN_HTTP_HEAD, STU_INFO, stuNum];
    [self sunnyRunRequestUrl:urlStr httpMethod:@"GET" params:nil datas:nil block:block];
}


+ (void)sunnyRunRequestAchievementsInfoWithStuNum:(NSString *)stuNum block:(BlockType)block {
    NSString *urlStr = [NSString stringWithFormat:@"%@%@%@", SUNNY_RUN_HTTP_HEAD, STU_ACHIEVEMENTS, stuNum];
    [self sunnyRunRequestUrl:urlStr httpMethod:@"GET" params:nil datas:nil block:block];
}


+ (void)sunnyRunRequestStuGroupInfoWithStuNum:(NSString *)stuNum block:(BlockType)block {
    NSString *urlStr = [NSString stringWithFormat:@"%@%@%@", SUNNY_RUN_HTTP_HEAD, STU_GROUP, stuNum];
    [self sunnyRunRequestUrl:urlStr httpMethod:@"GET" params:nil datas:nil block:block];
}


+ (void)sunnyRunRequestPasswordTestWithStuNum:(NSString *)stuNum password:(NSString *)password block:(BlockType)block {
    NSString *urlStr = [NSString stringWithFormat:@"%@%@%@%@%@", SUNNY_RUN_HTTP_HEAD, STU_PASSWORD_TEST_NUMBER, stuNum, STU_PASSWORD_TEST_PASSWORD, password];
    [self sunnyRunRequestUrl:urlStr httpMethod:@"GET" params:nil datas:nil block:block];
}


+ (void)sunnyRunRequestAnnouncementBlock:(BlockType)block {
    NSString *urlStr = [NSString stringWithFormat:@"%@%@", SUNNY_RUN_HTTP_HEAD, ANNOUNCEMENT];
    [self sunnyRunRequestUrl:urlStr httpMethod:@"GET" params:nil datas:nil block:block];
}


@end
