//
//  PropertyDetailViewController.m
//  App
//
//  Created by Megan Smith on 10/21/14.
//  Copyright (c) 2014 Smoothie. All rights reserved.
//

#import "PropertyDetailViewController.h"
#import "ColorSchemeViewController.h"


@interface PropertyDetailViewController ()

@end

@implementation PropertyDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"viewDidLoad for PropertyDetailVeiwController");
    
    self.profileName.title = self.profile.name;
    self.propertyName.text = self.property.name;
    self.url.text = self.property.websiteUrl;
    self.ID.text = self.profile.identifier;
    
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

- (IBAction)emailJS:(id)sender {
}
@end
