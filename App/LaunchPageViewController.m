//
//  LaunchPageViewController.m
//  App
//
//  Created by Megan Avery on 10/14/14.
//  Copyright (c) 2014 Smoothie. All rights reserved.
//

#import "LaunchPageViewController.h"

@interface LaunchPageViewController ()
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *propertyList;

@end

@implementation LaunchPageViewController

- (void)viewDidLoad
{
    NSLog(@"viewDidLoad");
    [super viewDidLoad];
    
    [self.tableView registerClass: [UITableViewCell class] forCellReuseIdentifier:@"cellid"];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    // Do any additional setup after loading the view, typically from a nib.
    
   // need to call some method to populate the propertyList based on some database/backend
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
    return 1;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender\
{
    NSLog(@"ABOUT TO SEGUE");
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"cellForRowAtIndexPath");
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid" forIndexPath:indexPath];
    
    // Configure the cell... will need to be replaced with the appropriate information to display
    cell.textLabel.text = @"Testing Title";
    cell.detailTextLabel.text = @"Testing Label";
    
    return cell;
}

@end
