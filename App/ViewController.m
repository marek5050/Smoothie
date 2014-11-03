//
//  ViewController.m
//  App
//
//  Created by Marek Bejda on 9/24/14.
//  Copyright (c) 2014 Smoothie. All rights reserved.
//

#import "ViewController.h"
#import <Parse/Parse.h>
#import "GTLAnalytics.h"
#import "GTMOAuth2ViewControllerTouch.h"
#import "LaunchPageViewController.h"

static NSString *const kKeychainItemName = @"SmoothieGA:Auth";
static NSString *const kClientId = @"705427936283-bc824tm4bc5b95m25tgmpl77srot6kds.apps.googleusercontent.com";
static NSString *const kClientSecret = @"GAcGqkopAvDDT4wvtr_a_MQ2";
NSString *kGTLAuthScopeAnalyticsEdit1 = @"https://www.googleapis.com/auth/analytics https://www.googleapis.com/auth/analytics.edit";


@interface ViewController ()

@property (weak,nonatomic) UIButton *authButton;


- (IBAction)authButtonClicked:(id)sender;

- (void)viewController:(GTMOAuth2ViewControllerTouch *)viewController
      finishedWithAuth:(GTMOAuth2Authentication *)auth
                 error:(NSError *)error;

- (void)isAuthorizedWithAuthentication:(GTMOAuth2Authentication *)auth;

@end


@implementation ViewController

- (void)viewController:(GTMOAuth2ViewControllerTouch *)viewController
      finishedWithAuth:(GTMOAuth2Authentication *)auth
                 error:(NSError *)error {
    [self dismissModalViewControllerAnimated:YES];

    if (error == nil) {
        NSLog(@"NO ERROR: %@",error);
        [self isAuthorizedWithAuthentication:auth];
        
    }else{
        NSLog(@"Authenticated with no Error %@ \n", error);
    }
}

- (void)isAuthorizedWithAuthentication:(GTMOAuth2Authentication *)auth {
    NSLog(@"ViewController:isAuthorizedWithAuthentication: %@", auth);

    [self.user setAuth:auth];
    [self.user setAuthorized:YES];

    self.user.service =[[GTLServiceAnalytics alloc] init];

    [self.user.service setAuthorizer:auth];

    [self performSegueWithIdentifier:@"LoggedIn" sender:self];

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSLog(@"ViewController:PrepareForSegue: %@", self.user.auth.clientID);

    LaunchPageViewController *remote = [segue destinationViewController];
    NSString *segueIdentifier= segue.identifier;
    [remote setUser: self.user];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    NSLog(@"ViewController:viewDidLoad:");
    self.user = [[User alloc] init];

    self.user.auth = [GTMOAuth2ViewControllerTouch authForGoogleFromKeychainForName:kKeychainItemName
                                                          clientID:kClientId
                                                      clientSecret:kClientSecret];
    
    if ([self.user.auth canAuthorize]) {
        [self isAuthorizedWithAuthentication:self.user.auth];
    }



    /*
     PFUser *user = [PFUser user];
     user.username = @"my name";
     user.password = @"my pass";
     user.email = @"email@example.com";

     // other fields can be set if you want to save more information
     user[@"phone"] = @"650-555-0000";*/
    //
    //    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
    //        if (!error) {
    //            // Hooray! Let them use the app now.
    //            NSLog(@"It might have worked!!!");
    //        } else {
    //
    //            NSString *errorString = [error userInfo][@"error"];
    //            NSLog(errorString);
    //
    //            // Show the errorString somewhere and let the user try again.
    //        }
    //    }];
}

- (IBAction)authButtonClicked:(id)sender {
    if (!self.user.authorized) {
        // Sign in.
        SEL finishedSelector = @selector(viewController:finishedWithAuth:error:);
        GTMOAuth2ViewControllerTouch *authViewController =
        [[GTMOAuth2ViewControllerTouch alloc] initWithScope:kGTLAuthScopeAnalyticsEdit1
                                                   clientID:kClientId
                                               clientSecret:kClientSecret
                                           keychainItemName:kKeychainItemName
                                                   delegate:self
                                           finishedSelector:finishedSelector];
        [self presentModalViewController:authViewController animated:YES];
    } else {
        // Sign out
        [GTMOAuth2ViewControllerTouch removeAuthFromKeychainForName:kKeychainItemName];
        //    [[self driveService] setAuthorizer:nil];
        self.authButton.titleLabel.text = @"Sign in";
        self.user.authorized = NO;
        //    [self toggleActionButtons:NO];
        //   [self.driveFiles removeAllObjects];
        //   [self.tableView reloadData];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
