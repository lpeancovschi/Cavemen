//
//  LeftMenuDataModel.m
//  Cavemen
//
//  Created by Leonid Peancovschi on 4/8/14.
//  Copyright (c) 2014 Endava. All rights reserved.
//

#import "LeftMenuDataModel.h"
#import "LeftMenuItem.h"
#import "MainVC.h"
#import "DiscoverVC.h"
#import "QRCodeVC.h"
#import "ConfigViewController.h"

@implementation LeftMenuDataModel

+ (NSArray *)leftMenuItems {

    NSArray *arr = @[
                     [[LeftMenuItem alloc] initWithTitle:@"Main VC" class:[MainVC class]],
                     [[LeftMenuItem alloc] initWithTitle:@"Discover VC" class:[DiscoverVC class]],
                     [[LeftMenuItem alloc] initWithTitle:@"QRCode VC" class:[QRCodeVC class]],
                     [[LeftMenuItem alloc] initWithTitle:@"Emitter VC" class:[ConfigViewController class]]
                     ];
    
    return arr;
}

@end
