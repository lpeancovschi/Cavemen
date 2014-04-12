//
//  DiscoverVC.m
//  Cavemen
//
//  Created by Leonid Peancovschi on 4/8/14.
//  Copyright (c) 2014 Endava. All rights reserved.
//

#import "DiscoverVC.h"

#define BEACON_IDENTIFIER_TABLE     @"cavemen.beacon"

#define BEACON_REGION_PROXIMITY_UUID @"3AB1650D-20BD-4DCE-8AE2-B2B6D67FE109"

@interface DiscoverVC ()

@end

@implementation DiscoverVC {

    CLLocationManager *_locationManager;
    CLBeaconRegion *_beaconRegionEndavaDUTable;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    
    // DU UUID
    NSUUID *beaconRegionEndavaDUUUID = [[NSUUID alloc] initWithUUIDString:BEACON_REGION_PROXIMITY_UUID];
    
    _beaconRegionEndavaDUTable = [[CLBeaconRegion alloc] initWithProximityUUID:beaconRegionEndavaDUUUID identifier:BEACON_IDENTIFIER_TABLE];
    _beaconRegionEndavaDUTable.notifyEntryStateOnDisplay = YES;
    
    [_locationManager startMonitoringForRegion:_beaconRegionEndavaDUTable];
    [self locationManager:_locationManager didStartMonitoringForRegion:_beaconRegionEndavaDUTable];
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region
{
    [_locationManager startRangingBeaconsInRegion:(CLBeaconRegion *)region];
}

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region
{
    [manager startRangingBeaconsInRegion:(CLBeaconRegion *)region];
    NSLog(@"did enter region %@", region);
}

- (void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region
{
    NSLog(@"Region type: %@", region.identifier);
    
    if ([beacons count] > 0) {
        
        CLBeacon *nearestExhibit = [beacons firstObject];
        NSLog(@"Did range beacon. Accuracy = %f meters, rssi: %ld, major: %@, minor: %@", nearestExhibit.accuracy, nearestExhibit.rssi, nearestExhibit.major, nearestExhibit.minor);
    }
}

- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region
{
    [manager stopRangingBeaconsInRegion:(CLBeaconRegion *)region];
    NSLog(@"Did exit region");
}

- (void)locationManager:(CLLocationManager *)manager didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region
{
    NSLog(@"Did determine state for region");
}

@end
