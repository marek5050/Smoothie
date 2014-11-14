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
#import "PNChart.h"


@interface LaunchPageViewController ()

@end

@implementation LaunchPageViewController

- (void)viewDidLoad
{
    NSLog(@"LaunchPageViewController:viewDidLoad");
    
    [super viewDidLoad];
    [self.tableView setDelegate:self];
    _tableView.dataSource = self;
    [self.otherAccounts setDelegate:self];
    _otherAccounts.dataSource = self;
    _otherAccounts.hidden = YES;
    
    
    [self.user setDelegate:self];
    [self.user loadUserSummary];
    [_user addObserver:self forKeyPath:@"active" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];
    
    // Do any additional setup after loading the view, typically from a nib.
    // need to call some method to populate the propertyList based on some database/backend
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if([keyPath isEqualToString:@"active"]){
        _ddMenuShowButton.titleLabel.text = _user.active.name;
        [_ddMenuShowButton setTitle:_user.active.name forState:UIControlStateNormal];
        
        [_tableView reloadData];
        [_otherAccounts reloadData];
        
        
    }
};


-(void)interfaceUpdate{
    NSLog(@"LaunchPageViewController:interfaceUpdate:");
   [_tableView reloadData];
}

//these methods are required for the tableview protocol stuff
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//    NSLog(@"NUMBER OF SECTIONS %d", [self.user.active.properties count]);
    
    if([tableView isEqual: _tableView])
        return [self.user.active.properties count];
    else
        return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([tableView isEqual: _tableView])
        return [[[self.user.active.properties objectAtIndex:section] profiles] count] + 1;
    else{
        NSLog(@"NUMBER OF ACCOUNTS: %d", [self.user.accounts count]);
        return [self.user.accounts count];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([sender isKindOfClass:[UITableViewCell class]])
    {
        UITableViewCell *cell = sender;
        NSIndexPath* pathOfTheCell = [self.tableView indexPathForCell:cell];
        if([segue.identifier isEqualToString:@"propertyDetails"]){
            NSLog(@"IS DOING THE SEGUE TO THE PROPERTY DETAILS");
            PropertyDetailViewController *pdvc = segue.destinationViewController;
            
            
            GoogleProperty *prop = [self.user.active.properties objectAtIndex:pathOfTheCell.section];
            GoogleProfile *prof = [prop.profiles objectAtIndex:pathOfTheCell.row];
            
            pdvc.property = prop;
            pdvc.profile = prof;
            pdvc.user = _user;
        
            NSLog(@"AFTER SETTING THE PROPERTY SUMMARY");
        }
    }
    
    if([segue.identifier isEqualToString:@"addPropertySegue"]){
       addPropertyController *remote = segue.destinationViewController;
        //NEED TO FIX THIS, ADDING A PROPERTY NO LONGER WORKS
       //NSLog(@"Property Id: %@", [[self.accountList objectAtIndex:0] identifier]);
       //remote.summary = [self.accountList objectAtIndex:0];
       // remote.propertyID= [[self.accountList objectAtIndex:0] identifier];
        
      //  remote.propertyid1.text = [[self.accountList objectAtIndex:0] identifier];
        
        [remote setUser:self.user];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"cellForRowAtIndexPath:Section: %d Row: %d",indexPath.section,indexPath.row );
    
    if([tableView isEqual: _tableView]){
    static NSString *CellIdentifier = @"cellid";
    InfoTableViewCell *cell = (InfoTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    [self tableView:tableView heightForRowAtIndexPath:indexPath];
  
//    NSLog(@"Count %d ",[self.user.active.properties count]);
    
    GoogleProperty *p = [self.user.active.properties objectAtIndex:indexPath.section];

//    NSLog(@"ProfileCount %d ",[p.profiles count]);
    
    int section_count = [[[self.user.active.properties objectAtIndex:indexPath.section] profiles] count];
    if(indexPath.row < section_count){
        GoogleProfile  *prof = [p.profiles objectAtIndex:indexPath.row];
        cell.activeUsers.text = [NSString stringWithFormat:@"Users: %@", [prof activeVisitors]];
        cell.url.text = [p websiteUrl];
        cell.name.text = [prof name];
        cell.name.textColor = [UIColor blackColor];
        cell.property.text = [prof identifier];
        [cell setUserInteractionEnabled:YES];

    }
    else{
        cell.name.text = @"ADD PROFILE";
        cell.name.textColor = [UIColor colorWithRed:.51 green:.8 blue:0.0 alpha:1.0];
        cell.activeUsers.text = @"";
        cell.url.text = @"";
        cell.property.text = @"";
        [cell setUserInteractionEnabled:NO];
    }
        return cell;
    }
    
    else {
        static NSString *CellIdentifier = @"accountCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        NSString *name = [[self.user.accounts objectAtIndex:indexPath.row] name];
        
        if([name isEqualToString: _ddMenuShowButton.titleLabel.text])
            cell.textLabel.text = [NSString stringWithFormat:@"** %@ **", name];
        else
            cell.textLabel.text = name;
        return cell;
    }


}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([tableView isEqual: _tableView]){
    int section_count = [[[self.user.active.properties objectAtIndex:indexPath.section] profiles] count];
    if(indexPath.row < section_count)
        return 80;
    else
        return 30;
    }
    else
        return 25;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if([tableView isEqual:_tableView]){
        GoogleProperty *p = [self.user.active.properties objectAtIndex:section];
        return p.name;
    }
    else
        return @"";
}

- (IBAction)NextAccount:(UIButton *)sender{
    
    _user.active = [_user.accounts objectAtIndex:1];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([tableView isEqual: _otherAccounts]){
        _user.active = [_user.accounts objectAtIndex: indexPath.row];
        _otherAccounts.hidden = YES;
    }
    
}

- (IBAction)ddMenuShow:(id)sender {
    _otherAccounts.hidden = NO;
}
@end
