//
//  GodClient.h
//  Cavemen
//
//  Created by Leonid Peancovschi on 4/12/14.
//  Copyright (c) 2014 Endava. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TableModel;
@class PersonModel;

@interface GodClient : NSObject

- (void)getTableWithToken:(NSString *)tableToken successBlock:(void (^)(TableModel *tableModel))successBlock;

- (void)getPersonWithFirstName:(NSString *)firstName successBlock:(void (^)(PersonModel *personModel))successBlock;

- (void)bookTableWithToken:(NSString *)tableToken successBlock:(void (^)())successBlock failureBlock:(void (^)(PersonModel *tableOwnerPerson))failureBlock;

@end
