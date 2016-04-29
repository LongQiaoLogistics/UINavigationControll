//
//  CargoInfoDetailViewController.m
//  龙巧物流
//
//  Created by 叶龙 on 16/4/2.
//  Copyright © 2016年 叶龙. All rights reserved.
//

#import "CargoInfoDetailViewController.h"

@interface CargoInfoDetailViewController ()

@end

@implementation CargoInfoDetailViewController

- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor redColor];
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _imageView.image = [UIImage imageNamed:_imageName];
    [self.view addSubview:_imageView];
    
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"美女" style:UIBarButtonItemStylePlain target:self action:nil];
//    self.navigationItem.leftBarButtonItem.tintColor = [UIColor colorWithRed:247/255.0 green:181/255.0 blue:0/255.0 alpha:1];

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
