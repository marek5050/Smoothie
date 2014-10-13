//
//  ViewController.m
//  App
//
//  Created by Marek Bejda on 9/24/14.
//  Copyright (c) 2014 Smoothie. All rights reserved.
//

#import "ViewController.h"
#import <Parse/Parse.h>

@interface ViewController ()
            

@end

@implementation ViewController
            
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSLog(@"----------------------We are here");
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
