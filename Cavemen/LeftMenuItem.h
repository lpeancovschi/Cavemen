//
//  LeftMenuItem.h
//  Cavemen
//
//  Created by Leonid Peancovschi on 4/8/14.
//  Copyright (c) 2014 Endava. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LeftMenuItem : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) Class vcClass;

- (instancetype)initWithTitle:(NSString *)title class:(Class)vcClass;

@end
