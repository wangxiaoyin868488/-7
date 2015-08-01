//
//  XYTemp1Controller.m
//  我的微博
//
//  Created by 王晓银 on 15/7/27.
//  Copyright (c) 2015年 王晓银. All rights reserved.
//

#import "XYTemp1Controller.h"
#import "XYTemp2Controller.h"
@interface XYTemp1Controller ()

@end

@implementation XYTemp1Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"XYTemp1Controller";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{

    XYTemp2Controller *t2Vc = [[XYTemp2Controller alloc]init];
    [self.navigationController pushViewController:t2Vc animated:YES];
}

- (void)back{


    [self.navigationController popViewControllerAnimated:YES];
    


}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
