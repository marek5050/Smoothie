//
//  InfoTableViewCell.h
//  App
//
//  Created by Marek Bejda on 10/31/14.
//  Copyright (c) 2014 Smoothie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfoTableViewCell : UITableViewCell
@property (nonatomic,strong) IBOutlet UILabel *name;
@property (nonatomic,strong) IBOutlet UILabel *property;
@property (nonatomic,strong) IBOutlet UILabel *url;
@property (nonatomic,strong) IBOutlet UILabel *activeUsers;

@end
