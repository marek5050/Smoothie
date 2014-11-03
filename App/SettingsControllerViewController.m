//
//  SettingsControllerViewController.m
//  App
//
//  Created by Megan Smith on 10/16/14.
//  Copyright (c) 2014 Smoothie. All rights reserved.
//

#import "SettingsControllerViewController.h"
#import "ColorSchemeViewController.h"


@interface SettingsControllerViewController ()

@end

@implementation SettingsControllerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
@end
