//
//  GodClient.m
//  Cavemen
//
//  Created by Leonid Peancovschi on 4/12/14.
//  Copyright (c) 2014 Endava. All rights reserved.
//

#import "GodClient.h"
#import "TableModel.h"
#import "PersonModel.h"
#import <Parse/Parse.h>

@implementation GodClient

- (void)getTableWithToken:(NSString *)tableToken successBlock:(void (^)(TableModel *tableModel))successBlock {

    PFQuery *query = [PFQuery queryWithClassName:@"Table"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %lu scores.", (unsigned long)objects.count);
            // Do something with the found objects
            
            for (PFObject *object in objects) {
                NSLog(@"%@", [object objectForKey:@"name"]);
                
                NSString *token = [object objectForKey:@"token"];
                
                if ([token isEqualToString:tableToken]) {
                
                    TableModel *tableModel = [[TableModel alloc] init];
                    tableModel.tableToken = token;
                    tableModel.tableStatus = [[object objectForKey:@"status"] intValue];
                    tableModel.employeesArray = [object objectForKey:@"employees"];
                    
                    successBlock(tableModel);
                    break;
                }
                
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

- (void)getPersonWithFirstName:(NSString *)firstName successBlock:(void (^)(PersonModel *personModel))successBlock {

    PFQuery *query = [PFQuery queryWithClassName:@"Person"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %lu scores.", (unsigned long)objects.count);
            // Do something with the found objects
            
            for (PFObject *object in objects) {
                
                NSString *fName = [object objectForKey:@"fName"];
                
                if ([firstName isEqualToString:fName]) {
                    
                    PersonModel *personModel = [[PersonModel alloc] init];
                    personModel.firstName = fName;
                    personModel.lastName = [object objectForKey:@"lName"];
                    personModel.jobTitle = [object objectForKey:@"jobTitle"];
                    personModel.photoURI = [object objectForKey:@"photoUri"];
                    personModel.projects = [object objectForKey:@"projects"];
                    
                    successBlock(personModel);
                    break;
                }
                
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

- (void)bookTableWithToken:(NSString *)tableToken successBlock:(void (^)())successBlock failureBlock:(void (^)(PersonModel *tableOwnerPerson))failureBlock {

    
}

@end
