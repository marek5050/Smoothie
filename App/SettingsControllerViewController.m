//
//  SettingsControllerViewController.m
//  App
//
//  Created by Megan Smith on 10/16/14.
//  Copyright (c) 2014 Smoothie. All rights reserved.
//

#import "SettingsControllerViewController.h"
#import "ColorSchemeViewController.h"
#import "AppDelegate.h"


@interface SettingsControllerViewController ()
@property (weak, nonatomic) IBOutlet UIButton *colorSchemeButton;
@property (weak, nonatomic) IBOutlet UIButton *helpButton;
@property (weak, nonatomic) IBOutlet UIButton *feedbackButtonLabel;

@property (weak, nonatomic) IBOutlet UILabel *underbar1;
@property (weak, nonatomic) IBOutlet UILabel *underbar2;

@end

@implementation SettingsControllerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    self.selectedScheme = appDelegate.selectedScheme;
    [self setColors];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changedColors:) name:changeScheme object:nil];
    // Do any additional setup after loading the view.
}

-(void) setColors {
    self.view.backgroundColor = [self.selectedScheme valueForKey:@"backgroundColor"];
    
    UIColor *textColor = [self.selectedScheme valueForKey:@"textColor"];
    
    self.colorSchemeButton.titleLabel.textColor = textColor;
    self.helpButton.titleLabel.textColor = textColor;

    self.feedbackButtonLabel.titleLabel.textColor = textColor;
    self.underbar1.textColor = textColor;
    self.underbar2.textColor = textColor;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)feedbackButton {
    NSLog(@"feedback button in settings pressed");
    //NEED TO REROUTE TO THE FEEDBACK EMAIL SCREEN
}

- (IBAction)logoutButton {
    NSLog(@"logout button in settings pressed");
}

- (void) changedColors:(NSNotification *)notification {
    NSLog(@"changed the color schemes IN APP DELEGATE");
    
    self.selectedScheme = [notification userInfo];
    [self setColors];
}
@end

