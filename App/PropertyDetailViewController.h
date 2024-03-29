//
//  PropertyDetailViewController.h
//  App
//
//  Created by Megan Smith on 10/21/14.
//  Copyright (c) 2014 Smoothie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GTLAnalytics.h"
#import "User.h"
#import "PNChart.h"
#import "GoogleDataController.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface PropertyDetailViewController : UIViewController <PNChartDelegate, UIScrollViewDelegate, GoogleDataDelegate, GoogleUserDelegate, GoogleUserDelegate,MFMailComposeViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *sv;
@property (strong, nonatomic) IBOutlet UINavigationItem *profileName;
@property (strong, nonatomic) GoogleProperty *property;
@property (strong, nonatomic) GoogleProfile *profile;
@property (strong,nonatomic)  User *user;
@property (strong,nonatomic)  GoogleDataController *dataController;

@property (nonatomic, strong) NSDictionary *selectedScheme;
-(void) interfaceUpdate;

@end