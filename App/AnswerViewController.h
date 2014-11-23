//
//  AnswerViewController.h
//  App
//
//  Created by Megan Smith on 11/23/14.
//  Copyright (c) 2014 Smoothie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnswerViewController : UIViewController

@property (strong, nonatomic) NSString *question;
@property (strong, nonatomic) NSString *answer;
@property (nonatomic, strong) NSDictionary *selectedScheme;

@end
