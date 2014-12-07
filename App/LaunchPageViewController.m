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
#import "AddProfileViewController.h"
#import "PNChart.h"
#import "SettingsControllerViewController.h"
#import "AppDelegate.h"

@interface LaunchPageViewController ()

@end

@implementation LaunchPageViewController

- (void)viewDidLoad
{
    NSLog(@"LaunchPageViewController:viewDidLoad");
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapBehind:)];
    
    
    [recognizer setNumberOfTapsRequired:1];
    recognizer.cancelsTouchesInView = NO; //So the user can still interact with controls in the modal view
    [self.tableView addGestureRecognizer:recognizer];
    
    
    [super viewDidLoad];
    [self.tableView setDelegate:self];
    _tableView.dataSource = self;
    [self.otherAccounts setDelegate:self];
    _otherAccounts.dataSource = self;
    _otherAccounts.hidden = YES;
    recognizer.delegate = self;
    
    [self loadRealtimeData];
    
    [self.user setDelegate:self];
    [self.user loadUserSummary];
    [_user addObserver:self forKeyPath:@"active" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];
    
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    self.selectedScheme = appDelegate.selectedScheme;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changedColors:) name:changeScheme object:nil];
    
    self.view.backgroundColor = [self.selectedScheme valueForKey:@"backgroundColor"];
    
    // Do any additional setup after loading the view, typically from a nib.
    // need to call some method to populate the propertyList based on some database/backend
}

- (void)handleTapBehind:(UITapGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateEnded)
    {
        CGPoint location = [sender locationInView:nil]; //Passing nil gives us coordinates in the window
        
        //Then we convert the tap's location into the local view's coordinate system, and test to see if it's in or outside. If outside, dismiss the view.
//        if (![self.view pointInside:[self.view convertPoint:location fromView:self.view.window] withEvent:nil])
//        {
//            // Remove the recognizer first so it's view.window is valid.
//         //   [self.view.window removeGestureRecognizer:sender];
//        //    [self dismissModalViewControllerAnimated:YES];
//            NSLog(@"DEF NOT here ") ;

                    _otherAccounts.hidden = YES;
//        }
    }
}

-(void)viewDidAppear:(BOOL)animated{
    [_user addObserver:self forKeyPath:@"active" options:NSKeyValueObservingOptionNew context:nil];

    [_user setDelegate:self];

    [_user loadUserSummary];
    if(_user.active != nil){
        [_tableView reloadData];
        [_otherAccounts reloadData];
    }
}

-(void) viewDidDisappear:(BOOL)animated{
    
    [_user removeObserver:self forKeyPath:@"active" context:nil];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if([keyPath isEqualToString:@"active"]){
        NSString *arrow = @"\u2B07\U0000FE0E";
       [_ddMenuShowButton setTitle:[[NSString alloc] initWithFormat:@"%@ %@",_user.active.name, arrow] forState:UIControlStateNormal];
        
        [_tableView reloadData];
        [_otherAccounts reloadData];
    
    }
};

-(void)loadRealtimeData{
    NSLog(@"loadRealtimeData");
    
    if(_user.active != nil){
        [_user loadUserRealTimeForActive];
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self loadRealtimeData];
    });
    
}

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
    NSLog(@" numberOfRowsInSection: %d ", [[[self.user.active.properties objectAtIndex:section] profiles] count] + 1);
    if([tableView isEqual: _tableView])
        
        return [[[self.user.active.properties objectAtIndex:section] profiles] count] + 1;
    else{
//        NSLog(@"NUMBER OF ACCOUNTS: %d", [self.user.accounts count]);
        return [self.user.accounts count];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"SEGUE: %@", segue.identifier);
    if([segue.identifier isEqualToString:@"propertyDetails"])
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
    
    if([segue.identifier isEqualToString:@"AddProfileSegue"]){
        UITableViewCell *cell = sender;
        NSIndexPath* pathOfTheCell = [self.tableView indexPathForCell:cell];

        AddProfileViewController *remote = segue.destinationViewController;
        GoogleProperty *prop = [self.user.active.properties objectAtIndex:pathOfTheCell.section];
        [remote setUser:_user];
        [remote setProperty:prop];
    }
    
    if([segue.identifier isEqualToString:@"addPropertySegue"]){
       addPropertyController *remote = segue.destinationViewController;
        remote.account = _user.active;
        
        [remote setUser:self.user];
    }
    
    if([segue.identifier isEqualToString:@"settings"]){
    SettingsControllerViewController *remote = segue.destinationViewController;
        [remote setUser:_user];
    }
}


-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer*)otherGestureRecognizer
{
    return YES;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"cellForRowAtIndexPath:Section: %d Row: %d",indexPath.section,indexPath.row );
    UITableViewCell *cell;
    NSString *CellIdentifier = @"cellid";
    
    if([tableView isEqual: _tableView]){

        [self tableView:tableView heightForRowAtIndexPath:indexPath];
  
        GoogleProperty *p = [self.user.active.properties objectAtIndex:indexPath.section];
    
        int section_count = [[[self.user.active.properties objectAtIndex:indexPath.section] profiles] count];
        
        if(indexPath.row < section_count){
            InfoTableViewCell *cell = (InfoTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

            //setting the information
            GoogleProfile  *prof = [p.profiles objectAtIndex:indexPath.row];
            if([prof activeVisitors]!=nil){
                cell.activeUsers.text = [NSString stringWithFormat:@"Current Users: %@", [prof activeVisitors]];
            }else{
                cell.activeUsers.text = @"Current Users: 0";
            }
            cell.url.text = [p websiteUrl];
            cell.name.text = [prof name];
            cell.property.text = [prof identifier];
            // [cell setUserInteractionEnabled:YES];
            
            //setting the colors
            UIColor *textColor = [self.selectedScheme valueForKey:@"textColor"];
            cell.name.textColor = textColor;
            cell.url.textColor = textColor;
            cell.property.textColor = textColor;
            cell.activeUsers.textColor = textColor;
            cell.textLabel.backgroundColor = [UIColor clearColor];
            cell.backgroundColor = [self.selectedScheme valueForKey:@"backgroundColor"];
            cell.textLabel.textColor = textColor;
            
            return cell;
        
        }else{
            CellIdentifier = @"addProfileCell";
            cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
            cell.textLabel.text = @"ADD PROFILE";
            cell.backgroundColor = [self.selectedScheme valueForKey:@"backgroundColor"];
            cell.textLabel.textColor = [UIColor redColor];
            //  [cell setUserInteractionEnabled:NO];
        }
    }
    
    else {
        CellIdentifier = @"accountCell";
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        NSString *name = [[self.user.accounts objectAtIndex:indexPath.row] name];
        
        if([name isEqualToString: _user.active.name])
            cell.textLabel.text = [NSString stringWithFormat:@"** %@ **", name];
        else
            cell.textLabel.text = name;
    }

    return cell;

}


-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    
    return YES;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([tableView isEqual: _tableView]){
        int section_count = [[[self.user.active.properties objectAtIndex:indexPath.section] profiles] count];
        if(indexPath.row < section_count)
            return 80;
        else
            return 35;
    }
    else
        return 35;
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

- (void) changedColors:(NSNotification *)notification {
    NSLog(@"changed the color schemes IN APP DELEGATE");
    
    self.selectedScheme = [notification userInfo];
    [self.tableView reloadData];
}
@end
