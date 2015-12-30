//
//  Tools.m
//  HduSunnyRunAppIos
//
//  Created by tyw on 15/12/8.
//  Copyright © 2015年 tyw. All rights reserved.
//

#import "Tools.h"

@implementation Tools

+ (NSDate *)dateFromStr:(NSString *)dateStr withFormatterStr:(NSString *)formatterStr {
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:formatterStr];
    
    NSDate* date = [formatter dateFromString:dateStr];
    return date;
}

+ (NSString *)strFromDate:(NSDate *)date withFormatterStr:(NSString *)formatterStr {
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:formatterStr];
    
    NSString* dateStr = [formatter stringFromDate:date];
    return dateStr;
}


//根据 最大宽度、字符串内容 计算自适应的尺寸
+ (CGSize)contentSizeWithMaxWidth:(CGFloat)maxWidth text:(NSString*)text fontOfSize:(CGFloat)fontOfSize {
    //maxLabelWidth ： 消息label最大宽度，就是你想让字符串自适应的宽度
    
    //字典，可能存储了这种字体的相关属性，可打印看看
    NSDictionary* dic = @{NSFontAttributeName:[UIFont systemFontOfSize:fontOfSize]};
    //自适应后获得这个label的size
    CGSize contentSize = [text boundingRectWithSize:CGSizeMake(maxWidth, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    
    return contentSize;
}


//把数组或字典转化成json数据
+ (NSString *)getJsonStrFromObj:(id)obj {
    NSError* error = nil;
    NSData* data = [NSJSONSerialization dataWithJSONObject:obj options:NSJSONWritingPrettyPrinted error:&error];
    if (error) {
        NSLog(@"error%@", error);
        return nil;
    }
    NSString* jsonStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return jsonStr;
}


//根据字符串与行间距，设置好富文本，返回
+ (NSAttributedString*)attributedStrFromStr:(NSString*)str lineSpace:(CGFloat)space {
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:str];
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:space];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [str length])];
    
    return attributedString;
}


//通过响应者链，找到要找的的类
+ (id)className:(NSString*)className fromResponder:(id)responder {
    UIResponder* res = responder;
    while (![res isKindOfClass:NSClassFromString(className)] && res) {
        res = res.nextResponder;
    }
    if (![res isKindOfClass:NSClassFromString(className)]) {
        NSLog(@"找不到要找的responder");
        return nil;
    }
    return res;
}





@end
