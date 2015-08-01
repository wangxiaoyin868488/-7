//
//  XYOAuthController.m
//  我的微博
//
//  Created by 王晓银 on 15/7/30.
//  Copyright (c) 2015年 王晓银. All rights reserved.
//

#import "XYOAuthController.h"
#import "AFNetworking.h"
#import "XYAcount.h"
#import "XYTabbarController.h"
#import "XYAcountTool.h"
#define Client_id @"2797160321"    //appkey

#define Client_secret @"856c2f9c6d49df82add99bb0b1a3e5b9"
#define Redirect_uri @"http://www.baidu.com/"



@interface XYOAuthController ()<UIWebViewDelegate>


@property(nonatomic,weak)UIWebView *webView;

@end

@implementation XYOAuthController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
   
    
    
    UIWebView *webView = [[UIWebView alloc]init];
    
    //设置webView的大小
    
    webView.frame = self.view.bounds;
    
    webView.delegate = self;
    
    
    [self.view addSubview:webView];
    
    self.webView = webView;
    
    //设置webView要加载的页面
    /*
     请求的地址：https://api.weibo.com/oauth2/authorize
     App Key：2797160321
     App Secret：856c2f9c6d49df82add99bb0b1a3e5b9
     */
    
    NSString *urlStr = [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@",Client_id,Redirect_uri];
    
    //把urlStr 转化成NSURL
    
    NSURL *url = [NSURL URLWithString:urlStr];
    
    //把url转化成request
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    //webView加载这个request
    
    [webView loadRequest:request];
}


# pragma mark--- webView的代理方法

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    NSLog(@"===%@",request.URL.absoluteString);

    NSString *urlStr = request.URL.absoluteString;
    
    //http://www.baidu.com/?code=6a369b08f236078e1c7918a997f40e99
    
    //判断是否是授权回调页  判断当前访问网址是否以回调页开头
    
    if ([urlStr hasPrefix:Redirect_uri]) {
        
        NSString *suStr = @"code=";
        
        //获取code=在url里面的位置
        NSRange range = [urlStr rangeOfString:suStr];
#warning 用到NSRange的时候，一定要考虑清楚，一定要判断是找到/一定要考虑清楚是否有越界
    
        if (range.location != NSNotFound) {
            //执行截取code 字符串 拿到授权码
            
            NSString *code = [urlStr substringFromIndex:range.location + range.length];
            
            NSLog(@"code === %@ ",code);
            
            //拿着code，去获取AccessToken
            
            [self getAccessTokenWithCode:code];
            
            return NO;
            
        }
        
    }


    return YES;
    


}


/**
 *  获取授权令牌
 *
 *  @param code <#code description#>
 */
- (void)getAccessTokenWithCode:(NSString *)code{
    
    //    client_id	true	string	申请应用时分配的AppKey。
    //    client_secret	true	string	申请应用时分配的AppSecret。
    //    grant_type	true	string	请求的类型，填写authorization_code
    //    code	true	string	调用authorize获得的code值。
    //    redirect_uri	true	string	回调地址，需需与注册应用里的回调地址一致。

    NSString *urlStr = @"https://api.weibo.com/oauth2/access_token";
    
    //拼装参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"client_id"] = Client_id;
    params[@"client_secret"] = Client_secret;
    params[@"grant_type"] = @"authorization_code";
    params[@"code"] = code;
    params[@"redirect_uri"] = Redirect_uri;
    
    
//    NSLocalizedDescription=Request failed: unacceptable content-type: text/plain
    
//新浪返回的数据对应的content-Type是text/plain，而AFNl默认的AFJSONResponseSerializer不接受这种类型

    

    //获取请求的管理者
    
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    
    // AFJSONResponseSerializer
    
    [manger POST:urlStr parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //将返回回来的数据字典转化为模型
        XYAcount *acount = [[XYAcount alloc]init];
        [acount setValuesForKeysWithDictionary:responseObject];
        
        //保存登陆信息
        [XYAcountTool saveAccount:acount];
        
//        
//        //去获取doc路径
//        NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//        
//        //拼接文件路径
//        
//        filePath = [filePath stringByAppendingString:@"account.archiver"];
//        
//        //归档
//        [NSKeyedArchiver archiveRootObject:acount toFile:filePath];
//        
//        NSLog(@"filePath = %@",filePath);
        
        //登陆成功之后转到tabbarcontroller
        
        XYTabbarController *tabVC = [[XYTabbarController alloc]init];
        
        //获取主窗口
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        window.rootViewController = tabVC;
        
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求错误:%@",error);
    }];


    
    











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
