//
//  AppDelegate.m
//  Cavemen
//
//  Created by Leonid on 4/4/14.
//  Copyright (c) 2014 Endava. All rights reserved.
//

#import "AppDelegate.h"
#import <MMDrawerController/MMDrawerController.h>
#import "LeftMenuVC.h"
#import "LoginViewController.h"
#import "UserDetailsViewControlelr.h"

@interface AppDelegate () <LoginViewControllerDelegate>

@property (nonatomic) MMDrawerController *drawer;
@property (nonatomic) LoginViewController *loginVC;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    LeftMenuVC *leftMenu = [[LeftMenuVC alloc] init];
    
    UserDetailsViewControlelr *myProfileVC = [[UserDetailsViewControlelr  alloc] init];
    UINavigationController *centerNav = [[UINavigationController alloc] initWithRootViewController:myProfileVC];
    
    self.loginVC = [[LoginViewController alloc] init];
    self.loginVC.delegate = self;
    
    self.drawer = [[MMDrawerController alloc] initWithCenterViewController:centerNav leftDrawerViewController:leftMenu];
    [self.drawer setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [self.drawer setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:self.loginVC];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)didLoginWithUsername:(NSString *)username
{
    NSLog(@"Username %@", username);
    
    [UIView transitionFromView:self.window.rootViewController.view
                        toView:self.drawer.view
                      duration:0.5
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    completion:^(BOOL finished)
     {
         self.window.rootViewController = self.drawer;
     }];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
