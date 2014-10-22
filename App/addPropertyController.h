//
//  addPropertyController.h
//  App
//
//  Created by Megan Smith on 10/16/14.
//  Copyright (c) 2014 Smoothie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GTLAnalytics.h"
#import <MessageUI/MessageUI.h>

@interface addPropertyController : UIViewController <UITextFieldDelegate,MFMailComposeViewControllerDelegate>
@property (strong, nonatomic) IBOutlet UITextField *name;
@property (strong, nonatomic) IBOutlet UITextField *url;
@property (strong, nonatomic) IBOutlet UILabel *propertyid1;
@property (strong, nonatomic) IBOutlet UITextView *script;
@property (strong, nonatomic) GTLAnalyticsAccountSummary *summary;


@property (strong,nonatomic) NSString *propertyID;

@property (nonatomic, strong) MFMailComposeViewController *picker;
@property GTLServiceAnalytics *service;

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error;

- (IBAction)createButtonPressed;
- (BOOL) createProperty: (NSString*) name url: (NSString*) url;



@end
