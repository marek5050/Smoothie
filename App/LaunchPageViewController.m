//
//  LaunchPageViewController.m
//  App
//
//  Created by Megan Avery on 10/14/14.
//  Copyright (c) 2014 Smoothie. All rights reserved.
//

#import "LaunchPageViewController.h"


@interface LaunchPageViewController ()



@end

@implementation LaunchPageViewController

- (void)viewDidLoad
{
    NSLog(@"viewDidLoad");
    self.propertyList = [[NSMutableArray alloc] init];
    
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    // Do any additional setup after loading the view, typically from a nib.
    
   // need to call some method to populate the propertyList based on some database/backend
}
-(void)loadData{
    GTLQueryAnalytics *query = [GTLQueryAnalytics queryForManagementAccountSummariesList];
    
    //service setAPIKey:@"AIzaSyB4bLjYuOISLLjSv_pVTD0sEYXuq3hq7AA"];
    //GTLServiceTicket *ticket = [[GTLServiceTicket alloc] init];
    
    [self.service executeQuery:query completionHandler:^(GTLServiceTicket *ticket,                                                        GTLAnalyticsAccountSummaries *files,
        NSError *error) {
        // [alert dismissWithClickedButtonIndex:0 animated:YES];
        if (error == nil) {
            NSLog(@"files: %@",files);
            [self.propertyList removeAllObjects];
            if(self.propertyList == nil){
                self.propertyList = [[NSMutableArray alloc] init];
            }
            
            [self.propertyList addObjectsFromArray:files.items];
            
            [self.tableView reloadData];
        } else {
            NSLog(@"An error occurred: %@", error);
        }
    }];
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
    return self.propertyList.count;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender\
{
    NSLog(@"ABOUT TO SEGUE");
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"cellForRowAtIndexPath");
    static NSString *CellIdentifier = @"cellid";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell... will need to be replaced with the appropriate information to display
    
   // cell.textLabel.text = @"Testing Title";
    //cell.detailTextLabel.text = @"Testing Label";
   cell.textLabel.text=[[self.propertyList objectAtIndex:indexPath.row] name];
    
//    if([self.propertyList objectAtIndex:indexPath.row]){
    cell.detailTextLabel.text=@"Hello World";
    NSLog(@"AFTER SETTING THE DETAILTEXTLABEL");
    NSLog(cell.detailTextLabel.text);

//        cell.detailTextLabel.text= [NSString stringWithFormat:@"%@",[[self.propertyList objectAtIndex:indexPath.row] name]];
  //  }
    return cell;
}

@end
