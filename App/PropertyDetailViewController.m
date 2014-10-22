//
//  PropertyDetailViewController.m
//  App
//
//  Created by Megan Smith on 10/21/14.
//  Copyright (c) 2014 Smoothie. All rights reserved.
//

#import "PropertyDetailViewController.h"

@interface PropertyDetailViewController ()

@end

@implementation PropertyDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"viewDidLoad for PropertyDetailVeiwController");
    
    self.propertyName.title = self.propertySummary.name;
    self.name.text = self.propertySummary.name;
    self.websiteURL.text = self.propertySummary.websiteUrl;
    self.identifier.text = self.propertySummary.identifier;
    self.internalWebPropertyId.text = self.propertySummary.internalWebPropertyId;
    self.level.text = self.propertySummary.level;
    self.kind.text = self.propertySummary.kind;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
