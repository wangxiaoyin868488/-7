//
//  XYPopView.m
//  我的微博
//
//  Created by 王晓银 on 15/7/29.
//  Copyright (c) 2015年 王晓银. All rights reserved.
//

#import "XYPopView.h"


@interface XYPopView ()


@property(nonatomic,weak)UIImageView *contentView;

@end
@implementation XYPopView



- (instancetype)initWithCustomView:(UIView *)customView imageName:(NSString *)imageName{


    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];
        self.width = SCREENW;
        self.height = SCREENH;
        
        [self addTarget:self action:@selector(coverBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
        //使用xcode控件面板里面指定slicing，如果只是竖直方向拉伸，得设置cetern为stretches
        
        //初始化小灰框(里面装的就是用户传入的自定义view)

        UIImageView *contentView = [[UIImageView alloc]init];
        
        
        contentView.image = [UIImage imageNamed:imageName];

        

        //可与用户交互
        contentView.userInteractionEnabled = YES;
    
        
        //设置宽度高度
        
        contentView.width = customView.width + 20;
        
        contentView.height = customView.height + 30;
        
        [self addSubview:contentView];
        
        self.contentView = contentView;
        
        //添加之前设置customView的X Y
        
        customView.x = 10;
        
        customView.y = 17;
        //把用户传入的customView添加到contentView
        
        [contentView addSubview:customView];
        
        
        
        
        
}

    return self;
    

}


- (void)coverBtnClick:(UIButton *)btn{

    [self removeFromSuperview];


}

- (void)showFromView:(UIView *)showView imageType:(ImageType)imageType{
    //根据showview调整灰框的位置
    //计算contentView的位置
    //要计算出showView在屏幕上的位置

    //这个rect就代表showView在主窗口上的位置
    CGRect rect = [showView convertRect:showView.bounds toView:nil];
    
    if (imageType == centerImage) {
        
        self.contentView.centerX = CGRectGetMidX(rect);
        self.contentView.y = CGRectGetMaxY(rect);
        
    }else{
        
        self.contentView.centerX = CGRectGetMidX(rect) - self.contentView.centerX *0.5 - 20;
        self.contentView.y = CGRectGetMaxY(rect);

    }
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    
    [window addSubview:self];
    

}
@end
