//
//  DiscoverVC.m
//  Cavemen
//
//  Created by Leonid Peancovschi on 4/8/14.
//  Copyright (c) 2014 Endava. All rights reserved.
//

#import "DiscoverVC.h"

@interface DiscoverVC ()

@end

@implementation DiscoverVC {

    CBCentralManager *_centralManager;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    _centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil options:nil];
}

#pragma mark CBDelegate

- (void)centralManagerDidUpdateState:(CBCentralManager *)central {

    
}

@end
