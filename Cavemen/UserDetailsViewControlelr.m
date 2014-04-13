//
//  UserDetailsViewControlelr.m
//  Cavemen
//
//  Created by Alex Maimescu on 4/12/14.
//  Copyright (c) 2014 Endava. All rights reserved.
//

#import "UserDetailsViewControlelr.h"
#import "DiscoverVC.h"
#import <AFNetworking/UIImageView+AFNetworking.h>
#import "PersonModel.h"
#import "CurrentPerson.h"
#import <QuartzCore/QuartzCore.h>
#import "GodClient.h"
#import <UIViewController+MMDrawerController.h>

@interface UserDetailsViewControlelr ()

@property (nonatomic, weak) IBOutlet UIImageView *photoImageView;
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *jobTitleLable;
@property (nonatomic, weak) IBOutlet UILabel *tableTokenLabel;
@property (weak, nonatomic) IBOutlet UIButton *relocateButton;
@property (weak, nonatomic) IBOutlet UIButton *freeCurrentTableButton;
@property (weak, nonatomic) IBOutlet UIView *employeeTableWidget;

@end

@implementation UserDetailsViewControlelr

- (instancetype)initWithPersonModel:(PersonModel *)person {

    if (self = [super init]) {
    
        _personModel = person;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (!self.personModel) {
    
        self.personModel = [CurrentPerson sharedInstance];
    }
    
    if (self.personQuickLook) {
        
        UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancel)];
        
        self.navigationController.navigationBar.tintColor = [UIColor blackColor];
        self.navigationItem.leftBarButtonItem = cancelButton;
        
        self.title = @"Table Owner";
        
        self.employeeTableWidget.hidden = YES;
    }
    else
    {
        self.title = @"My Profile";
        
        UIBarButtonItem *logoutButton = [[UIBarButtonItem alloc] initWithTitle:@"Log Out" style:UIBarButtonItemStyleBordered target:self action:@selector(logout)];
        
        self.navigationController.navigationBar.tintColor = [UIColor blackColor];
        self.navigationItem.rightBarButtonItem = logoutButton;
        
        UIBarButtonItem *menuItem = [[UIBarButtonItem alloc] initWithTitle:@"Menu" style:UIBarButtonItemStyleBordered target:self action:@selector(menuPressed)];
        self.navigationItem.leftBarButtonItem = menuItem;
    }
    
    self.tableTokenLabel.text = @"Table is not assigned";
}

- (void)menuPressed {

    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

- (void)updateUI {

    [self.photoImageView setImageWithURL:[NSURL URLWithString:_personModel.photoURI] placeholderImage:[UIImage imageNamed:@"photoPlaceholder"]];
    self.nameLabel.text = [NSString stringWithFormat:@"%@ %@", _personModel.firstName, _personModel.lastName];
    self.jobTitleLable.text = _personModel.jobTitle;
    
    if (_personModel.tableToken.length) {
        
        self.tableTokenLabel.text = [NSString stringWithFormat:@"Personal table ID %@", _personModel.tableToken];
    }
    else {
        
        self.tableTokenLabel.text = @"No table assigned";
    }
    
    NSLog(@"%@", self.nameLabel.text);
}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    
    [self updateUI];
}

- (void)logout
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"logout" object:self];
}

- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:^{
        
        NSLog(@"Did press cancel");
    }];
}

- (IBAction)didPressChangeTableButton:(id)sender
{
    DiscoverVC *discoveryVC = [[DiscoverVC alloc] init];
    
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:discoveryVC] animated:YES completion:^{
        
    }];
}

- (IBAction)didPressFreeCurrentTable:(id)sender
{
    [[GodClient sharedInstance] unsubscribeFromCurrentWithSuccessBlock:^{
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Cavemen"
                                                            message:@"You have successfully freed your current table"
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil, nil];
        
        [alertView show];
        
    } failureBlock:^{
        
        
    }];
}

@end
