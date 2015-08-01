//
//  XYAcount.m
//  我的微博
//
//  Created by 王晓银 on 15/7/30.
//  Copyright (c) 2015年 王晓银. All rights reserved.
//

#import "XYAcount.h"

@implementation XYAcount



- (void)setExpires_in:(NSInteger)expires_in{

    _expires_in = expires_in;
    
    self.create_at = [NSDate date];


}

/**
 *  指定自己身上的属性怎么去归档
 *
 *  @param encode <#encode description#>
 */
- (void)encodeWithCoder:(NSCoder *)encode{

    
    [encode encodeObject:self.access_token forKey:@"access_token"];
    [encode encodeObject:self.uid forKey:@"uid"];
    [encode encodeObject:self.remind_in forKey:@"remind_in"];
    [encode encodeInteger:self.expires_in forKey:@"expires_in"];
    [encode encodeObject:self.create_at forKey:@"create_at"];
    
}


- (instancetype)initWithCoder:(NSCoder *)encode{

    self = [super init];
    
    if (self) {
        self.access_token = [encode decodeObjectForKey:@"access_token"];
        self.uid = [encode decodeObjectForKey:@"uid"];
        self.remind_in = [encode decodeObjectForKey:@"remind_in"];
        self.expires_in = [encode decodeIntegerForKey:@"expires_in"];
        self.create_at = [encode decodeObjectForKey:@"create_at"];
        
    }


    return self;
    

}
@end
