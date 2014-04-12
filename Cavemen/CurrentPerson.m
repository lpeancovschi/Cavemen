//
//  CurrentPerson.m
//  Cavemen
//
//  Created by Leonid Peancovschi on 4/12/14.
//  Copyright (c) 2014 Endava. All rights reserved.
//

#import "CurrentPerson.h"

@implementation CurrentPerson

+ (instancetype)sharedInstance {

    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^ {
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

@end
