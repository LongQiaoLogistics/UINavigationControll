//
//  SendCargoViewController.m
//  龙巧物流
//
//  Created by 叶龙 on 16/3/14.
//  Copyright © 2016年 叶龙. All rights reserved.
//

#import "SendCargoViewController.h"

@interface SendCargoViewController ()

@end

@implementation SendCargoViewController
/*
-(void)loop{
    for(int i = 1;i <= 10;i++){
        [NSThread sleepForTimeInterval:1];
        NSLog(@"%d",i);
        NSThread *t = [NSThread currentThread];
        //中断线程
        if(i == 5){
            
            [t cancel]; //线程取消后,线程依然会执行
            //[NSThread exit];  //线程退出后,线程不会继续执行
            
        }
        BOOL flag = [t isCancelled];
        NSLog(@"%d",flag);
    }
}*/
- (void)viewDidLoad {
//    //线程的使用
//   NSThread *t =[[NSThread alloc]initWithTarget:self selector:@selector(loop) object:nil];
//    [t start];
//    
//    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
