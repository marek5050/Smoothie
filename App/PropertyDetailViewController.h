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
@property (strong, nonatomic) IBOutlet UINavigationItem *propertyName;
@property (strong, nonatomic) GTLAnalyticsWebPropertySummary *propertySummary;
@property (strong, nonatomic) User *user;
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *websiteURL;
@property (strong, nonatomic) IBOutlet UILabel *identifier;
@property (strong, nonatomic) IBOutlet UILabel *internalWebPropertyId;
@property (strong, nonatomic) IBOutlet UILabel *level;
@property (strong, nonatomic) IBOutlet UILabel *kind;
@end
