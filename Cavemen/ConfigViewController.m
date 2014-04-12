//
//  ConfigViewController.m
//  iBeacons Demo
//
//  Created by M Newill on 27/09/2013.
//  Copyright (c) 2013 Mobient. All rights reserved.
//

#import "ConfigViewController.h"
#import "AppConstants.h"

@interface ConfigViewController ()

@end

@implementation ConfigViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self initBeacon];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *tableButton = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    tableButton.backgroundColor = [UIColor redColor];
    [tableButton addTarget:self action:@selector(transmitBeacon:) forControlEvents:UIControlEventAllTouchEvents];
    [self.view addSubview:tableButton];
    
    UIButton *projectButton = [[UIButton alloc] initWithFrame:CGRectMake(100, 200, 100, 100)];
    projectButton.backgroundColor = [UIColor greenColor];
    [projectButton addTarget:self action:@selector(transmitProjectBeacon:) forControlEvents:UIControlEventAllTouchEvents];
    [self.view addSubview:projectButton];
}

- (void)initBeacon {
    NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:kEnTowerProximityUUID];
    self.beaconTableRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuid
                                                                major:1
                                                                minor:1
                                                           identifier:kBeaconTableIdentifier];
    
    self.beaconProjectRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuid
                                                                       major:1
                                                                       minor:1
                                                                  identifier:kBeaconProjectIdentifier];
}

- (IBAction)transmitBeacon:(UIButton *)sender {
    
    NSLog(@"transmit table");
    self.beaconPeripheralData = [self.beaconTableRegion peripheralDataWithMeasuredPower:nil];
    self.peripheralManager = [[CBPeripheralManager alloc] initWithDelegate:self
                                                                                     queue:nil
                                                                                   options:nil];
}

- (IBAction)transmitProjectBeacon:(UIButton *)sender {
    
    NSLog(@"transmit project");
    self.beaconPeripheralData = [self.beaconProjectRegion peripheralDataWithMeasuredPower:nil];
    self.peripheralManager = [[CBPeripheralManager alloc] initWithDelegate:self
                                                                     queue:nil
                                                                   options:nil];
}

-(void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral {
    if (peripheral.state == CBPeripheralManagerStatePoweredOn) {
        NSLog(@"Powered On");
        [self.peripheralManager startAdvertising:self.beaconPeripheralData];
    } else if (peripheral.state == CBPeripheralManagerStatePoweredOff) {
        NSLog(@"Powered Off");
        [self.peripheralManager stopAdvertising];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
