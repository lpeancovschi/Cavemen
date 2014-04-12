//
//  LoginViewController.h
//  Cavemen
//
//  Created by Alex Maimescu on 4/12/14.
//  Copyright (c) 2014 Endava. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LoginViewControllerDelegate <NSObject>

- (void)didLoginWithUsername:(NSString *)username;

@end

@interface LoginViewController : UIViewController

@property (nonatomic, weak) id <LoginViewControllerDelegate> delegate;

@end
