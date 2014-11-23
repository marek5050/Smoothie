//
//  AnswerViewController.m
//  App
//
//  Created by Megan Smith on 11/23/14.
//  Copyright (c) 2014 Smoothie. All rights reserved.
//

#import "AnswerViewController.h"
#import "AppDelegate.h"

@interface AnswerViewController ()

@end

@implementation AnswerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"AVC loaded");
    // Do any additional setup after loading the view.
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    self.selectedScheme = appDelegate.selectedScheme;
    
    self.view.backgroundColor = [self.selectedScheme valueForKey:@"backgroundColor"];
    
    UILabel *questionLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 50, self.view.bounds.size.width-15, 100)];
    questionLabel.text = self.question;
    questionLabel.numberOfLines = 0;
    questionLabel.textAlignment = NSTextAlignmentCenter;
    questionLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    questionLabel.textColor = [self.selectedScheme valueForKey:@"textColor"];
    [self.view addSubview:questionLabel];
    
    UILabel *answerLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 100, self.view.bounds.size.width-15, 400)];
    answerLabel.text = self.answer;
    answerLabel.numberOfLines = 0;
    answerLabel.textAlignment = NSTextAlignmentCenter;
    answerLabel.font = [UIFont fontWithName:@"Helvetica" size:16];
    answerLabel.textColor = [self.selectedScheme valueForKey:@"textColor"];
    [self.view addSubview:answerLabel];
    
   
}


@end
