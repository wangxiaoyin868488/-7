//
//  XYTabbarController.m
//  我的微博
//
//  Created by 王晓银 on 15/7/27.
//  Copyright (c) 2015年 王晓银. All rights reserved.
//

#import "XYTabbarController.h"
#import "XYTabBar.h"
#import "XYHomeController.h"

#import "XYNavigationController.h"
#import "XYDiscoverController.h"



@interface XYTabbarController ()<XYTabBarDelegate>

@end

@implementation XYTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    XYTabBar *tabBar = [[XYTabBar alloc]init];
    
    tabBar.delegate = self;

    [self setValue:tabBar forKey:@"tabBar"];
    
    
    
    XYHomeController *homeVc = [[XYHomeController alloc]init];

    [self addChildViewContr:homeVc imageName:@"tabbar_home" title:@"首页"];
    
    UITableViewController *messagevc = [[UITableViewController alloc]init];
    
    [self addChildViewContr:messagevc imageName:@"tabbar_message_center" title:@"消息"];
    
    XYDiscoverController *discoverVc = [[XYDiscoverController alloc]init];
    
    [self addChildViewContr:discoverVc imageName:@"tabbar_discover" title:@"发现"];
    
    UITableViewController *profileCtrl = [[UITableViewController alloc]init];
    
    [self addChildViewContr:profileCtrl imageName:@"tabbar_profile" title:@"我"];
    
    
}



- (void)addChildViewContr:(UIViewController *)vc imageName:(NSString *)imageName title:(NSString *)title{
    
    vc.tabBarItem.image = [UIImage imageNamed:imageName];
    
    //vc.navigationItem.title = title;
    //vc.tabBarItem.title = title;
    vc.title = title;
    
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:[NSString stringWithFormat:@"%@_selected",imageName]]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
//    
//    //初始化一个文字属性字典
//    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//    dict[NSForegroundColorAttributeName] = [UIColor orangeColor];
//    //把文字属性字典添加到TextAttributes
//    [vc.tabBarItem setTitleTextAttributes:dict forState:UIControlStateSelected];
    
    self.tabBar.tintColor = [UIColor orangeColor];
    
    
    XYNavigationController *naVc = [[XYNavigationController alloc]initWithRootViewController:vc];
    
    [self addChildViewController:naVc];
    
    //添加到
    //[self addChildViewController:vc];

}



//代理方法
- (void)tabBar:(XYTabBar *)tabBar plusBtnDidClick:(UIButton *)btn{

    NSLog(@"haha");
    
    
    UIViewController *plusVc = [[UIViewController alloc]init];
    XYNavigationController *nVc = [[XYNavigationController alloc]initWithRootViewController:plusVc];
    
    
    
    plusVc.view.backgroundColor = [UIColor redColor];
    
    [self presentViewController:nVc animated:YES completion:nil];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
