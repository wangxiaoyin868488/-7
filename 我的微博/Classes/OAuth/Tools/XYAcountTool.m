//
//  XYAcountTool.m
//  我的微博
//
//  Created by 王晓银 on 15/7/31.
//  Copyright (c) 2015年 王晓银. All rights reserved.
//

#import "XYAcountTool.h"
#import "XYAcount.h"

#define AccountArchivePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.archiver"]
@implementation XYAcountTool


+ (void)saveAccount:(XYAcount *)acount{
//
//    //如果没有抽取宏
//    
//    NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//    
//    filePath = [filePath stringByAppendingPathComponent:@"account.archiver"];
//    
//    //归档
    
    [NSKeyedArchiver archiveRootObject:acount toFile:AccountArchivePath];
    



}


+ (XYAcount *)acount{

//    //如果没有抽取宏
//    
//    NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//    
//    filePath = [filePath stringByAppendingPathComponent:@"account.archiver"];
//    
//
    
    
    //解档用户保存的信息
//    XYAcount *acount = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    XYAcount *acount = [NSKeyedUnarchiver unarchiveObjectWithFile:AccountArchivePath];

    
    //判断是否过期
    
    //计算出过期的时间
    
    NSDate *expiresDate = [acount.create_at dateByAddingTimeInterval:acount.expires_in];
    
    NSDate *currentDate = [NSDate date];
    
    NSComparisonResult result = [expiresDate compare:currentDate];
    
    if (result != NSOrderedAscending) {
        //过期
        return acount;
        
        
    }
        
        return nil;
        
}
    







@end
