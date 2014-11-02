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
    
}

-(void) setSunrise {
    
}

-(void) setMidnight {
    
}

@end