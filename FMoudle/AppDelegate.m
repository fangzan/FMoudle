//
//  AppDelegate.m
//  FMoudle
//
//  Created by AoChen on 2019/6/11.
//  Copyright © 2019 Ac. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeProtocol.h"
#import "MeProtocol.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    // Home组件
    id <HomeProtocol> homeMoudle = [FRouter interfaceCacheModuleForProtocol:@protocol(HomeProtocol)];
    homeMoudle.paramterForHome = @"MoudleHome";
    UIViewController *homeViewController = [homeMoudle interfaceViewController];
    UINavigationController *homeNavi = [[UINavigationController alloc]initWithRootViewController:homeViewController];
    homeNavi.tabBarItem.title = @"首页";
    
    // Me组件
    id <MeProtocol>meMoudle = [FRouter interfaceCacheModuleForProtocol:@protocol(MeProtocol)];
    UIViewController *meViewConterller = meMoudle.interfaceViewController;
    UINavigationController *meNavi = [[UINavigationController alloc]initWithRootViewController:meViewConterller];
    meNavi.tabBarItem.title = @"个人";
    
    // tabbr和window
    UITabBarController *tabbarController = [[UITabBarController alloc]init];
    tabbarController.viewControllers = @[homeNavi,meNavi];
    self.window.rootViewController = tabbarController;
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
