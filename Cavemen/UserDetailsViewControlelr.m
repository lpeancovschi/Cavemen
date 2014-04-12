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

@interface UserDetailsViewControlelr ()

@property (nonatomic, weak) IBOutlet UIImageView *photoImageView;
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *jobTitleLable;
@property (nonatomic, weak) IBOutlet UILabel *tableTokenLabel;

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
    
    self.tableTokenLabel.text = @"Table is not assigned";
    
    [self.photoImageView setImageWithURL:[NSURL URLWithString:_personModel.photoURI] placeholderImage:[UIImage imageNamed:@"photoPlaceholder"]];
    self.nameLabel.text = [NSString stringWithFormat:@"%@ %@", _personModel.firstName, _personModel.lastName];
    self.jobTitleLable.text = _personModel.jobTitle;
    
    if (_personModel.tableToken) {
        self.tableTokenLabel.text = _personModel.tableToken;
    }
}

- (IBAction)didPressChangeTableButton:(id)sender
{
    DiscoverVC *discoveryVC = [[DiscoverVC alloc] init];
    
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:discoveryVC] animated:YES completion:^{
        
    }];
}

@end
