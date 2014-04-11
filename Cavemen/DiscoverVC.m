//
//  DiscoverVC.m
//  Cavemen
//
//  Created by Leonid Peancovschi on 4/8/14.
//  Copyright (c) 2014 Endava. All rights reserved.
//

#import "DiscoverVC.h"

#define TI_BLE_UUID                 @"0497BB50-9830-FCD1-B929-D6D8D513C506"

@interface DiscoverVC ()

@property (nonatomic, weak) IBOutlet UILabel *statusLabel;

@end

@implementation DiscoverVC {

    CBCentralManager *_blueToothManager;
    
    CLLocationManager *_locationManager;
    CLBeaconRegion *_beaconRegion;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    _blueToothManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil options:nil];
    
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    
    NSUUID *sendorTagUUID = [[NSUUID alloc] initWithUUIDString:TI_BLE_UUID];
    
    _beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:sendorTagUUID identifier:@"cavemen.beacon"];
    _beaconRegion.notifyEntryStateOnDisplay = YES;
    
    [_locationManager startMonitoringForRegion:_beaconRegion];
    
    self.statusLabel.text = @"Searching...";
}

#pragma mark CBDelegate

- (void)centralManagerDidUpdateState:(CBCentralManager *)central {

    if (central.state == CBCentralManagerStatePoweredOn) {
    
        [central scanForPeripheralsWithServices:nil options:nil];
    } else {
        NSLog(@"BlueTooth Low Energy not supported or is turned off");
    }
}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI {

    NSLog(@"%@ uuid = %@", peripheral.name, peripheral.identifier.UUIDString);
}

#pragma mark - Beacon code

- (void)registerBeaconRegionWithUUID:(NSUUID *)proximityUUID andIdentifier:(NSString*)identifier {
    
    // Create the beacon region to be monitored.
    CLBeaconRegion *beaconRegion = [[CLBeaconRegion alloc]
                                    initWithProximityUUID:proximityUUID
                                    identifier:identifier];
    
    // Register the beacon region with the location manager.
    [_locationManager startMonitoringForRegion:beaconRegion];
}

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region {

    NSLog(@"did enter region %@", region);
    self.statusLabel.text = @"Did enter sensor tag beacon region";
}

- (void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region {
    
    if ([beacons count] > 0) {
        CLBeacon *nearestExhibit = [beacons firstObject];
        
        self.statusLabel.text = [NSString stringWithFormat:@"Did range beacon. Accuracy = %f meters", nearestExhibit.accuracy];
        
        NSLog(@"Did range beacon. Accuracy = %f meters", nearestExhibit.accuracy);
    }
}

- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region {

    self.statusLabel.text = @"Did exit region";
    
    NSLog(@"Did exit region");
}

- (void)locationManager:(CLLocationManager *)manager didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region {

    NSLog(@"Did determine state for region");
}

@end
