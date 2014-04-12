//
//  UserDetailsViewControlelr.h
//  Cavemen
//
//  Created by Alex Maimescu on 4/12/14.
//  Copyright (c) 2014 Endava. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PersonModel;

@interface UserDetailsViewControlelr : UIViewController

@property (nonatomic, strong) PersonModel *personModel;

- (instancetype)initWithPersonModel:(PersonModel *)person;

@end
