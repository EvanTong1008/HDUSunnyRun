//
//  Urls.h
//  HduSunnyRunAppIos
//
//  Created by tyw on 15/12/13.
//  Copyright © 2015年 tyw. All rights reserved.
//

#ifndef Urls_h
#define Urls_h

/*
 阳光长跑请求头
 hdu换成其他学校，就可以查询其他学校的
 */
#define SUNNY_RUN_HTTP_HEAD @"http://hdu.sunnysport.org.cn"



/*
 学生信息接口："/api/student/info/学号"
 返回值：
 {
 code ： 学号、
 name ： 学生姓名、
 validTimes ：到api调用为止该学生的有效次数、
 mileages ：到api调用时为止该学生的跑步里程、
 speed：到api调用时位置该学生跑步的平均速度
 }
 */
#define STU_INFO @"/api/student/info/"



/*
 学生成绩信息接口："/api/student/achievements/学号"
 返回值：
 对于Array中的每一项均为JsonObject
 {
 code ： 学号、
 date ： 跑步日期、
 domain ：该次跑步的时间段、
 mileage ：该次跑步的跑步里程、
 speed：该次跑步的平均速度、
 isValid：该次跑步是否为有效
 }
 */
#define STU_ACHIEVEMENTS @"/api/student/achievements/"



/*
 学生及格线接口："/api/student/group/学号"
 返回值：
 {
 group ： 学生分组名称、
 times ：学生该学期应该完成的有效次数、
 mileage ：每次跑步的最低里程、
 speed：每次跑步的最低速度
 }
 */
#define STU_GROUP @"/api/student/group/"



/*
 密码验证的接口："/api/student/学号/password/密码"
 返回值：
 {
 state ： 密码是否正确
 }
 */
#define STU_PASSWORD_TEST_NUMBER    @"/api/student/"
#define STU_PASSWORD_TEST_PASSWORD  @"/password/"



/*
 公告api接口："/api/announcement"
 注意返回的是html文本，不是纯文本
 可用webview解析
 */
#define ANNOUNCEMENT @"/api/announcement"





/*
 http://api.sunnysport.org.cn/schools
 这个是获得所有学校信息的接口。
 后面我会加的，一共有4个
 
 
 对所有的请求附加2个参数appkey，securitykey 后面服务器可能会对api请求做一下简单的认证，现在是任何人都可以访问到api的。
 appkey ： iosclientFuHGWFkuPo
 securitykey : tBbMtIEhISaqWycTtHEE
 
 */





#endif /* Urls_h */
