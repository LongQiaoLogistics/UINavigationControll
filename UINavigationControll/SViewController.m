//
//  SViewController.m
//  UINavigationControll
//
//  Created by 叶龙 on 16/3/11.
//  Copyright © 2016年 叶龙. All rights reserved.
//

#import "SViewController.h"

@interface SViewController ()

@end

@implementation SViewController

- (void)viewDidLoad {
    self.navigationController.toolbarHidden=NO;
    [self.navigationController.toolbar setBarStyle:UIBarStyleBlack];
    self.navigationController.navigationBarHidden=NO;
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    self.navigationController.navigationBar.backgroundColor = [UIColor blackColor];
    UIBarButtonItem *btn1=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:nil];
    UIBarButtonItem *btn2=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:nil];
    UIBarButtonItem *btn3=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:nil];
    UIBarButtonItem *btn4=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    NSArray *arr1=[[NSArray alloc]initWithObjects:btn4,btn1,btn4,btn2,btn4,btn3,btn4, nil, nil];
    self.toolbarItems=arr1;
    [super viewDidLoad];
    
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
