//
//  ViewController.m
//  App
//
//  Created by Marek Bejda on 9/24/14.
//  Copyright (c) 2014 Smoothie. All rights reserved.
//

#import "ViewController.h"
#import <Parse/Parse.h>
#import "GTMOAuth2ViewControllerTouch.h"
#import "GAI.h"
#import "GAIDictionaryBuilder.h"
#import "GTLAnalytics.h"


static NSString *const kKeychainItemName = @"iOSDriveSample: Google Drive";
static NSString *const kClientId = @"705427936283-36skae8h1kjraf3ih0us1o6150h44mln.apps.googleusercontent.com";
static NSString *const kClientSecret = @"dHkGVAcXBmG3qIIjJaaTNW-Y";
NSString * const kGTLAuthScopeDriveFile = @"https://www.googleapis.com/auth/analytics https://www.googleapis.com/auth/analytics.provision https://www.googleapis.com/auth/analytics.manage.users";

@interface ViewController ()

@property BOOL isAuthorized;


//@property (weak, nonatomic) IBOutlet UIButton *authButton;
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
    //    [[self driveService] setAuthorizer:auth];
    //    self.authButton.titleLabel.text = @"Sign Out";
    //    self.authButton setitle = @"Sign out";
    [self performSegueWithIdentifier:@"LoggedIn" sender:self];
    self.isAuthorized = YES;
    //   [self toggleActionButtons:YES];
    // [self loadDriveFiles];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSLog(@"----------------------We are here");
    
    GTMOAuth2Authentication *auth =
    [GTMOAuth2ViewControllerTouch authForGoogleFromKeychainForName:kKeychainItemName
                                                          clientID:kClientId
                                                      clientSecret:kClientSecret];
    
    if ([auth canAuthorize]) {
        [self isAuthorizedWithAuthentication:auth];
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
    if (!self.isAuthorized) {
        // Sign in.
        SEL finishedSelector = @selector(viewController:finishedWithAuth:error:);
        GTMOAuth2ViewControllerTouch *authViewController =
        [[GTMOAuth2ViewControllerTouch alloc] initWithScope:kGTLAuthScopeDriveFile
                                                   clientID:kClientId
                                               clientSecret:kClientSecret
                                           keychainItemName:kKeychainItemName
                                                   delegate:self
                                           finishedSelector:finishedSelector];
        [self presentModalViewController:authViewController
                                animated:YES];
    } else {
        // Sign out
        [GTMOAuth2ViewControllerTouch removeAuthFromKeychainForName:kKeychainItemName];
        //    [[self driveService] setAuthorizer:nil];
        self.authButton.titleLabel.text = @"Sign in";
        self.isAuthorized = NO;
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
