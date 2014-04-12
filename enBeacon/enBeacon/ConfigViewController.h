//
//  ConfigViewController.h
//  iBeacons Demo
//
//  Created by M Newill on 27/09/2013.
//  Copyright (c) 2013 Mobient. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface ConfigViewController : UIViewController <CBPeripheralManagerDelegate>

@property (strong, nonatomic) CLBeaconRegion *beaconTableRegion1;
@property (strong, nonatomic) CLBeaconRegion *beaconTableRegion2;

@property (strong, nonatomic) CLBeaconRegion *beaconProjectRegion1;
@property (strong, nonatomic) CLBeaconRegion *beaconProjectRegion2;

@property (strong, nonatomic) NSDictionary *beaconPeripheralData;
@property (strong, nonatomic) CBPeripheralManager *peripheralManager;

@end
