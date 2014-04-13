//
//  TempInfoViewControlelrViewController.m
//  Cavemen
//
//  Created by Alex Maimescu on 4/12/14.
//  Copyright (c) 2014 Endava. All rights reserved.
//

#import "TempInfoViewControlelrViewController.h"
#import <MBProgressHUD/MBProgressHUD.h>

@interface TempInfoViewControlelrViewController ()

@end

@implementation TempInfoViewControlelrViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.title = @"Scan Beacon Tag";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Scanning...";
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancel)];
    
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    self.navigationItem.leftBarButtonItem = cancelButton;
}

- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:^{
        
        NSLog(@"Did press cancel");
    }];
}

@end
