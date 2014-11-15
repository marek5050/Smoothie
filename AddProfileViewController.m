//
//  AddProfileViewController.m
//  App
//
//  Created by Marek Bejda on 11/14/14.
//  Copyright (c) 2014 Smoothie. All rights reserved.
//

#import "AddProfileViewController.h"

@interface AddProfileViewController ()

@end

@implementation AddProfileViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.name.delegate = self;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.name.delegate = self;

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

- (IBAction)CreateProfile:(id)sender {
    NSLog(@"CreateProfile: %@", _user);
  //  [_user addProfileFor:_property name:_name.text _typ]; //will be adding name, type, currency and timezone as parameters
    [_user addProfileFor:_property withName:_name.text type:[_type titleForSegmentAtIndex:_type.selectedSegmentIndex] timeZone:@"UTC" currency:@"USD"];
}

-(void) displayCreateMessage:(NSString*)message{
    _createMessage.text = message;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSLog(@"inside textFieldShouldReturn");
    [textField resignFirstResponder];
    return YES;
}
@end
