//
//  ColorSchemeViewController.m
//  App
//
//  Created by Megan Avery on 11/2/14.
//  Copyright (c) 2014 Smoothie. All rights reserved.
//

#define APP ((AppDelegate *)[[UIApplication sharedApplication] delegate])

#import "ColorSchemeViewController.h"
#import "ColorScheme.h"

@interface ColorSchemeViewController ()



@end

@implementation ColorSchemeViewController

- (void)viewDidLoad
{
    NSLog(@"viewDidLoad");
    self.schemes = [[NSMutableArray alloc] init];
    
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.scheme = [[ColorScheme alloc] init];
    [self.schemes addObjectsFromArray: self.scheme.options];
}

//these methods are required for the tableview protocol stuff
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSLog(@"numberOfSectionsInTableView");
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"numberOfRowsInSection");
    // Return the number of rows in the section.
    //    NSLog(@"Rendering with: %@",self.propertyList.count);
    return self.schemes.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"cellForRowAtIndexPath");
    static NSString *CellIdentifier = @"cellid";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    cell.textLabel.text=[self.schemes objectAtIndex:indexPath.row];
    
    return cell;
}

@end
