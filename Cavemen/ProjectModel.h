//
//  ProjectModel.h
//  Cavemen
//
//  Created by Leonid Peancovschi on 4/12/14.
//  Copyright (c) 2014 Endava. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProjectModel : NSObject

@property (nonatomic, strong) NSString *projectTitle;
@property (nonatomic, strong) NSString *projectIconUri;
@property (nonatomic, strong) NSArray *projectPersons;

@end
