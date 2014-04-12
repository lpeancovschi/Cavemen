//
//  QRCodeVC.m
//  Cavemen
//
//  Created by Leonid on 4/11/14.
//  Copyright (c) 2014 Endava. All rights reserved.
//

#import "QRCodeVC.h"

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
    // Do any additional setup after loading the view.
}

#pragma mark - ZBAR delegate methods

- (void) imagePickerController: (UIImagePickerController*) reader didFinishPickingMediaWithInfo: (NSDictionary*) info
{
    // ADD: get the decode results
    id<NSFastEnumeration> results =
    [info objectForKey: ZBarReaderControllerResults];
    ZBarSymbol *symbol = nil;
    for(symbol in results)
        // EXAMPLE: just grab the first barcode
        break;
    
    NSLog(@"decoded symbol = %@", symbol.data);
}

@end
