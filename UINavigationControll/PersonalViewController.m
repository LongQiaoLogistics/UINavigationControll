//
//  PersonalViewController.m
//  龙巧物流
//
//  Created by 叶龙 on 16/3/14.
//  Copyright © 2016年 叶龙. All rights reserved.
//

#import "PersonalViewController.h"
#import "SViewController.h"
#import "SendCargoViewController.h"

@interface PersonalViewController ()
@property(nonatomic,strong)UILabel *titleInfo;
@property(nonatomic,strong)UIButton *loginButton;
@property(nonatomic,strong)UILabel *usernameLabel;
@property(nonatomic,strong)UILabel *passwordLabel;
@property(nonatomic,strong)UITextField *usernameField;
@property(nonatomic,strong)UITextField *passwordField;
@property(nonatomic,strong)UILabel *infos;
@property(nonatomic,strong)UIImageView *weixinImageLogin;
@property(nonatomic,strong)UIImageView *sinaImageLogin;
@property(nonatomic,strong)UIImageView *qqImageLogin;
@property(nonatomic,strong)UILabel *thirdLoginInfo;
@property(nonatomic,strong)UILabel *questionLogin;
@property(nonatomic,strong)MFMessageComposeViewController *smsController;
@property(nonatomic,strong)UIImageView *imageView;
@end

@implementation PersonalViewController


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
//通过添加点击手势 来关闭键盘
-(void)closeKey:(UITapGestureRecognizer*)gestureRecognizer{
    [self.view endEditing:YES];
}

-(IBAction)right:(id)sender{
    NSLog(@"zhuce");
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
//    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
//    [self.view addSubview:_imageView];
//    
//    //http://7xow65.com1.z0.glb.clouddn.com/wp-content/uploads/2016/03/QQ20160310-7@2x.png
//    NSString *str = @"http://img1.mm131.com/pic/2207/4.jpg";
//    NSURL *url = [NSURL URLWithString:str];
//    NSData *imageData = [NSData dataWithContentsOfURL:url];
//    UIImage *image = [UIImage imageWithData:imageData];
//    self.imageView.image = image;
    
    
    
    self.title = @"登录龙巧物流";
    //self.navigationItem.prompt = @"ddddd";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"注册" style:UIBarButtonItemStylePlain target:self action:@selector(right:)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor colorWithRed:247/255.0 green:181/255.0 blue:0/255.0 alpha:1];
        //self.navigationController.navigationBar.barStyle =UIBarStyleBlack; R247 G181 B0
    
    //底部工具栏
    
    //注册一个手势事件 来关闭键盘 通过设置交互为yes来开启手势交互
    self.view.userInteractionEnabled = YES;
    //点击手势
    UITapGestureRecognizer *utgr = [[UITapGestureRecognizer alloc]initWithTarget:self  action:@selector(closeKey:)];
    [self.view addGestureRecognizer:utgr];
    
    
    CGFloat width = self.view.bounds.size.width;
    CGFloat height = self.view.bounds.size.height;
    
    //title
    self.titleInfo = [[UILabel alloc]initWithFrame:CGRectMake(width/10, height/8, width*4/5, height/12)];
    self.titleInfo.text = @"请使用手机号登录";
    self.titleInfo.textAlignment  = NSTextAlignmentCenter;
    [self.view addSubview:self.titleInfo];
    
    
    //设置登陆按钮
    self.loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.loginButton.layer setMasksToBounds:YES];
    [self.loginButton.layer setCornerRadius:5];
    [self.loginButton.layer setBorderWidth:1];
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 247/225.0,181/255.0,0/255.0,1}); //7CCD7C  11001110 60/225.0,61/255.0,105/255.0,1   R247 G181 B0
    [self.loginButton.layer setBorderColor:colorref];
    [self.loginButton setTitle:@"登录" forState:UIControlStateNormal];
    self.loginButton.titleLabel.font = [UIFont systemFontOfSize:13];
    // self.loginButton.showsTouchWhenHighlighted = YES;
    [self.loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];//title color
    self.loginButton.backgroundColor = [UIColor colorWithCGColor:colorref];
    self.loginButton.frame = CGRectMake(width/10,height/2, width/10*8, height/18);
    [self.loginButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    
    //questionLogin
    self.questionLogin = [[UILabel alloc]initWithFrame:CGRectMake(0, height/2+height/9, width, height/24)];
    self.questionLogin.text = @"登录遇到问题?";
    self.questionLogin.font = [UIFont systemFontOfSize:10];
    self.questionLogin.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.questionLogin];
    
    [self.view addSubview:self.loginButton];
    //初始化usernamelabel
    self.usernameLabel = [[UILabel alloc]initWithFrame:CGRectMake(width/10,height/4, width/10*3, height/18)];
    self.usernameLabel.text = @"手机号";
    self.usernameLabel.font = [UIFont systemFontOfSize:15];
    //    C4C4C4   11000100  128+64+4 C4C4C4 196
    CAShapeLayer *userNameSolidShapeLayer = [CAShapeLayer layer];
    CGMutablePathRef userNameSolidShapePath =  CGPathCreateMutable();
    [userNameSolidShapeLayer setFillColor:[[UIColor clearColor] CGColor]];
    [userNameSolidShapeLayer setStrokeColor:[[UIColor colorWithRed:196/250.0 green:196/250.0 blue:196/250.0 alpha:1.0] CGColor]];
    userNameSolidShapeLayer.lineWidth = 0.5f ;
    CGPathMoveToPoint(userNameSolidShapePath, NULL, width/10, height/4+height/18);
    CGPathAddLineToPoint(userNameSolidShapePath, NULL, width*9/10,height/4+height/18);
    //CGPathAddLineToPoint(solidShapePath, NULL, 300,50);
    [userNameSolidShapeLayer setPath:userNameSolidShapePath];
    CGPathRelease(userNameSolidShapePath);
    [self.view.layer addSublayer:userNameSolidShapeLayer];
    
    
    
    
    
    
    //    self.usernameLabel.backgroundColor = [UIColor orangeColor];
    self.passwordLabel = [[UILabel alloc]initWithFrame:CGRectMake(width/10,height*3/8, width/10*3, height/18)];
    self.passwordLabel.text = @"密码";
    self.usernameField = [[UITextField alloc]initWithFrame:CGRectMake(width/2-width/5, height/4, width*3/5, height/18)];
    self.passwordLabel.font = [UIFont systemFontOfSize:15];
    self.passwordField.placeholder = @"请填写密码";
    self.usernameField.placeholder = @"请填写手机号码";
    self.usernameField.font = [UIFont systemFontOfSize:13];
    // self.usernameField.textAlignment = NSTextAlignmentCenter;
    self.usernameField.borderStyle = UITextBorderStyleNone;
    
    
    //    C4C4C4   11000100  128+64+4 C4C4C4 196
    CAShapeLayer *passwordSolidShapeLayer = [CAShapeLayer layer];
    CGMutablePathRef passwordSolidShapePath =  CGPathCreateMutable();
    [passwordSolidShapeLayer setFillColor:[[UIColor clearColor] CGColor]];
    [passwordSolidShapeLayer setStrokeColor:[[UIColor colorWithRed:196/250.0 green:196/250.0 blue:196/250.0 alpha:1.0] CGColor]];
    passwordSolidShapeLayer.lineWidth = 0.5f ;
    CGPathMoveToPoint(passwordSolidShapePath, NULL, width/10, height*3/8+height/18);
    CGPathAddLineToPoint(passwordSolidShapePath, NULL, width*9/10,height*3/8+height/18);
    //CGPathAddLineToPoint(solidShapePath, NULL, 300,50);
    [passwordSolidShapeLayer setPath:passwordSolidShapePath];
    CGPathRelease(passwordSolidShapePath);
    [self.view.layer addSublayer:passwordSolidShapeLayer];
    
    //设置代理
    self.usernameField.delegate = self;
    //  self.usernameField.keyboardType = UIKeyboardTypeDefault;
    
    //    self.usernameField.backgroundColor = [UIColor greenColor];
    self.passwordField = [[UITextField alloc]initWithFrame:CGRectMake(width/2-width/5, height*3/8, width*3/5, height/18)];
    self.passwordField.borderStyle = UITextBorderStyleNone;
    
    self.passwordField.secureTextEntry = YES;
    self.passwordField.delegate = self;
    [self.view addSubview:self.usernameField];
    [self.view addSubview:self.passwordField];
    
    
    [self.view addSubview:self.usernameLabel];
    [self.view addSubview:self.passwordLabel];
    
    self.infos = [[UILabel alloc]initWithFrame:CGRectMake(width/10, height*11/12, width*4/5, height/12)];
    self.infos.text = @"Copyright@上海龙巧物流 2016.creator author(叶龙)";
    self.infos.font = [UIFont systemFontOfSize:10];
    [self.view addSubview:self.infos];
    
    
    
    //---------------weixinimagelogin----------------------
    UIImage *wximage = [UIImage imageNamed:@"weixin.png"];
    self.weixinImageLogin = [[UIImageView alloc]initWithImage:wximage];
    self.weixinImageLogin.frame = CGRectMake(width/15*3, height/2+height/4, width/10,width/10);
    [self.view addSubview:self.weixinImageLogin];
    
    //---------------sinaimagelogin----------------------
    UIImage *sinaImage = [UIImage imageNamed:@"sina.png"];
    self.sinaImageLogin = [[UIImageView alloc]initWithImage:sinaImage];
    self.sinaImageLogin.frame = CGRectMake(width/15*7, height/2+height/4, width/10 ,width/10);
    [self.view addSubview:self.sinaImageLogin];
    
    
    //---------------qqimagelogin----------------------
    UIImage *qqImage = [UIImage imageNamed:@"qq.png"];
    self.qqImageLogin = [[UIImageView alloc]initWithImage:qqImage];
    self.qqImageLogin.frame = CGRectMake(width/15*11, height/2+height/4, width/10 ,width/10);
    [self.view addSubview:self.qqImageLogin];
    
    /*
     *画实线
     */
    CAShapeLayer *solidShapeLayer = [CAShapeLayer layer];
    CGMutablePathRef solidShapePath =  CGPathCreateMutable();
    [solidShapeLayer setFillColor:[[UIColor clearColor] CGColor]];
    [solidShapeLayer setStrokeColor:[[UIColor blackColor] CGColor]];
    solidShapeLayer.lineWidth = 1.0f ;
    CGPathMoveToPoint(solidShapePath, NULL, width/10, 400);
    CGPathAddLineToPoint(solidShapePath, NULL, width*3/10,400);
    //CGPathAddLineToPoint(solidShapePath, NULL, 300,50);
    [solidShapeLayer setPath:solidShapePath];
    CGPathRelease(solidShapePath);
    [self.view.layer addSublayer:solidShapeLayer];
    
    self.thirdLoginInfo = [[UILabel alloc]initWithFrame:CGRectMake(width*3/10,400-height/48, width*2/5, height/24)];
    self.thirdLoginInfo.text = @"使用第三方账号登陆";
    self.thirdLoginInfo.font = [UIFont systemFontOfSize:10];
    self.thirdLoginInfo.textAlignment = NSTextAlignmentCenter;
    //    self.thirdLoginInfo.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:self.thirdLoginInfo];
    
    
    CAShapeLayer *solidShapeLayer1 = [CAShapeLayer layer];
    CGMutablePathRef solidShapePath1 =  CGPathCreateMutable();
    [solidShapeLayer1 setFillColor:[[UIColor clearColor] CGColor]];
    [solidShapeLayer1 setStrokeColor:[[UIColor blackColor] CGColor]];
    solidShapeLayer1.lineWidth = 1.0f ;
    CGPathMoveToPoint(solidShapePath1, NULL, width*7/10, 400);
    CGPathAddLineToPoint(solidShapePath1, NULL, width*9/10,400);
    //CGPathAddLineToPoint(solidShapePath, NULL, 300,50);
    [solidShapeLayer1 setPath:solidShapePath1];
    CGPathRelease(solidShapePath1);
    [self.view.layer addSublayer:solidShapeLayer1];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)sendSms{
    //发送信息
    self.smsController = [[MFMessageComposeViewController alloc]init];
    self.smsController.recipients = @[@"15151019892"];
    self.smsController.subject = @"sms 祝福消息";
    self.smsController.body = @"你好 xcode向你发送祝福信息 祝你新年快乐";
    [self presentViewController:self.smsController animated:YES completion:nil];
    self.smsController.messageComposeDelegate = self;
    //发送消息结束
}
-(void)login{
   
    //创建全局并行队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //创建串行队列
    dispatch_queue_t serialQueue = dispatch_queue_create("longqiaoApp", nil);
    
    
    //异步执行
    dispatch_async(queue, ^{
        for (int i = 0; i < 10; i++) {
            NSLog(@"task1 is %d",i);
        }
    
    });
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 10; i++) {
            NSLog(@"task2 is %d",i);
        }
        
    });
    
    SendCargoViewController *sc = [[SendCargoViewController alloc]init];
    
    [self.navigationController pushViewController:sc animated:YES];
    
    
}
-(IBAction)login:(id)sender{
    SViewController *svc = [[SViewController alloc]init];
    svc.view.backgroundColor = [UIColor purpleColor];
    //navigatonControll的属性是UIVIEWCONTROLL的一个属性 ,他判断当前navigationCtroller是否有对象被他控制 ，我们在appdelegate中初始化viewcontroll被他控制
    //如果navigationControll不为空 ，这将sviewcontroller对象压倒navigationcontroll中  这是一个栈的结构
    [self.navigationController pushViewController:svc animated:YES];
    //self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    
    
}
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
    if (result == MessageComposeResultSent) {
        NSLog(@"发送成功");
    }else if(result ==  MessageComposeResultCancelled){
        NSLog(@"取消发送");
    }else if(result == MessageComposeResultFailed){
        NSLog(@"发送失败");
    }
    
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
