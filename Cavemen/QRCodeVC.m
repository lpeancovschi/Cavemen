//
//  QRCodeVC.m
//  Cavemen
//
//  Created by Leonid on 4/11/14.
//  Copyright (c) 2014 Endava. All rights reserved.
//

#import "QRCodeVC.h"
#import <MBProgressHUD/MBProgressHUD.h>

@interface QRCodeVC ()

@end

@implementation QRCodeVC

- (id)init
{
    if (self = [super init])
    {
        self.readerDelegate            = self;
        self.supportedOrientationsMask = ZBarOrientationMaskAll;
        self.showsZBarControls         = NO;
        ZBarImageScanner *scnr = self.scanner;
        [scnr setSymbology: ZBAR_I25
                    config: ZBAR_CFG_ENABLE
                        to: 0];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancel)];
    
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    self.navigationItem.leftBarButtonItem = cancelButton;
}

- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:^{
        
        NSLog(@"Did press cancel");
    }];
}

#pragma mark - ZBAR delegate methods

- (void)imagePickerController: (UIImagePickerController *)reader didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // ADD: get the decode results
    id<NSFastEnumeration> results =
    [info objectForKey: ZBarReaderControllerResults];
    ZBarSymbol *symbol = nil;
    for(symbol in results)
        // EXAMPLE: just grab the first barcode
        break;
    
    if ([self.delegate respondsToSelector:@selector(didScanCode:)]) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            
            [self dismissViewControllerAnimated:YES completion:^{
                [self.delegate didScanCode:symbol.data];
            }];
        });
    }
}

@end
