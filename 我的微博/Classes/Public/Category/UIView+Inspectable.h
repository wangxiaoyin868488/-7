//
//  UIView+Inspectable.h
//  我的微博
//
//  Created by 王晓银 on 15/7/28.
//  Copyright (c) 2015年 王晓银. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface UIView (Inspectable)
/**
 *  圆角
 */
@property (nonatomic, assign) IBInspectable CGFloat cornerRadius;

/**
 *  边框颜色
 */
@property (nonatomic,strong) IBInspectable UIColor *borderColor;

/**
 *  边框宽度
 */
@property (nonatomic, assign) IBInspectable CGFloat borderWidth;


@end
