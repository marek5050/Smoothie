//
//  SettingsControllerViewController.h
//  App
//
//  Created by Megan Smith on 10/16/14.
//  Copyright (c) 2014 Smoothie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import  "User.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>


@interface SettingsControllerViewController : UIViewController<MFMailComposeViewControllerDelegate>
@property (nonatomic) User *user;

- (IBAction)feedbackButton;
- (IBAction)logoutButton;
@property (nonatomic, strong) NSDictionary *selectedScheme;

@end
