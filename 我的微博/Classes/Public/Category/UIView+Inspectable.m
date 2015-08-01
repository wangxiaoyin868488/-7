//
//  UIView+Inspectable.m
//  我的微博
//
//  Created by 王晓银 on 15/7/28.
//  Copyright (c) 2015年 王晓银. All rights reserved.
//

#import "UIView+Inspectable.h"

@implementation UIView (Inspectable)


- (void)setCornerRadius:(CGFloat)cornerRadius{

    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = cornerRadius > 0;

}

- (CGFloat)cornerRadius{

    return self.layer.cornerRadius;
    
}

- (void)setBorderColor:(UIColor *)borderColor{
    self.layer.borderColor = borderColor.CGColor;
}


- (UIColor *)borderColor{
    return [UIColor colorWithCGColor:self.layer.borderColor];
}


- (void)setBorderWidth:(CGFloat)borderWidth{
    self.layer.borderWidth = borderWidth;
}

- (CGFloat)borderWidth{
    return self.layer.borderWidth;
}


@end
