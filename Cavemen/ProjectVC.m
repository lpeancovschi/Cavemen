//
//  ProjectVC.m
//  Cavemen
//
//  Created by Leonid Peancovschi on 4/12/14.
//  Copyright (c) 2014 Endava. All rights reserved.
//

#import "ProjectVC.h"
#import <AFNetworking/UIImageView+AFNetworking.h>
#import "ProjectModel.h"

@interface ProjectVC ()

@property (nonatomic, weak) IBOutlet UIImageView *projectLogoView;
@property (nonatomic, weak) IBOutlet UILabel *projectName;
@property (nonatomic, weak) IBOutlet UITextView *projectDescription;

@end

@implementation ProjectVC

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.projectLogoView setImageWithURL:[NSURL URLWithString:self.projectModel.projectIconUri] placeholderImage:[UIImage imageNamed:@"projectPlaceholder"]];
    self.projectName.text = self.projectModel.projectTitle;
    self.projectDescription.text = self.projectModel.projectDescription;
}

@end
