//
//  QRCodeVC.h
//  Cavemen
//
//  Created by Leonid on 4/11/14.
//  Copyright (c) 2014 Endava. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ZBarSDK/ZBarSDK.h>

@protocol QRCodeVCDelegate <NSObject>

- (void)didScanCode:(NSString *)code;

@end

@interface QRCodeVC : ZBarReaderViewController <ZBarReaderDelegate>

@property (nonatomic, weak) id <QRCodeVCDelegate> delegate;

@end
