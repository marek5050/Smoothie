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
    [self cycleTheGlobalMailComposer];
    _name.delegate = self;
    _url.delegate = self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSLog(@"inside textFieldShouldReturn");
    [textField resignFirstResponder];
    return YES;
}


-(void) showEmail:(NSString *)identifier{
    
    NSMutableString *webTracking;
    
    [webTracking appendString:@"<script>\
     (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){\
     (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),\
     m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)\
     })(window,document,'script','//www.google-analytics.com/analytics.js','ga');\
     ga('create', '"];
    [webTracking appendString: identifier];
    [webTracking appendString:@"','auto'); ga('send', 'pageview'); </script>"];
    
    //    picker = [[MFMailComposeViewController alloc] init];
    _picker.mailComposeDelegate = self;
    
    [_picker setSubject:@"Hello from California!"];
    
    // Set up the recipients.
    //  NSArray *toRecipients = [NSArray arrayWithObjects:@"first@example.com",
    //                           nil];
    //  NSArray *ccRecipients = [NSArray arrayWithObjects:@"second@example.com",
    //                          @"third@example.com", nil];
    // NSArray *bccRecipients = [NSArray arrayWithObjects:@"four@example.com",
    //                          nil];
    
    //  [_picker setToRecipients:toRecipients];
    // [_picker setCcRecipients:ccRecipients];
    //  [_picker setBccRecipients:bccRecipients];
    
    // Attach an image to the email.
    // NSString *path = [[NSBundle mainBundle] pathForResource:@"ipodnano"
    //                                                ofType:@"png"];
    // NSData *myData = [NSData dataWithContentsOfFile:path];
    //[picker addAttachmentData:myData mimeType:@"image/png"
    //                 fileName:@"ipodnano"];
    
    // Fill out the email body text.
    NSString *emailBody = @"It is raining in sunny California!";
    [_picker setMessageBody:emailBody isHTML:NO];
    
    // Present the mail composition interface.
    [self presentModalViewController:_picker animated:YES];
    // [picker release]; // Can safely release the controller now.
}

-(void) cycleTheGlobalMailComposer{
    
    _picker = nil;
    _picker = [[MFMailComposeViewController alloc ] init];
    
}
-(void)helpEmail
{
    // APP.globalMailComposer IS READY TO USE from app launch.
    // recycle it AFTER OUR USE.
    
    if ( [MFMailComposeViewController canSendMail] )
    {
        [_picker setToRecipients:
         [NSArray arrayWithObjects: @"HELLO@hello.com", nil] ];
        [_picker setSubject:@"HELLO"];
        [_picker setMessageBody:@"HELLO" isHTML:NO];
        _picker.mailComposeDelegate = self;
        [self presentViewController:_picker
                           animated:YES completion:nil];
    }
    else
    {
        //        [UIAlertView ok:@"Unable to mail. No email on this device?"];
        [self cycleTheGlobalMailComposer];
    }
}

-(void)mailComposeController:(MFMailComposeViewController *)controller
         didFinishWithResult:(MFMailComposeResult)result
                       error:(NSError *)error
{
    [self dismissViewControllerAnimated:YES completion:^
     { [self cycleTheGlobalMailComposer]; }
     ];
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


-(void)addProperty{
    GTLAnalyticsWebproperty *web = [[GTLAnalyticsWebproperty alloc] init];
    [web setName:@"WhateverWeb"];
    [web setWebsiteUrl:@"http://whatever.com"];
    
    GTLQueryAnalytics *query = [GTLQueryAnalytics queryForManagementWebpropertiesInsertWithObject:web accountId:@"46044590"];
    
    [self.service executeQuery:query completionHandler:^(GTLServiceTicket *ticket,                                                        GTLAnalyticsWebproperty *property,
                                                         NSError *error) {
        if (error == nil) {
            
            NSLog(@"files: %@",property);
            [self showEmail:[property identifier]];
            
        } else {
            
            NSLog(@"files: %@",error);
            
            
        }
    }];
}


- (BOOL) createProperty: (NSString*) name url: (NSString*) url
{
    NSLog(@"trying to create a new property");
    //some logic about adding the property
    return YES;
}
@end
