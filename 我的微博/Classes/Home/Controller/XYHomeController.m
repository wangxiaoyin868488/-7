//
//  XYHomeController.m
//  我的微博
//
//  Created by 王晓银 on 15/7/27.
//  Copyright (c) 2015年 王晓银. All rights reserved.
//

#import "XYHomeController.h"
#import "XYHomeTitleButton.h"
#import "UIBarButtonItem+Extension.h"
#import "XYTemp1Controller.h"
#import "XYPopView.h"
#import "XYAcount.h"
#import "XYAcountTool.h"
#import "MJExtension.h"
#import "AFNetworking.h"
#import "XYUser.h"
#import "XYStatus.h"
#import "UIViewController+ESSeparatorInset.h"
#import "XYLoadMoreView.h"

static NSString *identifier = @"cell";

//默认加载条数
#define LOAD_COUNT 20

@interface XYHomeController ()

@property(nonatomic,assign)BOOL isLoadMore;


@property(nonatomic,strong)NSMutableArray *statusArray;

@end

@implementation XYHomeController



- (NSMutableArray *)statusArray{

    if (_statusArray == nil) {
        _statusArray = [NSMutableArray array];
        
        
    }

    return _statusArray;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //首先告诉tableView 里面装的是什么类型的cell
    //去缓存里面取  如果没取到 就加载
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:identifier];
    
    //解决底部的分割线
    
    UIView *footerView = [[UIView alloc]init];
    
    self.tableView.tableFooterView = footerView;
    
    //没用
    //self.tableView.separatorInset = UIEdgeInsetsMake(0, 5, 0, 0);
    //可以解决左边距的问题 (导入框架)
    [self setSeparatorInsetZeroWithTableView:self.tableView];
    
    
    //设置导航栏
    
    [self setUpNav];
    
    //获取个人信息
    
    [self getUserInfo];
    
    
    [self setRefreshView];
    
    
    //[self loadNewStatues];
    
    
    
}


- (void)setRefreshView{

    //刷新控件
    UIRefreshControl *refreshCrtl = [[UIRefreshControl alloc]init];
    //给刷新空间添加值改变的监听事件
    [refreshCrtl addTarget:self action:@selector(loadNewStatues:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refreshCrtl];
    
    //刷新最近的数据
    
    [self loadNewStatues:refreshCrtl];
    
    
    //设置加载更多的view
    
    XYLoadMoreView *loadMoreView = [XYLoadMoreView loadMoreView];
    
    
    loadMoreView.hidden = YES;
    
    self.tableView.tableFooterView = loadMoreView;
    


}

- (void)setUpNav{


    XYHomeTitleButton *titleBtn = [[XYHomeTitleButton alloc]init];
    
    [titleBtn setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];

    [titleBtn setTitle:@"全部动态" forState:UIControlStateNormal];
    
    [titleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [titleBtn sizeToFit];
    
    [titleBtn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.titleView = titleBtn;
    
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"navigationbar_friendsearch" target:self action:@selector(friend)];
    
    

    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImageName:@"navigationbar_pop" target:self action:@selector(pop:)];

}


- (void)titleBtnClick:(UIButton *)btn{

    
    //初始化customView

    UITableView *customView = [[UITableView alloc]init];
    
    customView.backgroundColor = [UIColor yellowColor];
    
    
    
    
    
    
    //customView.image = [UIImage imageNamed:@"allproducts_s"];
    customView.size = CGSizeMake(200, 300);
    
    

    XYPopView *popView = [[XYPopView alloc]initWithCustomView:customView imageName:@"popover_background"];
    

    [popView showFromView:btn imageType:centerImage];
    //[self.view addSubview:popView];
    


}




- (void)friend{

    NSLog(@"haah");
    
    XYTemp1Controller *t1Vc = [[XYTemp1Controller alloc]init];
    [self.navigationController pushViewController:t1Vc animated:YES];
    

}

- (void)pop:(UIButton *)btn{

    NSLog(@"heiehe");
    
    UIImageView *customView = [[UIImageView alloc]init];
    
    customView.backgroundColor = [UIColor yellowColor];
    
    customView.image = [UIImage imageNamed:@"allproducts_s"];
    customView.size = CGSizeMake(200, 300);
    
    
    
    XYPopView *popView = [[XYPopView alloc]initWithCustomView:customView imageName:@"popover_background_right"];
    
    
    [popView showFromView:btn imageType:rightImage];

    
    

}



#pragma mark ---- 私有方法

/**
 *  获取个人信息
 */
- (void)getUserInfo{

    NSString *strUrl = @"https://api.weibo.com/2/users/show.json";
    
    //参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    XYAcount *acount = [XYAcountTool acount];
    params[@"access_token"] = acount.access_token;
    
    params[@"uid"] = acount.uid;
    
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];

    
    [manger GET:strUrl parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        XYUser *user = [[XYUser alloc]init];
        
        [user setKeyValues:responseObject];
        
        XYHomeTitleButton *button = (XYHomeTitleButton *)self.navigationItem.titleView;
        
        [button setTitle:user.screen_name forState:UIControlStateNormal];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求失败：%@",error);
        
    }];


}


- (void)loadNewStatues:(UIRefreshControl *)refreshControl{

    NSString *strUrl = @"https://api.weibo.com/2/statuses/friends_timeline.json";
    
    //参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    XYAcount *acount = [XYAcountTool acount];
    
    params[@"access_token"] = acount.access_token;
    
    params[@"count"] = @(LOAD_COUNT);
    
    
    if ([self.statusArray firstObject]) {
        
        params[@"since_id"] = @([[self.statusArray firstObject] id]);
        
    }
    

    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    
    
    [manger GET:strUrl parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        //菊花停转
        
        [refreshControl endRefreshing];
        
        //这个array里面存的是字典
        NSArray *statuesDic = responseObject[@"statuses"];
        //这个集合里面放的就是XYStatus模型
        NSArray *statuses = [XYStatus objectArrayWithKeyValuesArray:statuesDic];
        //初始一个范围-->我们刷新回来的数据，需要添加到的tableView的前面(添加到数组的前面)

        NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, statuses.count)];
        
        [self.statusArray insertObjects:statuses atIndexes:set];
        
        //self.statusArray = statuses;
        
        //让tableView刷新
        
        [self.tableView reloadData];
        

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求失败：%@",error);
        
        [refreshControl endRefreshing];

        
    }];


}


- (void)loadMoreStatuses{

    
    NSString *urlStr = @"https://api.weibo.com/2/statuses/friends_timeline.json";
    //参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    XYAcount *acount = [XYAcountTool acount];
    
    params[@"access_token"] = acount.access_token;
    
    params[@"count"] = @(LOAD_COUNT);
    
    if ([self.statusArray lastObject]) {
        
        params[@"max_id"] = @([[self.statusArray lastObject] id] - 1);
        
    }

    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    
    
    [manger GET:urlStr parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //加载完成之后，把底部控件设置为隐藏，以及再次下拉的时候执行加载更多的逻辑

        self.tableView.tableFooterView.hidden = YES;
        
        
        //这个array里面存的是字典
        NSArray *statuesDic = responseObject[@"statuses"];
        //这个集合里面放的就是XYStatus模型
        NSArray *statuses = [XYStatus objectArrayWithKeyValuesArray:statuesDic];
        
        [self.statusArray addObjectsFromArray:statuses];
        
        //刷新tableView
        [self.tableView reloadData];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求失败");
        self.tableView.tableFooterView.hidden = YES;
        
    }];
    









}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return self.statusArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    cell.textLabel.text = [self.statusArray[indexPath.row] text];
    
    
    
    return cell;
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    // tableView 的内容高度 - 屏幕高度 <= scrollView的滑动距离
    // tableView.contentsize.h – screenH<=scrollView.contenoffset.y

    if (self.statusArray.count == 0 || self.tableView.tableFooterView.hidden == NO) {
        return;
        
    }
    
    CGFloat result = self.tableView.contentSize.height - SCREENH;
    
    NSLog(@"%f",scrollView.contentOffset.y);
    
    if (result <= scrollView.contentOffset.y - self.tabBarController.tabBar.height) {
        
        NSLog(@"滑到底部了");
        self.tableView.tableFooterView.hidden = NO;
        
        
        
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self loadMoreStatuses];
                });
        //[self loadMoreStatuses];
        
    }
    
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
