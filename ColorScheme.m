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
    self.options = @[@"Basic", @"Forest", @"Sunrise", @"Midnight"];
    
    self.basic = [[NSMutableDictionary alloc] init];
    self.forest = [[NSMutableDictionary alloc] init];
    self.sunrise = [[NSMutableDictionary alloc] init];
    self.midnight = [[NSMutableDictionary alloc] init];
    
    [self setBasic];
    [self setForest];
    [self setSunrise];
    [self setMidnight];
    
    return self;
}

-(void) setBasic {
    [self.basic setObject:[UIColor whiteColor]  forKey:@"backgroundColor"];
    [self.basic setObject:@"basic"  forKey:@"name"];
    [self.basic setObject:[UIColor blackColor]  forKey:@"textColor"];
    
    NSArray *colors = @[[UIColor blueColor], [UIColor greenColor], [UIColor redColor], [UIColor orangeColor], [UIColor blackColor]];
    
    [self.basic setObject:colors forKey:@"colorsArray"];
}

-(void) setForest {
    [self.forest setObject:[UIColor greenColor]  forKey:@"backgroundColor"];
    [self.forest setObject:@"forest"  forKey:@"name"];
    [self.forest setObject:[UIColor blackColor]  forKey:@"textColor"];
    
    NSArray *colors = @[[UIColor brownColor], [UIColor orangeColor], [UIColor lightGrayColor], [UIColor darkGrayColor], [UIColor blackColor]];
    
    [self.forest setObject:colors forKey:@"colorsArray"];
}

-(void) setSunrise {
    [self.sunrise setObject:[UIColor orangeColor]  forKey:@"backgroundColor"];
    [self.sunrise setObject:@"sunrise" forKey:@"name"];
    [self.sunrise setObject:[UIColor blackColor]  forKey:@"textColor"];
    
    NSArray *colors = @[[UIColor redColor], [UIColor magentaColor], [UIColor purpleColor], [UIColor blueColor], [UIColor cyanColor]];
        
    [self.sunrise setObject:colors forKey:@"colorsArray"];
    
    
}

-(void) setMidnight {
    [self.midnight setObject:[UIColor blackColor]  forKey:@"backgroundColor"];
    [self.midnight setObject:@"midnight"  forKey:@"name"];
    [self.midnight setObject:[UIColor whiteColor]  forKey:@"textColor"];
    
    NSArray *colors = @[[UIColor cyanColor], [UIColor greenColor], [UIColor blueColor], [UIColor redColor], [UIColor orangeColor]];
    
    [self.midnight setObject:colors forKey:@"colorsArray"];
}

@end