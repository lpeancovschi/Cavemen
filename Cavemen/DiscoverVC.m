//
//  DiscoverVC.m
//  Cavemen
//
//  Created by Leonid Peancovschi on 4/8/14.
//  Copyright (c) 2014 Endava. All rights reserved.
//

#import "DiscoverVC.h"
#import "TempInfoViewControlelrViewController.h"
#import "QRCodeVC.h"
#import "GodClient.h"
#import "TableModel.h"
#import "UserDetailsViewControlelr.h"
#import "ProjectModel.h"
#import "ProjectVC.h"
#import "CurrentPerson.h"
#import <MBProgressHUD/MBProgressHUD.h>

#define BEACON_IDENTIFIER_TABLE     @"cavemen.beacon"

#define BEACON_REGION_PROXIMITY_UUID @"3AB1650D-20BD-4DCE-8AE2-B2B6D67FE109"

@interface DiscoverVC () <UITextFieldDelegate, CLLocationManagerDelegate, QRCodeVCDelegate>
@property (weak, nonatomic) IBOutlet UITextField *tokenTextField;

@end

@implementation DiscoverVC {

    CLLocationManager *_locationManager;
    CLBeaconRegion *_beaconRegionEndavaDUTable;
    
    BOOL _monitorProjects;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"Identify table";
    self.tokenTextField.delegate = self;
    _monitorProjects = NO;
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancel)];
    
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    self.navigationItem.leftBarButtonItem = cancelButton;
}

- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:^{
        [self stopBeaconMonitoring];
    }];
}

- (void)startBeaconsDiscovery
{
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    
    // DU UUID
    NSUUID *beaconRegionEndavaDUUUID = [[NSUUID alloc] initWithUUIDString:BEACON_REGION_PROXIMITY_UUID];
    
    _beaconRegionEndavaDUTable = [[CLBeaconRegion alloc] initWithProximityUUID:beaconRegionEndavaDUUUID identifier:BEACON_IDENTIFIER_TABLE];
    _beaconRegionEndavaDUTable.notifyEntryStateOnDisplay = YES;
    
    [_locationManager startMonitoringForRegion:_beaconRegionEndavaDUTable];
    [self locationManager:_locationManager didStartMonitoringForRegion:_beaconRegionEndavaDUTable];
}

- (void)stopBeaconMonitoring
{
    [_locationManager stopMonitoringForRegion:_beaconRegionEndavaDUTable];
    [_locationManager stopRangingBeaconsInRegion:_beaconRegionEndavaDUTable];
    _locationManager = nil;
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
    if ([beacons count] > 0) {
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.labelText = @"Loading...";
                
        CLBeacon *nearestExhibit = [beacons firstObject];
        
        if (_monitorProjects) {
        
            [self processProjectMonitoringWithBeacon:nearestExhibit];
        } else {
            if ((nearestExhibit.proximity == CLProximityImmediate) &&
                (nearestExhibit.accuracy <= 0.1)) {
                
                NSString *code;
                
                NSLog(@"ID: %@, %@", nearestExhibit.major, nearestExhibit.minor);
                
                if (([nearestExhibit.major isEqual:@1]) && ([nearestExhibit.minor isEqual:@1])) {
                    code = @"10";
                } if (([nearestExhibit.major isEqual:@2]) && ([nearestExhibit.minor isEqual:@1])) {
                    code = @"15";
                }
                
                [self.presentedViewController dismissViewControllerAnimated:YES completion:^{
                    [self didScanCode:code];
                    [self stopBeaconMonitoring];
                }];
            }
        }
    }
}

- (void)processProjectMonitoringWithBeacon:(CLBeacon *)nearestExhibit {

    if (nearestExhibit.proximity == CLProximityNear) {
        
        NSString *code;
        
        NSLog(@"ID: %@, %@", nearestExhibit.major, nearestExhibit.minor);
        
        if (([nearestExhibit.major isEqual:@2]) && ([nearestExhibit.minor isEqual:@1000])) {
            code = @"1";
        } if (([nearestExhibit.major isEqual:@2]) && ([nearestExhibit.minor isEqual:@1001])) {
            code = @"2";
        }
        
        [self.presentedViewController dismissViewControllerAnimated:YES completion:^{
            [self didScanProjectCode:code];
            [self stopBeaconMonitoring];
        }];
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

#pragma mark - IBActions

- (IBAction)didPressScanBeacon:(id)sender
{
    _monitorProjects = NO;
    
    TempInfoViewControlelrViewController *tempInfoVC = [[TempInfoViewControlelrViewController alloc] init];
    
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:tempInfoVC] animated:YES completion:^{
        
        [self startBeaconsDiscovery];
    }];
}

- (IBAction)didPressScanProject:(id)sender {

    _monitorProjects = YES;
    
    TempInfoViewControlelrViewController *tempInfoVC = [[TempInfoViewControlelrViewController alloc] init];
    
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:tempInfoVC] animated:YES completion:^{
        
        [self startBeaconsDiscovery];
    }];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.tokenTextField) {
        [self didScanCode:textField.text];
        [textField resignFirstResponder];
    }
    
    return YES;
}

- (IBAction)didPressScanQRCode:(id)sender
{
    _monitorProjects = NO;
    
    QRCodeVC *qrCodeVC = [[QRCodeVC alloc] init];
    qrCodeVC.delegate = self;
    
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:qrCodeVC] animated:YES completion:^{}];
}

#pragma mark - QRCodeVCDelegate

- (void)didScanCode:(NSString *)code
{
    NSLog(@"Did scan code: %@", code);
    
    if (code.length <= 4) {
        
        [[GodClient sharedInstance] bookTableWithToken:code successBlock:^{
            
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
       
            [self dismissViewControllerAnimated:YES completion:^{
                
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Cavemen"
                                                                    message:@"You have successfully booked a new table"
                                                                   delegate:nil
                                                          cancelButtonTitle:@"OK"
                                                          otherButtonTitles:nil, nil];
                
                [alertView show];
            }];
            
        } failureBlock:^(PersonModel *tableOwnerPerson) {
            
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            
            UserDetailsViewControlelr *userDetails = [[UserDetailsViewControlelr alloc] initWithPersonModel:tableOwnerPerson];
            userDetails.personQuickLook = YES;
            [self presentViewController:[[UINavigationController alloc] initWithRootViewController:userDetails] animated:YES completion:nil];
        }];
    }
}

- (void)didScanProjectCode:(NSString *)code {

    [[GodClient sharedInstance] getProjectForToken:code success:^(ProjectModel *projectModel){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    
        ProjectVC *projectVC = [[ProjectVC alloc] init];
        projectVC.projectModel = projectModel;
        [self.navigationController pushViewController:projectVC animated:YES];
        
    } failureBlock:^(NSString *errorMsg){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    
    }];
}

@end
