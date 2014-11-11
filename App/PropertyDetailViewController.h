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

@interface PropertyDetailViewController : UIViewController <PNChartDelegate, UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *sv;
@property (strong, nonatomic) IBOutlet UINavigationItem *profileName;
@property (strong, nonatomic) GoogleProperty *property;
@property (strong, nonatomic) GoogleProfile *profile;
@end
