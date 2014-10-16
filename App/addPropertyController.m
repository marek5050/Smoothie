//
//  addPropertyController.m
//  App
//
//  Created by Megan Smith on 10/16/14.
//  Copyright (c) 2014 Smoothie. All rights reserved.
//

#import "addPropertyController.h"

@implementation addPropertyController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _name.delegate = self;
    _url.delegate = self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSLog(@"inside textFieldShouldReturn");
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)createButtonPressed {
    NSLog(@"createButtonPressed");
    
    BOOL success = [self createProperty:_name.text url: _url.text];
    if(success)
    {
        NSLog(@"creation of property was successful");
    }
    else
    {
        NSLog(@"creation of property failed");
    }
}

- (BOOL) createProperty: (NSString*) name url: (NSString*) url
{
    NSLog(@"trying to create a new property");
    //some logic about adding the property
    return YES;
}
@end
