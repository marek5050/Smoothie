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
#import "GTLAnalytics.h"
#import "LaunchPageViewController.h"

static NSString *const kKeychainItemName = @"iOSDriveSample: Google Drive";
static NSString *const kClientId = @"705427936283-bc824tm4bc5b95m25tgmpl77srot6kds.apps.googleusercontent.com";
static NSString *const kClientSecret = @"GAcGqkopAvDDT4wvtr_a_MQ2";
NSString *kGTLAuthScopeAnalyticsEdit1 = @"https://www.googleapis.com/auth/analytics https://www.googleapis.com/auth/analytics.edit";

static NSString *const APIKEY = @"AIzaSyB4bLjYuOISLLjSv_pVTD0sEYXuq3hq7AA";
GTMOAuth2Authentication *ga_auth;

@interface ViewController ()
@property (retain) NSMutableArray *userProperties;
@property (nonatomic) GTLServiceAnalytics *service;

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
        ga_auth = auth;
        
    }else{
        NSLog(@"Authenticated with no Error %@ \n", error);
    }
}

- (void)isAuthorizedWithAuthentication:(GTMOAuth2Authentication *)auth {
    NSLog(@"User Logged In %@", auth);
    self.isAuthorized = YES;
    self.service = [[GTLServiceAnalytics alloc] init];
    [self.service setAuthorizer:auth];
    
    [self performSegueWithIdentifier:@"LoggedIn" sender:self];

//    GTLQueryAnalytics *analytics = [[GTLQueryAnalytics alloc] init];
    //GTLQuery *query =
    
//    analytics.queryForManagementAccountSummariesList()
//    analytics.queryForManagementAccountSummariesList
    // [];
    //   [self toggleActionButtons:YES];
    // [self loadDriveFiles];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
//    DrEditFileEditViewController *viewController = [segue destinationViewController];
//    NSString *segueIdentifier = segue.identifier;
//    viewController.driveService = [self driveService];
//    viewController.delegate = self;
//    
//    if ([segueIdentifier isEqualToString:@"editFile"]) {
//        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
//        GTLDriveFile *file = [self.driveFiles objectAtIndex:indexPath.row];
//        viewController.driveFile = file;
//        viewController.fileIndex = indexPath.row;
//    } else if ([segueIdentifier isEqualToString:@"addFile"]) {
//        viewController.driveFile = [GTLDriveFile object];
//        viewController.fileIndex = -1;
//    }
    LaunchPageViewController *remote = [segue destinationViewController];
    NSString *segueIdentifier= segue.identifier;
    [remote setService:self.service];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSLog(@"----------------------We are here");
    
    ga_auth = [GTMOAuth2ViewControllerTouch authForGoogleFromKeychainForName:kKeychainItemName
                                                          clientID:kClientId
                                                      clientSecret:kClientSecret];
    
    if ([ga_auth canAuthorize]) {
        [self isAuthorizedWithAuthentication:ga_auth];
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
        [[GTMOAuth2ViewControllerTouch alloc] initWithScope:kGTLAuthScopeAnalyticsEdit1
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
