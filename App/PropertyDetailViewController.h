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

@interface PropertyDetailViewController : UIViewController
@property (strong, nonatomic) IBOutlet UINavigationItem *profileName;
@property (weak, nonatomic) IBOutlet UILabel *propertyName;
@property (weak, nonatomic) IBOutlet UILabel *url;
@property (weak, nonatomic) IBOutlet UILabel *ID;
@property (strong, nonatomic) GoogleProperty *property;
@property (strong, nonatomic) GoogleProfile *profile;
- (IBAction)emailJS:(id)sender;
@end
