//
//  LaunchPageViewController.h
//  App
//
//  Created by Megan Avery on 10/14/14.
//  Copyright (c) 2014 Smoothie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GTLAnalytics.h"

@interface LaunchPageViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> 
//@property NSMutableArray *UserProperties;
@property GTLServiceAnalytics *service;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *propertyList;

-(void)loadData;
@end
