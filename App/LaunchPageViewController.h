//
//  LaunchPageViewController.h
//  App
//
//  Created by Megan Avery on 10/14/14.
//  Copyright (c) 2014 Smoothie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GTLAnalytics.h"
#import "User.h"

@interface LaunchPageViewController : UIViewController <UITableViewDataSource, UITableViewDelegate,GoogleUserDelegate>

@property (strong, nonatomic) IBOutlet UINavigationItem *accountName;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) User *user;

- (IBAction)NextAccount:(UIButton *)sender;

/* Required for GoogleUserDelegate */
-(void) interfaceUpdate;

@end
