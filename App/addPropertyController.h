//
//  addPropertyController.h
//  App
//
//  Created by Megan Smith on 10/16/14.
//  Copyright (c) 2014 Smoothie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface addPropertyController : UIViewController <UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *name;
@property (strong, nonatomic) IBOutlet UITextField *url;

- (IBAction)createButtonPressed;
- (BOOL) createProperty: (NSString*) name url: (NSString*) url;

@end
