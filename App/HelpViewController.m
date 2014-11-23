//
//  HelpViewController.m
//  App
//
//  Created by Megan Smith on 11/23/14.
//  Copyright (c) 2014 Smoothie. All rights reserved.
//

#import "HelpViewController.h"
#import "AnswerViewController.h"
#import "AppDelegate.h"


@interface HelpViewController ()

@end

@implementation HelpViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"HelpViewController: viewdidLoad");
    
    self.questions = @[@"What is a property?", @"What is an account?", @"What is a profile", @"How do I add a property to an account?",  @"After I add a property to an account, how do I add Google Analytics to my website?", @"How do I add a profile to a property?"];
    
    NSString *propertyExplanation = @"Each property corresponds to a website that you want to track with GA. An account can have multiple properties, aka websites it wants to keep track of.";
    NSString *accountExplanation = @"An account is just a way to divide up the websites you want to keep track of. Each account can have multiple properties.";
    NSString *profileExplanation = @"A profiles is a way to track specific things about a property. Each property must have at least one profile in order for the analytics to work.";
    NSString *addingProperty = @"You can add a property by hitting the '+' in the top right corner of the home page. To create a property you just need to know 2 things: what you want to name the property and the URL of the website you want to track";
    NSString *addingGAToWebsite = @"Once you have successfully created a property you will have the option to email yourself the corresponding javascript. You should email this javascript to yourself and then copy and paste it into the html for the website you want to track. Unfortunately this means you will only be able to track websites  you are the admin for.";
    NSString *addingProfile = @"The homepage will show you a list of properties you have created for a specific account. You can add a profile to any property by hitting the 'Add Profile' cell in the list of profiles for that property. To add profile you only need to know what you want to name it. The nitty gritty of the profiles can be configured on the Google Analytics website.";
    
    self.answers = @[propertyExplanation, accountExplanation, profileExplanation, addingProperty, addingGAToWebsite, addingProfile];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    self.selectedScheme = appDelegate.selectedScheme;
}

//these methods are required for the tableview protocol stuff
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSLog(@"NUMBER OF SECTIONS");
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"numberOfRowsInSection: %d", self.questions.count);
    return self.questions.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"cellForRowAtIndexPath: Row: %d", indexPath.row );
    UITableViewCell *cell;
    NSString *CellIdentifier = @"cellid";
  
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.textLabel.numberOfLines = 0;
        
    NSString *question = [self.questions objectAtIndex:indexPath.row];
    cell.textLabel.text = question;
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.backgroundColor = [self.selectedScheme valueForKey:@"backgroundColor"];
    cell.textLabel.textColor = [self. selectedScheme valueForKey:@"textColor"];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 85;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UITableViewCell *cell = sender;
    NSIndexPath* pathOfTheCell = [self.tableView indexPathForCell:cell];
    int index = pathOfTheCell.row;
    
    NSString *question = [self.questions objectAtIndex:index];
    NSString *answer = [self.answers objectAtIndex:index];
    
    AnswerViewController *avc = segue.destinationViewController;
    avc.answer = answer;
    avc.question = question;
    
    NSLog(@"set the question and answer for the detail page");
}

@end
