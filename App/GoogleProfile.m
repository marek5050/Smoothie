//
// Created by Marek Bejda on 11/2/14.
// Copyright (c) 2014 Smoothie. All rights reserved.
//

#import "GoogleProfile.h"


@implementation GoogleProfile {

}
-(id) init{
    self = [super init];

    if(self){
      [self setUpdate:YES];

    }
    return self;
}

-(id) initWithSummary:(GTLAnalyticsProfileSummary *)summary{
    self = [self init];
    if(self){

   //     NSLog(@"GoogleProfile:initWithSummary: %@",summary);
        [self setIdentifier:summary.identifier];
        [self setName:summary.name];
        [self setType:summary.type];

    }
    return self;
}

@end