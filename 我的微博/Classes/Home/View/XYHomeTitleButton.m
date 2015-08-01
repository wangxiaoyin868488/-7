//
//  XYHomeTitleButton.m
//  我的微博
//
//  Created by 王晓银 on 15/7/27.
//  Copyright (c) 2015年 王晓银. All rights reserved.
//

#import "XYHomeTitleButton.h"

@implementation XYHomeTitleButton

- (void)layoutSubviews{

    [super layoutSubviews];
    
    //title的位置
    self.titleLabel.x = 0;
    
    //更具title的位置设置image的位置
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame) + 5;
    
    self.width = CGRectGetMaxX(self.imageView.frame);
    
    self.centerX  = self.superview.centerX;
    





}


@end
