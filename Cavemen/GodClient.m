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
#import "CurrentPerson.h"

@implementation GodClient

- (void)getTableWithToken:(NSString *)tableToken successBlock:(void (^)(TableModel *tableModel))successBlock failureBlock:(void (^)(NSString *errroMsg))failureBlock {

    PFQuery *query = [PFQuery queryWithClassName:@"Table"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %lu scores.", (unsigned long)objects.count);
            // Do something with the found objects
            
            BOOL tableExists = NO;
            
            for (PFObject *object in objects) {
                
                NSString *token = [object objectForKey:@"token"];
                
                if ([token isEqualToString:tableToken]) {
                
                    TableModel *tableModel = [[TableModel alloc] init];
                    tableModel.tableToken = token;
                    tableModel.tableStatus = [[object objectForKey:@"status"] intValue];
                    tableModel.employeesArray = [object objectForKey:@"employees"];
                    
                    tableExists = YES;
                    
                    successBlock(tableModel);
                    break;
                }
                
            }
            
            if (!tableExists) {
            
                failureBlock(@"There is no such table");
            }
            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

- (void)getPersonWithFirstName:(NSString *)firstName successBlock:(void (^)(PersonModel *personModel))successBlock failureBlock:(void (^)(NSString *errorMsg))failureBlock {

    PFQuery *query = [PFQuery queryWithClassName:@"Person"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %lu scores.", (unsigned long)objects.count);
            // Do something with the found objects
            
            BOOL userExists = NO;
            
            for (PFObject *object in objects) {
                
                NSString *fName = [object objectForKey:@"fName"];
                
                if ([firstName isEqualToString:fName]) {
                    
                    PersonModel *personModel = [[PersonModel alloc] init];
                    personModel.firstName = fName;
                    personModel.lastName = [object objectForKey:@"lName"];
                    personModel.jobTitle = [object objectForKey:@"jobTitle"];
                    personModel.photoURI = [object objectForKey:@"photoUri"];
                    personModel.projects = [object objectForKey:@"projects"];
                    
                    userExists = YES;
                    
                    successBlock(personModel);
                    break;
                }
            }
            
            if (!userExists) {
            
                failureBlock(@"Invalid user name");
            }
            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

- (void)bookTableWithToken:(NSString *)tableToken successBlock:(void (^)())successBlock failureBlock:(void (^)(PersonModel *tableOwnerPerson))failureBlock {

    PFQuery *query = [PFQuery queryWithClassName:@"Person"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %lu scores.", (unsigned long)objects.count);
            // Do something with the found objects
            
            BOOL isTableFree = YES;
            
            CurrentPerson *currentPerson = [CurrentPerson sharedInstance];
            PFObject      *currentPersonPFObject;
            
            for (PFObject *object in objects) {
                
                NSString *tToken = [object objectForKey:@"tableToken"];
                
                if ([tToken isEqualToString:tableToken]) {
                    
                    PersonModel *personModel = [[PersonModel alloc] init];
                    personModel.firstName = [object objectForKey:@"fName"];
                    personModel.lastName  = [object objectForKey:@"lName"];
                    personModel.jobTitle  = [object objectForKey:@"jobTitle"];
                    personModel.photoURI  = [object objectForKey:@"photoUri"];
                    personModel.projects  = [object objectForKey:@"projects"];
                    
                    isTableFree = NO;
                    
                    failureBlock(personModel);
                    break;
                }
                
                NSString *personName = [object objectForKey:@"fName"];
                
                if ([personName isEqualToString:currentPerson.firstName]) {
                
                    currentPersonPFObject = object;
                }
            }
            
            if (isTableFree) {
            
                [currentPersonPFObject setObject:tableToken forKey:@"tableToken"];
                [currentPersonPFObject saveInBackground];
                
                successBlock();
            } 
            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

- (void)unsubscribeFromCurrentWithSuccessBlock:(void (^)())successBlock failureBlock:(void (^)())failureBlock {

    PFQuery *query = [PFQuery queryWithClassName:@"Person"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            
            CurrentPerson *currentPerson = [CurrentPerson sharedInstance];
            
            for (PFObject *object in objects) {
                
                NSString *tToken = [object objectForKey:@"tableToken"];
                
                if ([tToken isEqualToString:currentPerson.tableToken]) {
                    
                    // remove urrent table token
                    [object setObject:@"" forKey:@"tableToken"];
                    [object saveInBackground];
                    
                    successBlock();
                    break;
                }
            }
        } else {
            // Log details of the failure
            failureBlock();
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

@end
