//
//  ConfigViewController.m
//  iBeacons Demo
//
//  Created by M Newill on 27/09/2013.
//  Copyright (c) 2013 Mobient. All rights reserved.
//

#import "ConfigViewController.h"

@interface ConfigViewController ()

@property (weak, nonatomic) IBOutlet UIButton *beaconTable1Button;
@property (weak, nonatomic) IBOutlet UIButton *beaconTable2Button;

@property (weak, nonatomic) IBOutlet UIButton *beaconProject1Button;
@property (weak, nonatomic) IBOutlet UIButton *beaconProject2Button;

@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@end

@implementation ConfigViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self initBeacon];
    
    self.title = @"Beacon Emitter";
}

- (void)initBeacon
{
    NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:@"3AB1650D-20BD-4DCE-8AE2-B2B6D67FE109"];
    
    self.beaconTableRegion1 = [[CLBeaconRegion alloc] initWithProximityUUID:uuid
                                                                      major:1
                                                                      minor:1
                                                                 identifier:@"cavemen.beacon"];
    
    self.beaconTableRegion2 = [[CLBeaconRegion alloc] initWithProximityUUID:uuid
                                                                      major:2
                                                                      minor:1
                                                                 identifier:@"cavemen.beacon"];
    
    self.beaconProjectRegion1 = [[CLBeaconRegion alloc] initWithProximityUUID:uuid
                                                                        major:2
                                                                        minor:-1
                                                                   identifier:@"cavemen.beacon"];
    
    self.beaconProjectRegion2 = [[CLBeaconRegion alloc] initWithProximityUUID:uuid
                                                                        major:2
                                                                        minor:-2
                                                                   identifier:@"cavemen.beacon"];
}

- (IBAction)disableTransmission:(id)sender
{
    if ([self.peripheralManager isAdvertising]) {
        [self.peripheralManager stopAdvertising];
    }
    
    self.peripheralManager = nil;
    self.statusLabel.text = @"No transmission";
}

- (IBAction)transmitBeacon:(UIButton *)sender {
    
    if ([self.peripheralManager isAdvertising]) {
        [self.peripheralManager stopAdvertising];
    }

    NSLog(@"transmit table");
    
    if (sender == self.beaconTable1Button) {
        self.beaconPeripheralData = [self.beaconTableRegion1 peripheralDataWithMeasuredPower:nil];
        self.statusLabel.text = @"Table 1";
    } else if (sender == self.beaconTable2Button) {
        self.beaconPeripheralData = [self.beaconTableRegion2 peripheralDataWithMeasuredPower:nil];
        self.statusLabel.text = @"Table 2";
    }
    
    self.peripheralManager = [[CBPeripheralManager alloc] initWithDelegate:self
                                                                     queue:nil
                                                                   options:nil];
}

- (IBAction)transmitProjectBeacon:(UIButton *)sender {
    
    if ([self.peripheralManager isAdvertising]) {
        [self.peripheralManager stopAdvertising];
    }
    
    NSLog(@"transmit project");
    
    if (sender == self.beaconProject1Button) {
        self.beaconPeripheralData = [self.beaconProjectRegion1 peripheralDataWithMeasuredPower:nil];
        self.statusLabel.text = @"Project 1";
    } else if (sender == self.beaconProject2Button) {
        self.beaconPeripheralData = [self.beaconProjectRegion2 peripheralDataWithMeasuredPower:nil];
        self.statusLabel.text = @"Project 2";
    }
    
    self.peripheralManager = [[CBPeripheralManager alloc] initWithDelegate:self
                                                                     queue:nil
                                                                   options:nil];
}

- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral
{
    if (peripheral.state == CBPeripheralManagerStatePoweredOn) {
        NSLog(@"Powered On");
        [self.peripheralManager startAdvertising:self.beaconPeripheralData];
    } else if (peripheral.state == CBPeripheralManagerStatePoweredOff) {
        NSLog(@"Powered Off");
        [self.peripheralManager stopAdvertising];
    }
}

@end
