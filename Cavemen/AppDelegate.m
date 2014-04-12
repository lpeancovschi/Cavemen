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
#import <Parse/Parse.h>
#import "GodClient.h"
#import "TableModel.h"
#import "PersonModel.h"
#import "LoginViewController.h"
#import "UserDetailsViewControlelr.h"
#import <Parse/Parse.h>
#import "GodClient.h"
#import "TableModel.h"
#import "PersonModel.h"
#import "CurrentPerson.h"
#import "ProjectModel.h"

@interface AppDelegate () <LoginViewControllerDelegate>

@property (nonatomic) MMDrawerController *drawer;
@property (nonatomic) LoginViewController *loginVC;

@end

@implementation AppDelegate {

    UserDetailsViewControlelr *_myProfileVC;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    [Parse setApplicationId:@"X7woT6Y1lWzo9LWvVGTLalqEyHueHiz10XP5iwaa"
                  clientKey:@"2nDd05km9XcNmHZShR7GZNOkpgOsOFs7CVwk7LGe"];

    LeftMenuVC *leftMenu = [[LeftMenuVC alloc] init];
    
    _myProfileVC = [[UserDetailsViewControlelr  alloc] init];
    UINavigationController *centerNav = [[UINavigationController alloc] initWithRootViewController:_myProfileVC];
    
    self.loginVC = [[LoginViewController alloc] init];
    self.loginVC.delegate = self;
    
    self.drawer = [[MMDrawerController alloc] initWithCenterViewController:centerNav leftDrawerViewController:leftMenu];
    [self.drawer setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [self.drawer setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logOut) name:@"logout" object:nil];
    
    GodClient *godClient = [GodClient sharedInstance];
//    [godClient getTableWithToken:@"1" successBlock:^(TableModel *tableModel) {
//    
//        NSLog(@"table.token = %@", tableModel.tableToken);
//        NSLog(@"table.status = %lu", tableModel.tableStatus);
//        NSLog(@"table.employees.count = %lu", (unsigned long)tableModel.employeesArray.count);
//        
//    } failureBlock:^(NSString *errorMsg){
//    
//        NSLog(@"%@", errorMsg);
//    }];
//    
//    [godClient getPersonWithFirstName:@"Leonid" successBlock:^(PersonModel *personModel) {
//        
//        NSLog(@"personModel.fName = %@", personModel.firstName);
//        NSLog(@"personModel.lastName = %@", personModel.lastName);
//        NSLog(@"person.jobTitle = %@", personModel.jobTitle);
//    } failureBlock:^(NSString *errorMsg){}];
    
//    [godClient getProjectForToken:@"1" success:^(ProjectModel *projectModel){
//    
//        NSLog(@"project.title = %@", projectModel.projectTitle);
//        NSLog(@"project.descr = %@", projectModel.projectDescription);
//    } failureBlock:^(NSString *errorMsg){
//    
//        
//    }];
    
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:self.loginVC];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)logOut
{
    [UIView transitionFromView:self.window.rootViewController.view
                        toView:self.loginVC.view
                      duration:0.5
                       options:UIViewAnimationOptionTransitionFlipFromRight
                    completion:^(BOOL finished)
     {
         self.window.rootViewController = self.loginVC;
     }];
}

- (void)didLoginWithUsername:(NSString *)username
{
    NSLog(@"Username %@", username);
    
    _myProfileVC.personModel = [CurrentPerson sharedInstance];
    
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
