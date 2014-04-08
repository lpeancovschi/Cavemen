//
//  LeftMenuVC.m
//  Cavemen
//
//  Created by Leonid Peancovschi on 4/6/14.
//  Copyright (c) 2014 Endava. All rights reserved.
//

#import "LeftMenuVC.h"
#import "LeftMenuDataModel.h"
#import "LeftMenuItem.h"
#import "UIViewController+MMDrawerController.h"

@interface LeftMenuVC ()

@end

@implementation LeftMenuVC

- (void)viewDidLoad
{
    [super viewDidLoad];
}

#pragma mark - Table View Data Source

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
    
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    LeftMenuItem *item = [LeftMenuDataModel leftMenuItems][indexPath.row];
    
    cell.textLabel.text = item.title;
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [LeftMenuDataModel leftMenuItems].count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    LeftMenuItem *item = [LeftMenuDataModel leftMenuItems][indexPath.row];
    [((UINavigationController *)self.mm_drawerController.centerViewController) setViewControllers:@[[[item.vcClass alloc] init]] animated:YES];
}

@end
