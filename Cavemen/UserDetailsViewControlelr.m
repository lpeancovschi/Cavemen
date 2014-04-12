//
//  UserDetailsViewControlelr.m
//  Cavemen
//
//  Created by Alex Maimescu on 4/12/14.
//  Copyright (c) 2014 Endava. All rights reserved.
//

#import "UserDetailsViewControlelr.h"
#import "DiscoverVC.h"

@interface UserDetailsViewControlelr ()

@end

@implementation UserDetailsViewControlelr

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.title = @"My Profile";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)didPressChangeTableButton:(id)sender
{
    DiscoverVC *discoveryVC = [[DiscoverVC alloc] init];
    
    [self presentViewController:discoveryVC animated:YES completion:^{
        
    }];
}

@end
