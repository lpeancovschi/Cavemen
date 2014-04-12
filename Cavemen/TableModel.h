//
//  TableModel.h
//  Cavemen
//
//  Created by Leonid Peancovschi on 4/12/14.
//  Copyright (c) 2014 Endava. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, TABLE_STATUS) {
    BOOKED,
    EMPTY,
    NOT_AVAILABLE,
};

@interface TableModel : NSObject

@property (nonatomic) TABLE_STATUS tableStatus;
@property (nonatomic, strong) NSArray *employeesArray;
@property (nonatomic, strong) NSString *tableToken;

- (instancetype)initWithTableToken:(TABLE_STATUS)status emplayeesArray:(NSArray *)array tableToken:(NSString *)tableToken;

@end
