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
#import "User.h"

@interface addPropertyController : UIViewController <UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *name;
@property (strong, nonatomic) IBOutlet UITextField *url;
@property (strong, nonatomic) IBOutlet UILabel *propertyid1;
@property (strong, nonatomic) IBOutlet UITextView *script;
@property (strong, nonatomic) GoogleAccount *account;
@property (nonatomic, strong) NSDictionary *selectedScheme;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *urlLabel;
@property (weak, nonatomic) IBOutlet UILabel *accountNameLabel;

@property (strong,nonatomic) User *user;


@property (strong,nonatomic) NSString *propertyID;


- (IBAction)createButtonPressed;
- (BOOL) createProperty: (NSString*) name url: (NSString*) url;



@end
