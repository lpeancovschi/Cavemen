//
//  LeftMenuItem.m
//  Cavemen
//
//  Created by Leonid Peancovschi on 4/8/14.
//  Copyright (c) 2014 Endava. All rights reserved.
//

#import "LeftMenuItem.h"

@implementation LeftMenuItem

- (instancetype)initWithTitle:(NSString *)title class:(Class)vcClass {

    if (self = [super init]) {
    
        self.title   = title;
        self.vcClass = vcClass;
    }
    
    return self;
}

@end
