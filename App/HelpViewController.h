//
//  HelpViewController.h
//  App
//
//  Created by Megan Smith on 11/23/14.
//  Copyright (c) 2014 Smoothie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HelpViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *questions;
@property (strong, nonatomic) NSArray *answers;

@end
