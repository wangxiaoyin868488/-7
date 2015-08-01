//
//  XYTabBar.h
//  我的微博
//
//  Created by 王晓银 on 15/7/27.
//  Copyright (c) 2015年 王晓银. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XYTabBar;


@protocol XYTabBarDelegate <NSObject,UITabBarDelegate>

- (void)tabBar:(XYTabBar *)tabBar plusBtnDidClick:(UIButton *)btn;


@end

@interface XYTabBar : UITabBar

@property(nonatomic,weak)id<XYTabBarDelegate> delegate;

@end
