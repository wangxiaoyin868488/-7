//
//  XYSeachView.m
//  我的微博
//
//  Created by 王晓银 on 15/7/28.
//  Copyright (c) 2015年 王晓银. All rights reserved.
//

#import "XYSeachView.h"


@interface XYSeachView ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *seachField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightConstraint;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

@end
@implementation XYSeachView


+ (instancetype)seachView{


    return [[[NSBundle mainBundle]loadNibNamed:@"XYSeachView" owner:nil options:nil]lastObject];
    


}

- (void)awakeFromNib{

    UIImageView *leftView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"searchbar_textfield_search_icon"]];
    
    leftView.contentMode = UIViewContentModeCenter;
    
    leftView.width = 35;
    

    self.seachField.leftView = leftView;
    self.seachField.leftViewMode = UITextFieldViewModeAlways;

    self.seachField.delegate = self;
    

}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
    }
    return self;
}

//代理方法
- (void)textFieldDidBeginEditing:(UITextField *)textField{

    self.rightConstraint.constant = self.cancelButton.width;
    
    //动画效果
    [UIView animateWithDuration:0.25 animations:^{
        [self layoutIfNeeded];
        
    }];



}
- (IBAction)cancelButtonClick:(UIButton *)sender {
    
    self.rightConstraint.constant = 0;
    //动画效果
    [UIView animateWithDuration:0.25 animations:^{
        [self layoutIfNeeded];
        
    }];
    
    //[self endEditing:YES];
    
    //取消成为第一响应者
    
    [self.seachField resignFirstResponder];
    
    
    
}


@end
