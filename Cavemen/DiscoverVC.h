//
//  DiscoverVC.h
//  Cavemen
//
//  Created by Leonid Peancovschi on 4/8/14.
//  Copyright (c) 2014 Endava. All rights reserved.
//

#import "BaseVC.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import <CoreLocation/CoreLocation.h>

@interface DiscoverVC : BaseVC <CBCentralManagerDelegate, CLLocationManagerDelegate>

@end
