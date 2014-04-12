//
//  PersonModel.h
//  Cavemen
//
//  Created by Leonid Peancovschi on 4/12/14.
//  Copyright (c) 2014 Endava. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonModel : NSObject

@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *jobTitle;
@property (nonatomic, strong) NSString *photoURI;
@property (nonatomic, strong) NSArray *projects;
@property (nonatomic, strong) NSString *tableToken;

@end
