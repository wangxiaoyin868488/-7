//
//  XYNewfeatureController.m
//  我的微博
//
//  Created by 王晓银 on 15/7/28.
//  Copyright (c) 2015年 王晓银. All rights reserved.
//

#import "XYNewfeatureController.h"
#import "XYTabbarController.h"
#import "XYOAuthController.h"
#import "XYAcount.h"
#import "UIWindow+Extension.h"

@interface XYNewfeatureController ()<UIScrollViewDelegate>

@property(nonatomic,weak)UIPageControl *pageControl;

@end

@implementation XYNewfeatureController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    NSUInteger count = 4;
    
    UIPageControl *control = [[UIPageControl alloc]init];
    //设置选中和未选中的指示器的颜色
    control.currentPageIndicatorTintColor = [UIColor redColor];
    control.pageIndicatorTintColor = [UIColor lightGrayColor];
    
    //设置页数
    control.numberOfPages = count;
    
    control.centerX = SCREENW * 0.5;
    
    control.y = SCREENH - 80;
    [self.view addSubview:control];
    
    self.pageControl = control;
    
    
    
    
    
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    
    //打开分页
    scrollView.pagingEnabled = YES;
    //隐藏水平滚动条
    scrollView.showsHorizontalScrollIndicator = NO;
    
    //要监听scrollView的滚动
    
    scrollView.delegate = self;
    
    
    //insert这个方法可以指定你要添加的view放在哪个一个位置，还可能有方法指定这个view放在某一个View的下边或者上边
    [self.view insertSubview:scrollView belowSubview:control];
    
    
    
    //scrollView.backgroundColor = [UIColor redColor];
    
    for (int i = 0; i < count; i++) {
        
        UIImageView *imageView = [[UIImageView alloc]init];
        //拼装图片的名字
        NSString *imageName = [NSString stringWithFormat:@"new_feature_%zd",i + 1];
        
        imageView.image = [UIImage imageNamed:imageName];
        
        //设置imageView 的位置和大小
        imageView.size = scrollView.size;
        imageView.x = i * scrollView.width;
        
        [scrollView addSubview:imageView];

        if (i == count - 1) {
            //设置最后一张的内容
            [self setUpLastImage:imageView];
            
        }
    }
    
    //[self.view addSubview:scrollView];

    //设置滚动区域
    scrollView.contentSize = CGSizeMake(count * scrollView.width, 0);
    
    //[self.view addSubview:scrollView];

}

//设置最后一页的内容

- (void)setUpLastImage:(UIImageView *)imageView{

    imageView.userInteractionEnabled = YES;
    
    
    //进入微博的按钮
    UIButton *enterBtn = [[UIButton alloc]init];
    
    //设置不同状态的背景图片
    [enterBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
    
    [enterBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    
    //设置表体
    [enterBtn setTitle:@"进入微博" forState:UIControlStateNormal];
    
    enterBtn.size = enterBtn.currentBackgroundImage.size;
    
    //设置位置
    
    //enterBtn.centerX = SCREENW *0.5;
    //enterBtn.y = SCREENH - 150;
    
    enterBtn.centerX = imageView.width *0.5;
    enterBtn.y = imageView.height - 150;
    
    [enterBtn addTarget:self action:@selector(enterBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [imageView addSubview:enterBtn];
    
    
    //添加分享的按钮
    
    UIButton *shareBtn = [[UIButton alloc]init];
    
    //设置不同状态的图片
    
    [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateNormal];
    [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateSelected];
    
    //设置文字与文字颜色
    [shareBtn setTitle:@"分享到微博" forState:UIControlStateNormal];
    [shareBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    //调整大小
    
    [shareBtn sizeToFit];
    //设置位置
    //shareBtn.centerX = SCREENW * 0.5;
    //shareBtn.y = enterBtn.y - 50;
    
    shareBtn.centerX = imageView.width *0.5;
    shareBtn.y = enterBtn.y - 40;
    
    
    [shareBtn addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [imageView addSubview:shareBtn];
    
    
}

- (void)enterBtnClick:(UIButton *)btn{

    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
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
//    
//    if (!acount) {
//        //跳到登陆界面去
//        window.rootViewController = [[XYOAuthController alloc]init];
//        
//    }else{
//        
//        //登陆成功之后转到tabbarcontroller
//        
//        XYTabbarController *tabVC = [[XYTabbarController alloc]init];
//        
//        window.rootViewController = tabVC;
//        
//    }
    
    [window switchRootViewController];
    
    
}





- (void)shareBtnClick:(UIButton *)btn{

    btn.selected = !btn.selected;
    

}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    //计算出当前偏移页数的小数
    CGFloat page = scrollView.contentOffset.x / scrollView.width;
    
    //把得出小数四舍五入，的出当前的页数
    
    NSInteger pageNum = (int)(page + 0.5);
    
    if (self.pageControl.currentPage != pageNum) {
        self.pageControl.currentPage = pageNum;
        
    }



}

@end
