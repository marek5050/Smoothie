//
//  AddProfileViewController.h
//  App
//
//  Created by Marek Bejda on 11/14/14.
//  Copyright (c) 2014 Smoothie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface AddProfileViewController : UIViewController <UITextFieldDelegate>
@property (strong,nonatomic) User *user;
@property (strong,nonatomic) GoogleProperty *property;
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UISegmentedControl *type;
@property (weak, nonatomic) IBOutlet UILabel *createMessage;

- (IBAction)CreateProfile:(id)sender;
@end
 