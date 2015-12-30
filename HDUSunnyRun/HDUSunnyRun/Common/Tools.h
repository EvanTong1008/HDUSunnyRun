//
//  Tools.h
//  HduSunnyRunAppIos
//
//  Created by tyw on 15/12/8.
//  Copyright © 2015年 tyw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface Tools : NSObject

//日期与字符串之间的互相转换
+ (NSDate*)dateFromStr:(NSString*)dateStr withFormatterStr:(NSString*)formatterStr;
+ (NSString*)strFromDate:(NSDate*)date withFormatterStr:(NSString*)formatterStr;

//文本自适应高度
+ (CGSize)contentSizeWithMaxWidth:(CGFloat)maxWidth text:(NSString*)text fontOfSize:(CGFloat)fontOfSize;

//字典或数组转换成json字符串
+ (NSString*)getJsonStrFromObj:(id)obj;

//根据字符串与行间距，设置好富文本，返回
+ (NSAttributedString*)attributedStrFromStr:(NSString*)str lineSpace:(CGFloat)space;

//通过响应者链，找到要找的的类.className就是要找的类的名字，responder就是响应者链的起始点
+ (id)className:(NSString*)className fromResponder:(id)responder;


@end
