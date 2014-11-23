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
#import "AppDelegate.h"

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
    
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    self.selectedScheme = appDelegate.selectedScheme;
    
    NSLog(@"%@", [self.selectedScheme valueForKey:@"backgroundColor"]);
    self.tableView.backgroundColor = [self.selectedScheme valueForKey:@"backgroundColor"];
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
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.backgroundColor = [self.selectedScheme valueForKey:@"backgroundColor"];
    cell.textLabel.textColor = [self. selectedScheme valueForKey:@"textColor"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *selection = [self.schemes objectAtIndex:indexPath.row];
    
    if([selection isEqual: @"Basic"])
        self.selectedScheme = self.scheme.basic;
    if([selection isEqual:  @"Forest"])
        self.selectedScheme = self.scheme.forest;
    if([selection  isEqual: @"Sunrise"])
        self.selectedScheme = self.scheme.sunrise;
    if([selection  isEqual: @"Midnight"])
        self.selectedScheme = self.scheme.midnight;
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self updateColors];
}

-(void) updateColors {
    
    NSLog(@"UPDATING COLOR");
    NSArray *cells = [self.tableView visibleCells];
    
    for(int i = 0; i < cells.count; ++i){
        UITableViewCell *cell = [cells objectAtIndex: i];
        cell.backgroundColor = [self.selectedScheme valueForKey:@"backgroundColor"];
        cell.textLabel.textColor = [self.selectedScheme valueForKey:@"textColor"];
    }
    
    self.tableView.backgroundColor = [self.selectedScheme valueForKey:@"backgroundColor"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:changeScheme object:nil userInfo:self.selectedScheme];
}

@end
