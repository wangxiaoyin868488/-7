//
//  XYStatus.h
//  我的微博
//
//  Created by 王晓银 on 15/7/31.
//  Copyright (c) 2015年 王晓银. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYStatus : NSObject
/**
 *  正文内容
 */

@property (nonatomic, copy) NSString *text;


/**
 *  微博的id
 */


@property(nonatomic,assign)long long id;
@end
