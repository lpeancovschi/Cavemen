//
//  LoginViewController.m
//  Cavemen
//
//  Created by Alex Maimescu on 4/12/14.
//  Copyright (c) 2014 Endava. All rights reserved.
//

#import "LoginViewController.h"
#import <MBProgressHUD.h>
#import "GodClient.h"
#import "CurrentPerson.h"
#import "PersonModel.h"

#define kOFFSET_FOR_KEYBOARD 80.0

@interface LoginViewController ()  <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *endavaLogo;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.title = @"Authentication";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.usernameTextField.delegate = self;
    self.usernameTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.passwordTextField.delegate = self;
    self.passwordTextField.autocorrectionType = UITextAutocorrectionTypeNo;
}

- (void)viewWillAppear:(BOOL)animated
{
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    // unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}

#pragma - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.passwordTextField) {
        
        [textField resignFirstResponder];
    }
    else if (textField == self.usernameTextField) {
        
        [self.passwordTextField becomeFirstResponder];
    }
    
    return YES;
}

- (IBAction)didPressLoginButton:(id)sender
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Loading...";
    
    GodClient *godClient = [GodClient sharedInstance];
    
    [godClient getPersonWithFirstName:self.usernameTextField.text successBlock:^(PersonModel *personModel){
    
        CurrentPerson *currentPerson = [CurrentPerson sharedInstance];
        
        currentPerson.firstName = personModel.firstName;
        currentPerson.lastName = personModel.lastName;
        currentPerson.jobTitle = personModel.jobTitle;
        currentPerson.photoURI = personModel.photoURI;
        currentPerson.projects = personModel.projects;
        currentPerson.tableToken = personModel.tableToken;
        
        [godClient bookTableWithToken:@"15" successBlock:^(){
        
            NSLog(@"table 1 has been booked");
        } failureBlock:^(PersonModel *tableOwner){
        
            NSLog(@"table 1 is occupied by %@", tableOwner.firstName);
        }];

//        [godClient unsubscribeFromCurrentWithSuccessBlock:^(){} failureBlock:^(){}];
        
        [hud hide:YES];
        
        if ([self.delegate respondsToSelector:@selector(didLoginWithUsername:)]) {
            [self.delegate didLoginWithUsername:self.usernameTextField.text];
        }
    } failureBlock:^(NSString *errorMsg){
        
        NSLog(@"%@", errorMsg);
        [hud hide:YES];
    }];
}

#pragma mark - Keyboard Callbacks

- (void)keyboardWillShow
{
    // Animate the current view out of the way
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}

- (void)keyboardWillHide
{
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}

- (void)setViewMovedUp:(BOOL)movedUp
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3]; // if you want to slide up the view
    
    CGRect rect = self.view.frame;
    if (movedUp)
    {
        rect.origin.y -= kOFFSET_FOR_KEYBOARD;
        rect.size.height += kOFFSET_FOR_KEYBOARD;
    }
    else
    {
        rect.origin.y += kOFFSET_FOR_KEYBOARD;
        rect.size.height -= kOFFSET_FOR_KEYBOARD;
    }
    self.view.frame = rect;
    
    [UIView commitAnimations];
}

@end
