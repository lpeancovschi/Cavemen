//
//  TableModel.m
//  Cavemen
//
//  Created by Leonid Peancovschi on 4/12/14.
//  Copyright (c) 2014 Endava. All rights reserved.
//

#import "TableModel.h"

@implementation TableModel

- (instancetype)initWithTableToken:(TABLE_STATUS)status emplayeesArray:(NSArray *)array tableToken:(NSString *)tableToken {

    if (self = [super init]) {
    
        self.tableStatus    = status;
        self.employeesArray = array;
        self.tableToken     = tableToken;
    }
    
    return self;
}

@end
