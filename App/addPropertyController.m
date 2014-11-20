//
//  addPropertyController.m
//  App
//
//  Created by Megan Smith on 10/16/14.
//  Copyright (c) 2014 Smoothie. All rights reserved.
//

#import "addPropertyController.h"
#import "ColorSchemeViewController.h"
#import "AppDelegate.h"


@implementation addPropertyController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _name.delegate = self;
    _url.delegate = self;
    
    self.propertyID = _account.identifier;
    self.propertyid1.text = _account.name;
    
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    self.selectedScheme = appDelegate.selectedScheme;
    [self setColors];

     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changedColors:) name:changeScheme object:nil];
    
}

-(void) setColors {
    NSLog(@"CALLING SET COLORS");
    self.view.backgroundColor = [self.selectedScheme valueForKey:@"backgroundColor"];
    self.script.backgroundColor = [self.selectedScheme valueForKey:@"backgroundColor"];

    
    UIColor *textColor = [self.selectedScheme valueForKey:@"textColor"];
    self.nameLabel.textColor = textColor;
    self.urlLabel.textColor = textColor;
    self.accountNameLabel.textColor = textColor;
    self.script.textColor = textColor;
    self.propertyid1.textColor = textColor;
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
    GTLAnalyticsWebproperty *web = [[GTLAnalyticsWebproperty alloc] init];
    [web setName:name];
    [web setWebsiteUrl:url];
    
    NSLog(@"Name: %@  Url: %@ PropertyID: %@",name, url, _propertyID);
    
    GTLQueryAnalytics *query = [GTLQueryAnalytics queryForManagementWebpropertiesInsertWithObject:web accountId:[self propertyID]];
    [self.user.service executeQuery:query completionHandler:^(GTLServiceTicket *ticket,                                                        GTLAnalyticsWebproperty *property,
        NSError *error) {
        if (error == nil) {
            
            NSLog(@"files: %@",property);
           // [self showEmail:[property identifier]];
            NSString *stri = [NSString stringWithFormat:@" **** Property was created succesfully, restart the app to see the new property. **** \n<script>\
                              (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){\
                              (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),\
                              m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)\
                              })(window,document,'script','//www.google-analytics.com/analytics.js','ga');\
                              ga('create', ' %@ ','auto'); ga('send', 'pageview'); </script>",[property identifier]];
            
            [_script setText:stri];
            
        } else {
            
            NSLog(@"files: %@",error);
            
        [_script setText:@"*** CREATION WAS NOT SUCCESFUL *** \n URL Format must be: http://url.com or name cannot be empty, and you cannot have more than 20 properties!"];
            
        }
    }];
    
    return YES;
}

- (void) changedColors:(NSNotification *)notification {
    NSLog(@"changed the color schemes add property");
    
    self.selectedScheme = [notification userInfo];
    [self setColors];
}

@end
