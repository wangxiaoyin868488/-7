//
//  XYPopView.h
//  我的微博
//
//  Created by 王晓银 on 15/7/29.
//  Copyright (c) 2015年 王晓银. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum{

    rightImage,
    centerImage

}ImageType;

@interface XYPopView : UIButton





/**
 *  初始化一个popView
 *
 *  @param customView 用户自定义的view 里面的内容是用户定义好的 popview只供显示
 *  @param showView   popView里面contentView显示在哪个view下面(根据什么View来显示)
 *  @return
 */
- (instancetype)initWithCustomView:(UIView *)customView imageName:(NSString *)imageName;


/**
 *  显示出来 根据传入的View的位置显示图片
 *
 *  @param showView showView 要显示在哪一个View的下面
 */
- (void)showFromView:(UIView *)showView imageType:(ImageType)imageType;


@end
