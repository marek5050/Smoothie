//
//  LaunchPageViewController.m
//  App
//
//  Created by Megan Avery on 10/14/14.
//  Copyright (c) 2014 Smoothie. All rights reserved.
//

#define APP ((AppDelegate *)[[UIApplication sharedApplication] delegate])

#import "LaunchPageViewController.h"
#import "PropertyDetailViewController.h"
#import "addPropertyController.h"

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
    [self loadData];
    
    // Do any additional setup after loading the view, typically from a nib.
    
   // need to call some method to populate the propertyList based on some database/backend
}

-(void)loadData{
    GTLQueryAnalytics *query = [GTLQueryAnalytics queryForManagementAccountSummariesList];
    
    [self.service executeQuery:query completionHandler:^(GTLServiceTicket *ticket,                                                        GTLAnalyticsAccountSummaries *files,
        NSError *error) {
        // [alert dismissWithClickedButtonIndex:0 animated:YES];
        if (error == nil) {
            NSLog(@"files: %@",files);
            [self.propertyList removeAllObjects];
            if(self.propertyList == nil){
                self.propertyList = [[NSMutableArray alloc] init];
            }
            if(self.accountList == nil)
            {            self.accountList = [[NSMutableArray alloc] init];
            }
            
            GTLAnalyticsAccountSummary *accountSummary = [[GTLAnalyticsAccountSummary alloc] init];
            accountSummary = [files.items objectAtIndex:0];
            [self.propertyList addObjectsFromArray:accountSummary.webProperties];
            
            [self.accountList addObjectsFromArray: files.items];
            self.accountName.title = accountSummary.name;
            
            [self.tableView reloadData];
          //  [self helpEmail];
            
        } else {
            NSLog(@"An error occurred: %@", error);
        }
    }];
    [self.tableView reloadData];
}

//- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
//{
//    switch (result)
//    {
//        case MFMailComposeResultCancelled:
//            NSLog(@"Mail cancelled");
//            break;
//        case MFMailComposeResultSaved:
//            NSLog(@"Mail saved");
//            break;
//        case MFMailComposeResultSent:
//            NSLog(@"Mail sent");
//            break;
//        case MFMailComposeResultFailed:
//            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
//            break;
//        default:
//            break;
//    }
//    
//    // Close the Mail Interface
//    [self dismissViewControllerAnimated:YES completion:NULL];
//}


// The mail compose view controller delegate method
//- (void)mailComposeController:(MFMailComposeViewController *)controller
//          didFinishWithResult:(MFMailComposeResult)result
//                        error:(NSError *)error
//{
//    [self dismissModalViewControllerAnimated:YES];
//}



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

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
 //   NSLog(@"ABOUT TO SEGUE");
    if([sender isKindOfClass:[UITableViewCell class]])
    {
        UITableViewCell *cell = sender;
        NSIndexPath* pathOfTheCell = [self.tableView indexPathForCell:cell];
        if([segue.identifier isEqualToString:@"propertyDetails"]){
            NSLog(@"IS DOING THE SEGUE TO THE PROPERTY DETAILS");
            PropertyDetailViewController *pdvc = segue.destinationViewController;
            pdvc.propertySummary = self.propertyList[pathOfTheCell.row];
            NSLog(@"AFTER SETTING THE PROPERTY SUMMARY");
        }
        
    }
    
    if([segue.identifier isEqualToString:@"addPropertySegue"]){
        addPropertyController *remote = segue.destinationViewController;
        NSLog(@"Property Id: %@", [[self.accountList objectAtIndex:0] identifier]);
        remote.summary = [self.accountList objectAtIndex:0];
       // remote.propertyID= [[self.accountList objectAtIndex:0] identifier];
        
      //  remote.propertyid1.text = [[self.accountList objectAtIndex:0] identifier];
        
        [remote setService:self.service];
    }
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
   cell.detailTextLabel.text=[[self.propertyList objectAtIndex:indexPath.row] websiteUrl];


//        cell.detailTextLabel.text= [NSString stringWithFormat:@"%@",[[self.propertyList objectAtIndex:indexPath.row] name]];
  //  }
    return cell;
}

@end
