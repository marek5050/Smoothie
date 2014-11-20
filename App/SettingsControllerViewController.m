//
//  SettingsControllerViewController.m
//  App
//
//  Created by Megan Smith on 10/16/14.
//  Copyright (c) 2014 Smoothie. All rights reserved.
//

#import "SettingsControllerViewController.h"
#import "ColorSchemeViewController.h"
#import "ViewController.h"
#import "GTMOAuth2ViewControllerTouch.h"
#import "LaunchPageViewController.h"

static NSString *const kKeychainItemName = @"SmoothieGA:Auth";



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

//    [GTMOAuth2ViewControllerTouch removeAuthFromKeychainForName:kKeychainItemName];

//    [self performSegueWithIdentifier: @"LoginController" sender: self];
//    _user =  [[User alloc] init];
//    _user.auth = nil;
//    _user.authorized=NO;
//    NSLog(@"Arrays: %@ %d ",_user, _user.accounts.count);

    [self.navigationController popToRootViewControllerAnimated:YES];
    ViewController *rootController =
    (ViewController *)
    [self.navigationController.viewControllers objectAtIndex: 0];
    [rootController authButtonClicked:nil];
    
    NSLog(@"logout button in settings pressed");
}

@end
