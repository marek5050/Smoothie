//
//  ColorScheme.m
//  App
//
//  Created by Megan Avery on 11/2/14.
//  Copyright (c) 2014 Smoothie. All rights reserved.
//

#import "ColorScheme.h"

@implementation ColorScheme

-(id) init {
    self.options = @[@"Forest", @"Sunrise", @"Midnight"];
    
    self.forest = [[NSMutableDictionary alloc] init];
    self.sunrise = [[NSMutableDictionary alloc] init];
    self.midnight = [[NSMutableDictionary alloc] init];
    
    [self setForest];
    [self setSunrise];
    [self setMidnight];
    
    return self;
}

-(void) setForest {
    [self.forest setObject:[UIColor greenColor]  forKey:@"backgroundColor"];
    [self.forest setObject:@"forest"  forKey:@"name"];
    [self.forest setObject:[UIColor blackColor]  forKey:@"textColor"];
}

-(void) setSunrise {
    [self.sunrise setObject:[UIColor orangeColor]  forKey:@"backgroundColor"];
    [self.sunrise setObject:@"sunrise" forKey:@"name"];
    [self.sunrise setObject:[UIColor blackColor]  forKey:@"textColor"];
}

-(void) setMidnight {
    [self.midnight setObject:[UIColor blackColor]  forKey:@"backgroundColor"];
    [self.midnight setObject:@"midnight"  forKey:@"name"];
    [self.midnight setObject:[UIColor whiteColor]  forKey:@"textColor"];
}

@end