//
//  LaunchPageViewController.m
//  App
//
//  Created by Megan Avery on 10/14/14.
//  Copyright (c) 2014 Smoothie. All rights reserved.
//

#import "LaunchPageViewController.h"
#import "PropertyDetailViewController.h"
#import "addPropertyController.h"
#import "InfoTableViewCell.h"
#import "GoogleAccount.h"
#import "ColorSchemeViewController.h"


@interface LaunchPageViewController ()

@end

@implementation LaunchPageViewController

- (void)viewDidLoad
{
    NSLog(@"LaunchPageViewController:viewDidLoad");
    
    [super viewDidLoad];
    [self.tableView setDelegate:self];
    _tableView.dataSource = self;
    
    [self.user setDelegate:self];
    [self.user loadUserSummary];
    [_user addObserver:self forKeyPath:@"active" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];
    

    
    // Do any additional setup after loading the view, typically from a nib.
    // need to call some method to populate the propertyList based on some database/backend
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if([keyPath isEqualToString:@"active"]){
        [_tableView reloadData];
    }
};


-(void)interfaceUpdate{
    NSLog(@"LaunchPageViewController:interfaceUpdate:");
   [_tableView reloadData];
}

//these methods are required for the tableview protocol stuff
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
   // NSLog(@"LaunchPageViewController:numberOfSectionsInTableView:Sections: %d",[self.user.active.properties count]);
    // Return the number of sections.
    
    return [self.user.active.properties count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   // NSLog(@"LaunchPageViewController:numberOfRowsInSection:Rows: %d",[[[self.user.active.properties objectAtIndex:section] profiles] count]);
    // Return the number of rows in the section.
    // NSLog(@"Rendering with: %@",self.propertyList.count);
    
    return [[[self.user.active.properties objectAtIndex:section] profiles] count];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
 //   NSLog(@"ABOUT TO SEGUE");
    if([sender isKindOfClass:[UITableViewCell class]])
    {
        UITableViewCell *cell = sender;
        NSIndexPath* pathOfTheCell = [self.tableView indexPathForCell:cell];
        if([segue.identifier isEqualToString:@"propertyDetails"]){
            NSLog(@"IS DOING THE SEGUE TO THE PROPERTY DETAILS");
           // PropertyDetailViewController *pdvc = segue.destinationViewController;
            //pdvc.propertySummary = self.propertyList[pathOfTheCell.row];
            NSLog(@"AFTER SETTING THE PROPERTY SUMMARY");
        }
        
    }
    
    if([segue.identifier isEqualToString:@"addPropertySegue"]){
       addPropertyController *remote = segue.destinationViewController;
       //NSLog(@"Property Id: %@", [[self.accountList objectAtIndex:0] identifier]);
       //remote.summary = [self.accountList objectAtIndex:0];
       // remote.propertyID= [[self.accountList objectAtIndex:0] identifier];
        
      //  remote.propertyid1.text = [[self.accountList objectAtIndex:0] identifier];
        
        [remote setUser:self.user];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"cellForRowAtIndexPath:Section: %d Row: %d",indexPath.section,indexPath.row );
    static NSString *CellIdentifier = @"cellid";
    InfoTableViewCell *cell = (InfoTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
  
    NSLog(@"Count %d ",[self.user.active.properties count]);
    
    GoogleProperty *p = [self.user.active.properties objectAtIndex:indexPath.section];

    NSLog(@"ProfileCount %d ",[p.profiles count]);
    
    GoogleProfile  *prof = [p.profiles objectAtIndex:indexPath.row];
    cell.activeUsers.text = @"5";
    cell.url.text = [p websiteUrl];
    cell.name.text = [prof name];
    cell.property.text = [prof identifier];
  //  cell.detailTextLabel.text = @"123";
  //  cell.textLabel.text=@"#@1";
  //  NSLog(@"LaunchPageViewController:cellForRowAtIndexPath: %d %d", indexPath.row, indexPath.section);

    return cell;
}

- (IBAction)NextAccount:(UIButton *)sender{
    
    _user.active = [_user.accounts objectAtIndex:1];
    
}

@end
