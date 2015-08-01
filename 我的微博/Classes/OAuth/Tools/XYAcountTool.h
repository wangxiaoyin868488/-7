//
//  XYAcountTool.h
//  我的微博
//
//  Created by 王晓银 on 15/7/31.
//  Copyright (c) 2015年 王晓银. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XYAcount;
@interface XYAcountTool : NSObject


/**
 *  保存账户信息
 *
 *  @param acount 账号的信息
 */
+ (void)saveAccount:(XYAcount *)acount;



/**
 *  读取账号
 *
 *  @return 
 */
+ (XYAcount *)acount;


@end
