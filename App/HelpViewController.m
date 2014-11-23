//
//  HelpViewController.m
//  App
//
//  Created by Megan Smith on 11/23/14.
//  Copyright (c) 2014 Smoothie. All rights reserved.
//

#import "HelpViewController.h"
#import "AnswerViewController.h"

@interface HelpViewController ()

@end

@implementation HelpViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"HelpViewController: viewdidLoad");
    
    self.questions = @[@"What is a property?", @"What is an account?", @"What is a profile", @"How do I add a property to an account?",  @"After I add a property to an account, how do I add Google Analytics to my website?", @"How do I add a profile to a property?"];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
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
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    
    return cell;
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
