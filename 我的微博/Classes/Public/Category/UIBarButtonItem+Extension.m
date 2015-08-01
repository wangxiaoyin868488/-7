//
//  UIBarButtonItem+Extension.m
//  我的微博
//
//  Created by 王晓银 on 15/7/27.
//  Copyright (c) 2015年 王晓银. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)

+ (instancetype)itemWithImageName:(NSString *)imageName target:(id)target action:(SEL)action
{

    //初始化一个自定义View(UIButton)
    UIButton *btn = [[UIButton alloc]init];
    
    //设置不同状态显示的图片
    
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    
   
    [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_highlighted",imageName]] forState:UIControlStateHighlighted];
    
    btn.size = btn.currentImage.size;
    
    
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc]initWithCustomView:btn];
    

}

+ (instancetype)itemWithImageName:(NSString *)imageName target:(id)target action:(SEL)action title:(NSString *)title{

    UIButton *btn = [[UIButton alloc]init];
    //设置不同状态显示的图片
    
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    
    
    [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_highlighted",imageName]] forState:UIControlStateHighlighted];
    

    UIColor *color = RGB(68, 68, 68);
    
    [btn setTitleColor:color forState:UIControlStateNormal];
    
    //设置button的文字
    
    [btn setTitle:title forState:UIControlStateNormal];
    
    [btn sizeToFit];

    //添加点击事件
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc]initWithCustomView:btn];
    
}

@end
