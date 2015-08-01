//
//  XYNavigationController.m
//  我的微博
//
//  Created by 王晓银 on 15/7/27.
//  Copyright (c) 2015年 王晓银. All rights reserved.
//

#import "XYNavigationController.h"
#import "UIBarButtonItem+Extension.h"

@interface XYNavigationController ()

@end

@implementation XYNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillAppear:(BOOL)animated{

    
    //我们要根据推送内容打开指定页面
    //*要打开一个ctrl，得要一个承载体
    //*推送过来的内容，要打开页面，一般用最后用户看到的页面
    //*viewWillAppear viewWillDisappear 这两个方法决定了我们这通知只有一个导航控制器去监听
    //注册远程推送消息的通知
    
    //收到通知内容
    
    //可以处理通知
    //tag = 1;
    //    if (通知内容.tag == 1) {
    //        self [pushViewController:个人中心 animated:YES];
    //    }

    [super viewWillAppear:animated];
    

}

- (void)viewDidDisappear:(BOOL)animated{

    //取消注册远程推送消息的通知
    [super viewDidDisappear:animated];
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{

    NSString *title = @"返回";
    
    //如果发现里面已经存在有且仅有一个，执行到这句代码的时候，代表即将要往navCtrl添加第2个
    if (self.childViewControllers.count == 1) {
        title = [[self.childViewControllers firstObject] title];
        
    }

    //如果当前push进来是第一个控制器的话，（代表当前childViewCtrls里面是没有东西）我们就不要设置leftitem
    if (self.childViewControllers.count) {
        //设置左边item
        
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"navigationbar_back_withtext" target:self action:@selector(back) title:title];
        
         //如果当前不是第一个子控制器，那么在push出去的时候隐藏底部的tabbar
        
        viewController.hidesBottomBarWhenPushed = YES;
        
    }
         //这句代码的位置是一个关键

    [super pushViewController:viewController animated:animated];
    


}


- (void)back{

    [self popViewControllerAnimated:YES];
    



}
@end
