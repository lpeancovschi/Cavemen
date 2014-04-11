//
//  QRResultVC.m
//  Cavemen
//
//  Created by Leonid on 4/11/14.
//  Copyright (c) 2014 Endava. All rights reserved.
//

#import "QRResultVC.h"

@interface QRResultVC ()

@property (nonatomic, weak) IBOutlet UILabel *qrCodeLabel;

@end

@implementation QRResultVC {

    NSString *_qrCodeString;
}

- (instancetype)initWithQRCodeString:(NSString *)qrCodeString {

    if (self = [super init]) {
    
        _qrCodeString = qrCodeString;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.qrCodeLabel.text = _qrCodeString;
}


@end
