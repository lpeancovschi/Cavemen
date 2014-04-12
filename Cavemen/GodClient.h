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

- (void)getTableWithToken:(NSString *)tableToken successBlock:(void (^)(TableModel *tableModel))successBlock failureBlock:(void (^)(NSString *errroMsg))failureBlock;

- (void)getPersonWithFirstName:(NSString *)firstName successBlock:(void (^)(PersonModel *personModel))successBlock failureBlock:(void (^)(NSString *errorMsg))failureBlock;

- (void)bookTableWithToken:(NSString *)tableToken successBlock:(void (^)())successBlock failureBlock:(void (^)(PersonModel *tableOwnerPerson))failureBlock;

- (void)unsubscribeFromCurrentWithSuccessBlock:(void (^)())successBlock failureBlock:(void (^)())failureBlock;

//- (void)getProjectForToken:(NSString *)projectToken success

@end
