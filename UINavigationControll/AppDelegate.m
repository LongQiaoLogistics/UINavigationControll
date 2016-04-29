//
//  AppDelegate.m
//  UINavigationControll
//
//  Created by 叶龙 on 16/3/11.
//  Copyright © 2016年 叶龙. All rights reserved.
//

#import "AppDelegate.h"
#import "PersonalViewController.h"
#import "SendCargoViewController.h"
#import "FindCargoViewController.h"
#import "CargoInfosViewController.h"

@interface AppDelegate ()

@end


@implementation AppDelegate

const static NSString *cargoMessage = @"货源消息";
/**
 *  <#Description#>
 *
 *  @param application   <#application description#>
 *  @param launchOptions <#launchOptions description#>
 *
 *  @return <#return value description#>
 */
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    UIScreen *screnn = [UIScreen mainScreen];
    self.window = [[UIWindow alloc]initWithFrame:screnn.bounds];
    
    //设置UITabBarController 作为rootViewController
    UITabBarController  *tbc = [[UITabBarController alloc]init];
    /**
     1、控制器跳转
     
     导航控制器的定义中，提供了Push与Pop的方法，来实现子控制器之间的跳转，其中：Push对应入栈操作，Pop对应出栈操作。
     
     - (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated; // 入栈操作，显示新的子控制器
     
     - (nullable UIViewController *)popViewControllerAnimated:(BOOL)animated;//出栈操作，显示栈顶的控制器
     - (nullable NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated; // 出栈操作，显示指定的控制器
     - (nullable NSArray *)popToRootViewControllerAnimated:(BOOL)animated; // 出栈操作，显示导航控制器的根控制器
     
     2、管理子控制器
     
     导航控制器对象中提供了属性，用于管理该导航控制器下的所有子控制器。
     
     @property(nonatomic,copy) NSArray *viewControllers;//存放本导航控制器管理的所有子控制器
     @property(nullable, nonatomic,readonly,strong) UIViewController *topViewController;//获取栈顶控制器
     
     
     */
    //导航试图用于导航个人中心
    PersonalViewController *pvc = [[PersonalViewController alloc]init];
    pvc.view.backgroundColor = [UIColor whiteColor];
    UINavigationController *unc = [[UINavigationController alloc]initWithRootViewController:pvc];
    //尺寸，UITabBarItem有图片icon也有文字，图片是50*50
    UITabBarItem *personTabBarItem = [[UITabBarItem alloc]initWithTitle:@"个人中心" image:nil selectedImage:nil];
    unc.tabBarItem = personTabBarItem;
    
    //货源消息控制器
    CargoInfosViewController *civc = [[CargoInfosViewController alloc]init];
    UINavigationController *cargoInfosDefineUserNav = [[UINavigationController alloc]initWithRootViewController:civc];
    UITabBarItem *cargoInfosTabBarItem = [[UITabBarItem alloc]initWithTitle:cargoMessage image:nil selectedImage:nil];
    cargoInfosDefineUserNav.tabBarItem = cargoInfosTabBarItem;
    
    //发货视图控制器
    SendCargoViewController *scvc = [[SendCargoViewController alloc]init];
    UIImage *sendCargoImage = [[UIImage imageNamed:@"home.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *sendCargoImageSelect = [[UIImage imageNamed:@"user1.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UITabBarItem *sendCargoTabBarItem = [[UITabBarItem alloc]initWithTitle:@"发货" image:nil selectedImage:nil];
    scvc.tabBarItem = sendCargoTabBarItem;
    scvc.view.backgroundColor = [UIColor orangeColor];
    
    //找货视图控制器
    FindCargoViewController *fcvc = [[FindCargoViewController alloc]init];
    UITabBarItem *findCargoTabBarItem = [[UITabBarItem alloc]initWithTitle:@"货源信息" image:nil selectedImage:nil];
    fcvc.tabBarItem = findCargoTabBarItem;
    fcvc.view.backgroundColor = [UIColor blackColor];
    
    //将几个视图控制器装在到标签控制器中
    NSArray *viewControlls = [[NSMutableArray alloc]initWithObjects:scvc,fcvc,cargoInfosDefineUserNav,unc, nil];
    tbc.viewControllers = viewControlls;
    
    //设置标签控制器 赋值给 window.rootViewController
    self.window.rootViewController = tbc;
    [self.window makeKeyAndVisible];
    
    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.longqiao.UINavigationControll" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"UINavigationControll" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"UINavigationControll.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
