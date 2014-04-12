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

@implementation LeftMenuDataModel

+ (NSArray *)leftMenuItems {

    NSArray *arr = @[
                     [[LeftMenuItem alloc] initWithTitle:@"My Profile" class:[UserDetailsViewControlelr class]],
                     [[LeftMenuItem alloc] initWithTitle:@"Check Table" class:[DiscoverVC class]]
                     ];
    
    return arr;
}

@end
