//
//  LeftMenuDataModel.m
//  Cavemen
//
//  Created by Leonid Peancovschi on 4/8/14.
//  Copyright (c) 2014 Endava. All rights reserved.
//

#import "LeftMenuDataModel.h"
#import "LeftMenuItem.h"
#import "DiscoverVC.h"
#import "UserDetailsViewControlelr.h"
#import "ResultsViewController.h"

@implementation LeftMenuDataModel

+ (NSArray *)leftMenuItems {

    NSArray *arr = @[
                     [[LeftMenuItem alloc] initWithTitle:@"My Profile" class:[UserDetailsViewControlelr class]],
                     [[LeftMenuItem alloc] initWithTitle:@"Check Table" class:[DiscoverVC class]],
                     [[LeftMenuItem alloc] initWithTitle:@"Your Zone Award" class:[ResultsViewController class]],
                     [[LeftMenuItem alloc] initWithTitle:@"EnSport" class:[ResultsViewController class]],
                     [[LeftMenuItem alloc] initWithTitle:@"EnCoach" class:[ResultsViewController class]]
                     ];
    
    return arr;
}

@end
