//
//  CurrentPerson.h
//  Cavemen
//
//  Created by Leonid Peancovschi on 4/12/14.
//  Copyright (c) 2014 Endava. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PersonModel.h"

@interface CurrentPerson : PersonModel

+ (instancetype)sharedInstance;

@end
