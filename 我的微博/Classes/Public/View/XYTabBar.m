//
//  XYTabBar.m
//  我的微博
//
//  Created by 王晓银 on 15/7/27.
//  Copyright (c) 2015年 王晓银. All rights reserved.
//

#import "XYTabBar.h"

@interface XYTabBar ()


@property(nonatomic,weak)UIButton *plusBtn;

@end


@implementation XYTabBar


- (instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    
    if (self) {
        UIButton *plusBtn = [[UIButton alloc]init];
        //设置加号按钮在不同状态下的图片
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        
        [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        
        
        //给按钮添加点击事件
        
        [plusBtn addTarget:self action:@selector(plusBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
        [self addSubview:plusBtn];
        
        self.plusBtn = plusBtn;
        
        
        //设置button的大小
        plusBtn.size = plusBtn.currentBackgroundImage.size;
   
    }

    return self;
}

//设置加号按钮的位置
- (void)layoutSubviews{

    [super layoutSubviews];
    
    //调整加号按钮的位置
    self.plusBtn.centerX = self.width * 0.5;
    self.plusBtn.centerY = self.height *0.5;
    
    //调整UITabBarButton的大小和位置
    
    CGFloat tabBarBtnW = self.width * 0.2;
    
    
    NSInteger index = 0;
    
    for (int i = 0; i < self.subviews.count; i++) {
        UIView *view = self.subviews[i];
        
        if ([view isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            //宽度
            view.width = tabBarBtnW;
            //根据当前button的index,去设置其对应的x
            view.x = index * tabBarBtnW;
            if (index == 1) {
                index++;
                
            }
            index++;
        }
    }
}


- (void)plusBtnClick:(UIButton *)btn{


    //NSLog(@"hahaah");

    if ([self.delegate respondsToSelector:@selector(tabBar:plusBtnDidClick:)]) {
        [self.delegate tabBar:self plusBtnDidClick:btn];
        
    }




}


@end
