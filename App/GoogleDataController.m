//
//  GoogleDataController.m
//  App
//
//  Created by Marek Bejda on 11/11/14.
//  Copyright (c) 2014 Smoothie. All rights reserved.
//

#import "GoogleDataController.h"


@implementation GoogleDataController



-(instancetype) init{
    self = [super init];
    if(self){
        
        _requests= [[NSDictionary alloc] init];
        
    }
    return self;
}

@end
