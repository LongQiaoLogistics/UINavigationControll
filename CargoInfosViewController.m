//
//  CargoInfosViewController.m
//  龙巧物流
//
//  Created by 叶龙 on 16/4/2.
//  Copyright © 2016年 叶龙. All rights reserved.
//

#import "CargoInfosViewController.h"
#import "CargoInfoDetailViewController.h"
#import "MJRefresh.h"


@interface CargoInfosViewController ()
//@property(nonatomic,strong)UITableView *cargoInfosTableView;
@property(nonatomic,copy)NSMutableArray *dataList;
//声明一个块函数
@property(copy,nonatomic)void (^customBlock)(void);
//定义一个SEL
@property (assign,nonatomic)SEL methodPoint ;


@end

@implementation CargoInfosViewController


//初始化数组 self.dataList
-(NSMutableArray *)dataList{
    if (_dataList == nil) {
        _dataList = [NSMutableArray array];
        for (int i = 0; i < 13; i++) {
            NSString *str = [NSString stringWithFormat:@"%d.jpg",i];
            [_dataList addObject:str];
        }
    }
    return _dataList;
}
-(void)loadNewData{
    
    //加载之前打印出原始数据
    NSLog(@"load 加载之前 %@",self.dataList);
    //模拟加载数据
    for (int i = 0; i < 5; i++) {
        NSString *str = [NSString stringWithFormat:@"%d.jpg",i];

        [self.dataList insertObject:str atIndex:0];
     
    }
    //加载之后打印出原始数据
    NSLog(@"load 加载之后%@",self.dataList);
    
   // NSMutableURLRequest
    [self.tableView reloadData];
    
    [self.tableView.mj_header endRefreshing];
}

-(void) loadMoreData {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        for (int i = 0; i < 5; i++) {
            NSString *str = [NSString stringWithFormat:@"%d.jpg",i];

            [self.dataList addObject:str];
        }
        NSLog(@" loadMoreData  datalist的个数为:%lu",self.dataList.count);

        [self.tableView reloadData];
        
        [self.tableView.mj_footer endRefreshing];
    });
}

-(void)addRoad{
    NSLog(@"roads......");
}
- (void)viewWillAppear:(BOOL)animated{
    //self.navigationController.navigationBar. 设置导航栏的颜色
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:72/255.0 alpha:1];
    //60/225.0,61/255.0,105/255.0,1
    UIColor *titleColor = [UIColor whiteColor];
    NSDictionary * dict=[NSDictionary dictionaryWithObject:titleColor forKey:NSForegroundColorAttributeName];
    //dict setValue:<#(nullable id)#> forKey:<#(nonnull NSString *)#>
    self.navigationController.navigationBar.titleTextAttributes = dict;
    
    
}
- (void)viewDidLoad {
    //设置块函数的
    self.customBlock = ^{
        NSLog(@"这是自己定义的函数");
    };
    self.customBlock();
    //设置SEL
    self.methodPoint = _cmd;
    NSString *selName = NSStringFromSelector(self.methodPoint);
    NSLog(@"%@",selName);
    //设置全局并行队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //异步执行
    //任务一
//    dispatch_async(queue, ^{
//        for(int i = 0 ;i < 1000;i++){
//            NSLog(@"task1---%d-----%@",i,[NSThread currentThread]);
//        }
//    });
//    //任务二
//    dispatch_async(queue, ^{
//        for (int j = 0; j < 1000; j++) {
//            NSLog(@"task2---%d------%@",j,[NSThread currentThread]);
//        }
//    });
    //任务三 ，执行完成后返回主线程
    dispatch_async(queue, ^{
        
        //返回主线
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"返回主线程----%@",[NSThread currentThread]);
        });
    });
    self.title = @"货源消息";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"增加线路" style:UIBarButtonItemStylePlain target:self action:@selector(addRoad)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor colorWithRed:247/255.0 green:181/255.0 blue:0/255.0 alpha:1];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    //self.tableView.rowHeight = 100;
    self.tableView.sectionIndexColor = [UIColor blueColor];
    self.tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    //self.tableView.style = UITableViewStyleGrouped;
    //--------mjrefresh 开始-------------
    [self.navigationController.navigationBar setBackgroundColor:[UIColor clearColor]];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //这里是模拟代码,模拟从网络获取数据的时间差
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self loadNewData];
            
        });
    }];
    
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    // 设置了底部inset
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 30, 0);
    // 忽略掉底部inset
    self.tableView.mj_footer.ignoredScrollViewContentInsetBottom = 30;
    //--------mjrefresh 结束-------------
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
////设置section的index
//-(NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
//    NSMutableArray *arr = [NSMutableArray array];
//    [arr addObject:@""];
//    [arr addObject:@""];
//    [arr addObject:@""];
//    return arr;
//}

//设置section的数量
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;{
    return 1 ;
}
//- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    switch (section) {
//        case 0:
//            return @"";
//            break;
//        case 1:
//            return @"";
//            break;
//        case 2:
//            return @"";
//            break;
//        default:
//            return @"";
//            break;
//    }
//}
//- (nullable NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
//    switch (section) {
//        case 0:
//           return @"";
//            break;
//            case 1:
//            return @"";
//            break;
//            case 2:
//            return @"";
//            break;
//        default:
//            return @"";
//            break;
//    }
//}
//每个section段的cell数量
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataList.count;
    
}
// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //为每一个图片设置一个缓存名称
    NSString *highPerformanceFlag = [NSString stringWithFormat:@"highPerformanceFlag%@",self.dataList[indexPath.row]];
    NSLog(@"第%lu个cell缓存名称为:%@",indexPath.row,self.dataList[indexPath.row]);
    //初始化时使用高性能的initWithStyle:(UITableViewCellStyle) reuseIdentifier:(NSString *)的方法将cell放入到缓冲池中
    //1 先判断缓冲池是否具有identifier对象的cell对象
    UITableViewCell *tc = [tableView dequeueReusableCellWithIdentifier:highPerformanceFlag];
    if (tc == nil) {
        NSLog(@"真的被刷新了 %lu",indexPath.row);
        tc = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:highPerformanceFlag];
      
        tc.textLabel.text = [self.dataList objectAtIndex:indexPath.row];
        tc.imageView.image = [UIImage imageNamed:[self.dataList objectAtIndex:indexPath.row]];
        //tc.imageView.transform = CGAffineTransformScale(tc.imageView.transform, 2.0, 2.0);
        tc.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return tc;
}
//单击触发的方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CargoInfoDetailViewController *cidvc = [[CargoInfoDetailViewController alloc]init];
    cidvc.imageName = [self.dataList objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:cidvc animated:NO];
}

//单元格cell编辑  列如增加 左划删除
- (nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(8_0) __TVOS_PROHIBITED{
    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"带走这个美女" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        //NSString *beautyName = [_dataList objectAtIndex:indexPath.row];
        [_dataList removeObjectAtIndex:indexPath.row];
        NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
        [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
        [self.tableView reloadData];
    }];
    return [NSArray arrayWithObject:deleteRowAction];
}
/*}
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


@end
