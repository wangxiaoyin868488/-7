//
//  UIWindow+Extension.m
//  我的微博
//
//  Created by 王晓银 on 15/7/30.
//  Copyright (c) 2015年 王晓银. All rights reserved.
//

#import "UIWindow+Extension.h"
#import "XYAcount.h"
#import "XYTabbarController.h"

#import "XYOAuthController.h"

#import "XYAcountTool.h"
@implementation UIWindow (Extension)

- (void)switchRootViewController{

//    //是否登录过
//    //去获取doc路径
//    NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//    
//    //拼接文件路径
//    
//    filePath = [filePath stringByAppendingString:@"account.archiver"];
//    
//    //解档用户登录成功保存的信息
//    
//    XYAcount *acount = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
//    //判断是否过期
//    //计算过期的时间
//    
//    NSDate *expiresDate = [acount.create_at dateByAddingTimeInterval:acount.expires_in];
//    
//    NSDate *currentDate = [NSDate date];
//    
//    NSComparisonResult result = [expiresDate compare:currentDate];
//    
//    if (result == NSOrderedAscending) {
//        //过期
//        
//        XYOAuthController *oAuthVc = [[XYOAuthController alloc]init];
//        self.rootViewController = oAuthVc;
//
//        
//        
//    }else{
//    
//        
//        XYTabbarController *tabVC = [[XYTabbarController alloc]init];
//        
//        self.rootViewController = tabVC;
//        
//
//    
//    }
//    
    XYAcount *acount = [XYAcountTool acount];

    if (!acount) {
        //跳到登陆界面去
        
        XYOAuthController *oAuthVc = [[XYOAuthController alloc]init];
        self.rootViewController = oAuthVc;
        
    }else{
        
        //登陆成功之后转到tabbarcontroller
        
        XYTabbarController *tabVC = [[XYTabbarController alloc]init];
        
        self.rootViewController = tabVC;
        
    }


    
    
    
}


@end
