//
//  XYAcount.h
//  我的微博
//
//  Created by 王晓银 on 15/7/30.
//  Copyright (c) 2015年 王晓银. All rights reserved.
//

#import <Foundation/Foundation.h>



//{
//    "access_token": "ACCESS_TOKEN",
//    "expires_in": 1234,
//    "remind_in":"798114",
//    "uid":"12341234"
//}

@interface XYAcount : NSObject <NSCoding>


@property (nonatomic, copy) NSString *uid;

@property (nonatomic, assign) NSInteger expires_in;

@property (nonatomic, copy) NSString *access_token;

@property (nonatomic, copy) NSString *remind_in;


@property (nonatomic,strong) NSDate *create_at;


@end
