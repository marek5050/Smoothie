//
//  ColorSchemeViewController.h
//  App
//
//  Created by Megan Avery on 11/2/14.
//  Copyright (c) 2014 Smoothie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ColorSchemeViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *schemes;
@property (nonatomic, strong) NSDictionary *selectedScheme;

@end